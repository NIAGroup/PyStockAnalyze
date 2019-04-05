#!/bin/bash -e

echo "[build] Creating project environment variables"
PROJ_ROOT_DIR=$(git rev-parse --show-toplevel)
PROJ_BUILD_PATH=$PROJ_ROOT_DIR/build
PROJ_SRC_PATH=$PROJ_ROOT_DIR/src
PROJ_TOOL_PATH=$PROJ_ROOT_DIR/tools

PROJ_VENV_NAME='pydjango-build-env'
PROJ_VENV_PATH=$PROJ_BUILD_PATH/$PROJ_VENV_NAME
PROJ_ACTENV_PATH=$PROJ_VENV_PATH/Scripts/activate

# Pointer to manage python script
PROJ_DJNAME='pysdjango'
PROJ_DJANGO_PATH=$PROJ_SRC_PATH/$PROJ_DJNAME
PROJ_MANAGE_PATH=$PROJ_DJANGO_PATH/manage.py
alias manage='python $PROJ_MANAGE_PATH'

# Local environment (not-to-be-commited) directory
PROJ_LOC_PATH=$PROJ_DJANGO_PATH/$PROJ_DJNAME/localenv


# Create activate script pointer
alias activate='source $PROJ_ACTENV_PATH'

if [ ! -d $PROJ_VENV_PATH ]; then
	if [ ! -d $PROJ_BUILD_PATH ]; then
		mkdir $PROJ_BUILD_PATH
	fi

	echo "[build] Creating python virtual environment"
	python -m venv "$PROJ_VENV_PATH"
	# Install dependencies into environment
	echo "[build] Activate virtual environment"
	activate

	echo "[build] Upgrading pip installation"
	python -m pip install --upgrade pip $PROXY_OPT

	echo "[build] Instsalling dependencies"
	pip install -r $PROJ_TOOL_PATH/requirements.txt $PROXY_OPT
else
	echo "[build] Python virtual environment already exists"
fi

# Disable tracking of local environment files
git update-index --skip-worktree $PROJ_LOC_PATH/*.py
	# TODO: Add support for recursive search and ignore

# Don't want people to be able to run these--b/c they may get them wrong
alias stashenv='git update-index --no-skip-worktree $PROJ_LOC_PATH/*.py; git stash push -- $PROJ_LOC_PATH'
alias popenv='git stash pop > /dev/null; git update-index --skip-worktree $PROJ_LOC_PATH/*.py'

gitf_function() {
	stashenv
	git flow feature finish "$1"
	popenv
}

gitp_function() {
	stashenv
	git pull
	popenv
}

alias gits='git flow feature start'
alias gitf='gitf_function'
alias gitp='gitp_function'