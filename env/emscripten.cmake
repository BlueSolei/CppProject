# code
if(${CMAKE_C_COMPILER} MATCHES "emcc")
  set(EMSCRIPTEN TRUE)
endif()

# functions
function(wasemize_exe TARGET)
  set_target_properties(${TARGET} PROPERTIES SUFFIX ".html" LINK_FLAGS
                                                            "--emrun")

  install(
    TARGETS ${TARGET}
    RUNTIME DESTINATION bin
    LIBRARY DESTINATION lib
    ARCHIVE DESTINATION lib)

  install(FILES ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/${TARGET}.js
                ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/${TARGET}.wasm
          DESTINATION bin)
endfunction(wasemize_exe)
