cmake_minimum_required(VERSION 3.0)

project(bin2coff LANGUAGES C)

# Add executable
add_executable(${PROJECT_NAME} bin2coff.c)