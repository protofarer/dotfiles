-- file: colors/jb.lua
local colorbuddy = require("colorbuddy")
colorbuddy.setup()

local Color = colorbuddy.Color
local Group = colorbuddy.Group
local c = colorbuddy.colors
local s = colorbuddy.styles

-- Clear existing highlights
vim.cmd("hi clear")
if vim.fn.exists("syntax_on") then
	vim.cmd("syntax reset")
end

-- Set colorscheme name
vim.g.colors_name = "jb"
vim.o.background = "dark"

-- -----------------------------------------
-- Define colors
-- -----------------------------------------

-- General
Color.new("black", "#000000")
Color.new("white", "#fefefe")
Color.new("max_white", "#ffffff")

-- Background
Color.new("deep_wood_green", "#062626")

-- Core / Code
Color.new("gold", "#e5cbb0")
Color.new("terminal_green", "#68f24d")
Color.new("lime", "#85f79c")
Color.new("cyan", "#8df4cf")
Color.new("teal", "#43d8a9")

-- Editor
Color.new("bright_amber", "#e28513")
Color.new("medium_amber", "#8d7324")
Color.new("dull_amber", "#471e00")
Color.new("muted_amber", "#5a3800")

-- highlighted text keeps foreground color, bg is bright blue
Color.new("dbg_blue", "#0002F9")
Color.new("dbg_green", "#00FF00")

-- Accent
Color.new("warm_red", "#a82626")
Color.new("muted_red", "#8b3a3a")
Color.new("warm_yellow", "#b8860b")
Color.new("light_yellow", "#b5a40c")
Color.new("burnt_orange", "#cc5500")
Color.new("phosphor", "#ff7700")

-- Special
Color.new("green", "#347919") -- functions
Color.new("silver", "#a3a3a3") -- literals aka numbers, strings, booleans and constants
Color.new("ombre", "#da491d") -- keywords, operators
Color.new("bronze", "#c26b00") -- variables, fields

-- -----------------------------------------
-- Define highlight groups
-- -----------------------------------------

-- What I actually care about for this theme:
-- -----------------------------------------

Group.new("Comment", c.terminal_green, c.deep_wood_green, s.italic)
Group.new("@comment", c.terminal_green, c.deep_wood_green, s.NONE)
Group.new("TodoFgTODO", c.terminal_green, nil, s.italic) -- TODO comment plugin; the colon and comment itself
Group.new("TodoBgTODO", c.terminal_green, nil, s.bold + s.underline) -- TODO comment plugin; the word TODO itself

-- plain styles, common code
Group.new("@variable", c.gold, c.deep_wood_green, s.NONE)
Group.new("@punctuation.delimiter", c.gold, c.deep_wood_green, s.NONE)
Group.new("@punctuation.bracket", c.gold, c.deep_wood_green, s.NONE)
Group.new("@operator", c.gold, c.deep_wood_green, s.NONE)
Group.new("Function", c.gold, c.deep_wood_green, s.NONE)
Group.new("@function", c.gold, c.deep_wood_green, s.NONE)
Group.new("Identifier", c.gold, c.deep_wood_green, s.NONE)
Group.new("PreProc", c.gold, c.deep_wood_green, s.NONE) -- backslash token used for preproc newline

Group.new("@string.escape", c.teal, c.black, s.NONE)
Group.new("String", c.teal, c.deep_wood_green, s.NONE)
Group.new("@string", c.teal, c.deep_wood_green, s.NONE)

Group.new("Constant", c.cyan, c.deep_wood_green, s.NONE)
Group.new("Number", c.cyan, c.deep_wood_green, s.NONE)
Group.new("@number", c.cyan, c.deep_wood_green, s.NONE)
Group.new("@boolean", c.cyan, c.deep_wood_green, s.NONE)

Group.new("@keyword", c.white, c.deep_wood_green, s.NONE)

-- std + bold
Group.new("Type", c.lime, c.deep_wood_green, s.NONE) -- both def and ref
Group.new("Special", c.lime, c.deep_wood_green, s.NONE) -- affects words `int` `char` `void`, aka built-in C types aka `@type.builtin.c`

-- editor
Group.new("LineNr", c.gold, c.deep_wood_green, s.NONE)
Group.new("Normal", c.gold, c.deep_wood_green, s.NONE)
Group.new("MatchParen", c.gold, c.deep_wood_green, s.NONE)
Group.new("Cursor", c.lime, c.deep_wood_green, s.NONE)
Group.new("StatusLine", c.gold, c.deep_wood_green, s.NONE)
Group.new("StatusLineNC", c.gold, c.deep_wood_green, s.italic)
Group.new("Directory", c.gold, c.deep_wood_green, s.NONE)

-- -----------------------------------------

-- N2H
-- -----------------------------------------

Group.new("Todo", c.warm_yellow, c.deep_wood_green, s.bold + s.underline)
-- Group.new('Visual', c.deep_wood_green, c.bright_amber, s.italic)
Group.new("Visual", nil, c.gold, s.italic)
Group.new("VisualNOS", c.deep_wood_green, c.bright_amber, s.italic)


-- (diag)
Group.new("Error", c.warm_red, c.deep_wood_green, s.NONE)
Group.new("ErrorMsg", c.warm_red, c.deep_wood_green, s.NONE)
Group.new("WarningMsg", c.burnt_orange, c.deep_wood_green, s.NONE)

-- (search)
Group.new("CurSearch", c.deep_wood_green, c.lime, s.bold)
Group.new("IncSearch", c.deep_wood_green, c.lime, s.italic)
Group.new("Search", c.deep_wood_green, c.lime, s.italic)


-- what are these?
-- -----------------------------------------
Group.new("DiffAdd", c.warm_yellow, c.deep_wood_green, s.NONE)
Group.new("DiffDelete", c.warm_red, c.deep_wood_green, s.NONE)


-- gold fg w/bright_amber bg
Group.new("CursorColumn", c.gold, c.bright_amber, s.NONE)
-- Group.new('CursorLine', c.bright_amber, c.dull_amber, s.NONE)
-- Group.new('CursorLine', c.white, c.light_yellow, s.NONE)

-- -----------------------------------------

-- gold fg w/deep_wood_green bg
Group.new("DiffChange", c.gold, c.deep_wood_green, s.NONE)
Group.new("DiffDelete", c.gold, c.deep_wood_green, s.NONE)
Group.new("DiffText", c.gold, c.deep_wood_green, s.NONE)
Group.new("Folded", c.gold, c.deep_wood_green, s.NONE)
Group.new("Ignore", c.gold, c.deep_wood_green, s.NONE)
Group.new("Label", c.gold, c.deep_wood_green, s.NONE)
Group.new("ModeMsg", c.gold, c.deep_wood_green, s.NONE)
Group.new("MoreMsg", c.gold, c.deep_wood_green, s.NONE)
Group.new("NonText", c.gold, c.deep_wood_green, s.NONE)
Group.new("PmenuSbar", c.gold, c.deep_wood_green, s.NONE)
Group.new("PmenuSel", c.gold, c.deep_wood_green, s.italic)
Group.new("PmenuThumb", c.gold, c.deep_wood_green, s.NONE)
Group.new("SpecialKey", c.gold, c.deep_wood_green, s.italic)
Group.new("Statement", c.gold, c.deep_wood_green, s.NONE)
Group.new("StorageClass", c.gold, c.deep_wood_green, s.NONE)

Group.new("TabLine", c.gold, c.deep_wood_green, s.NONE)
Group.new("TabLineFill", c.gold, c.deep_wood_green, s.NONE)
Group.new("TabLineSel", c.gold, c.deep_wood_green, s.bold)
Group.new("Title", c.gold, c.deep_wood_green, s.NONE)
Group.new("Underlined", c.gold, c.deep_wood_green, s.underline)
Group.new("VertSplit", c.gold, c.deep_wood_green, s.NONE)
Group.new("WarningMsg", c.gold, c.deep_wood_green, s.NONE)
Group.new("WildMenu", c.gold, c.deep_wood_green, s.NONE)
Group.new("cucumberTags", c.gold, c.deep_wood_green, s.bold)
Group.new("htmlTagN", c.gold, c.deep_wood_green, s.bold)
Group.new("rubySymbol", c.gold, c.deep_wood_green, s.NONE)

-- bright_amber fg w/deep_wood_green bg
Group.new("DiffAdd", c.bright_amber, c.deep_wood_green, s.NONE)
Group.new("Pmenu", c.bright_amber, c.deep_wood_green, s.bold)

-- no impact on Odin
Group.new("TypeDef", c.gold, c.deep_wood_green, s.NONE)

Group.new("Structure", c.gold, c.deep_wood_green, s.NONE) -- default imported package name refs, match module alias (@variable above)

-- Type references (class names when used, seems to be more specific than neovim Type)
-- Group.new('@type', c.lime, c.deep_wood_green, s.NONE)
-- Group.new('@type.builtin', c.lime, c.deep_wood_green, s.NONE)

-- Constructor calls
-- Group.new('@constructor', c.lime, c.deep_wood_green, s.NONE)

-- Class/type definitions
Group.new("@type.definition", c.lime, c.deep_wood_green, s.NONE)
-- override possible treesitter highlighting, fix green comments in odin
-- vim.cmd [[highlight Comment guifg=#8B0000 guibg=#0B0000 gui=italic]]
-- vim.cmd [[highlight TSComment guifg=#8B0000 guibg=#0B0000 gui=italic]]
-- vim.cmd [[highlight @comment guifg=#8B0000 guibg=#0B0000 gui=italic]]
