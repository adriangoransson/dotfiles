; extends

(command
  name: (command_name) @_command
  (#match? @_command "awk")
  argument: (raw_string) @awk
)

(command
  name: (command_name) @_command
  (#match? @_command "jq")
  argument: (raw_string) @jq
)
