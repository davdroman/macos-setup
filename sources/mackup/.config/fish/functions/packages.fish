function update_all_packages
    brew update && \
    brew cask upgrade && \
    gem update && \
    gem cleanup && \
    npm update -g && \
    brew upgrade && \
    brew cleanup
end
