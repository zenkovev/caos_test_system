def IsCorrectMatrixType(matrix) -> bool:
  if (type(matrix) != list):
    return False
  for i in range(len(matrix)):
    if (type(matrix[i]) != list):
      return False
    for j in range(len(matrix[i])):
      if (type(matrix[i][j]) != float):
        return False
  return True

def IsCorrectMatrixTypePrint(matrix):
  if (IsCorrectMatrixType(matrix)):
    print("Matrix has correct type")
  else:
    print("Matrix has incorrect type")
