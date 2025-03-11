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
	clinguin client-server --domain-files instances/cogsys.lp encodings/encoding.lp encodings/cogsys_info.lp encodings/preference.lp --ui-files ui/ui_main.lp -c n=4
	```

	### With examination tasks
	```bash
	clinguin client-server --domain-files instances/cogsys.lp instances/cogsys-examinations.lp instances/test-cogsys-exams.lp encodings/encoding-examinations.lp encodings/cogsys_info.lp encodings/preference.lp --ui-files ui/ui_main.lp -c n=4
	```


### Clinguin Version

`Clinguin 2.3.1`
