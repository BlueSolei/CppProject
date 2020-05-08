cmake_minimum_required(VERSION 3.2)
project(Dummy)

if(NOT CMAKE_BUILD_TYPE)
  message(
    STATUS
      "Build type is default defined as Release. change it by define -DCMAKE_BUILD_TYPE=Debug as param to cmake"
  )
  set(CMAKE_BUILD_TYPE Release)
endif()

include(env/conan_build_tool.cmake)
conan_cmake_run(CONANFILE conanfile.txt BASIC_SETUP BUILD missing)

set(CMAKE_CXX_STANDARD 17)

set(EXE_NAME ${CMAKE_PROJECT_NAME})
set(EXE_FILES src/Main.cpp src/Dummy.cpp src/Dummy.h)
source_group(TREE ${CMAKE_CURRENT_SOURCE_DIR} FILES ${EXE_FILES})
add_executable(${EXE_NAME} ${EXE_FILES})
target_link_libraries(${EXE_NAME} ${CONAN_LIBS})
if(WIN32)
  target_compile_definitions(${EXE_NAME} PRIVATE UNICODE _UNICODE)
endif()

# Tests
set(TEST_NAME ${EXE_NAME}Test)
set(TEST_FILES src/Dummy.cpp src/Dummy.h tests/DummyTest.cpp tests/Main.cpp)
source_group(TREE ${CMAKE_CURRENT_SOURCE_DIR} FILES ${TEST_FILES})
add_executable(${TEST_NAME} ${TEST_FILES})
target_link_libraries(${TEST_NAME} ${CONAN_LIBS})
if(WIN32)
  target_compile_definitions(${TEST_NAME} PRIVATE UNICODE _UNICODE)
endif()

install(
  DIRECTORY ${CMAKE_SOURCE_DIR}/env/
  DESTINATION ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}
  FILES_MATCHING
  PATTERN "*.*" PERMISSIONS OWNER_READ OWNER_WRITE GROUP_READ WORLD_READ)
# FILES ${CMAKE_SOURCE_DIR}/env DESTINATION ${CMAKE_RUNTIME_OUTPUT_DIRECTORY})
