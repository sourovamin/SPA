import llvmlite.binding as llvm
import llvmlite.ir as ir
import re


# Update the variable value with previously stored value
def refine_val(val, variables):
    if val in variables:
        val = variables[val]
    return val

# Try to calculate the string expression
# If it is calculateable return the value, if not return the original
def evaluate_string(expression):
    try:
        return eval(expression)
    except:
        return expression

# Get the calculated value of the variables
def calculated_variables(variables):
    new_var = {}
    for key, value in variables.items():
        new_var[key] = evaluate_string(value)
    return new_var



if __name__ == '__main__':
    # Load an LL file
    with open('example.ll', 'r') as f:
            ir_str = f.read()
    module = llvm.parse_assembly(ir_str)

    variables = {}

    # Print the functions defined in the LL code
    for func in module.functions:
        for bb in func.blocks:
            for inst in bb.instructions:
                string = str(inst).strip()
                
                #print(inst.opcode)
                #print(inst)

                if inst.opcode == 'store':
                    # Pattern to get variable name and value
                    # store i32 0, i32* %sum, align 4
                    words = string.split()
                    output = [words[2].strip(','), words[4].strip(',')]
                    
                    if output[0] and output[1]:
                        output[0] = refine_val(output[0], variables)
                        variables[output[1]] = output[0]


                if inst.opcode == 'load':
                    # Pattern to get variable name and value
                    # %1 = load i32, i32* %a, align 4
                    words = string.split()
                    output = [word for word in words if word.startswith('%')]
                    output = [x.strip(",") for x in output]

                    if output[0] and output[1]:
                        output[1] = refine_val(output[1], variables)
                        variables[output[0]] = output[1]

                
                if inst.opcode == 'add':
                    words = string.split()
                    output = [words[0]] + words[-2:]
                    output = [x.strip(",") for x in output]

                    if output[0] and output[1] and output[2]:
                        output[1] = refine_val(output[1], variables)
                        output[2] = refine_val(output[2], variables)
                        variables[output[0]] = output[1] + ' + ' + output[2]


    print(variables)
    calculated_variables = calculated_variables(variables)
    print(calculated_variables)