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
