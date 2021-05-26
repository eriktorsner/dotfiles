alias dcwp='docker-compose exec --user www-data phpfpm wp'

# Go development
export GOPATH="${HOME}/.go"
export GOROOT="$(brew --prefix golang)/libexec"
export PATH="$PATH:${GOPATH}/bin:${GOROOT}/bin"
test -d "${GOPATH}" || mkdir "${GOPATH}"
test -d "${GOPATH}/src/github.com" || mkdir -p "${GOPATH}/src/github.com"

# Valet
alias xdon="mv /usr/local/etc/php/7.4/conf.d/xdebug.ini.dis /usr/local/etc/php/7.4/conf.d/xdebug.ini;valet restart"
alias xdoff="mv /usr/local/etc/php/7.4/conf.d/xdebug.ini /usr/local/etc/php/7.4/conf.d/xdebug.ini.dis;valet restart"

#bitwarden
alias bwunlock='export BW_SESSION=`bw unlock --raw`'

bindkey "^[^[[C" forward-word
bindkey "^[^[[D" backward-word
