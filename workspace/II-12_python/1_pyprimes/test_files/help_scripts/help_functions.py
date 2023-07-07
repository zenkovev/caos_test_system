import primes

def IsCorrectListOfInt(element) -> bool:
  if (type(element) != list):
    return False
  for i in range(len(element)):
    if (type(element[i]) != int):
      return False
  return True

def IsCorrectFactorizationTypePrint(factorization, is_prime):
  if (is_prime and type(factorization) == str):
    print("Factorization has correct type")
    return
  if ((not is_prime) and IsCorrectListOfInt(factorization)):
    print("Factorization has correct type")
    return
  print("Factorization has incorrect type")
  return

def RunFactorOut(*args, is_prime=False, is_exception=False, last_run=False):
  print("Factorization of number " + ", ".join(["{}".format(x) for x in args]))

  if (not is_exception):
    factorization = primes.factor_out(*args)
    IsCorrectFactorizationTypePrint(factorization, is_prime=is_prime)
    print(factorization)
  else:
    try:
      print(primes.factor_out(*args))
      print("Factorization has not exception")
    except Exception as e:
      print("Factorization has exception")
      print(type(e))

  if (not last_run):
    print()
