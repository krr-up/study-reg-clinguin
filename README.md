# Running Clinguin Program
## Prerequisites

- Python 3.10

<details>
<summary>If you don’t have Python installed:</summary>

1. **Download Python 3.10** from the official website: [Python Downloads](https://www.python.org/downloads/release/python-3100/).
2. **Install Python** by following the instructions for your operating system.
	- For Windows, make sure to check the box that says "Add Python to PATH" during installation.
	- For macOS, you can use Homebrew:
		```bash
		brew install python@3.10
		```
	- For Linux, you can use your package manager. For example, on Ubuntu:
		```bash
		sudo apt update
		sudo apt install python3.10
		```
3. **Verify the installation** by running the following command in your terminal or command prompt:
	```bash
	python --version
	```
4. **Install pip** (Python package manager) if it’s not already installed. You can do this by running:
	```bash
	python -m ensurepip --upgrade
	```
5. **Upgrade pip** to the latest version:
	```bash
	pip install --upgrade pip
	```
</details>

- Git
<details>
<summary>If you don’t have Git installed:</summary>

1. **Download Git** from the official website: [Git Downloads](https://git-scm.com/downloads).
2. **Install Git** by following the instructions for your operating system.
	- For Windows, you can use the installer and follow the prompts.
	- For macOS, you can use Homebrew:
		```bash
		brew install git
		```
	- For Linux, you can use your package manager. For example, on Ubuntu:
		```bash
		sudo apt update
		sudo apt install git
		```
3. **Verify the installation** by running the following command in your terminal or command prompt:
	```bash
	git --version
	```
</details>

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
	- What this does:

		- n=4 sets the default number of semesters. Change this number (e.g., n=6) to adjust semesters.

	- The program will open automatically in your browser.

		- If it doesn’t open: Go to http://127.0.0.1:8087/.


## Using the Interface
### 1. Creating a Study Plan
- Choose semesters:
	When the program starts, select the number of semesters (e.g., 4). Columns will appear for each semester.

- Assign modules:
  - Select from dropdown menu of a semester.
  - OR: click the module from the sidebar and assign from the opened window.

### 2. Locking/Unlocking Modules
**To move a module** to another semester:

- Click the lock icon 🔒 on the module (unlocks it).
- Drag the module to a new semester.
- Click the lock icon again to lock it in place.

**To remove a module:** Click the X on the module.

### 3. Auto-Generate a Plan
Click the `Next` button (top-right) to create a random plan.

### 4. Using the Sidebar
**Open the sidebar:**
- Hover over the right edge of the window.

**Set preferences for modules:**

- Click a module to open its information window.
- Choose:

	- **Include:** Must be in the plan.
	- **Exclude:** Cannot be in the plan.
	- **Try to Include/Exclude:** The program will attempt to follow this.

### 5. Clearing Your Plan
Click `Clear` to erase your plan.<br>
⚠️ Warning: This cannot be undone!



### Clinguin Version

`Clinguin 2.4.1`
