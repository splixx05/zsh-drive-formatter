# open a new tmux window for this function
# otherwise the function will be run in the current terminal

function :format() {
  local script_dir="${${(%):-%x}:A:h}"
  local form_script="$script_dir/form.sh"

  if [[ -n $TMUX ]]; then
    tmux new-window -n usbform "$form_script"
  else
    "$form_script"
  fi
}
