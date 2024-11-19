# Aliases

command -v colorls > /dev/null 2>&1 && { alias dir='colorls -la'; } || { alias dir='ls -lasF'; }
alias k="kubectl"
alias h="helm"
alias tf="terraform"
alias a="ansible"
alias ap="ansible-playbook"
alias cm="chezmoi"
#alias cdd="cd ~/Development"
function cdd() {
    cd ~/Development/$1
}

alias wgetp='wget -P ~/Downloads/'

# remove % symbol from curl answer in zsh (-w) as well as other odd output (-s):
alias curl="curl -s -w '\n'"

alias ipconfig="curl ifconfig.co/json"
