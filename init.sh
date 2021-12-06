#!/usr/bin/env bash

# BASH error handling:
#   exit on command failure
set -e
#   keep track of the last executed command
trap 'LAST_COMMAND=$CURRENT_COMMAND; CURRENT_COMMAND=$BASH_COMMAND' DEBUG
#   on error: print the failed command
trap 'ERROR_CODE=$?; FAILED_COMMAND=$LAST_COMMAND; tput setaf 1; echo "ERROR: command \"$FAILED_COMMAND\" failed with exit code $ERROR_CODE"; tput sgr0;' ERR INT TERM

if [[ "$1" = "--help" ]]; then
    echo Usage: ./init.sh
    echo    Initalize the project.
    echo    Call this first thing, as its recreate the git repo.
    exit 0
fi

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

pushd $SCRIPT_DIR

# project name is eather pwd or the first param
ProjectName=$([ -z "$1" ] && echo $(basename $(pwd)) || echo $1)

FindFiles() {
    git ls-files | grep -v $0
}

# clean, just in case
rm -rf build

echo Project\'s name is changed from "'dummy'" --\> "'$ProjectName'"

# change in files 'dummy' --> '<ProjectName>'
ProjectNameLower=$(echo $ProjectName | tr '[:upper:]' '[:lower:]')
FindFiles $0 | xargs sed -i -e "s/dummy/$ProjectName/g;s/dummy/$ProjectNameLower/g"

# Change file names from dummy-test.cpp --> <ProjectName>Test.cpp
FindFiles $0 | grep dummy | sed -e "s/\(\(.*\)dummy\(.*\)\)/\1 \2$ProjectName\3/g" | xargs -n 2 git mv

popd

git clean -df

rm -rf .git
git init
git add .
git rm --cached init.* 	# no need for init scripts anymore
git commit -m "Seed project files"

# must be the last one, as it deletes this script :-O
git clean -df
