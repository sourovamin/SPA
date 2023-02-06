"""Example file for running spa"""

from spa import fs_data as fsd
import llvmlite.binding as llvm
import llvmlite.ir as ir

 # Load an LL file
with open('example.ll', 'r') as f:
    ir_str = f.read()
module = llvm.parse_assembly(ir_str)

fsd = fsd.fs_data(module)

print('Function List:')
print(fsd.function_list)

print('Block List:')
print(fsd.block_list)

print('Specific Block, Entry of main function:')
print(fsd.get_block('main', 'entry'))

print('For List:')
print(fsd.for_list)