import sys
sys.path += ["tmp_files"]

from help_functions import RunFactorOut

def IsPrime(num):
  div = 2
  while (div*div <= num):
    if (num % div == 0):
      return False
    div += 1

  return True

cnt = 100
for i in range(cnt):
  num = int(input())
  RunFactorOut(num, is_prime=IsPrime(num), last_run=(i+1 == cnt))
