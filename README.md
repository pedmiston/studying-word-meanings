# Studying word meanings through the eyes

## Build

The version of reveal.js needed to build this presentation is contained in a git submodule. To build the presentation, you need to clone this repo and download the relevant submodules.

    git submodule init
    git submodule update
    ./build -o  # build and open the presentation

To save the html slides as a pdf, you need to install decktape. These are the steps required taken from the decktape repo.

    curl -L https://github.com/astefanutti/decktape/archive/v1.0.0.tar.gz | tar -xz --exclude phantomjs
    cd decktape-1.0.0
    curl -L https://github.com/astefanutti/decktape/releases/download/v1.0.0/phantomjs-osx-cocoa-x86-64 -o phantomjs
    chmod +x phantomjs
    cd ..

Now you can build the slides to pdf as well.

    ./build -po  # build and open the presentation as a pdf
