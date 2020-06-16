# C++ seed project

[![pre-commit](https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit&logoColor=white)](https://github.com/pre-commit/pre-commit)

## Prerequeste

- [CMake](https://cmake.org/download/)
- [Python](https://www.python.org/downloads/)
- [Conan](https://conan.io/downloads.html) (it will be installed by cmake script if not exist)
- On Windos: [Git-Bash](https://git-scm.com/download)

## Create a project

Say you want to have a project name RPC.

### Create the project (Mac/Linux):

- `git clone https://github.com/bluesolei/CppProject RPC`
- `cd RPC`
- `./init.sh`

#### Build & Run:

1. `./build.sh [clean] [wasm]`
2. `./run.sh [tests]`

\* [word] is optional

### Create the project (Windows):

- `git clone https://github.com/bluesolei/CppProject RPC`
- `cd RPC`
- `init.bat`

#### Build & Run:

1. `build.bat [clean] [wasm]`
2. `run.bat [tests]`

\* [word] is optional

### The project files

To dev your project, you can find the native project files (.sln, makefile, etc.) under the `build` folder.
You will have two projects, RPC and RPCTest.
