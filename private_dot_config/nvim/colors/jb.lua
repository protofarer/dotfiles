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
Color.new("gray", "#a0a0a0")
-- TODO: grey for search

-- Background
Color.new("deep_wood_green", "#062626")

-- Core / Code
Color.new("gold", "#e5cbb0")
Color.new("terminal_green", "#68f24d")
Color.new("lime", "#9df9af")
Color.new("cyan", "#9cfcd9")
Color.new("teal", "#3ddba6")

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
Color.new("bright_yellow", "#f7e87b")
Color.new("burnt_orange", "#cc5500")
Color.new("phosphor", "#ff7700")

-- Special
Color.new("green", "#347919")
Color.new("silver", "#a3a3a3")
Color.new("light_silver", "#c6c6c6")
Color.new("bright_silver", "#e0e0e0")
Color.new("ombre", "#da491d")
Color.new("bronze", "#c26b00")

-- -----------------------------------------
-- Define highlight groups
-- -----------------------------------------

-- What I actually care about for this theme:
-- -----------------------------------------

Group.new("Comment", c.terminal_green, c.deep_wood_green, s.NONE)
Group.new("@comment", c.terminal_green, c.deep_wood_green, s.NONE)
Group.new("TodoFgTODO", c.terminal_green, nil, s.NONE) -- TODO comment plugin; the colon and comment itself
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

Group.new("@string.escape", c.teal, c.deep_wood_green, s.NONE)
Group.new("String", c.teal, c.deep_wood_green, s.NONE)
Group.new("@string", c.teal, c.deep_wood_green, s.NONE)

Group.new("Constant", c.cyan, c.deep_wood_green, s.NONE)
Group.new("Number", c.cyan, c.deep_wood_green, s.NONE)
Group.new("@number", c.cyan, c.deep_wood_green, s.NONE)
Group.new("@boolean", c.cyan, c.deep_wood_green, s.NONE)

Group.new("@keyword", c.white, c.deep_wood_green, s.NONE)

-- std + bold
Group.new("Type", c.lime, c.deep_wood_green, s.NONE) -- both def and ref
Group.new("@type", c.lime, c.deep_wood_green, s.NONE)
Group.new("Special", c.lime, c.deep_wood_green, s.NONE) -- affects words `int` `char` `void`, aka built-in C types aka `@type.builtin.c`

-- editor / misc
Group.new("Visual", nil, c.white, s.NONE) -- cursor word match auto-highlight and visual selection
Group.new("LineNr", c.gold, c.deep_wood_green, s.NONE)
Group.new("Normal", c.gold, c.deep_wood_green, s.NONE)
Group.new("MatchParen", c.terminal_green, c.deep_wood_green, s.NONE)
Group.new("Cursor", c.lime, c.deep_wood_green, s.NONE)
Group.new("StatusLine", c.gold, c.deep_wood_green, s.NONE)
Group.new("StatusLineNC", c.gold, c.deep_wood_green, s.italic)
Group.new("Directory", c.gold, c.deep_wood_green, s.NONE)

-- search
Group.new("Search", c.deep_wood_green, c.gray, s.NONE)
Group.new("CurSearch", c.deep_wood_green, c.lime, s.NONE)
Group.new("IncSearch", c.deep_wood_green, c.max_white, s.NONE)

-- e.g. When C LSP deems an #include statement unnecessary, thus should be some muted color
Group.new("DiagnosticUnnecessary", c.muted_amber, c.deep_wood_green, s.NONE)

-- -----------------------------------------

-- N2H
-- -----------------------------------------

Group.new("Todo", c.warm_yellow, c.deep_wood_green, s.bold + s.underline)
Group.new("VisualNOS", c.deep_wood_green, c.bright_amber, s.italic)

-- (diag)
Group.new("Error", c.dbg_blue, c.deep_wood_green, s.NONE)
Group.new("ErrorMsg", c.dbg_blue, c.deep_wood_green, s.NONE)
Group.new("WarningMsg", c.dbg_blue, c.deep_wood_green, s.NONE)

-- what are these?
-- -----------------------------------------
Group.new("DiffAdd", c.warm_yellow, c.deep_wood_green, s.NONE)
Group.new("DiffDelete", c.warm_red, c.deep_wood_green, s.NONE)
Group.new("Statement", c.dbg_blue, c.deep_wood_green, s.NONE)
Group.new("Structure", c.dbg_blue, c.deep_wood_green, s.NONE) -- default imported package name refs, match module alias (@variable above)
Group.new("TypeDef", c.dbg_blue, c.deep_wood_green, s.NONE)

-- gold fg w/bright_amber bg
Group.new("CursorColumn", c.dbg_blue, c.bright_amber, s.NONE)
Group.new("CursorLine", c.dbg_blue, c.light_yellow, s.NONE)

-- -----------------------------------------

Group.new("DiffText", c.dbg_blue, c.deep_wood_green, s.NONE)
Group.new("DiffAdd", c.dbg_blue, c.deep_wood_green, s.NONE)
Group.new("DiffChange", c.dbg_blue, c.deep_wood_green, s.NONE)
Group.new("DiffDelete", c.dbg_blue, c.deep_wood_green, s.NONE)

Group.new("WarningMsg", c.dbg_blue, c.deep_wood_green, s.NONE)
Group.new("ModeMsg", c.dbg_blue, c.deep_wood_green, s.NONE)
Group.new("MoreMsg", c.dbg_blue, c.deep_wood_green, s.NONE)

Group.new("Pmenu", c.dbg_blue, c.deep_wood_green, s.bold)
Group.new("PmenuSbar", c.dbg_blue, c.deep_wood_green, s.NONE)
Group.new("PmenuSel", c.dbg_blue, c.deep_wood_green, s.italic)
Group.new("PmenuThumb", c.dbg_blue, c.deep_wood_green, s.NONE)

Group.new("SpecialKey", c.dbg_blue, c.deep_wood_green, s.italic)
Group.new("StorageClass", c.dbg_blue, c.deep_wood_green, s.NONE)

Group.new("TabLine", c.dbg_blue, c.deep_wood_green, s.NONE)
Group.new("TabLineFill", c.dbg_blue, c.deep_wood_green, s.NONE)
Group.new("TabLineSel", c.dbg_blue, c.deep_wood_green, s.bold)

Group.new("Label", c.dbg_blue, c.deep_wood_green, s.NONE)
Group.new("Title", c.dbg_blue, c.deep_wood_green, s.NONE)
Group.new("NonText", c.dbg_blue, c.deep_wood_green, s.NONE)

Group.new("Folded", c.dbg_blue, c.deep_wood_green, s.NONE)
Group.new("Ignore", c.dbg_blue, c.deep_wood_green, s.NONE)
Group.new("Underlined", c.dbg_blue, c.deep_wood_green, s.underline)
Group.new("VertSplit", c.dbg_blue, c.deep_wood_green, s.NONE)

Group.new("WildMenu", c.dbg_blue, c.deep_wood_green, s.NONE)
Group.new("cucumberTags", c.dbg_blue, c.deep_wood_green, s.bold)
Group.new("htmlTagN", c.dbg_blue, c.deep_wood_green, s.bold)
Group.new("rubySymbol", c.dbg_blue, c.deep_wood_green, s.NONE)
