import random

matrix_cnt = 2
row_cnt = 2
column_cnt = 2

for matrix_counter in range(matrix_cnt):
  for row_counter in range(row_cnt):
    for column_counter in range(column_cnt):
      print(random.randint(1, 10), end='')
      if (column_counter+1 != column_cnt):
        print(' ', end='')
      else:
        print()
  if (matrix_counter+1 != matrix_cnt):
    print()
