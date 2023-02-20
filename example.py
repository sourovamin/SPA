"""Example file for running spa"""

from spa import fs_data as fsd
from spa import exf_data as exfd
from spa import fcp
import llvmlite.binding as llvm
import llvmlite.ir as ir
import sys

input_file = sys.argv[1]

# Load an LL file
try:
    with open(input_file, 'r') as f:
        ir_str = f.read()
    module = llvm.parse_assembly(ir_str)
except:
    print('Invalid input file!')
    sys.exit()

fsd = fsd.fs_data(module)

# print('Function List:')
# print(fsd.function_list)

# print('Block List:')
# print(fsd.block_list)

# print('Specific Block, Entry of main function:')
# print(fsd.get_block('main', 'entry'))

print('For List:')
print(fsd.for_list)

# print('Not in for:')
# print(fsd.not_for_list())

exfd = exfd.exf_data(module)

print('Variables')
print(exfd.variables)

print('Text')
print(exfd.text)

# print('Final Base Variables')
# print(exfd.fin_variables())

print('Total BB Execution')
print(exfd.bb_execution)

# Function Call Path
fcp = fcp.fcp(input_file)
print('\n')

print('User Defined Function List')
print(fcp.func_list)

print('Function Index')
print(fcp.func_index)

print('Main Call Path')
print(fcp.call_path)

# store path to file
fcp.store_path()