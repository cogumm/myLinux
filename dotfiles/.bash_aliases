alias sudo='sudo '

command_exists () {
    type "$1" &> /dev/null ;
}

ALIASES_HOME=$HOME

for FILE_PREFIX in  git \
                    github \
                    npm \
		    pnpm \
                    yarn
do
  source $ALIASES_HOME/.aliases/${FILE_PREFIX}_aliases
done
