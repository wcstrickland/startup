# setting up a virtaul environment
[docs](https://packaging.python.org/guides/installing-using-pip-and-virtual-environments/)

### pip
- sudo pacman -S python-pip
- python3 -m pip install --user --uprade pip
- python3 -m pip install --user virtualenv

### setting up venv
- cd into project root
- python3 -m venv env
    - makes the environment folder
- source env/bin/activate
    - adds a python installation to this bin folder and adds it to your path
- deactivate
    - leaves the venv. No need to recreate each time simply activate an environment
