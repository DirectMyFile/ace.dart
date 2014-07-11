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

# Build the examples
pub build example

# Deploy the examples to gh-pages
git checkout gh-pages
mkdir -p examples
cd build/example/
cp -r . ../../examples
cd ../../

git add -A
git diff-index --quiet HEAD || git commit -m"auto commit from drone"
git remote set-url origin git@github.com:rmsmith/ace.dart.git
git push origin gh-pages
