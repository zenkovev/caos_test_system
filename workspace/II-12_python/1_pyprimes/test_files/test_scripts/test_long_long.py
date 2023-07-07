import sys
sys.path += ["tmp_files"]

from help_functions import RunFactorOut

RunFactorOut(549307486781579, is_prime=True)
RunFactorOut(42093170566074323, is_prime=True)
RunFactorOut(96961169801159971, is_prime=True)

RunFactorOut(123456789123456789)
RunFactorOut(2075707605110650, last_run=True)
