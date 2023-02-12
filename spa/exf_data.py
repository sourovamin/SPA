"""Calculate execution data statically from the ll file module"""

import llvmlite.binding as llvm
import llvmlite.ir as ir
import re
import math

class exf_data:
    module = None
    text = ''
    variables = None
    base_variables = {}
    func_name = None
    bb_execution = 0
    for_iteration = None

    """
    Initiate the init function that load ll and fetch data
    :param module: Module obtained from ll file
    :param func: Content from the ll file, default: main
    :param variables: Value of the variables, default: {}
    """
    def __init__(self, module, func_name = 'main', variables = {}):
        self.module = module
        self.variables = variables
        self.func_name = func_name

        self.base_iteration()
        self.calculate_variables(self.base_variables)
        self.main_iteration()
        self.calculate_variables(self.variables)


    """
    Update the variable value with previously stored value
    :param val: Input value
    :param val: Input variables
    :return : Refined value using stored variables
    """
    def refine_val(self, val, variables):
        if val in variables:
            val = variables[val]
        return val

    
    """
    Get the value of variables
    :param variables: Stored variable
    :param val: Input val
    :return : value from variables
    """
    def get_val(self, val, variables):
        try:
            return variables[val]
        except:
            return val

    
    """
    Try to calculate the string expression
    If it is calculateable return the value, if not return the original
    :param expression: Expression string
    :return : Calculated expression
    """
    def evaluate_string(self, expression):
        try:
            return eval(expression)
        except:
            return expression


    """
    Calculate the values of the variables
    :param variables: Input variables
    :return : Calculated variables
    """
    def calculate_variables(self, variables):
        for key, value in variables.items():
            variables[key] = self.evaluate_string(value)

        return variables


    """
    Calculate for the opcode store
    :param string: Instruction string
    """
    def opcode_store(self, string, variables):
        # Pattern to get variable name and value
        # store i32 0, i32* %sum, align 4
        words = string.split()
        output = [words[2].strip(','), words[4].strip(',')]
                            
        if output[0] and output[1]:
            output[0] = self.refine_val(output[0], variables)
            variables[output[1]] = output[0]


    """
    Calculate for the opcode load
    :param string: Instruction string
    """
    def opcode_load(self, string, variables):
        # Pattern to get variable name and value
        # %1 = load i32, i32* %a, align 4
        words = string.split()
        output = [word for word in words if word.startswith('%')]
        output = [x.strip(",") for x in output]

        if output[0] and output[1]:
            output[1] = self.refine_val(output[1], variables)
            variables[output[0]] = output[1]


    """
    Calculate for the opcode add
    :param string: Instruction string
    """
    def opcode_add(self, string, variables):
        words = string.split()
        output = [words[0]] + words[-2:]
        output = [x.strip(",") for x in output]

        if output[0] and output[1] and output[2]:
            output[1] = self.refine_val(output[1], variables)
            output[2] = self.refine_val(output[2], variables)
            variables[output[0]] = str(output[1]) + ' + ' + str(output[2])
    

    """
    Base iteration to get all the temp variables final values
    :return : dict, final values of temp variables
    """
    def base_iteration(self):
        # variables = {}
        for func in self.module.functions:
            for bb in func.blocks:
                for inst in bb.instructions:
                    string = str(inst).strip()

                    if inst.opcode == 'store':
                        self.opcode_store(string, self.base_variables)

                    if inst.opcode == 'load':
                        self.opcode_load(string, self.base_variables)
                        
                    if inst.opcode == 'add':
                        self.opcode_add(string, self.base_variables)

    
    """
    Get the probable iteration number
    :param start: Starting point
    :param end: Ending point
    :param inc: Incriment
    :return : iteration number or dependency
    """
    def iteration_count(self, start, end, inc, parent_iteration=None):
        start_s = str(start)
        end_s = str(end)
        inc_s = str(inc)
        try:
            #count = abs(eval(start - end))
            #return count
            #return math.floor(count)
            count = abs((eval(start_s) - eval(end_s)) / eval(inc_s))
            if parent_iteration:
                count = parent_iteration * count
            return math.floor(count)
        except:
            output = ''
            if parent_iteration:
                output += str(parent_iteration) + ' * '
            output += 'f('
            start_f = end_f = ''
            try:
                start_f = int(start)
            except:
                start_f = start

            try:
                end_f = int(end)
            except:
                end_f = end

            if not isinstance(start_f, int):
                output += str(start_f) + ', '
            if not isinstance(end_f, int):
                output += str(end_f)

            output += ')'
            return output

    
    """
    Count the probable basic block executions for loop
    :param iteration: Iteration of loop
    :param bb_count: Number of blocks
    :return : Probable basic block executions
    """
    def bb_execution_for(self, iteration, bb_count):
        count = 'NA'
        try:
            if isinstance(iteration, int) and isinstance(bb_count, int):
                count = (iteration * (bb_count - 1)) + 1
            else:
                count = str(bb_count - 1) + '*' + str(iteration)
            return count
        except:
            return count
    
    
    """
    Main executions over changing values and storing data on the run
    Iterate over the functions
    """
    def main_iteration(self):
        from spa import fs_data as fsd
        fsd = fsd.fs_data(self.module)
        for_list = fsd.for_list
        not_for = fsd.not_for_list()
        for_cond_list = {k: list(v.keys()) for k, v in for_list.items()}
        total_lin_block = 0
        temp_lin_block = 0

        for func in self.module.functions:
            if func.name == self.func_name:
                for bb in func.blocks:
                    # Count the linear blocks excluding for executions
                    if bb.name in not_for[func.name]:
                        temp_lin_block = temp_lin_block + 1
                    else:
                        if temp_lin_block > 0:
                            total_lin_block = total_lin_block + temp_lin_block
                            self.text += 'Linear Block(s): ' + str(temp_lin_block) + '\n'
                            temp_lin_block = 0

                    # Operation if for condition found
                    if bb.name in for_cond_list[func.name]:
                        self.calculate_variables(self.variables)
                        degree = for_list[func.name][bb.name].get('nested_degree', 1)
                        nested = ', Nested: ' + str(for_list[func.name][bb.name]['nested_for']) if len(for_list[func.name][bb.name]['nested_for']) > 0 else ''
                        inc = int(for_list[func.name][bb.name].get('inc', 1))
                        start = self.get_val(for_list[func.name][bb.name]['start'], self.base_variables)
                        end = self.get_val(for_list[func.name][bb.name]['end'], self.base_variables)
                        parent = for_list[func.name][bb.name].get('parent', None)
                        parent_text = ', Parent: ' + str(parent) if parent else ''
                        parent_iteration = for_list[func.name][parent].get('iteration', None) if parent else None
                        # Self iteration count
                        self_iteration = self.iteration_count(start, end, inc)
                        # Total iteration count considering parent iteration
                        iteration_count = self.iteration_count(start, end, inc, parent_iteration)
                        # Modify for list
                        for_list[func.name][bb.name]['iteration'] = iteration_count
                        bb_count = for_list[func.name][bb.name].get('block_count', 'NA')
                        execution = self.bb_execution_for(iteration_count, bb_count)
                        # Modify for list
                        for_list[func.name][bb.name]['block_exec'] = execution

                        self.text += 'for: ' + str(bb.name) + ', Degree: ' + str(degree) + nested + parent_text + ', Start: ' + str(start) + ', End: ' + str(end)+ ', Probable Self Iteration: ' + str(self_iteration) + ', Probable Iteration: ' + str(iteration_count)  + ', Probable BB Execution: ' + str(execution) + '\n'
                        # self.text += str(self.variables) + '\n'

                        try:
                            if isinstance(self.bb_execution, int) and isinstance(execution, int):
                                self.bb_execution += execution
                            else:
                                if self.bb_execution == 0:
                                    self.bb_execution = ''
                                self.bb_execution = str(self.bb_execution) + ' + ' + str(execution)
                        except:
                            if self.bb_execution == 0:
                                self.bb_execution = ''
                            self.bb_execution = str(self.bb_execution) + ' + ' +  str(bb.name)

                    for inst in bb.instructions:
                        string = str(inst).strip()

                        if inst.opcode == 'store':
                            self.opcode_store(string, self.variables)

                        if inst.opcode == 'load':
                            self.opcode_load(string, self.variables)
                        
                        if inst.opcode == 'add':
                            self.opcode_add(string, self.variables)

        self.for_iteration = for_list                    


        