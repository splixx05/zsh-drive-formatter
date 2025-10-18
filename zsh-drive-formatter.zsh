# open a new tmux window for this function
# otherwise the function will be run in the current terminal

SRC="${ZSH:-$HOME/.zsh}/plugins/local/zsh-drive-formatter"

function :format() {
  if [[ -n $TMUX ]]; then
    tmux new-window -n usbform "$SRC/form.sh"
  else
    "$SRC/form.sh"
  fi
}
