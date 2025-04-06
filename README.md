# Running Clinguin Program
## Prerequisites

- Python 3.10

## Instructions

1. **Clone the repository and navigate to the project directory:**
	```bash
	git clone https://github.com/krr-up/study-reg-clinguin.git
	cd study-reg-clinguin
	```

2. **Install the required dependencies:**
	```bash
	pip install -r requirements.txt
	```

3. **Run the Clinguin server:**
	### Without examination tasks
	```bash
	clinguin client-server --domain-files instances/cogsys.lp encodings/encoding.lp instances/cogsys_info.lp encodings/preference.lp --ui-files ui/ui_main.lp -c n=4
	```

	### With examination tasks
	```bash
	clinguin client-server --domain-files instances/instance_main.lp encodings/encoding-examinations.lp encodings/preference.lp --ui-files ui/ui_main.lp -c n=4
	```

	### With custom backend
	```
	clinguin client-server --domain-files encodings/encoding-examinations.lp encodings/preference.lp --instance-files instances/instance_main.lp --ui-files ui/ui_main.lp -c n=4 --custom-classes custom_clingo_backend.py --backend CustomClingoBackend
	```

	### Test with custom backend
	```
	clinguin client-server --domain-files example/encoding.lp --instance-files example/i1.lp example/i2.lp --ui-files example/ui.lp --custom-classes custom_clingo_backend.py --backend CustomClingoBackend```
	```


### Clinguin Version

`Clinguin 2.3.1`

