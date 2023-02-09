cmake_minimum_required(VERSION 3.0)

project(libresources LANGUAGES C)

include(additional_execution.cmake)

file(GLOB_RECURSE RESOURCES "generated/resources/*.c")
file(GLOB_RECURSE OBJS "generated/resources/*.obj")
file(GLOB_RECURSE SRCS "platform/win32/dummy.c")

# Add executable
add_library(libresources ${SRCS} ${OBJS} ${RESOURCES})

export(TARGETS libresources NAMESPACE libresources:: FILE libresourcesTargets.cmake)

install(TARGETS libresources
    EXPORT libresourcesTargets
    LIBRARY DESTINATION lib
    ARCHIVE DESTINATION lib
    RUNTIME DESTINATION bin
)