cmake_minimum_required(VERSION 3.2)
project(pydbg)

set(CMAKE_C_STANDARD 11)

find_package(Python3 3.8 EXACT REQUIRED COMPONENTS Interpreter Development)

add_executable(pydbg-bin ${PROGRAM_NAME})
target_link_libraries(pydbg-bin PRIVATE Python3::Python)
