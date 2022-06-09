echo Creating virtual environment
if exist venv\pyenv.cfg (
	echo Virtual Environment Exists. Skipping...
) else (
	py -3.7 -m venv ./venv/
	echo Virtual Environment Created
)
echo Installing dependencies
cmd /c venv\scripts\activate.bat ^
& python -m pip install --upgrade pip ^
& python -m pip install -r python_code/requirements.txt
echo Done
