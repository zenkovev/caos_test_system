cmake_minimum_required(VERSION 2.9)
project(tutorial_ide C)
set(CMAKE_C_STANDARD 11)

set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${tutorial_ide_SOURCE_DIR}/bin)
add_executable(tutorial_ide tutorial_ide.c)