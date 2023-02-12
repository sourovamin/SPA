"""Run variaous operation for opcodes, add new opcodes here"""

import re
import math

class operation:
    ops = None

    """
    Initiate the init function and add all the stated operations to dict
    """
    def __init__(self):
        self.ops = {
            # Add any new opcode operations here
            # Keep the naming convention right: opcode_operation
            'opcode_store': self.opcode_store,
            'opcode_load': self.opcode_load,
            'opcode_add': self.opcode_add
        }


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
    
