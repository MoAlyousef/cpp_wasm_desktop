cmake_minimum_required(VERSION 3.15)
project(cpp_frontend)

set(CMAKE_CXX_FLAGS ${CMAKE_CXX_FLAGS} "-s WASM=1 -s EXPORTED_RUNTIME_METHODS=['UTF8ToString','lengthBytesUTF8','stringToUTF8','ccall']")

include(FetchContent)
FetchContent_Declare(
    LIVID
    GIT_REPOSITORY https://github.com/MoAlyousef/livid
    GIT_TAG main
    GIT_SHALLOW TRUE
)
FetchContent_MakeAvailable(LIVID)

add_executable(index src/main.cpp)
set_target_properties(index PROPERTIES SUFFIX .html)
target_compile_features(index PRIVATE cxx_std_17)
target_link_options(index PRIVATE --shell-file ${CMAKE_CURRENT_LIST_DIR}/my_shell.html)
target_link_libraries(index PRIVATE livid::livid)
install(FILES 
        ${CMAKE_CURRENT_BINARY_DIR}/index.html 
        ${CMAKE_CURRENT_BINARY_DIR}/index.wasm 
        ${CMAKE_CURRENT_BINARY_DIR}/index.js
        CONFIGURATIONS Release
        RUNTIME DESTINATION ${CMAKE_CURRENT_LIST_DIR}/../bin)