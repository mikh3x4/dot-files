# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH

if [[ ! -f $HOME/.antigen.zsh ]]; then
	echo -e "Antigen not found, installing..."
	cd $HOME
	# git clone https://github.com/zsh-users/antigen.git
	curl -L git.io/antigen > .antigen.zsh
	cd -
fi

source ~/.antigen.zsh
antigen use oh-my-zsh
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle git

# antigen bundle zpm-zsh/ls
# antigen bundle pinelibg/dircolors-solarized-zsh

antigen theme af-magic
antigen apply

source $ZSH/oh-my-zsh.sh

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=7"
ZSH_AUTOSUGGEST_STRATEGY=(match_prev_cmd completion history)

# LS_COLORS from https://geoff.greer.fm/lscolors/
export LS_COLORS="di=34:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43" 

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

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

export PROMPT='%{$fg_bold[blue]%}%n@%m:%{$reset_color%} %{$fg_bold[red]%}$(collapse_pwd)%{$reset_color%} $(_git_prompt)$ '

export PATH=/usr/local/bin:$PATH

export EDITOR=vim

ulimit -c 0
set -o noclobber
alias cp='cp -i'    # prompt before overwriting file
alias mv='mv -i'    # prompt before overwriting file
alias rm='rm -i'    # prompt before removing file

### Stanford (AFS) specific settings

if [ -n "$TMUX" ]; then                                                                               
  function refresh {                                                                                
    export $(tmux show-environment | grep "^KRB5CCNAME")                                       
    export $(tmux show-environment | grep "^DISPLAY")                                             
    aklog
  }                                                                                                 
else                                                                                                  
  function refresh { }                                                                              
fi

function preexec {
    # refresh
}

# IPRL specific settings
export HOME=/juno/u/mikadam

[ -z "${TMUX}" ] && cd ~
# fix for unusual home directory

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/juno/u/mikadam/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/juno/u/mikadam/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/juno/u/mikadam/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/juno/u/mikadam/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

export PATH=~/.local/bin:$PATH

# source $HOME/t2s_venv/bin/activate
#
conda activate nerfhab

# task2shape specific settings

export DATA_DIR=/juno/group/rachel0

# # disables colors on directories
# LS_COLORS=${LS_COLORS/ow=[[:digit:];]#:/ow=1;34:}
