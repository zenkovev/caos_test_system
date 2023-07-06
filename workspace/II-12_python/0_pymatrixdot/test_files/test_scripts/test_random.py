import sys
sys.path += ["tmp_files"]

import matrix
import help_matrix_type as helper

def input_list() -> list:
  return [int(num) for num in input().split()]

print("===== Random matrix of size 2 =====")

size = 2
A = [input_list(), input_list()]
input()
B = [input_list(), input_list()]

C = matrix.dot(size, A, B)
helper.IsCorrectMatrixTypePrint(C)
print(C)
