#!/bin/bash

session="_popup_$(tmux display -p '#S_#{pane_current_path}')"
# Maybe I'll change things in the future.
# There will be one session for all popups,
# and every path will have its own window.
# So I'll be able to create this session on startup
# and then set all the options for it.
# current_path="$(tmux display -p '#{pane_current_path}')"

if ! tmux has -t "$session" 2> /dev/null; then
  parent_session="$(tmux display -p '#{session_id}')"
  session_id="$(tmux new-session -dP -s "$session" -F '#{session_id}' -e TMUX_PARENT_SESSION="$parent_session")"
  tmux set-option -s -t "$session_id" key-table popup
  tmux set-option -s -t "$session_id" status off
  tmux set-option -s -t "$session_id" prefix None
  session="$session_id"
fi

exec tmux attach -t "$session" > /dev/null
