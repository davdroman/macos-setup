From a fresh install of macOS's Terminal:

1. `xcode-select --install`
2. `curl -sS https://github.com/davdroman/macos-setup/archive/master.zip > macOS.zip`
3. `unzip macOS.zip`
4. `cp macOS "$HOME/Library/Mobile Documents/com~apple~CloudDocs" && rm macOS.zip`
5. `cd "$HOME/Library/Mobile Documents/com~apple~CloudDocs/macOS/scripts"`
6. `./setup.sh`
