local tint = require('tint')

local function set_dark_theme()
  vim.cmd([[
    set background=dark
    colorscheme catppuccin-macchiato
  ]])
  tint.refresh()
end

local function set_light_theme()
  vim.cmd([[
    set background=light
    colorscheme github
    highlight link LspSignatureActiveParameter CursorLine
  ]])
  tint.refresh()
end

local function set_system_theme()
  local dark_mode = vim.fn.has('mac') == 1
      and vim.fn.system('defaults read -g AppleInterfaceStyle') == 'Dark\n'

  if dark_mode then
    set_dark_theme()
  else
    set_light_theme()
  end
end

local augroup = vim.api.nvim_create_augroup('colorscheme_event_listener', {})
vim.api.nvim_clear_autocmds({ group = augroup })
vim.api.nvim_create_autocmd('Signal SIGUSR1', {
  group = augroup,
  callback = set_system_theme,
})

vim.api.nvim_create_user_command('SetSystemTheme', set_system_theme, {})
vim.api.nvim_create_user_command('SetDarkTheme', set_dark_theme, {})
vim.api.nvim_create_user_command('SetLightTheme', set_light_theme, {})

-- Run on first source
set_system_theme()
tint.setup({ tint = -20, saturation = 0.55 })
