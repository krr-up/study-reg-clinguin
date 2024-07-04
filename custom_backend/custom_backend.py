from clinguin.server.application.backends import ClingoBackend
import clingo
from clingo.script import enable_python
from typing import Dict, Tuple, Any

# Enable Python scripting in clingo
enable_python()

class CustomBackend(ClingoBackend):
    """
    A custom backend that extends ClingoBackend to handle dynamic constant updates.
    """

    def __init__(self, args: Any):
        """
        Initialize the CustomBackend.
        
        Args:
            args: Command-line arguments passed to the backend.
        """
        super().__init__(args)
        self.current_constants = self._parse_command_line_constants()
        self._add_domain_state_constructor("_generate_constant_facts")

    def _parse_command_line_constants(self) -> Dict[str, int]:
        """
        Parse initial constants from command-line arguments.
        
        Returns:
            A dictionary of constant names and their integer values.
        """
        return {
            name: int(value)
            for const in self.args.const
            for name, value in [const.split("=")]
        }

    def update_constant(self, name: str, value: Any) -> Tuple[bool, str]:
        """
        Update a constant value and refresh the backend if necessary. This method handles input from UI as string
        and also allows direct integer updates.
        
        Args:
            name: The name of the constant to update.
            value: The new value for the constant, either as an integer or string.

        Returns:
            A tuple containing a boolean indicating success and a message string.
        """
        try:
            new_value = int(value)
            if name not in self.current_constants or self.current_constants[name] != new_value:
                self.current_constants[name] = new_value
                self._refresh_constant_arguments()
                self._outdate()
                self._init_ctl()
                self._ground()
            return True, f"Constant {name} updated successfully to {new_value}"
        except ValueError:
            return False, f"Invalid input: constant {name} must be an integer"

    def _refresh_constant_arguments(self) -> None:
        """
        Refresh the internal representation of constants for Clingo arguments.
        """
        self._constants = [f"-c {name}={value}" for name, value in self.current_constants.items()]

    def _init_ctl(self) -> None:
        """
        Initialize the clingo Control object with updated constants.
        """
        self._ctl = clingo.Control(["0"] + self._constants)
        super()._init_ctl()

    @property
    def _generate_constant_facts(self) -> str:
        """
        Generate Prolog facts representing current constants for the domain state.
        
        Returns:
            A string containing Prolog facts for each constant.
        """
        return "\n".join(f"current_constant({name},{value})." 
                         for name, value in self.current_constants.items()) + "\n"

    def get_current_constants(self) -> Dict[str, int]:
        """
        Get the current values of all constants.
        
        Returns:
            A dictionary of current constant names and their values.
        """
        return self.current_constants



    def test_clear_atoms(self):
        """
        A test method adapted from clear_atoms to see if method calling works in the UI.
        """
        self._outdate()
        self._atoms = set()
        self._init_ctl()
        self._ground()
