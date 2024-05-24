# function defaultAction() {
#   echo "default action"
# }


# Dirty install for yarn autocomplete
# if it was not setup, set it up

YARN_AUTO_COMP_DIR=$HOME/.antidote/https-COLON--SLASH--SLASH-github.com-SLASH-g-plane-SLASH-zsh-yarn-autocompletions
if [[ ! -f "$YARN_AUTO_COMP_DIR/yarn-autocompletions" ]]; then
	cd $YARN_AUTO_COMP_DIR && ./zplug.zsh
	echo "hello"
fi
