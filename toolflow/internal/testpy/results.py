import pathlib

class Results:
    asm_path: str|None = None

    mars_pass: bool = False
    mars_compile_errs: list[str] = []
    mars_sim_errs: list[str] = []

    modelsim_pass: bool = False
    modelsim_errs: list[str] = []

    compare_pass: bool = False
    compare_errs: list[str] = []

    mars_inst: int = 1
    proc_cycles: int = 0

    dest_path: str = ""

    def __init__(self, asm_path: str):
        """ Inits new results class.
        """
        self.asm_path = asm_path
        return

        return [str(asm_path), sim_success, modelsim_msg, compare, compare_out, cpi, f'output/{pathlib.Path(asm_path).name}']

