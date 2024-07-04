from clinguin.server.application.backends import ClingoBackend
from clingo import Control
from typing import Dict, Tuple, Any

class CustomBackend(ClingoBackend):
    def __init__(self, args: Any):
        # Parse and store command-line constants
        self.current_constants = {
            name: value
            for const in (args.const or [])
            for name, value in [const.split("=")]
        }
        super().__init__(args)
        # Add a method to generate constant facts for the domain state
        self._add_domain_state_constructor("_generate_constant_facts")

    def _init_ctl(self):
        """Initialize the Clingo control object with current constants and domain files."""
        try:
            # Create constant definitions and initialize Control
            const_defs = [f"-c {name}={value}" for name, value in self.current_constants.items()]
            self._ctl = Control(["0"] + const_defs)
            
            # Load domain files and add atoms
            for f in self._domain_files:
                self._ctl.load(str(f))
            for atom in self._atoms:
                self._ctl.add("base", [], str(atom) + ".")
            
            # Ground the program
            self._ctl.ground([("base", [])])
        except Exception as e:
            self._logger.error(f"Error initializing clingo.Control: {e}")
            raise

    def update_constant(self, name: str, value: Any) -> Tuple[bool, str]:
        """Update a constant value and reinitialize the control if necessary."""
        try:
            name = name.strip('"')
            new_value = str(value).strip('"')
            
            if self.current_constants.get(name) != new_value:
                self.current_constants[name] = new_value
                self._outdate()
                self._init_ctl()
            return True, f"Constant {name} updated successfully to {new_value}"
        except Exception as e:
            return False, f"Error updating constant {name}: {str(e)}"

    @property
    def _generate_constant_facts(self) -> str:
        """Generate Prolog facts for current constants."""
        return "\n".join(f"current_constant({name},{value})." 
                         for name, value in self.current_constants.items()) + "\n"

    def get_current_constants(self) -> Dict[str, str]:
        """Return the current constants."""
        return self.current_constants.copy()