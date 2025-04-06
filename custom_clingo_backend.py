from functools import cache, cached_property
from pydoc import resolve
from clinguin.server.application.backends.clingo_backend import (
	ClingoBackend,
)
from pathlib import Path
from clinguin.utils.annotations import extends

class CustomClingoBackend(ClingoBackend):
	"""
	Custom backend for Clinguin that extends the ClingoBackend class.
	Has an option to update instances dynamically.
	"""

	@extends(ClingoBackend)
	def _init_command_line(self):
		super()._init_command_line()
		self._instance_files = self._args.instance_files
		
		# Save original domain files to a separate attribute
		self._original_domain_files = self._domain_files.copy()

	""" @extends(ClingoBackend)
	def _load_and_add(self):
		super()._load_and_add()
		instance = self._args.instance_files[0]
		path = Path(instance)
		if not path.is_file():
				self._logger.critical("File %s does not exist", instance)
				raise Exception(f"File {instance} does not exist")
		try:
			self._load_file(instance)
		except Exception as e:
				self._logger.critical(
					"Failed to load file %s (there is likely a syntax error in this logic program file).",
					instance,
				)
				self._logger.critical(str(e))
				raise e """
	
	def _set_instance(self, filename: str):
		filename = filename.strip('"')
		if filename not in self._instance_files:
			raise ValueError(f"Instance {filename} not found in provided instance files.")
		
		resolved_path = Path(filename).resolve()
		if not resolved_path.is_file():
			raise FileNotFoundError(f"File '{resolved_path}' does not exist.")
		
		self._domain_files = self._original_domain_files.copy() + [str(resolved_path)]

		self._atoms = set()

	""" def _set_instance(self, i):
		index = int(i)
		instance = self._args.instance_files[index]
		self._domain_files = self._original_domain_files.copy() + [instance]

		self._atoms = set()

		path = Path(instance)
		if not path.is_file():
			self._logger.critical("File %s does not exist", instance)
			raise Exception(f"File {instance} does not exist")
 """
	
	def _init_ds_constructors(self):
		super()._init_ds_constructors()
		self._add_domain_state_constructor("_ds_instance_files")

	@cached_property
	def _ds_instance_files(self):
		prg = "#defined _clinguin_instance/1.\n"
		for f in self._instance_files:
			prg += f'_clinguin_instance("{f}").\n'
		#print(prg)
		return prg


	@classmethod
	def register_options(cls, parser):
		"""
		Registers command line options for CustomClingoBackend.
		"""
		super().register_options(parser)
		parser.add_argument(
			"--instance-files",
			nargs="+",
			help="Files with various instances to be used",
			metavar="",
		)


	def set_instance(self, filename: str):
		self._set_instance(filename)
		self._init_interactive()
		self._outdate()
		self._init_ctl()
		self._ground()