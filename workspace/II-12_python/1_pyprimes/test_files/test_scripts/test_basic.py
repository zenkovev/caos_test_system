import sys
sys.path += ["tmp_files"]

from help_functions import RunFactorOut

RunFactorOut(100)
RunFactorOut(17, is_prime=True)

RunFactorOut(2, is_prime=True)
RunFactorOut(3, is_prime=True)
RunFactorOut(4)
RunFactorOut(5, is_prime=True)
RunFactorOut(6)
RunFactorOut(7, is_prime=True)

RunFactorOut(500)
RunFactorOut(503, is_prime=True)
RunFactorOut(1000)
RunFactorOut(2999, is_prime=True)
RunFactorOut(6007, is_prime=True)

RunFactorOut(502501, is_prime=True)
RunFactorOut(754181, is_prime=True)
RunFactorOut(904811, is_prime=True)

RunFactorOut(1505112)
RunFactorOut(123456789, last_run=True)
