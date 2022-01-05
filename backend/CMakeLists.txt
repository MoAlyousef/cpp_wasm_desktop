cmake_minimum_required(VERSION 3.15)
project(cpp_backend)

include(FetchContent)

FetchContent_Declare(
    WEBVIEW
    GIT_REPOSITORY https://github.com/webview/webview
    GIT_SHALLOW TRUE
)
FetchContent_MakeAvailable(WEBVIEW)

FetchContent_Declare(
    HTTPLIB
    GIT_REPOSITORY https://github.com/yhirose/cpp-httplib
    GIT_SHALLOW TRUE
)
FetchContent_MakeAvailable(HTTPLIB)

find_package(Threads REQUIRED)

set(SOURCES src/main.cpp)
if(APPLE)
    set(SOURCES ${SOURCES} src/cocoa_helper.m)
endif()

add_executable(app ${SOURCES})
target_compile_features(app PRIVATE cxx_std_17)
target_include_directories(app PRIVATE ${webview_SOURCE_DIR} ${httplib_SOURCE_DIR})
target_link_libraries(app PRIVATE Threads::Threads)

if(UNIX AND NOT APPLE)
  find_package(PkgConfig)
  pkg_check_modules(WEBKITGTK "gtk+-3.0 webkit2gtk-4.0")
  add_definitions(${WEBKITGTK_CFLAGS} ${WEBKITGTK_CFLAGS_OTHER})
  target_link_libraries(app PRIVATE ${WEBKITGTK_LIBRARIES})
elseif(MSVC)
  set_target_properties(app PROPERTIES VS_CPPWINRT true)
  target_link_libraries(app PRIVATE ${webview_SOURCE_DIR}/script/microsoft.web.webview2.1.0.664.37/build/native/x64/WebView2LoaderStatic.lib)
elseif(WIN32) # mingw
    add_library(WebView2Loader ${webview_SOURCE_DIR}/dll/x64/WebView2Loader.dll)
    add_library(webview ${webview_SOURCE_DIR}/dll/x64/webview.dll)
    target_link_libraries(app PRIVATE WebView2Loader webview)
elseif(APPLE)
  target_link_libraries(app PRIVATE "-framework WebKit" "-framework Cocoa")
else()
  message(FATAL_ERROR "Unsupported platform")
endif()

install(TARGETS app
        CONFIGURATIONS Release
        RUNTIME DESTINATION ${CMAKE_CURRENT_LIST_DIR}/../bin)