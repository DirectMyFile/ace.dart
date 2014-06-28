#!/bin/sh

# Install Dartium content_shell
$DART_SDK/../chromium/download_contentshell.sh
unzip content_shell-linux-x64-release.zip
mkdir content_shell
mv drt*/* ./content_shell

# Get package dependencies
pub get

# Start virtual frame buffer
sudo start xvfb

# Run tests as dart w/ content_shell
./content_shell/content_shell --dump-render-tree test/ace_test.html

# Build test application javascript
pub build test

# Run tests as javascript w/ content_shell
./content_shell/content_shell --dump-render-tree build/test/ace_test.html
