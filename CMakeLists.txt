cmake_minimum_required(VERSION 3.19)
project(dummy)

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
source_group(TREE ${CMAKE_CURRENT_SOURCE_DIR})

# library
add_library(dummy)
install(TARGETS dummy)
target_include_directories(dummy PUBLIC src)
target_sources(dummy PUBLIC src/dummy.h)
target_sources(dummy PRIVATE # cmake-format: sortable
                             src/dummy.cpp)
target_link_libraries(dummy PUBLIC ${CONAN_LIBS})
if(WIN32)
  target_compile_definitions(dummy PRIVATE UNICODE _UNICODE)
endif()

# cli
add_executable(dummy-cli)
install(TARGETS dummy-cli)
target_sources(dummy-cli PRIVATE # cmake-format: sortable
                                 src/cli/main.cpp)
target_link_libraries(dummy-cli dummy ${CONAN_LIBS})
set_target_properties(dummy-cli PROPERTIES OUTPUT_NAME dummy)
if(WIN32)
  target_compile_definitions(dummy-cli PRIVATE UNICODE _UNICODE)
endif()

if(EMSCRIPTEN)
  wasemize_exe(dummy)
endif()

# Tests
add_executable(dummy-test)
install(TARGETS dummy-test)
target_sources(dummy-test PRIVATE # cmake-format: sortable
                                  tests/dummy-test.cpp tests/main.cpp)
target_link_libraries(dummy-test dummy ${CONAN_LIBS})
if(WIN32)
  target_compile_definitions(dummy-test PRIVATE UNICODE _UNICODE)
endif()
