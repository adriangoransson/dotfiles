; extends

; Set Treesitter capture @spell on certain nodes to spell check names for
; - packages
; - types
; - fields
; - functions/methods (and parameters)
; - variable declarations (with var and :=)

; Use with ftplugin.
; setl spell
; -- camelCased identifiers.
; setl spelloptions+=camel
; setl spellcapcheck=

(package_clause
    (package_identifier) @spell)

(type_spec
  (type_identifier) @spell)

(field_declaration
  (field_identifier) @spell)

(function_declaration
  name: (identifier) @spell)

(method_declaration
  name: (field_identifier) @spell)

(parameter_declaration
  name: (identifier) @spell)

(var_spec
  name: (identifier) @spell)

(short_var_declaration
  left: (expression_list
          (identifier) @spell))

(const_spec
  name: (identifier) @spell)

(method_elem
  name: (field_identifier) @spell)
