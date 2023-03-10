"""Run variaous operation for opcodes, add new opcodes here"""

import re
import math
import struct

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
            'opcode_call': self.opcode_call,
            'opcode_add': self.opcode_add,
            'opcode_fadd': self.opcode_add,
            'opcode_sub': self.opcode_sub,
            'opcode_fsub': self.opcode_sub,
            'opcode_mul': self.opcode_mul,
            'opcode_fmul': self.opcode_mul,
            'opcode_fdiv': self.opcode_fdiv,
            'opcode_sdiv': self.opcode_sdiv,
            'opcode_rem': self.opcode_rem,
            'opcode_srem': self.opcode_rem,
            'opcode_frem': self.opcode_rem,
            'opcode_fpext': self.opcode_fpext,
            'opcode_sitofp': self.opcode_fpext,
            'opcode_fptrunc': self.opcode_fpext,
            'opcode_uitofp': self.opcode_fpext,
            'opcode_fptoui': self.opcode_fpext,
            'opcode_fptosi': self.opcode_fpext,
            'opcode_ptrtoint': self.opcode_fpext,
            'opcode_inttoptr': self.opcode_fpext,
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
    Update the variable string with previously stored value
    :param val: Input value
    :param val: Input variables
    :return : Refined string using stored variables
    """
    def refine_string(self, string, variables):
        try:
            pattern = r"%\d+"
            new_s = re.sub(pattern, lambda match: self.refine_val(match.group(), variables), string)
            return str(new_s)
        except:
            return string

    """
    Process value if float or hexadecimal value found
    :param val: Input value
    :return : Processed value
    """
    def process_value(self, val):
        try:
            # if int
            return int(val)
        except ValueError:
            try:
                # if float
                return float(val)
            except ValueError:
                try:
                    # if hexadecimal
                    hexa_check = int(val, 16)
                    try:
                        val = struct.unpack('>d', bytes.fromhex(val[2:]))[0]
                    except:
                        return val
                    return val
                except ValueError:
                    return val

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
            output[0] = self.refine_val(self.process_value(output[0]), variables)
            variables[output[1]] = output[0]


    """
    Calculate for the opcode load
    :param string: Instruction string
    """
    def opcode_load(self, string, variables):
        # Pattern to get variable name and value
        # %1 = load i32, i32* %a, align 4
        words = string.split()
        output = [word for word in words if word.startswith('%') or word.startswith('@')]
        output = [x.strip(',') for x in output]

        if output[0] and output[1]:
            output[1] = self.refine_val(output[1], variables)
            variables[output[0]] = output[1]


    """
    Calculate for the opcode call
    :param string: Instruction string
    """
    def opcode_call(self, string, variables):
        # Pattern to get variable name and value
        # %call = call i32 @_Z3mulii(i32 10, i32 %0)
        call = re.search(r"@[_a-zA-Z]\w*\([^)]*\)", string)
        if call is None:
            return
        output = call.group()
        words = string.split()

        if output and words[0].startswith('%'):
            variables[words[0]] = self.refine_string(str(output), variables)


    """
    Calculate for the opcode add
    :param string: Instruction string
    """
    def opcode_add(self, string, variables):
        # Pattern to get variable name and value
        # %add25 = add nsw i32 %13, 20
        words = string.split()
        output = [words[0]] + words[-2:]
        output = [x.strip(",") for x in output]

        if output[0] and output[1] and output[2]:
            output[1] = self.refine_val(output[1], variables)
            output[2] = self.refine_val(output[2], variables)
            variables[output[0]] = str(output[1]) + ' + ' + str(output[2])


    """
    Calculate for the opcode sub
    :param string: Instruction string
    """
    def opcode_sub(self, string, variables):
        # Pattern to get variable name and value
        # %sub = sub float %0, %1
        words = string.split()
        output = [words[0]] + words[-2:]
        output = [x.strip(",") for x in output]

        if output[0] and output[1] and output[2]:
            output[1] = self.refine_val(output[1], variables)
            output[2] = self.refine_val(output[2], variables)
            variables[output[0]] = str(output[1]) + ' - ' + str(output[2])

    
    """
    Calculate for the opcode mul
    :param string: Instruction string
    """
    def opcode_mul(self, string, variables):
        # Pattern to get variable name and value
        # %mul27 = mul nsw i32 %15, %16
        words = string.split()
        output = [words[0]] + words[-2:]
        output = [x.strip(",") for x in output]

        if output[0] and output[1] and output[2]:
            output[1] = self.refine_val(output[1], variables)
            output[2] = self.refine_val(output[2], variables)
            variables[output[0]] = '(' + '(' +str(output[1]) + ')' + ' * ' + '(' + str(output[2]) + ')' + ')'


    """
    Calculate for the opcode fdiv
    :param string: Instruction string
    """
    def opcode_fdiv(self, string, variables):
        # Pattern to get variable name and value
        # %div = fdiv i32 %0, %1
        words = string.split()
        output = [words[0]] + words[-2:]
        output = [x.strip(",") for x in output]

        if output[0] and output[1] and output[2]:
            output[1] = self.refine_val(output[1], variables)
            output[2] = self.refine_val(output[2], variables)
            variables[output[0]] = '(' + '(' +str(output[1]) + ')' + ' / ' + '(' + str(output[2]) + ')' + ')'

    
    """
    Calculate for the opcode sdiv
    :param string: Instruction string
    """
    def opcode_sdiv(self, string, variables):
        # Pattern to get variable name and value
        # %div = fdiv i32 %0, %1
        words = string.split()
        output = [words[0]] + words[-2:]
        output = [x.strip(",") for x in output]

        if output[0] and output[1] and output[2]:
            output[1] = self.refine_val(output[1], variables)
            output[2] = self.refine_val(output[2], variables)
            variables[output[0]] = '(' + '(' +str(output[1]) + ')' + ' / ' + '(' + str(output[2]) + ')' + ')'
            

    """
    Calculate for the opcode fpext floating-point extend
    Also works for other conversations like sitofp, fptrunc
    :param string: Instruction string
    """
    def opcode_fpext(self, string, variables):
        # Pattern to get variable name and value
        # %conv = fpext float %2 to double
        pattern = r'%\w+'
        output = re.findall(pattern, string)

        if output[0] and output[1]:
            output[1] = self.refine_val(output[1], variables)
            variables[output[0]] = output[1]


    """
    Calculate for the opcode rem reminder of the division
    :param string: Instruction string
    """
    def opcode_rem(self, string, variables):
        # Pattern to get variable name and value
        # %rem = srem i32 %0, %1
        words = string.split()
        output = [words[0]] + words[-2:]
        output = [x.strip(",") for x in output]

        if output[0] and output[1] and output[2]:
            output[1] = self.refine_val(output[1], variables)
            output[2] = self.refine_val(output[2], variables)
            variables[output[0]] = str(output[1]) + ' % ' + str(output[2])
