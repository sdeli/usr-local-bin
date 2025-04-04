# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block, everything else may go below.
# if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#   source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
# fi

# OH-MY-ZSH SETUP ===========
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"
FZF_BASE="/usr/local/opt/fzf"

plugins=(
    git
    sudo
    nvm
    npm
    fzf
    history
    node
    zsh-autosuggestions
    zsh-syntax-highlighting
    doctl
)

source $ZSH/oh-my-zsh.sh

# PATH ====================
PATH="$PATH:/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin:$HOME/.nvm/versions/node/v10.16.3/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:$HOME/.antigen/bundles/robbyrussell/oh-my-zsh/lib:$HOME/.antigen/bundles/robbyrussell/oh-my-zsh/plugins/git:$HOME/.antigen/bundles/robbyrussell/oh-my-zsh/plugins/fzf:$HOME/.antigen/bundles/zsh-users/zsh-syntax-highlighting:$HOME/.antigen/bundles/zsh-users/zsh-autosuggestions:$HOME/.antigen/bundles/romkatv/powerlevel10k:$HOME/.fzf/bin:$HOME/Projects/usr-local-bin"

# ALIASES ================
alias myip="curl http://ipecho.net/plain; echo"
alias gcm="git checkout master"
alias amm="git commit --amend --no-edit; git push origin HEAD -f"
export FZF_CTRL_T_COMMAND='find ~/Projects ~/Downloads ~/Documents ~/Desktop ~/screenshots ~/Desktop ~/.hammerspoon ~/.vscode ~/.ssh ~/.zshrc'

# FZF SETUP =============
# custom_fzf() {
#    find $HOME/Projects $HOME/Downloads | fzf --height 80% --layout reverse --no-info --prompt="${LBUFFER}" --color 'fg:#52ca51,fg+:#e04156,border:#e8cd02,info:#52ca51,pointer:#52ca51,prompt:#e04156'
# }

# zle -N custom_fzf_widget custom_fzf

# bindkey 'qq' custom_fzf_widget

# fzfHistorySearch() {
#   echo $(fc -l -n 1 | sed 's/^\s*//' | fzf --height 80% --layout reverse --no-info --border --prompt="${LBUFFER}" --color 'fg:#52ca51,fg+:#e04156,border:#e8cd02,info:#52ca51,pointer:#52ca51,prompt:#e04156')
# }

# fzfHistoryWidget() {
#   choices=$(fzfHistorySearch)
#   if [ ! -z $choices ];
#   then
#     LBUFFER="${LBUFFER}${choices}"
#   fi
  
#   local ret=$?
#   zle reset-prompt
#   return $ret
# }

# zle     -N   fzfHistoryWidget
# bindkey 'hs' fzfHistoryWidget

fzfGitBranchDeleteSearch() {
  prompt=$1
  echo $(git branch --format='%(refname:short)' | fzf --height 80% --multi --layout reverse --no-info --border --prompt="${prompt}" --color 'fg:#52ca51,fg+:#e04156,border:#e8cd02,info:#52ca51,pointer:#52ca51,prompt:#e04156')
}

fzfGitBranchDeleteSearchWidget() {
  choices=$(fzfGitBranchDeleteSearch 'git branch -D')
  if [ ! -z $choices ];
  then
    LBUFFER="git branch -D ${LBUFFER}${choices}"
  fi

  local ret=$?
  zle reset-prompt
  return $ret
}

zle     -N   fzfGitBranchDeleteSearchWidget
bindkey 'gd' fzfGitBranchDeleteSearchWidget

fzfGitBranchCheckoutSearchWidget() {
  choices=$(fzfGitBranchDeleteSearch 'git checkout')
  if [ ! -z $choices ];
  then
    LBUFFER="git checkout ${LBUFFER}${choices}"
  fi

  local ret=$?
  zle reset-prompt
  return $ret
}

zle     -N   fzfGitBranchCheckoutSearchWidget
bindkey 'gt' fzfGitBranchCheckoutSearchWidget


# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh;