find_program(CONAN_CMD conan)
if(NOT CONAN_CMD AND CONAN_REQUIRED)
    message("Conan C++ package manager isn't installed. installing it now")
    execute_process(COMMAND pip install conan 
                    COMMAND conan remote add bincrafters https://api.bintray.com/conan/bincrafters/public-conan
                    COMMAND conan remote add outcome https://api.bintray.com/conan/ned14/Outcome)
endif()

# Download conan.cmake, download taged release - v0.14
if(NOT EXISTS "${CMAKE_SOURCE_DIR}/env/conan.cmake")
   message(STATUS "Downloading conan.cmake from https://github.com/conan-io/cmake-conan")
   file(DOWNLOAD "https://github.com/conan-io/cmake-conan/raw/v0.14/conan.cmake"
                 "${CMAKE_SOURCE_DIR}/env/conan.cmake")
endif()
include(env/conan.cmake)