SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
pushd $SCRIPT_DIR
cd bin
if [[ "$1" != "tests" ]]; then
    if [[ -f dummy.html ]]; then
        source ../activate.sh
        emrun ./dummy.html
        source ../deactivate.sh
    else
        ./dummy
    fi
else
    ./dummy-test
fi
popd
