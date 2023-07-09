cmake_minimum_required(VERSION 3.2)
project(pycsvcalc)

set(CMAKE_C_STANDARD 11)

find_package(Python REQUIRED Development)

add_executable(pycsvcalc-bin ${PROGRAM_NAME})
target_link_libraries(pycsvcalc-bin PRIVATE Python::Python)
