# _homebrew.fish to be executed first (so other scripts can prepend to path).
fish_add_path --path /opt/homebrew/bin /opt/homebrew/sbin

set -gx HOMEBREW_NO_ANALYTICS true
set -gx HOMEBREW_USE_INTERNAL_API 1
