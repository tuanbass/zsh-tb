if ((!$ + commands[kubectl])); then
	return
fi

alias kgpy='kgp -o=yaml'
alias kgsy='kgs -o=yaml'
alias kgdy='kgd -o=yaml'
alias kgcmy='kgcm -o=yaml'
alias kgssy='kgss -o=yaml'
alias kafd='kubectl apply --dry-run=client -f'
alias kgev='kubectl get events --sort-by=.metadata.creationTimestamp'
alias kgnow='kubectl get nodes -o wide'
alias kak='kubectl apply -k'
# require install kubectx and kubens first, then use this alias
# kube krew install ctx
# kube krew install ns

alias kns='kubectl ns'
alias kctx='kubectl ctx'
alias kvu='kubectl view-utilization -h'

kgpx() {
	# kubectl get pods , fzf then execute a command against selected pod
	pod=$(kubectl get pods | fzf | awk '{print $1}')
	command=${*:-"echo"}
	echo "$command $pod"
	eval "$command $pod"
}

kgpxx() {
	# kubectl get pods , fzf then execute a command against selected pod
	pod=$(kubectl get pods | fzf | awk '{print $1}')
	shell_command=${*:-"sh"}
	# command="kubectl exec -it $pod -- $shell_command"
	command="keti $pod -- $shell_command"
	echo "$command"
	eval "$command"
}
