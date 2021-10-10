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

add_executable(Dummy)
install(TARGETS Dummy)
target_sources(Dummy PRIVATE # cmake-format: sortable
                             src/Main.cpp src/Dummy.cpp src/Dummy.h)
get_target_property(EXE_FILES Dummy SOURCES)
source_group(TREE ${CMAKE_CURRENT_SOURCE_DIR} FILES ${EXE_FILES})
target_link_libraries(Dummy ${CONAN_LIBS})
if(WIN32)
  target_compile_definitions(Dummy PRIVATE UNICODE _UNICODE)
endif()

if(EMSCRIPTEN)
  wasemize_exe(Dummy)
endif()

# Tests
add_executable(DummyTest)
install(TARGETS DummyTest)
target_sources(
  DummyTest
  PRIVATE # cmake-format: sortable
          src/Dummy.cpp src/Dummy.h tests/DummyTest.cpp tests/Main.cpp)
get_target_property(TEST_FILES DummyTest SOURCES)
source_group(TREE ${CMAKE_CURRENT_SOURCE_DIR} FILES ${TEST_FILES})
target_link_libraries(DummyTest ${CONAN_LIBS})
if(WIN32)
  target_compile_definitions(DummyTest PRIVATE UNICODE _UNICODE)
endif()
