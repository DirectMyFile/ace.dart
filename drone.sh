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

# TODO: is there a Chromium content_shell we can run here instead of Dartium?
# Run tests as javascript w/ content_shell
./content_shell/content_shell --dump-render-tree build/test/ace_test.html

# Generate API docs and push to gh-pages
docgen --compile --package-root packages --no-include-sdk --no-include-dependent-packages lib/ace.dart lib/proxy.dart
rm -r packages/
mkdir packages
git checkout gh-pages
cd dartdoc-viewer/client/out/web/
rsync -rv --exclude=packages . ../../../..
rsync -rv --exclude=*.dart ../packages ../../../..
cd ../../../../
git add -A
git diff-index --quiet HEAD || git commit -m"auto commit from drone"
git remote set-url origin git@github.com:rmsmith/ace.dart.git
git push origin gh-pages
