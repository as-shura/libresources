cmake_minimum_required(VERSION 3.0)

project(libresources VERSION 1.0.0 LANGUAGES C)

include(additional_execution.cmake)

#file(GLOB_RECURSE RESOURCES "generated/resources/*.c")
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

include(CMakePackageConfigHelpers)
write_basic_package_version_file(
    libresourcesConfigVersion.cmake
    VERSION ${PACKAGE_VERSION}
    COMPATIBILITY AnyNewerVersion
)

install(EXPORT libresources
        FILE libresourcesTargets.cmake
        NAMESPACE libresources::
        DESTINATION lib/cmake/libresources
)

configure_file(libresourcesConfig.cmake.in libresourcesConfig.cmake @ONLY)