try_compile(RESULT_VAR PROJECT bin2coff
            SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/Utilities/bin2coff
            BINARY_DIR ${CMAKE_CURRENT_BINARY_DIR}/Utilities/bin2coff
            CMAKE_FLAGS
              -DCMAKE_LIBRARY_OUTPUT_DIRECTORY:STRING=${CMAKE_CURRENT_BINARY_DIR}/bin
            OUTPUT_VARIABLE output)
if(NOT RESULT_VAR)
  message(FATAL_ERROR "Failed to compile bin2coff application.\n${output}")
endif()

find_program(bin2coff_EXECUTABLE bin2coff
  "${CMAKE_CURRENT_BINARY_DIR}/Utilities/bin2coff"
  "${CMAKE_CURRENT_BINARY_DIR}/Utilities/bin2coff/bin"
  "${CMAKE_CURRENT_BINARY_DIR}/Utilities/bin2coff/Debug"
  "${CMAKE_CURRENT_BINARY_DIR}/Utilities/bin2coff/Release"
)
message("bin2coff_EXECUTABLE = ${bin2coff_EXECUTABLE}")

file(GLOB_RECURSE FONT_RESOURCES "resources/fonts/*.ttf" "resources/fonts/*.ttc" "resources/fonts/*.otf" "resources/fonts/*.cff")

file(MAKE_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/generated/resources/compiled_fonts)

if(MSVC)
  if(CMAKE_SIZEOF_VOID_P EQUAL 8)
    set(ARCH "x64")
  else()
    set(ARCH "Win32")
  endif()
endif()

message("ARCHITECTURE : ${ARCH}")

foreach(FONT ${FONT_RESOURCES})
    file(COPY ${FONT} DESTINATION ${CMAKE_CURRENT_BINARY_DIR}/fonts)
    get_filename_component(FONT_NAME ${FONT} NAME_WE)
    get_filename_component(FONT_EXT ${FONT} EXT)
    string(REPLACE "." "" EXTENSION ${FONT_EXT})
    set(INPUT_NAME "${FONT_NAME}${FONT_EXT}")
    set(OUTPUT_NAME "${FONT_NAME}_${EXTENSION}.obj")
    #set(OUTPUT_NAME "${FONT_NAME}_${EXTENSION}.c")
    set(FINAL_LABEL "_binary_${FONT_NAME}_${EXTENSION}") 
    #message("${INPUT_NAME} ${OUTPUT_NAME} ${FINAL_LABEL} x64")
    execute_process(COMMAND "${bin2coff_EXECUTABLE}"
        "${CMAKE_CURRENT_BINARY_DIR}/fonts/${INPUT_NAME}" "${CMAKE_CURRENT_SOURCE_DIR}/generated/resources/compiled_fonts/${OUTPUT_NAME}" "${FINAL_LABEL}" "${ARCH}"
        WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
        OUTPUT_VARIABLE OUT RESULT_VARIABLE VAL ERROR_VARIABLE ERR
    )
    if(VAL)
        message(FATAL_ERROR "Failed to run the command.\n${VAL}\n${ERR}")
    endif()
endforeach()
