cmake_minimum_required(VERSION 3.0)

project(libresources VERSION 1.0.0 LANGUAGES C)

include(additional_execution.cmake)

#file(GLOB_RECURSE RESOURCES "generated/resources/*.c")
file(GLOB_RECURSE OBJS "generated/resources/*.obj")
file(GLOB_RECURSE SRCS "platform/win32/dummy.c")

# Add executable
add_library(libresources ${SRCS} ${OBJS} ${RESOURCES})

# Add CMake find_package() integration
set(CONFIG_INSTALL_DIR "${CMAKE_INSTALL_LIBDIR}/cmake/${PROJECT_NAME}")
set(PROJECT_CONFIG "${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}Config.cmake")
set(TARGETS_EXPORT_NAME "${PROJECT_NAME}Targets")
set(NAMESPACE "unofficial::libresources::")

export(TARGETS libresources NAMESPACE ${NAMESPACE} FILE libresourcesTargets.cmake)

install(TARGETS libresources
  EXPORT ${TARGETS_EXPORT_NAME}
  RUNTIME DESTINATION bin
  LIBRARY DESTINATION lib
  ARCHIVE DESTINATION lib
  INCLUDES include
)

include(CMakePackageConfigHelpers)
write_basic_package_version_file(
    libresourcesConfigVersion.cmake
    VERSION ${PACKAGE_VERSION}
    COMPATIBILITY AnyNewerVersion
)

configure_package_config_file("libresourcesConfig.cmake.in" "${PROJECT_CONFIG}" INSTALL_DESTINATION "${CONFIG_INSTALL_DIR}")
install(FILES "${PROJECT_CONFIG}" DESTINATION "${CONFIG_INSTALL_DIR}")

install(EXPORT ${TARGETS_EXPORT_NAME}
        NAMESPACE ${NAMESPACE}
        DESTINATION "${CONFIG_INSTALL_DIR}")

configure_file(libresourcesConfig.cmake.in libresourcesConfig.cmake @ONLY)