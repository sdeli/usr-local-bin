# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block, everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="/home/sandor/.oh-my-zsh"

source $HOME/antigen.zsh

antigen use oh-my-zsh

antigen bundle nvm
antigen bundle git
antigen bundle fzf
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions
antigen theme romkatv/powerlevel10k

antigen apply

source $ZSH/oh-my-zsh.sh

custom_fzf() {
   find * -type f | fzf --height 80% --reverse --border
}

zle -N custom_fzf_widget custom_fzf

bindkey 'ert' custom_fzf_widget

alias myip="curl http://ipecho.net/plain; echo"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

PATH="$PATH:/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin:/home/sandor/.nvm/versions/node/v10.16.3/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:/home/sandor/.antigen/bundles/robbyrussell/oh-my-zsh/lib:/home/sandor/.antigen/bundles/robbyrussell/oh-my-zsh/plugins/git:/home/sandor/.antigen/bundles/robbyrussell/oh-my-zsh/plugins/fzf:/home/sandor/.antigen/bundles/zsh-users/zsh-syntax-highlighting:/home/sandor/.antigen/bundles/zsh-users/zsh-autosuggestions:/home/sandor/.antigen/bundles/romkatv/powerlevel10k:/home/sandor/.fzf/bin"

fzfHistorySearch() {
  echo $(fc -l -n 1 | sed 's/^\s*//' | fzf --height 80% --layout reverse --no-info --border --color 'fg:#52ca51,fg+:#e04156,border:#e8cd02,info:#52ca51,pointer:#52ca51,prompt:#e04156')
}

fzfHistoryWidget() {
  LBUFFER="${LBUFFER}$(fzfHistorySearch)"
  local ret=$?
  zle reset-prompt
  return $ret
}

zle     -N   fzfHistoryWidget
bindkey 'hs' fzfHistoryWidget
