# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# ZSH_THEME="robbyrussell"

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
#
#

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


# if [[ ! -d $HOME/antigen ]]; then
if [[ ! -f $HOME/antigen.zsh ]]; then
	echo -e "Antigen not found, installing..."
	cd $HOME
	# git clone https://github.com/zsh-users/antigen.git
	curl -L git.io/antigen > antigen.zsh
	cd -
fi

source ~/antigen.zsh
antigen use oh-my-zsh
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle git

antigen theme af-magic
antigen apply

# export ZSH="/Users/mik/.oh-my-zsh"
# ZSH_THEME="af-magic"
# # plugins=(git)
source $ZSH/oh-my-zsh.sh

# load zgen
# source "${HOME}/.zgen/zgen.zsh"

# # if the init scipt doesn't exist
# if ! zgen saved; then
#     echo "Creating a zgen save"

#     zgen oh-my-zsh

#     # plugins
#     zgen oh-my-zsh plugins/git
#     # zgen oh-my-zsh plugins/sudo
#     # zgen oh-my-zsh plugins/command-not-found
#     # zgen load zsh-users/zsh-syntax-highlighting
#     # zgen load /path/to/super-secret-private-plugin

#     # completions
#     zgen load zsh-users/zsh-completions src

#     # theme
#     # zgen oh-my-zsh themes/arrow

#     # save all to init script
#     zgen save
# fi

# source ~/.zplug/init.zsh

# # Make sure to use double quotes
# # zplug "zsh-users/zsh-history-substring-search"

# zplug "zsh-users/zsh-completions"

# # Supports oh-my-zsh plugins and the like
# zplug "plugins/git",   from:oh-my-zsh


# # Set the priority when loading
# # e.g., zsh-syntax-highlighting must be loaded
# # after executing compinit command and sourcing other plugins
# # (If the defer tag is given 2 or above, run after compinit command)
# zplug "zsh-users/zsh-syntax-highlighting", defer:2

# # Load theme file
# # zplug 'dracula/zsh', as:theme

# # Install plugins if there are plugins that have not been installed
# if ! zplug check --verbose; then
#     printf "Install? [y/N]: "
#     if read -q; then
#         echo; zplug install
#     fi
# fi

# # Then, source plugins and add commands to $PATH
# zplug load --verbose

# ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#ff00ff,bg=cyan,bold,underline"
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=7"
ZSH_AUTOSUGGEST_STRATEGY=(match_prev_cmd completion history)

# disabled history sharing across sessions
setopt no_share_history
unsetopt share_history

function collapse_pwd {
    echo $(pwd | sed -e "s,^$HOME,~,")
}

function _git_branch_name {
  echo $(command git symbolic-ref HEAD 2>/dev/null | sed -e 's|^refs/heads/||')
}

function _is_git_dirty {
  echo $(command git status -s --ignore-submodules=dirty 2>/dev/null)
}

function _git_prompt {
  if [[ $(_git_branch_name) ]]; then
    git_branch='['$(_git_branch_name)']'
    if [[ $(_is_git_dirty) ]]; then
      git_info=%{$fg[red]%}$git_branch"× "%{$reset_color%}
    else
      git_info=%{$fg[green]%}$git_branch" "%{$reset_color%}
    fi
  fi
  echo $git_info
}

#replaces collapse_pwd
function custom_collapse_pwd() {
  local pwd_var="$(collapse_pwd)"
  local directories=("${(@s:/:)pwd_var}")
  local len="$#directories"
  if (( len > 2 )); then
    # Display last two directories with "..." before that
    echo "+/${directories[len-1]}/${directories[len]}"
  else
    # Display the full directory if there are 1 or 2 directories only
    echo "$pwd_var"
  fi
}

PROMPT='%{$fg_bold[yellow]%}%n@%{$fg[yellow]%}%m:%{$reset_color%} %{$fg_bold[red]%}$(custom_collapse_pwd)%{$reset_color%} $(_git_prompt)$ '

# adding brew path
export PATH=/usr/local/bin:$PATH

export EDITOR=vim
alias vim="nvim"
alias v="nvim"


# share history between terminals
setopt share_history

# Created by `pipx` on 2022-09-23 03:01:35
export PATH="$PATH:/Users/mik/.local/bin"
export PATH="$PATH:/snap/bin"

autoload -U bashcompinit
bashcompinit

eval "$(register-python-argcomplete pipx)"

alias rm="echo Use 'del', or the full path i.e. '/bin/rm'"
alias del="trash"

# pyenv setup
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
# eval "$(pyenv virtualenv-init -)"

## windborne stuff
export WINDBORNE_DIR="/home/mik/windborne"

alias amslah='make -f $(git rev-parse --show-toplevel 2> /dev/null || echo ~ )/amslah/Makefile'
alias al="amslah"

export PATH="$WINDBORNE_DIR/bin:$PATH"
export PYTHONPATH="$WINDBORNE_DIR/infra:$PYTHONPATH"

alias p="python3" #this line was added by windborne's setup tool
