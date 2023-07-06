import sys
sys.path += ["tmp_files"]

import matrix
import help_matrix_type as helper

print("===== Square decreased matrix =====")

size = 2
A = [[1, 2, 3],
     [4, 5, 6],
     [7, 8, 9]]
B = [[10, 11, 12],
     [13, 14, 15],
     [16, 17, 18]]

C = matrix.dot(size, A, B)
helper.IsCorrectMatrixTypePrint(C)
print(C)

print()

print("===== Square increased matrix =====")

size = 4
A = [[1, 2, 3],
     [4, 5, 6],
     [7, 8, 9]]
B = [[10, 11, 12],
     [13, 14, 15],
     [16, 17, 18]]

C = matrix.dot(size, A, B)
helper.IsCorrectMatrixTypePrint(C)
print(C)

print()

print("===== Matrix 3*2 Matrix 2*3 Size 3 =====")

size = 3
A = [[1, 2],
     [4, 5],
     [7, 8]]
B = [[1, 2, 3],
     [4, 5, 6]]

C = matrix.dot(size, A, B)
helper.IsCorrectMatrixTypePrint(C)
print(C)

print()

print("===== Matrix 2*3 Matrix 3*2 Size 2 =====")

size = 2
A = [[1, 2, 3],
     [4, 5, 6]]
B = [[1, 2],
     [4, 5],
     [7, 8]]

C = matrix.dot(size, A, B)
helper.IsCorrectMatrixTypePrint(C)
print(C)

print()

print("===== Matrix 4*2 Matrix 4*2 Size 3 =====")

size = 3
A = [[1, 2, 3, 4],
     [5, 6, 7, 8]]
B = [[1, 2, 3, 4],
     [5, 6, 7, 8]]

C = matrix.dot(size, A, B)
helper.IsCorrectMatrixTypePrint(C)
print(C)
