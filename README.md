# PyStockAnalyze
Django web application that takes stock data, analyzes it and presents a graphical user interface.

Note: If you're using a Linux/Mac OS, skip to step 5 and assume that all steps applying to Git Bash apply to the native Terminal

## Environment Setup
1. Install Python 3.7.2 (Check off "Add Python 3.7 to PATH")
   > https://www.python.org/downloads/release/python-372/
2. Install a code editor
   1. Option 1: PyCharm
   2. Option 2: Sublime (https://www.sublimetext.com/3)
   > Note: Make sure your editor is on your windows path or save the path in notepad (to be used in a later step)
3. Install Git Bash:
   > https://git-scm.com/downloads
4. While inside of the git bash commandline, modify proxy to support github access
   > git config --global http.proxy http://<proxy_server>:<port>
   
   > Note: Git bash will be used to make updates to the repository and submit them to the remote repository
5. Open Git Bash and navigate to home directory to create .bashrc file
   > Navigate to home directory by entering ```cd ~```
   
   > ```touch ~/.bashrc```
   
   > To check that this file exists, run ls ~/.bashrc

   > Add the following code to the bashrc file
   ```bash
   # Enable calling python executable
   alias python='winpty python.exe'
   # Setup proxy
   PROXY_OPT=--proxy=--proxy=http://<proxy_server>:<port>
   # Enable building environment through command
   alias buildenv='source $(git rev-parse --show-toplevel)/tools/build_env.sh'
   alias cleanenv='$(git rev-parse --show-toplevel)/tools/clean_env.sh'
   alias setproxy='PROXY_OPT=--proxy=http://<proxy_sever>:<port>'
   alias clrproxy='PROXY_OPT='
   ```
   
   > Make sure to update the PROXY in the bashrc with the correct proxy information behind the firewall

5. Clone repository:
   > ```git clone https://github.com/NIAGroup/PyStockAnalyze.git```

6. Exit Git Bash and re-open it or run "source ~/.bashrc" to make the new commands available for execution while in git bash. The commands are to be used as follows:
   > **buildenv** - Used to create the python virtual environment and install all dependencies

   > **cleanenv** - Used to remove virtual environment build folder and exit environment if it's active



6. Enable git flow:
   ```bash
   cd <repo_path>
   git flow init
   ```

7. Test that the build flow worked by running django webserver:
   ```bash
   manage runserver
   ```
   > Open web browser to the following URL: ```http://127.0.0.1:8000/```

