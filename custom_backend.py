from collections import defaultdict
import re
from clinguin.server.application.backends import ClingoMultishotBackend
from clingo import Control
from typing import Tuple, Any


class CustomBackend(ClingoMultishotBackend):
    def __init__(self, args: Any):
        # Parse and store constants
        self.current_constants = {
            name: value
            for const in (args.const or [])
            for name, value in [const.split("=")]
        }
        super().__init__(args)
        # Add a method to generate constant facts for the domain state
        self._add_domain_state_constructor("_ds_generate_constant_facts")

	# ---------------------------------------------
    # Setup
    # ---------------------------------------------


    def _init_ctl(self):
        """Initialize the Clingo control object with current constants and domain files."""
        try:
            # Create constant definitions and initialize Control
            const_defs = [
                f"-c {name}={value}" for name, value in self.current_constants.items()
            ]
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
        
	# ---------------------------------------------
    # Public methods
    # ---------------------------------------------


    def update_constant(self, name: str, value: Any) -> Tuple[bool, str]:
        """Update a constant value and reinitialize the control if necessary."""
        try:
            name = name.strip('"')
            new_value = str(value).strip('"')

            if self.current_constants.get(name) != new_value:
                self.current_constants[name] = new_value
                self._assumptions = set()
                self._outdate()
                self._init_ctl()
                self._ground()
            return True, f"Constant {name} updated successfully to {new_value}"
        except ValueError:
            return (
                False,
                f"Error updating constant {name}: Provided value must be an integer",
            )
        except Exception as e:
            return False, f"Error updating constant {name}: {str(e)}"


    def custom_download(self, file_name="study_plan.lp"):
        """
        Custom download function to save the solution in a more user-friendly format,
        showing only assignments related to semesters and formatting them.
        """
        if self._model is None:
            raise RuntimeError("Can't download when there is no model")

        # Filter the model to include only semester assignments
        semester_assignments = [
            f"{str(atom)}."
            for atom in self._model
            if re.match(r"in\(\w+,s\(\d+\)\)", str(atom))
        ]

        # Format the StudyPlan
        semesters = defaultdict(list)
        for line in semester_assignments:
            match = re.match(r"in\((\w+),s\((\d+)\)\)\.", line.strip())
            if match:
                module, semester = match.groups()
                semesters[int(semester)].append(module)

        formatted_output = ""
        for semester in sorted(semesters.keys()):
            formatted_output += f"Semester {semester}:\n"
            for module in semesters[semester]:
                formatted_output += f"{module}\n"
            formatted_output += "\n"

        # Write the formatted output to the file
        file_name = file_name.strip('"')
        with open(file_name, "w", encoding="UTF-8") as file:
            file.write(formatted_output)

        self._messages.append(
            (
                "Download successful",
                f"Information saved in file {file_name}.",
                "success",
            )
        )

	# ---------------------------------------------
    # Properties
    # ---------------------------------------------

    @property
    def _ds_generate_constant_facts(self) -> str:
        """Generate facts for current constants."""
        facts = [
            f"_clinguin_const({name},{value})."
            for name, value in self.current_constants.items()
        ]
        return "#defined _clinguin_const/2." + " ".join(facts) + "\n"