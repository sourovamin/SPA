"""Calculate the function call path from the ll file text"""

import llvmlite.binding as llvm
import llvmlite.ir as ir
from glob import glob
import numpy as np
import re
import math

class fcp:
    func_calls_id = None
    temp_func_calls = []
    func_path_unorderd = []
    func_list = None
    ll_lines = None
    module = None
    func_index = None
    call_path = None


    """
    Initiate the init function that load ll and fetch data
    :param filepath: Input file
    :param module: LLVM module fetched from ll file
    """
    def __init__(self, filepath, module = None, func_name = 'main'):
        with open(filepath) as f:
            lines = f.readlines()
        self.ll_lines = [x.strip() for x in lines]

        if module is None:
            with open(filepath, 'r') as f:
                ir_str = f.read()
            self.module = llvm.parse_assembly(ir_str)

        self.func_list = self.function_list()
        self.func_index = self.func_index(self.func_list, self.ll_lines)
        self.func_calls_id = self.func_calls(self.func_index, self.func_list, self.ll_lines)

        # Unordered call path id for each function
        for fid, func in enumerate(self.func_list):
            self.temp_func_calls.clear()
            self.rec_add(fid)
            self.func_path_unorderd.append([fid] + self.temp_func_calls)

        func_id = self.get_func_id(self.func_list, func_name)

        if func_id == -1:
            print(func_name, ': function is not found! (error!)')
            return

        ext_call_path = self.ext_call_path(func_id, self.func_path_unorderd)

        self.call_path = self.main_call_path(ext_call_path, self.func_list)


    """
    Get the list of user defined functions
    :return module: LLVM module fetched from ll file
    """
    def function_list(self):
        func_list = []
        # Exclude these functions starts with these prefixes
        prefixes = ['_ZNSt3', '_ZNKSt3', '__clang_call_terminate']
        for func in self.module.functions:
            if not func.is_declaration and not [prefix for prefix in prefixes if func.name.startswith(prefix)]:
                for block in func.blocks:
                    func_list.append(func.name)
                    break

        return func_list
    


    """
    Get the start and end index of all the functions
    :param funcs: Function list
    :param ll_lines: Lines from ll file
    :return func_index: [function_index, function name, start_position, end_position]
    """
    def func_index(self, funcs, ll_lines):
        func_index = []
        for i, func in enumerate(funcs):
            start_index = 0
            end_index = 0
            found = False
            for j, line in enumerate(ll_lines):
                if line.find('@' + func + '(') != -1 and line.find('define') != -1:
                
                    start_index = j
                    found = True
                    continue
                if found == True and line == '}':
                    end_index = j
                    func_index.append([i, func, start_index, end_index])
                    break
        
        # func_index [function_index, function name, start_position, end_position]
        return func_index
                

    """
    Calculate function calls from each function
    :param func_index
    :param func_list
    :param ll_lines
    :return func_calls
    """
    def func_calls(self, func_index, func_list, ll_lines):
        func_calls = []
        for findx in func_index:
            temp_path = [findx[0]]
            
            if findx[2] > 0 and findx[3] > findx[2]:
                for line in ll_lines[findx[2] : findx[3]]:
                    for f_id, func in enumerate(func_list):
                        if line.find('call') != -1 and (line.find('@' + func + '(') != -1 or line.find('@' + func + ' ') != -1):
                            temp_path.append(f_id)

            func_calls.append(temp_path)

        return func_calls


    """
    Get the ID of main function
    :return id
    """
    def get_main_id(self, func_list):
        id = -1
        for i, func in enumerate(func_list):
            if(func == 'main'):
                id = i
                break

        return id


    """
    Get the ID of specific function
    :return id
    """
    def get_func_id(self, func_list, func_name):
        id = -1
        for i, func in enumerate(func_list):
            if(func == func_name):
                id = i
                break

        return id
    
    """
    Recursively add the function id
    """
    def rec_add(self, fid):

        length = len(self.func_calls_id[fid])
        
        if(length == 1):
            return
        
        for i in range(1, length):
            if self.func_calls_id[fid][i] == fid:
                self.temp_func_calls.append(self.func_calls_id[fid][i])
                continue
            self.temp_func_calls.append(self.func_calls_id[fid][i])
            self.rec_add(self.func_calls_id[fid][i])


    
    """
    Calculate extended call path
    :param fid
    :param func_path_unorderd
    :return list: call path
    """
    def ext_call_path(self, fid, func_path_unorderd):
        ecp = []
        for i, id in enumerate(func_path_unorderd[fid]):
            if i == 0:
                ecp.append([fid])
                continue
            elif i == 1:
                ecp.append([fid, id])
                continue

            else:
                temp_ecp = ecp[i-1].copy()

                while True:
                    if len(temp_ecp) == 1:
                        temp_ecp = temp_ecp + [id]
                        break

                    last = temp_ecp[-1]
                    if id in self.func_calls_id[last][1:]:
                        temp_ecp = temp_ecp + [id]
                        break
                    else:
                        temp_ecp.pop()
                        continue

            ecp.append(temp_ecp)

        return ecp



    """
    Get the function name of call path
    :param ext_call_path
    :param func_list
    :return list: call path with function name
    """
    def main_call_path(self, ext_call_path, func_list):
        main_call_path = ext_call_path.copy()
        for i in range( len(ext_call_path)):
            for j in range( len(ext_call_path[i])):
                main_call_path[i][j] = func_list[ext_call_path[i][j]]

        return main_call_path


    
    """
    Store call path to file
    :param out_file: default main_call_path.txt
    """
    def store_path(self, out_file='main_call_path.txt'):
        out_string = ''
        for path in self.call_path:
            for func in path[:-1]:
                out_string = out_string + func + ' -> '
            out_string = out_string + path[-1]
            out_string = out_string + '\n'
        try:
            with open(out_file, 'w') as f:
                f.write(out_string)
        except:
            print('Path write to file failed!')


    
    """
    Function call path execution with data
    :param out_file: default main_call_path.txt
    """
    def fcp_execution(self, out_file='fcp_execution.txt', show_result=True):
        from spa import exf_data as exfd
        from spa import fs_data as fsd
        out_text = ''

        global_vars = fsd.fs_data(self.module).global_vars

        for path in self.call_path:
            variables = global_vars
            next_func = None
            path_text = ''
            for func in path[:-1]:
                path_text = path_text + func + ' -> '
            path_text = path_text + path[-1]
            path_text = path_text + '\n'
            
            out_text += '# ' + path_text
            out_text += 'Focused Function: ' + path[-1] + '\n'

            # Iterate through the call path for data
            for index, func in enumerate(path[:-1]):
                if index < len(path) - 1:
                    next_func = path[index]
                ex = exfd.exf_data(self.module, func, next_func, variables)
                variables = ex.variables

            ex = exfd.exf_data(self.module, path[-1], next_func, variables)

            out_text += '\n' + ex.text
            out_text += '\nTotal Probable BB Execution'
            out_text += '\n' + str(ex.bb_execution)

            out_text += '\n\n'

        if show_result:
            print(out_text)

        # Store to file
        try:
            with open(out_file, 'w') as f:
                f.write(out_text)
        except:
            print('Path write to file failed!')

        

