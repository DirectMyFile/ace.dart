# Install Dartium content_shell
$DART_SDK/../chromium/download_contentshell.sh
unzip content_shell-linux-x64-release.zip
mkdir content_shell
mv drt*/* ./content_shell

# Pub get dependencies
pub get

# Start virtual frame buffer
sudo start xvfb

# Run tests in Dartium content_shell
./content_shell/content_shell --dump-render-tree test/ace_test.html

# Generate API docs and push to gh-pages
dartdoc --package-root packages --include-lib ace,ace.proxy lib/ace.dart lib/proxy.dart
git checkout gh-pages
cd docs/
cp -r . ..
cd ../
git add -A
git commit -m"auto commit from drone"
git remote set-url origin git@github.com:rmsmith/ace.dart.git
git push origin gh-pages
