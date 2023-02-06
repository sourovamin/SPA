"""Fetch static data from the ll file"""

import llvmlite.binding as llvm
import llvmlite.ir as ir
import re

class fs_data:
    module = None
    function_list = None
    block_list = None
    for_list = None

    """
    Initiate the init function that load ll and fetch data
    :param module: Content from the ll file
    """
    def __init__(self, module):
        self.module = module
        self.block_list = self.func_blocks()
        self.function_list = self.func_list()
        self.for_list = self.fetch_for()


    """
    Store function name and basic blocs inside the function
    :return : A dict value containing function name and block lists inside
    """
    def func_blocks(self):
        data = {}
        for func in self.module.functions:
            bb_list = []
            for block in func.blocks:
                bb_list.append(block.name)
            if len(bb_list) > 0:
                data[func.name] = bb_list
        return data


    """
    Get the functions list excluding library function
    :return : A list containg all the functions
    """
    def func_list(self):
        func_list = []
        for key, value in self.block_list.items():
            func_list.append(key)
        
        return func_list

    
    """
    Get data of specific basic block
    :param func_name: Name of the function
    :param block_name: Name of the block
    :return : Content of the specific block, None if not found
    """
    def get_block(self, func_name, block_name):
        func = self.module.get_function(func_name)
        try:
            return next(b for b in func.blocks if b.name == block_name)
        except:
            return None

    
    """
    Get the blocks that are not part of for loops
    :return dict: list of blocks in each function
    """
    def not_for_list(self):
        data = self.block_list
        
        for func, b_list in data.items():
            for start_b, dt in self.for_list[func].items():
                try:
                    start = data[func].index(start_b)
                    end = data[func].index(dt['end_bb'])
                    data[func] = data[func][:start] + data[func][end+1:]
                except:
                    pass

        return data


    """
    Get all the for loops and related data
    :return : Dict of all the for loops with fetchable data fousing on for condition
    """
    def fetch_for(self):
        # Setup for list
        for_list = {}
        for func, value in self.block_list.items():
            for_cond = {}
            for bb in value:
                if 'for.cond' in bb:
                    for_cond[bb] = {}
            for_list[func] = for_cond

        # Get values for for list
        for func in self.module.functions:
            for bb in func.blocks:

                # Condition blocks
                if 'for.cond' in bb.name:
                    body_bb = 'NA'
                    end_bb = 'NA'
                    vars = []
                    start = 'NA'
                    end = 'NA'
                    inst = list(bb.instructions)

                    # Analyze br instruction
                    br_inst = str(inst[-1])
                    words = br_inst.split()
                    for word in words:
                        if 'for.body' in word:
                            body_bb = word.rstrip(',')
                        if 'for.end' in word:
                            end_bb = word.rstrip(',')

                    # Analyze other instructions
                    for inst in inst[:-1]:
                        if inst.opcode == 'icmp':
                            words = str(inst).split()
                            end = words[-1]
                            start = words[-2].strip(',')
                            output = [word for word in words if word.startswith('%')]
                            output = [x.strip(',') for x in output]
                            vars = vars + output[1:]

                    # Store values
                    for_list[func.name][bb.name]['body_bb'] = body_bb.lstrip('%')
                    for_list[func.name][bb.name]['end_bb'] = end_bb.lstrip('%')
                    for_list[func.name][bb.name]['dependency'] = vars
                    for_list[func.name][bb.name]['start'] = start
                    for_list[func.name][bb.name]['end'] = end

                # For inc blocks
                if 'for.inc' in bb.name:
                    inc_val = None
                    inc_cond = None
                    for inst in bb.instructions:
                        if inst.opcode == 'add':
                            inc_vals = str(inst).split()
                            if inc_vals[-1]:
                                inc_val = inc_vals[-1]

                        if inst.opcode == 'br':
                            words = str(inst).split()
                            inc_conds = [word for word in words if word.startswith('%')]
                            if inc_conds[0]:
                                inc_cond = inc_conds[0].strip('%')

                    if inc_val and inc_cond:
                        if for_list[func.name][inc_cond]:
                            for_list[func.name][inc_cond]['inc'] = inc_val

        # Get the nested degree ,nested for and sequential block counts
        for func, value in for_list.items():
            for for_block, attr in value.items():
                try:
                    # Sequential block count in for loop
                    start_index = self.block_list[func].index(for_block)
                    end_index = self.block_list[func].index(attr['end_bb'])
                    block_count = abs(end_index - start_index) +1
                    for_list[func][for_block]['block_count'] = block_count

                    # Nested degree and nested for storing
                    temp_list = self.block_list[func][start_index + 1 : end_index + 1]
                    nested_degree = 1
                    nested_for = []
                    for item in temp_list:
                        if 'for.cond' in item:
                            nested_degree = nested_degree + 1
                            nested_for.append(item)

                    for_list[func][for_block]['nested_degree'] = nested_degree
                    for_list[func][for_block]['nested_for'] = nested_for

                except:
                    pass
        
        return for_list


