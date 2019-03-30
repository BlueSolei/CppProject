SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

pushd $SCRIPT_DIR

# project name is eather pwd or the first param
ProjectName=$([ -z "$1" ] && echo $(basename $(pwd)) || echo $1)

FindFiles() {
    git ls-files | grep -v $0
}

# clean, just in case
rm -rf build

# change in files 'Dummy' --> '<ProjectName>'
ProjectNameLower=$(echo $ProjectName | tr '[:upper:]' '[:lower:]')
FindFiles $0 | xargs sed -i '' -e "s/Dummy/$ProjectName/g;s/dummy/$ProjectNameLower/g"

# Change file names from DummyTest.cpp --> <ProjectName>Test.cpp
FindFiles $0 | grep Dummy | sed -e "s/\(\(.*\)Dummy\(.*\)\)/\1 \2$ProjectName\3/g" | xargs -n 2 git mv

git add .

git commit -m "Change project name from 'Dummy' --> '$ProjectName'"

echo remove remote seed project repo
git remote remove origin

popd
