alias la='ls -AlFhG'
alias ls='ls -lFhG'

alias update='gem update --system && brew update && brew upgrade && rvm get latest && rvm rubygems latest && upgrade_oh_my_zsh'

alias apbackup='rsync -ahi -s --progress --delete /Users/nicklas/Pictures/Aperture\ Library.aplibrary/ /Volumes/Backup/Aperture\ Library.aplibrary'

alias reload="source ~/.zshrc"

alias fact="elinks -dump randomfunfacts.com | sed -n '/^| /p' | tr -d \|"

alias dsclean='find . -type f -name ".DS_Store" -delete'
alias swpclean="find . -name '*.swp' -delete"
alias guard='bundle exec /usr/bin/env guard'

alias merge-gh-pages='gco gh-pages && git merge master && ggpush && gco master'
