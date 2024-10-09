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
	```bash
	clinguin client-server --domain-files instances/cogsys.lp encodings/meta.lp encodings/cogsys_info.lp encodings/preference.lp --ui-files ui/ui_main.lp -c n=3
	```

### Clinguin Version

`Clinguin 2.0.0`
