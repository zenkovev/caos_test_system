import sys
sys.path += ["tmp_files"]

from help_functions import RunFactorOut

RunFactorOut("abc", is_exception=True)
RunFactorOut([10, 20], is_exception=True)
RunFactorOut(10, 20, is_exception=True, last_run=True)
