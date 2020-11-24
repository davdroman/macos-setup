function dedup_path --description "Removes duplicate entries from \$PATH"
  set -l NEWPATH
  for p in $PATH
    if not contains $NEWPATH $p
      set NEWPATH $NEWPATH $p
    end
  end
  set PATH $NEWPATH
end

rbenv init - | source
dedup_path # needed cause rbenv does 'set -g' by default

# Helpers

function rblist
  rbenv install --list
end

function rbinstall
  set OPENSSL_DIR (brew --prefix openssl)
  RUBY_CONFIGURE_OPTS="--with-openssl-dir=$OPENSSL_DIR" \
  rbenv install $argv
end

function rbinstalled
  rbenv versions
end

function rbselect
  rbenv global $argv
end

function rbuninstall
  rbenv uninstall $argv
end
