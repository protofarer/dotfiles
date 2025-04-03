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
Color.new("white", "#E60000") -- bright red
Color.new("grey", "#8B0000") -- dull red
Color.new("lightgrey", "#300000") -- duller red

-- Define highlight groups
-- black fg w/white bg
Group.new("Cursor", c.black, c.white, s.NONE)
Group.new("IncSearch", c.black, c.white, s.italic)
Group.new("Search", c.black, c.white, s.italic)
Group.new("Visual", c.black, c.white, s.italic)
Group.new("VisualNOS", c.black, c.white, s.italic)

-- grey fg w/white bg
Group.new("CursorColumn", c.grey, c.white, s.NONE)
-- Group.new('CursorLine', c.grey, c.white, s.NONE)
Group.new("CursorLine", c.white, c.lightgrey, s.NONE)

-- grey fg w/black bg
Group.new("Comment", c.grey, c.black, s.italic)
Group.new("DiffChange", c.grey, c.black, s.NONE)
Group.new("DiffDelete", c.grey, c.black, s.NONE)
Group.new("DiffText", c.grey, c.black, s.NONE)
Group.new("Directory", c.grey, c.black, s.NONE)
Group.new("Error", c.grey, c.black, s.NONE)
Group.new("Folded", c.grey, c.black, s.NONE)
Group.new("Function", c.grey, c.black, s.bold)
Group.new("Identifier", c.grey, c.black, s.NONE)
Group.new("Ignore", c.grey, c.black, s.NONE)
Group.new("Label", c.grey, c.black, s.bold)
Group.new("LineNr", c.grey, c.black, s.NONE)
Group.new("MatchParen", c.grey, c.black, s.NONE)
Group.new("ModeMsg", c.grey, c.black, s.NONE)
Group.new("MoreMsg", c.grey, c.black, s.NONE)
Group.new("NonText", c.grey, c.black, s.NONE)
Group.new("Normal", c.grey, c.black, s.NONE)
Group.new("PmenuSbar", c.grey, c.black, s.NONE)
Group.new("PmenuSel", c.grey, c.black, s.italic)
Group.new("PmenuThumb", c.grey, c.black, s.NONE)
Group.new("PreProc", c.grey, c.black, s.bold)
Group.new("Special", c.grey, c.black, s.bold)
Group.new("SpecialKey", c.grey, c.black, s.italic)
Group.new("Statement", c.grey, c.black, s.bold)
Group.new("StatusLine", c.grey, c.black, s.bold)
Group.new("StatusLineNC", c.grey, c.black, s.italic)
Group.new("StorageClass", c.grey, c.black, s.bold)
Group.new("Structure", c.grey, c.black, s.bold)
Group.new("TabLine", c.grey, c.black, s.NONE)
Group.new("TabLineFill", c.grey, c.black, s.NONE)
Group.new("TabLineSel", c.grey, c.black, s.bold)
Group.new("Title", c.grey, c.black, s.NONE)
Group.new("Todo", c.grey, c.black, s.bold + s.underline)
Group.new("Type", c.grey, c.black, s.bold)
Group.new("TypeDef", c.grey, c.black, s.bold)
Group.new("Underlined", c.grey, c.black, s.underline)
Group.new("VertSplit", c.grey, c.black, s.NONE)
Group.new("WarningMsg", c.grey, c.black, s.NONE)
Group.new("WildMenu", c.grey, c.black, s.NONE)
Group.new("cucumberTags", c.grey, c.black, s.bold)
Group.new("htmlTagN", c.grey, c.black, s.bold)
Group.new("rubySymbol", c.grey, c.black, s.NONE)

-- white fg w/black bg
Group.new("Constant", c.white, c.black, s.NONE)
Group.new("DiffAdd", c.white, c.black, s.NONE)
Group.new("Number", c.white, c.black, s.NONE)
Group.new("Pmenu", c.white, c.black, s.bold)
Group.new("String", c.white, c.black, s.NONE)

-- Treesitter groups
local treesitter_groups = {
	"TSAttribute",
	"TSBoolean",
	"TSCharacter",
	"TSComment",
	"TSConditional",
	"TSConstant",
	"TSConstBuiltin",
	"TSConstMacro",
	"TSConstructor",
	"TSError",
	"TSException",
	"TSField",
	"TSFloat",
	"TSFunction",
	"TSFuncBuiltin",
	"TSFuncMacro",
	"TSInclude",
	"TSKeyword",
	"TSKeywordFunction",
	"TSKeywordOperator",
	"TSLabel",
	"TSMethod",
	"TSNamespace",
	"TSNone",
	"TSNumber",
	"TSOperator",
	"TSParameter",
	"TSParameterReference",
	"TSProperty",
	"TSPunctDelimiter",
	"TSPunctBracket",
	"TSPunctSpecial",
	"TSRepeat",
	"TSString",
	"TSStringRegex",
	"TSStringEscape",
	"TSSymbol",
	"TSTag",
	"TSTagDelimiter",
	"TSText",
	"TSStrong",
	"TSEmphasis",
	"TSUnderline",
	"TSStrike",
	"TSTitle",
	"TSLiteral",
	"TSURI",
	"TSMath",
	"TSTextReference",
	"TSEnvironment",
	"TSEnvironmentName",
	"TSNote",
	"TSWarning",
	"TSDanger",
	"TSTodo",
	"TSType",
	"TSTypeBuiltin",
	"TSVariable",
	"TSVariableBuiltin",
}

for _, group in ipairs(treesitter_groups) do
	Group.new(group, c.white, c.black, s.NONE)
end

-- Link groups
local links = {
	{ "TSFunction", "Function" },
	{ "TSKeyword", "Keyword" },
	{ "TSConditional", "Conditional" },
	{ "TSRepeat", "Repeat" },
	{ "TSString", "String" },
	{ "TSNumber", "Number" },
	{ "TSBoolean", "Boolean" },
	{ "TSOperator", "Operator" },
	{ "TSVariable", "Variable" },
	{ "TSConstant", "Constant" },
	{ "TSComment", "Comment" },
	{ "TSType", "Type" },
}
for _, link in ipairs(links) do
	vim.api.nvim_set_hl(0, link[1], { link = link[2] })
end

-- Override specific highlight groups for Treesitter
Group.new("@variable", c.white, c.black, s.NONE)
Group.new("@function", c.white, c.black, s.bold)
Group.new("@keyword", c.white, c.black, s.bold)
Group.new("@string", c.white, c.black, s.NONE)
Group.new("@number", c.white, c.black, s.NONE)
Group.new("@boolean", c.white, c.black, s.NONE)
Group.new("@operator", c.white, c.black, s.NONE)
Group.new("@punctuation.delimiter", c.white, c.black, s.NONE)
Group.new("@punctuation.bracket", c.white, c.black, s.NONE)
Group.new("@comments", c.white, c.black, s.NONE)

-- override possible treesitter highlighting, fix green comments in odin
vim.cmd([[highlight Comment guifg=#8B0000 guibg=#0B0000 gui=italic]])
vim.cmd([[highlight TSComment guifg=#8B0000 guibg=#0B0000 gui=italic]])
vim.cmd([[highlight @comment guifg=#8B0000 guibg=#0B0000 gui=italic]])

Group.new("@comment", c.white, c.black, s.NONE)
