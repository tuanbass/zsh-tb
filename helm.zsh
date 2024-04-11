if (( ! $+commands[helm] )); then
  return
fi

# If the completion file does not exist, generate it and then source it
# Otherwise, source it and regenerate in the background
if [[ ! -f "$ZSH_CACHE_DIR/completions/_helm" ]]; then
  helm completion zsh | tee "$ZSH_CACHE_DIR/completions/_helm" >/dev/null
  source "$ZSH_CACHE_DIR/completions/_helm"
else
  source "$ZSH_CACHE_DIR/completions/_helm"
  helm completion zsh | tee "$ZSH_CACHE_DIR/completions/_helm" >/dev/null &|
fi

# define some aliases

alias h='helm'
alias hin='helm install'
alias hun='helm uninstall'
alias hse='helm search'
alias hup='helm upgrade'


alias hls='helm list'
alias hlist='echo use hls instead!!!'
alias hlsa='helm ls --all'
alias hget='helm get'
alias hgetv='helm get values'
alias hgetva='helm get values --all'
alias hgeta='helm get all'
alias hhist='helm history'
alias hcrt='helm create'
alias hdp='helm dependency'
alias hrp='helm repo'
alias hdpu='helm dependency update'
alias hdpx='(cd charts && for filename in *.tgz; do tar -xf "$filename" && rm -f "$filename"; done;)'
alias hup='helm upgrade --install'
alias hun='helm uninstall'
alias hst='helm status'

helm-list-all-resource() {
  release_name=$1
  kubectl get all --all-namespaces -l="app.kubernetes.io/managed-by=Helm,app.kubernetes.io/instance=${release_name}"
}

