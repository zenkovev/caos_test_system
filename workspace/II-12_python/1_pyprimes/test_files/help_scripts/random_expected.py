def Factorization(num) -> list:
  factors = []
  div = 2

  while (div*div <= num):
    if (num % div == 0):
      factors.append(div)
      num //= div
    else:
      div += 1
  if (num >= 2):
    factors.append(num)

  return factors

def FactorizationPrint(num):
  factors = Factorization(num)
  if (len(factors) == 1):
    print("Prime!")
  else:
    print(factors)

cnt = 100
for i in range(cnt):
  num = int(input())

  print("Factorization of number {}".format(num))
  print("Factorization has correct type")
  FactorizationPrint(num)

  if (i+1 != cnt):
    print()
