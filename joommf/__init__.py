def test():
    """Call tests of submodules"""
    modules = ['joommfutil', 'discretisedfield', 'oommfodt']
    return_codes = {}

    for module in modules:
        print("Processing {}".format(module))
        command1 = 'm = __import__("{}")'.format(module)
        exec(command1)
        command2 = "return_code = m.test()"
        exec(command2)

        print("Return code is {}".format(return_code))
        return_codes[module] = return_code
