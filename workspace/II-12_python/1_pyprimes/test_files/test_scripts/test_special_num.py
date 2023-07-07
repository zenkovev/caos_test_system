import sys
sys.path += ["tmp_files"]

from help_functions import RunFactorOut

RunFactorOut(1)
RunFactorOut(-1)
RunFactorOut(0, is_exception=True)

RunFactorOut(123456789123456789123456789, is_exception=True)
RunFactorOut(-123456789123456789123456789, is_exception=True)

RunFactorOut(2147483646)
RunFactorOut(2147483647, is_prime=True)
RunFactorOut(2147483648)
RunFactorOut(2147483649)
RunFactorOut(-2147483646)
RunFactorOut(-2147483647, is_prime=True)
RunFactorOut(-2147483648)
RunFactorOut(-2147483649)

RunFactorOut(9223372036854775806)
RunFactorOut(9223372036854775807)
RunFactorOut(9223372036854775808, is_exception=True)
RunFactorOut(9223372036854775809, is_exception=True)
RunFactorOut(-9223372036854775806)
RunFactorOut(-9223372036854775807)
RunFactorOut(-9223372036854775808)
RunFactorOut(-9223372036854775809, is_exception=True, last_run=True)
