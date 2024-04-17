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
#k8s alias
alias kk="k9s --logoless"
kgpf () {
  pod=$(kubectl get pods | fzf | awk '{print $1}')
  echo "Copied $pod to the clipboard"
  echo $pod | clip
}
kgpaf () {
  pod=$(kubectl get pods --all-namespaces | fzf | awk '{print $2}')
  echo "Copied $pod to the clipboard"
  echo $pod | clip
}

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

kgpxx-root() {
	# kubectl get pods , fzf then execute a command against selected pod
	pod=$(kubectl get pods | fzf | awk '{print $1}')
	shell_command=${*:-"sh"}
	command="kubectl pexec -it $pod -- $shell_command"
	echo "$command"
	eval "$command"
}


if [ $(command -v kubech) ]; then   
  
# Temporary switch the k8s context/namespace for this shell
  function kkns(){
    if [ $# = 0 ]; then 
      selection=$(kubechn |fzf)
    else 
      selection=$1
    fi
    kubechn $selection
  }  

  function kkctx(){
    if [ $# = 0 ]; then 
      selection=$(kubechc |fzf)
    else 
      selection=$1
    fi
    kubechc $selection
  }  
fi
