def function_print(a, b):
    print(b)
    print(a)

def str_to_str(string) -> str:
    return "[" + string + "]"
    
def void():
    print()
    
if (True):
    print("a")
    print("b")


list_obj = ["abc", "cba"]
number = 42



print({"alpha": "beta"})
print({"gamma": "delta"})
function_print(["assert", "mutex", "condvar"], list_obj)
function_print(str_to_str("fiber"), "fibers")
function_print(number, "wait_group")
function_print("fun", "lazy")
function_print(str_to_str("abra"), str_to_str("cadabra"))
function_print(str_to_str("ELF"), "text")

print("Finish")
