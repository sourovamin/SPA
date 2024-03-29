"""Calculate execution data statically from the ll file module"""

import llvmlite.binding as llvm
import llvmlite.ir as ir
import re
import math

from spallvm import operation as op

class exf_data:
    module = None
    text = ''
    variables = None
    base_variables = {}
    func_name = None
    bb_execution = 0
    for_iteration = None
    ops = None
    f_calls = {}
    next_func = None

    """
    Initiate the init function that load ll and fetch data
    :param module: Module obtained from ll file
    :param func: Content from the ll file, default: main
    :param variables: Value of the variables, default: {}
    """
    def __init__(self, module, func_name = 'main', next_func = None, variables = {}):
        self.module = module
        self.variables = variables
        self.func_name = func_name
        self.next_func = next_func
        self.ops = op.operation().ops

        self.main_iteration()
        self.calculate_variables(self.variables)

    
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
    Base iteration to get all the temp variables final values
    :return : dict, final values of temp variables
    """
    def fin_variables(self):
        # variables = {}
        for func in self.module.functions:
            for bb in func.blocks:
                for inst in bb.instructions:
                    string = str(inst).strip()
                    method_name = 'opcode_' + str(inst.opcode )

                    # Run all the operations
                    if method_name in self.ops:
                        self.ops[method_name](string, self.base_variables)
                    else:
                        pass

        self.calculate_variables(self.base_variables)
        return self.base_variables

    
    """
    Get the probable iteration number
    :param start: Starting point
    :param end: Ending point
    :param inc: Incriment
    :return : iteration number or dependency
    """
    def iteration_count(self, start, end, inc, parent_iteration=None, self_iteration=1):
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
                output += str(parent_iteration) + ' * ' + str(self_iteration)
            else:
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
    Fetch the function calls and add info
    :param string: Iteration of loop
    :param iteration: Number of possible iteration
    :param iteration: Calls under for condition
    """
    def fetch_f_call(self, string, iteration = 1, in_for = None):
        pattern = r'@(\w+)\('
        matches = re.findall(pattern, string)
        for match in matches:
            self.f_calls[match] = {}
            self.f_calls[match]['iteration'] =  iteration
            if in_for is not None:
                self.f_calls[match]['loop'] = in_for


    """
    Get the variable stored value
    :param val: Input value
    :return : Refined value using stored variables
    """
    def get_variable_val(self, val):
        if val in self.variables:
            val = self.variables[val]
        return str(val)
    
    
    """
    Main executions over changing values and storing data on the run
    Iterate over the functions
    """
    def main_iteration(self):
        from spallvm import fs_data as fsd
        fsd = fsd.fs_data(self.module)
        for_list = fsd.for_list
        while_list = fsd.while_list
        not_for = fsd.not_for_list()
        not_while = fsd.not_while_list()
        for_cond_list = {k: list(v.keys()) for k, v in for_list.items()}
        while_cond_list = {k: list(v.keys()) for k, v in while_list.items()}
        total_lin_block = 0
        temp_lin_block = 0
        current_for_name = None
        current_while_name = None
        iteration_count = 1
        self.f_calls = {}
        exit_flag = False

        for func in self.module.functions:
            if exit_flag:
                break
            if func.name == self.func_name:
                for bb in func.blocks:
                    if exit_flag:
                        break
                    # Update variables
                    for inst in bb.instructions:
                        string = str(inst).strip()
                        method_name = 'opcode_' + str(inst.opcode )

                        # Run all the methods from operation
                        if method_name in self.ops:
                            self.ops[method_name](string, self.variables)
                        else:
                            pass
                    
                    # Count the linear blocks excluding for executions
                    if bb.name in not_for[func.name] or bb.name in not_while[func.name]:
                        temp_lin_block = temp_lin_block + 1
                    else:
                        if temp_lin_block > 0:
                            total_lin_block = total_lin_block + temp_lin_block
                            self.text += 'Linear Block(s): ' + str(temp_lin_block) + '\n'
                            temp_lin_block = 0

                    # Operation if for condition found
                    if bb.name in for_cond_list[func.name]:
                        current_for_name = bb.name
                        self.calculate_variables(self.variables)
                        degree = for_list[func.name][bb.name].get('nested_degree', 1)
                        nested = ', Nested: ' + str(for_list[func.name][bb.name]['nested_for']) if len(for_list[func.name][bb.name]['nested_for']) > 0 else ''
                        inc = int(for_list[func.name][bb.name].get('inc', 1))
                        start = self.get_val(for_list[func.name][bb.name]['start'], self.variables)
                        end = self.get_val(for_list[func.name][bb.name]['end'], self.variables)
                        parent = for_list[func.name][bb.name].get('parent', None)
                        parent_text = ', Parent: ' + str(parent) if parent else ''
                        if parent and 'while' in parent:
                            parent_iteration = while_list[func.name][parent].get('iteration', None) if parent else None
                        else:
                            parent_iteration = for_list[func.name][parent].get('iteration', None) if parent else None
                        # Self iteration count
                        self_iteration = self.iteration_count(start, end, inc)
                        # Total iteration count considering parent iteration
                        iteration_count = self.iteration_count(start, end, inc, parent_iteration, self_iteration)
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

                    # Operation if while condition found
                    if bb.name in while_cond_list[func.name]:
                        current_while_name = bb.name
                        self.calculate_variables(self.variables)
                        # degree = while_list[func.name][bb.name].get('nested_degree', 1)
                        # nested = ', Nested: ' + str(while_list[func.name][bb.name]['nested_while']) if len(while_list[func.name][bb.name]['nested_while']) > 0 else ''
                        parent = while_list[func.name][bb.name].get('parent', None)
                        parent_text = ', Parent: ' + str(parent) if parent else ''
                        if parent and 'for' in parent:
                            parent_iteration = for_list[func.name][parent].get('iteration', None) if parent else None
                        else:
                            parent_iteration = while_list[func.name][parent].get('iteration', None) if parent else None
                        temp_dependency = [self.get_variable_val(x) for x in while_list[func.name][bb.name].get('dependency', [])]
                        dependency = ','.join(temp_dependency)
                        bb_count = while_list[func.name][bb.name].get('block_count', 'BB')
                        # Self iteration count
                        self_iteration = bb.name + '(' + str(dependency) + ')'
                        # Total iteration count considering parent iteration
                        parent_it_text = ' * ' + str(parent_iteration) if parent_iteration is not None else ''
                        iteration_count = str(self_iteration) + parent_it_text
                        # Modify for list
                        while_list[func.name][bb.name]['iteration'] = iteration_count
                        execution = str(bb_count) + ' * ' + str(iteration_count)
                        # Modify for list
                        while_list[func.name][bb.name]['block_exec'] = execution

                        self.text += 'while: ' + str(bb.name) + ', Probable Self Iteration: ' + str(self_iteration) + ', Probable Iteration: ' + str(iteration_count)  + ', Probable BB Execution: ' + str(execution) + '\n'
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

                    # Get function calls
                    for inst in bb.instructions:
                        line = str(inst).strip()
                        if inst.opcode == 'call':

                            if 'for.end' in bb.name:
                                if parent is not None and parent_iteration is not None:
                                    self.fetch_f_call(line, parent_iteration, parent)
                                else:
                                    self.fetch_f_call(line)
                            else:
                                if bb.name in not_for[func.name]:
                                    self.fetch_f_call(line)
                                else:
                                    self.fetch_f_call(line, iteration_count, current_for_name)

                            if self.next_func is not None and '@' + self.next_func + '(' in line:
                                exit_flag = True
                                break

                # If there are some linear blocks
                if temp_lin_block > 0:
                    total_lin_block = total_lin_block + temp_lin_block
                    self.text += 'Linear Block(s): ' + str(temp_lin_block) + '\n'

                # Refine bb_execution string
                if isinstance(self.bb_execution, str):
                    self.bb_execution = self.bb_execution.strip().lstrip('+').strip()
                
                # Add total linear blocks to bb_execution
                if total_lin_block > 0:
                    try:
                        if isinstance(self.bb_execution, int) and isinstance(total_lin_block, int):
                            self.bb_execution += total_lin_block
                        else:
                            self.bb_execution = str(total_lin_block) + ' + ' + str(self.bb_execution)
                    except:
                        pass                     

                if len(self.f_calls) > 0:
                    self.text += '\nFunction Calls:\n'
                    for func in self.f_calls:
                        iteration = '' if self.f_calls[func].get('iteration', None) is None else 'Probable Iteration: ' + str(self.f_calls[func]['iteration'])
                        loop_name = '' if self.f_calls[func].get('loop', None) is None else ', In Loop: ' + str(self.f_calls[func]['loop'])
                        self.text += str(func) + ', ' + iteration + loop_name + '\n'

        self.for_iteration = for_list
        