cmake_minimum_required(VERSION 3.2)
project(Dummy)

include(${CMAKE_BINARY_DIR}/conanbuildinfo.cmake)
conan_basic_setup()

set(CMAKE_CXX_STANDARD 17)

add_executable(${CMAKE_PROJECT_NAME} 
  src/Main.cpp
  )

target_link_libraries(${CMAKE_PROJECT_NAME} ${CONAN_LIBS})

# Tests
set(TEST_FILES
	tests/DummyTest.cpp
	tests/Main.cpp
	)
set(TEST_NAME ${CMAKE_PROJECT_NAME}Test)

add_executable(${TEST_NAME} ${TEST_FILES})
target_link_libraries(${TEST_NAME} ${CONAN_LIBS})

