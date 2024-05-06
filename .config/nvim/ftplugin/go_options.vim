setl tw=100

" Use custom treesitter queries to target nodes for spell checking.
setl spell
setl spelloptions+=camel
setl spellcapcheck=

if !exists("b:undo_ftplugin")
  let b:undo_ftplugin = ""
endif

let b:undo_ftplugin .= "| setl tw< | setl spell< | setl spelloptions< | setl spellcapcheck<"
