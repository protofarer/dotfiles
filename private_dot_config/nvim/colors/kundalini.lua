-- file: colors/kundalini.lua
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
vim.g.colors_name = "kundalini"
vim.o.background = "dark"

-- Define colors
Color.new("black", "#0B0000")
Color.new("white", "#FF0000") -- brightest red
Color.new("light", "#D00000") -- light red
Color.new("grey", "#8B0000") -- medium red
Color.new("muted", "#300000") -- muted red
Color.new("dim", "#100000") -- dim red

Color.new("blue", "#0000FF")
Color.new("green", "#00FF00")

-- ------------------------------
-- ------------------------------

-- What I actually care about for this theme:

Group.new("Comment", c.grey, c.black, s.italic)
Group.new("@comment", c.grey, c.black, s.italic)
Group.new("TodoFg", c.grey, nil, s.italic) -- TODO comment plugin
-- Group.new("TodoBg", c.grey, nil, s.italic) -- TODO comment plugin

-- std style, normal code
Group.new("@variable", c.grey, c.black, s.NONE)
Group.new("@keyword", c.grey, c.black, s.NONE)
Group.new("@punctuation.delimiter", c.grey, c.black, s.NONE)
Group.new("@punctuation.bracket", c.grey, c.black, s.NONE)
Group.new("@operator", c.grey, c.black, s.NONE)
Group.new("Function", c.grey, c.black, s.NONE)
Group.new("@function", c.grey, c.black, s.NONE)
Group.new("Identifier", c.grey, c.black, s.bold) -- struct fields

-- std + bold
Group.new("Type", c.grey, c.black, s.bold)
Group.new("TypeDef", c.blue, c.black, s.bold)
Group.new("Special", c.grey, c.black, s.bold) -- affects words `int` `char` `void`, aka built-in C types aka `@type.builtin.c`

-- lighter
Group.new("Constant", c.light, c.black, s.NONE)
Group.new("Number", c.light, c.black, s.NONE)
Group.new("@number", c.light, c.black, s.NONE)
Group.new("@boolean", c.light, c.black, s.NONE)

Group.new("String", c.light, c.black, s.italic)
Group.new("@string", c.light, c.black, s.italic)
Group.new("@string.escape", c.light, c.black, s.NONE)

-- editor
Group.new("Normal", c.white, c.black, s.NONE) -- statusline stdout text fg
Group.new("MatchParen", c.white, c.black, s.NONE)

-- editor
Group.new("Cursor", c.black, c.white, s.NONE)
Group.new("LineNr", c.grey, c.black, s.NONE)
Group.new("StatusLine", c.grey, c.black, s.bold)
Group.new("StatusLineNC", c.grey, c.black, s.italic) -- status line cwd
Group.new("Directory", c.grey, c.black, s.NONE) -- mini directory display

-- ------------------------------
-- ------------------------------

-- N2H
Group.new("Error", c.blue, c.black, s.NONE)
Group.new("Todo", c.blue, c.black, s.bold + s.underline)
Group.new("WarningMsg", c.blue, c.black, s.NONE)

-- editor
-- black fg w/white bg
-- Group.new("IncSearch", c.black, c.white, s.italic)
-- Group.new("Search", c.black, c.white, s.italic)
-- Group.new("Visual", c.black, c.white, s.italic)
-- Group.new("VisualNOS", c.black, c.white, s.italic)
-- grey fg, white bg
-- Group.new("CursorColumn", c.grey, c.white, s.NONE)
-- Group.new("CursorLine", c.white, c.lightgrey, s.NONE)

-- ------------------------------
-- ------------------------------

-- what are these?

Group.new("Statement", c.blue, c.black, s.bold)
Group.new("Structure", c.blue, c.black, s.bold)

-- grey fg, black bg
Group.new("DiffChange", c.blue, c.black, s.NONE)
Group.new("DiffDelete", c.blue, c.black, s.NONE)
Group.new("DiffText", c.blue, c.black, s.NONE)
Group.new("Folded", c.blue, c.black, s.NONE)
Group.new("Ignore", c.blue, c.black, s.NONE)
Group.new("ModeMsg", c.blue, c.black, s.NONE)
Group.new("MoreMsg", c.blue, c.black, s.NONE)
Group.new("NonText", c.blue, c.black, s.NONE)
Group.new("TabLine", c.blue, c.black, s.NONE)
Group.new("TabLineFill", c.blue, c.black, s.NONE)
Group.new("Title", c.blue, c.black, s.NONE)
Group.new("VertSplit", c.blue, c.black, s.NONE)
Group.new("PmenuSbar", c.blue, c.black, s.NONE)
Group.new("PmenuThumb", c.blue, c.black, s.NONE)
Group.new("PmenuSel", c.blue, c.black, s.italic)
Group.new("Label", c.blue, c.black, s.bold)
Group.new("PreProc", c.blue, c.black, s.bold)
Group.new("StorageClass", c.blue, c.black, s.bold)
Group.new("SpecialKey", c.blue, c.black, s.italic)
Group.new("TabLineSel", c.blue, c.black, s.bold)
Group.new("Underlined", c.blue, c.black, s.underline)

Group.new("WildMenu", c.grey, c.black, s.NONE)
Group.new("cucumberTags", c.grey, c.black, s.bold)
Group.new("htmlTagN", c.grey, c.black, s.bold)
Group.new("rubySymbol", c.grey, c.black, s.NONE)

-- white fg w/black bg

Group.new("DiffAdd", c.blue, c.black, s.NONE)
Group.new("Pmenu", c.blue, c.black, s.bold)
