-- file: colors/tmc.lua
local colorbuddy = require 'colorbuddy'
colorbuddy.setup()

local Color = colorbuddy.Color
local Group = colorbuddy.Group
local c = colorbuddy.colors
local s = colorbuddy.styles

-- Clear existing highlights
vim.cmd 'hi clear'
if vim.fn.exists 'syntax_on' then
  vim.cmd 'syntax reset'
end

-- Set colorscheme name
vim.g.colors_name = 'tmc'
vim.o.background = 'dark'

-- Define colors
Color.new('black', '#0B0B0B')
Color.new('white', '#FFFFFF')
Color.new('grey', '#A0A0A0')

-- Define highlight groups
-- black fg w/white bg
Group.new('Cursor', c.black, c.white, s.NONE)
Group.new('IncSearch', c.black, c.white, s.italic)
Group.new('Search', c.black, c.white, s.italic)
Group.new('Visual', c.black, c.white, s.italic)
Group.new('VisualNOS', c.black, c.white, s.italic)

-- grey fg w/white bg
Group.new('CursorColumn', c.grey, c.white, s.NONE)
Group.new('CursorLine', c.grey, c.white, s.NONE)

-- grey fg w/black bg
Group.new('Comment', c.grey, c.black, s.italic)
Group.new('DiffChange', c.grey, c.black, s.NONE)
Group.new('DiffDelete', c.grey, c.black, s.NONE)
Group.new('DiffText', c.grey, c.black, s.NONE)
Group.new('Directory', c.grey, c.black, s.NONE)
Group.new('Error', c.grey, c.black, s.NONE)
Group.new('Folded', c.grey, c.black, s.NONE)
Group.new('Function', c.grey, c.black, s.bold)
Group.new('Identifier', c.grey, c.black, s.NONE)
Group.new('Ignore', c.grey, c.black, s.NONE)
Group.new('Label', c.grey, c.black, s.bold)
Group.new('LineNr', c.grey, c.black, s.NONE)
Group.new('MatchParen', c.grey, c.black, s.NONE)
Group.new('ModeMsg', c.grey, c.black, s.NONE)
Group.new('MoreMsg', c.grey, c.black, s.NONE)
Group.new('NonText', c.grey, c.black, s.NONE)
Group.new('Normal', c.grey, c.black, s.NONE)
Group.new('PmenuSbar', c.grey, c.black, s.NONE)
Group.new('PmenuSel', c.grey, c.black, s.italic)
Group.new('PmenuThumb', c.grey, c.black, s.NONE)
Group.new('PreProc', c.grey, c.black, s.bold)
Group.new('Special', c.grey, c.black, s.bold)
Group.new('SpecialKey', c.grey, c.black, s.italic)
Group.new('Statement', c.grey, c.black, s.bold)
Group.new('StatusLine', c.grey, c.black, s.bold)
Group.new('StatusLineNC', c.grey, c.black, s.italic)
Group.new('StorageClass', c.grey, c.black, s.bold)
Group.new('Structure', c.grey, c.black, s.bold)
Group.new('TabLine', c.grey, c.black, s.NONE)
Group.new('TabLineFill', c.grey, c.black, s.NONE)
Group.new('TabLineSel', c.grey, c.black, s.bold)
Group.new('Title', c.grey, c.black, s.NONE)
Group.new('Todo', c.grey, c.black, s.bold + s.underline)
Group.new('Type', c.grey, c.black, s.bold)
Group.new('TypeDef', c.grey, c.black, s.bold)
Group.new('Underlined', c.grey, c.black, s.underline)
Group.new('VertSplit', c.grey, c.black, s.NONE)
Group.new('WarningMsg', c.grey, c.black, s.NONE)
Group.new('WildMenu', c.grey, c.black, s.NONE)
Group.new('cucumberTags', c.grey, c.black, s.bold)
Group.new('htmlTagN', c.grey, c.black, s.bold)
Group.new('rubySymbol', c.grey, c.black, s.NONE)

-- white fg w/black bg
Group.new('Constant', c.white, c.black, s.NONE)
Group.new('DiffAdd', c.white, c.black, s.NONE)
Group.new('Number', c.white, c.black, s.NONE)
Group.new('Pmenu', c.white, c.black, s.bold)
Group.new('String', c.white, c.black, s.NONE)

-- -- Treesitter highlight groups to white/black
-- local ts_white_groups = {
--   'variable',
--   'function',
--   'function.builtin',
--   'keyword',
--   'keyword.function',
--   'keyword.operator',
--   'parameter',
--   'label',
--   'constant',
--   'constant.builtin',
--   'constant.macro',
--   'conditional',
--   'repeat',
--   'exception',
--   'type',
--   'type.builtin',
--   'namespace',
--   'include',
--   'preproc',
--   'debug',
--   'tag',
-- }
--
-- for _, group in ipairs(ts_white_groups) do
--   Group.new('@' .. group, c.white, c.black, s.NONE)
-- end
--
-- -- Treesitter highlight groups to grey/black
-- local ts_grey_groups = {
--   'method',
--   'field',
--   'property',
-- }
--
-- for _, group in ipairs(ts_grey_groups) do
--   Group.new('@' .. group, c.grey, c.black, s.NONE)
-- end
--
-- -- Link common syntax groups to Treesitter groups
-- local links = {
--   { 'Identifier', '@variable' },
--   { 'Function', '@function' },
--   { 'Statement', '@keyword' },
--   { 'Conditional', '@conditional' },
--   { 'Repeat', '@repeat' },
--   { 'Type', '@type' },
--   { 'String', '@string' },
--   { 'Number', '@number' },
--   { 'Boolean', '@boolean' },
--   { 'Constant', '@constant' },
--   { 'Operator', '@operator' },
-- }
--
-- for _, link in ipairs(links) do
--   vim.api.nvim_set_hl(0, link[1], { link = '@' .. link[2] })
-- end
