#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
pushd "$SCRIPT_DIR" >/dev/null 2>&1 || return
./run.sh --tests
popd >/dev/null 2>&1 || return
