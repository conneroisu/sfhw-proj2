"""Mars Interface.

Date:
    2022.08.24
"""

import subprocess
from pathlib import Path

import logging
logger = logging.getLogger(__name__)

class Mars:
    """Interface into mars execution.
    """

    def __init__(self, mars_path):
        """Creates new Mars object.

        Args:
            mars_path (str): String or pathlike to mars jar
        """
        logger.debug(f'New Mars runner, using jar {mars_path}')
        self.mars_path = Path(mars_path)  #:Mars Path

        if not self.mars_path.is_file():
            raise FileNotFoundError

    def check_asm_file(self, asm_file_path):
        """Set the asm file to use.

        Checks if the given file exists.

        Args:
            asm_file_path (str) : String or path like to asm file

        Returns:
            True if file exists, else false
        """
        asm_file_path = Path(asm_file_path)

        if not asm_file_path.is_file():
            logger.warning('ASM file "{self.asm_file_path}" does not exist')
            return False

        return True

    def check_assemble(self, asm_file_path):
        """Assembles MIPS file.

        Args:
            asm_file_path (str) : String or Pathlike to MIPS file

        Returns:
            list of errors (empty if no errors)

        """
        if not self.check_asm_file(asm_file_path):
            return [f'Error: file "{asm_file_path}" does not exists', ]

        errors = subprocess.check_output(
            ['java','-jar', self.mars_path, 'nc', 'a', asm_file_path],
            stderr=subprocess.STDOUT,
            encoding='utf8'
            )

        error_list = errors.split('\n')[:-3] # Throw away the last 3 lines, as they are general messages

        logger.info(f'Assembled file {asm_file_path}. Found {len(error_list)} errors.')

        return error_list

    def generate_hex(self, asm_file_path, output_path):
        """Generates hex files for IMEM and DMEM sections.

        This generates both IMEM and DMEM hex files. The method assumes that the assembly file
        correctly compiles

        Args:
            output_path (str) : String or path like to output files.
                Output files will be {output_path}.imem and {output_path}.dmem

            asm_file_path (str): String or path like to assembly file

        Returns:
            True if succesfull, else false

        """

        if not self.check_asm_file(asm_file_path):
            return False

        imem_path = Path(output_path) / 'imem.hex'
        dmem_path = Path(output_path) / 'dmem.hex'
    
        subprocess.check_output(
            ['java', '-jar', self.mars_path, 'a', 'dump', '.text', 'HexText', imem_path, asm_file_path],
            )
    
        # create the dump file in case no data mem dump is generated
        dmem_path.touch()
    
        subprocess.check_output(
            ['java', '-jar', self.mars_path, 'a', 'dump', '.data', 'HexText', dmem_path, asm_file_path],
            )

        logger.info(f'Generated hex files {imem_path} and {dmem_path}')
        return True


    def run_sim(self, asm_file_path, output_trace, timeout=30):
        '''Simulates given MIPS file.

        Args:
            asm_file (str) : String or pathlike of asm_file
    
        Returns:
            list of errors (empty if no errors)
        '''
        logger.info(f'Simulating file {asm_file_path}')

        if not self.check_asm_file(asm_file_path):
            return [f'Error: file "{asm_file_path}" does not exists', ]

        mars_out = subprocess.run(
            ['timeout', str(timeout), 'java', '-jar', self.mars_path, 'nc', 'ar', asm_file_path],
            encoding='utf8',
            stdout=subprocess.PIPE,
            stderr=subprocess.STDOUT
            )
    
        if mars_out.returncode == 124:
            logger.warning('Mars hit infinite loop.')
            mars_errs.append('Mars hit infinite loop. Check assembly file for infinte recursion or loops.')
        
        mars_errs = self.check_mars_dump(mars_out.stdout)

        with open(output_trace, 'w') as f:
            f.write(mars_out.stdout)

        return mars_errs


    def check_mars_dump(self, output):
        '''Checks mars dump for errors.

        Args:
            output (str) : Mars output trace

        Returns:
            None if no error, else next error

        '''
    
        # Mars does not seem provide non-zero error codes, so we need to look at the dump to check for errors
        # We defensively check for the assembly file not existing, so an invalid argument should not be possible
        # This method scans the dump and checks for lines starting with 'Error '

        errors = []
    
        for line in output.split('\n'):
            if line.startswith('Error '):
                logger.warning(f'Found MARS sim error - {line.rstrip()}')
                errors.append(line.rstrip())

        return errors
    
