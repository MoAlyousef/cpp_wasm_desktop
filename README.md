# cpp_wasm_desktop

A proof of concept repo showing use of C++ on both frontend and backend. The fronted is done using [livid](https://github.com/MoAlyousef/livid) and [emscripten](https://github.com/emscripten-core/emscripten), while the backend uses [webview](https://github.com/webview/webview) and [cpp-httplib](https://github.com/yhirose/cpp-httplib).

## Requirements

You need a working installation of Emscripten, instructions can be found [here](https://emscripten.org/docs/getting_started/downloads.html), CMake >= 3.15 and a C++17 compiler. Linux requires webkit2gtk, which can be installed from your package manager:
- Debian-based distros: `sudo apt-get install libwebkit2gtk-4.0-dev`.
- RHEL-based distros: `sudo dnf install webkit2gtk3-devel`

For mingw, because of the lack of winrt headers, the build won't succeed.

## Building

Both frontend and backend are cmake projects. You can clone this repo or use it as a template, and you can build by running the bootstrap script.

On posix systems:
```
$ git clone https://github.com/MoAlyousef/cpp_wasm_desktop
$ cd cpp_wasm_desktop
$ chmod +x bootstrap.sh
$ ./bootstrap.sh
```

On Windows:
```
$ git clone https://github.com/MoAlyousef/cpp_wasm_desktop
$ cd cpp_wasm_desktop
$ bootstrap.bat
```

## Running

The build produces a directory called bin which includes the outputs of both the frontend and backend projects. You can just run the app binary:
```
$ bin/app # or bin\app on windows
```

This should spawn a desktop application with the frontend livid frontend.

## Deployment

The app binary is self-contained and only requires the index.html, index.js and index.wasm files. 
The spawned server in the application serves the html statically, but you might need to change mount point to be a different directory depending on how you deploy your application.
The html shell uses bulma from an online cdn, if you don't want an internet connection to be required for your app, consider downloading whatever CSS library and bundling it with your app.