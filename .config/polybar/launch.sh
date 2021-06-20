#!/usr/bin/env bash

killall -q polybar

log() {
	echo "$1" | tee -a /tmp/polybar.log
}

log "---"
polybar top 2>&1 | tee -a /tmp/polybar.log & disown

log "Bars launched..."
