set -g fish_key_bindings fish_hybrid_key_bindings

bind -s -M insert ctrl-n down-or-search # accept-autosuggestion in vi mode.
bind -s -M insert ctrl-y nextd-or-forward-word
bind -s -M default ctrl-y nextd-or-forward-word
bind -s -M default V edit_command_buffer
bind -s -M default ctrl-c -m insert cancel-commandline
