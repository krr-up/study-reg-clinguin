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
	### With and without examination tasks (comment in main_encoding.lp)
	```bash
	clinguin client-server --domain-files instances/main_cogsys_inst.lp encodings/main_encoding.lp --ui-files ui/ui_main.lp -c n=4
	```

### Clinguin Version

`Clinguin 2.4.1`
