" https://github.com/adriangoransson/deindent

if executable("deindent")
    augroup DeindentClipboardRegister
        autocmd!
        autocmd TextYankPost *
            \ if v:event["regname"] == "*" |
            \ call setreg("*", system("deindent", getreg("*"))) |
            \ endif
    augroup END
endif
