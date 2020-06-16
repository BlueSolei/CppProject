SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
pushd $SCRIPT_DIR
cd build/bin
if [[ "$1" != "tests" ]]; then
    if [[ -f Dummy.html ]]; then
        source ../activate.sh
        emrun ./Dummy.html
    else
        ./Dummy
    fi
else
    ./DummyTest
fi
popd
