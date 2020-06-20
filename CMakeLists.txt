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
conan_cmake_run(
  CONANFILE
  conanfile.txt
  PROFILE
  ${CONAN_PROFILE}
  BASIC_SETUP
  BUILD
  missing)

include(env/emscripten.cmake)

set(CMAKE_CXX_STANDARD 17)

set(EXE_NAME ${CMAKE_PROJECT_NAME})
add_executable(${EXE_NAME})
target_sources(${EXE_NAME} PRIVATE # cmake-format: sortable
                                   src/Main.cpp src/Dummy.cpp src/Dummy.h)
get_target_property(EXE_FILES ${EXE_NAME} SOURCES)
source_group(TREE ${CMAKE_CURRENT_SOURCE_DIR} FILES ${EXE_FILES})
target_link_libraries(${EXE_NAME} ${CONAN_LIBS})
if(WIN32)
  target_compile_definitions(${EXE_NAME} PRIVATE UNICODE _UNICODE)
endif()

if(EMSCRIPTEN)
  wasemize_exe(${EXE_NAME})
endif()

# Tests
set(TEST_NAME ${EXE_NAME}Test)
add_executable(${TEST_NAME})
target_sources(
  ${TEST_NAME}
  PRIVATE # cmake-format: sortable
          src/Dummy.cpp src/Dummy.h tests/DummyTest.cpp tests/Main.cpp)
get_target_property(TEST_FILES ${TEST_NAME} SOURCES)
source_group(TREE ${CMAKE_CURRENT_SOURCE_DIR} FILES ${TEST_FILES})
target_link_libraries(${TEST_NAME} ${CONAN_LIBS})
if(WIN32)
  target_compile_definitions(${TEST_NAME} PRIVATE UNICODE _UNICODE)
endif()

# install( DIRECTORY ${CMAKE_SOURCE_DIR}/env/ DESTINATION
# ${CMAKE_RUNTIME_OUTPUT_DIRECTORY} FILES_MATCHING PATTERN "*.*" PERMISSIONS
# OWNER_READ OWNER_WRITE GROUP_READ WORLD_READ) FILES ${CMAKE_SOURCE_DIR}/env
# DESTINATION ${CMAKE_RUNTIME_OUTPUT_DIRECTORY})
