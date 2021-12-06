# make sure we have conan, install if not
find_program(CONAN_CMD conan)
if(NOT CONAN_CMD AND CONAN_REQUIRED)
  message("Conan C++ package manager isn't installed. installing it now")
  execute_process(COMMAND pip install conan COMMAND_ECHO STDOUT
                          COMMAND_ERROR_IS_FATAL ANY)
endif()

# Download conan.cmake, download tagged release - v0.16.1
if(NOT EXISTS "${CMAKE_CURRENT_LIST_DIR}/conan.cmake")
  message(
    STATUS
      "Downloading conan.cmake from https://github.com/conan-io/cmake-conan")
  file(DOWNLOAD
       "https://github.com/conan-io/cmake-conan/raw/v0.16.1/conan.cmake"
       "${CMAKE_CURRENT_LIST_DIR}/conan.cmake")
endif()
include(${CMAKE_CURRENT_LIST_DIR}/conan.cmake)
