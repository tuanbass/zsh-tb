if ((!$ + commands[git])); then
	return
fi

alias ggeturl='git remote get-url'
alias glog='git log --graph --pretty="format:%C(auto,yellow)%h%C(auto,magenta)% G? %C(auto,blue)%>(18,trunc)%ad %C(auto,green)%<(12,trunc)%aN%C(auto,reset)%s%C(auto,red)% gD% D"'
alias gdh='git diff HEAD'
alias gcld='git clone --depth 1'
alias ghash='git rev-parse --short'
alias ghashl='git rev-parse'
alias tiga='tig --all'
alias lg='lazygit'
