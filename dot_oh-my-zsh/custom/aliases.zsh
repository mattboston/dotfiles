# Aliases

command -v colorls >/dev/null 2>&1 && { alias dir='colorls -la'; } || { alias dir='ls -lasF'; }
# alias dir='ls -lasF'

## Colorize

alias \
  ls="ls -hN --color=auto --group-directories-first" \
  grep="grep --color=auto" \
  diff="diff --color=auto" \
  ccat="highlight --out-format=ansi" \
  ip="ip -color=auto"

## Ansible

alias \
  a='ansible ' \
  aconf='ansible-config ' \
  acon='ansible-console ' \
  aver='ansible-version' \
  apb='ansible-playbook ' \
  ainv='ansible-inventory ' \
  adoc='ansible-doc ' \
  agal='ansible-galaxy ' \
  apull='ansible-pull ' \
  aval='ansible-vault' \
  ansible-version='ansible --version'

alias k="kubectl"
alias h="helm"
alias tf="terraform"
alias ap="ansible-playbook"
alias c="cursor ."
alias cm="chezmoi"
alias cddf="cd ~/Development/fsc-platform"
function cdd() {
  cd ~/Development/$1
}

alias wgetp='wget -P ~/Downloads/'

# remove % symbol from curl answer in zsh (-w) as well as other odd output (-s):
alias curl="curl -s -w '\n'"

alias ipconfig="curl ifconfig.co/json"
