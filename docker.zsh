if ((!$ + commands[docker])); then
	return
fi

#alias for docker
alias de='docker exec -it '
alias docker_get_ip='docker inspect --format "{{ .NetworkSettings.IPAddress }}"'
alias docker_clean_all_force='docker system prune -af'
alias docker_clean_cache='docker builder prune'
alias docker_check_storage='docker system df'

# alias for docker compose

alias dc='docker-compose'
alias dcu='docker-compose up -d'
alias dcd='docker-compose down'
alias dce-root='docker-compose exec -u0'
alias docker_tui=lazydocker


function de (){
	docker exec -it $1 bash 
}

function docker-getIP(){
    docker inspect --format '{{ .NetworkSettings.IPAddress }}' $1
}

function docker-stack-getIP(){
  ifconfig docker_gwbridge|grep netmask|awk '{print $2}'
}

docker_remove_stop_container(){
  filter=$1
  shift
  docker ps -a |grep $filter| awk '{print $1}'| xargs -I{} docker rm {} $@
}

docker_remove_unused_images(){
  filter=$1
  shift
  docker images |grep "${filter}" | awk '{print $3}' | xargs -I{} docker rmi {} $@
}

