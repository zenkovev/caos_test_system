import numpy as np

def input_list() -> list:
  return [int(num) for num in input().split()]

print("===== Random matrix of size 2 =====")
print("Matrix has correct type")

A = [input_list(), input_list()]
A = np.matrix(A)
input()
B = [input_list(), input_list()]
B = np.matrix(B)

C = A @ B
C = [[float(num) for num in row] for row in C.tolist()]
print(C)
