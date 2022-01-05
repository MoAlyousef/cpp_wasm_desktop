#include <cstdlib>
#include <httplib.h>
#include <iostream>
#include <webview.h>
#include <thread>

#ifdef __APPLE__
#include "cocoa_helper.h"
#else
void add_nsmenu() { return; }
#endif

int main() {
    httplib::Server svr;
    auto ret = svr.set_mount_point("/", "./bin");
    if (!ret) {
        std::cerr << "Wrong directory" << std::endl;
        std::exit(-1);
    }
    
    auto handle = std::thread([&]{
        svr.listen("127.0.0.1", 8000);
    });

    webview::webview w(true, nullptr);
    w.set_title("cpp_backend");
    w.set_size(480, 320, WEBVIEW_HINT_NONE);
    w.set_size(180, 120, WEBVIEW_HINT_MIN);
    add_nsmenu();
    w.navigate("http://127.0.0.1:8000");
    w.run();
    
    svr.stop();
    handle.join();
    return 0;
}