; extends

(command
  name: (command_name) @_command
  (#match? @_command "awk")
  argument: (raw_string) @injection.content
  (#offset! @injection.content 0 1 0 -1)
  (#set! injection.language "awk")
)

(command
  name: (command_name) @_command
  (#match? @_command "jq")
  argument: (raw_string) @injection.content
  (#offset! @injection.content 0 1 0 -1)
  (#set! injection.language "jq")
)
