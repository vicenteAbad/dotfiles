# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="flazz"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
if [[ $OSTYPE == 'darwin'* ]]; then
  alias vim='mvim -v'
  alias whatweb=/Users/abad/Applications/WhatWeb/whatweb
fi
if [[ $TERM_PROGRAM == 'iTerm.app' && $0 == '-zsh' ]]; then
  clear
  echo
  echo
  neofetch
fi
writevartmux(){
  file="$HOME/.vars.txt"     	
  filechoise="$HOME/.varschoise.txt"
  [ -f $file ] || touch $file  
  case "$#" in
 
  2)
    if grep $1 $file &> /dev/null; then
       value=$(grep $1 $file | cut -f 2 -d '=')
       line=$(grep -n $1 $file | cut -f 1 -d ':')
       sed -i -e "$line s/$value/$2/g" $file	         
    else
      echo $1=$2 >> $file	    
      [ $( wc -l $file | awk '{print $1}' ) = "1" ] && echo $1=$2 > $filechoise
    fi
    echo "$1=$2 is new var in tmux vars"    
  ;;

  1)
    	  
    if [ "$1" = 'clear' ]; then
       rm $file $filechoise && touch $file $filechoise	     
       echo "clear all vars in tmuxvars" 
    else	     
      if grep $1 $file &> /dev/null; then
         grep $1 $file > $filechoise
      else
         echo "$1 dont exits"
         return 1
      fi    
      echo "$1 is fixed var now"
    fi
  ;;

  *)
    echo "writevartmux name value : create/update vars"
    echo "writevartmux name       : choise var"
    echo "writevartmux clear      : clear all vars"
    return 1
  ;;
  esac
}
readvartmux(){
  file="$HOME/.vars.txt"     	
  filechoise="$HOME/.varschoise.txt"
  case "$#" in
  1)
    grep "$1=" $file | cut -f 2 -d '='
  ;;
  *)  
    while IFS= read -r line
    do
       grep "$( echo $line | cut -f1 -d '=' )=" $filechoise &>/dev/null && echo -n "--> "  
       echo "$line" 
    done < $file
  ;;
  esac
}
