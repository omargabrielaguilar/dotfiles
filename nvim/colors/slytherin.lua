-- ~/.config/nvim/lua/colors/slytherin.lua
local sly = require("colors.slytherin-palette")

vim.cmd("highlight clear")
vim.o.background = "dark"
vim.g.colors_name = "slytherin"

local set = vim.api.nvim_set_hl

-- Basic UI
set(0, "Normal",       { fg = sly.fg, bg = sly.bg })
set(0, "CursorLine",   { bg = sly.cursorline })
set(0, "Visual",       { bg = sly.selection })
set(0, "Comment",      { fg = sly.comment, italic = true })

-- Syntax
set(0, "Identifier",   { fg = sly.fg })
set(0, "Function",     { fg = sly.green_bright })
set(0, "Keyword",      { fg = sly.green, bold = true })
set(0, "String",       { fg = sly.yellow })
set(0, "Number",       { fg = sly.cyan })
set(0, "Boolean",      { fg = sly.magenta })
set(0, "Constant",     { fg = sly.blue })
set(0, "Type",         { fg = sly.green })

-- Diagnostics
set(0, "DiagnosticError", { fg = sly.red })
set(0, "DiagnosticWarn",  { fg = sly.yellow })
set(0, "DiagnosticInfo",  { fg = sly.blue })
set(0, "DiagnosticHint",  { fg = sly.cyan })

-- Treesitter Highlights
set(0, "@comment",        { fg = sly.comment, italic = true })
set(0, "@constant",       { fg = sly.blue })
set(0, "@constant.builtin", { fg = sly.magenta })
set(0, "@string",         { fg = sly.yellow })
set(0, "@string.escape",  { fg = sly.cyan })
set(0, "@number",         { fg = sly.cyan })
set(0, "@boolean",        { fg = sly.red })
set(0, "@float",          { fg = sly.cyan })

set(0, "@function",       { fg = sly.green_bright })
set(0, "@function.builtin", { fg = sly.green })
set(0, "@method",         { fg = sly.green })
set(0, "@constructor",    { fg = sly.blue })

set(0, "@parameter",      { fg = sly.fg })
set(0, "@variable",       { fg = sly.fg })
set(0, "@variable.builtin", { fg = sly.magenta })

set(0, "@type",           { fg = sly.green })
set(0, "@type.builtin",   { fg = sly.green_bright })
set(0, "@field",          { fg = sly.fg })
set(0, "@property",       { fg = sly.fg })

set(0, "@operator",       { fg = sly.fg })
set(0, "@punctuation.delimiter", { fg = sly.comment })
set(0, "@punctuation.bracket",   { fg = sly.gray })
set(0, "@punctuation.special",   { fg = sly.yellow })

set(0, "@keyword",        { fg = sly.green, bold = true })
set(0, "@keyword.function", { fg = sly.green_bright, bold = true })
set(0, "@keyword.return", { fg = sly.magenta })

set(0, "@tag",            { fg = sly.blue })
set(0, "@tag.attribute",  { fg = sly.green })
set(0, "@tag.delimiter",  { fg = sly.fg })

set(0, "@namespace",      { fg = sly.cyan })
set(0, "@symbol",         { fg = sly.cyan })

-- Optional
set(0, "@text.title",     { fg = sly.green_bright, bold = true })
set(0, "@text.strong",    { bold = true })
set(0, "@text.emphasis",  { italic = true })


-- LSP Semantic Tokens
set(0, "@lsp.type.class",           { link = "@type" })
set(0, "@lsp.type.decorator",       { link = "@function" })
set(0, "@lsp.type.enum",            { link = "@type" })
set(0, "@lsp.type.enumMember",      { link = "@constant" })
set(0, "@lsp.type.function",        { link = "@function" })
set(0, "@lsp.type.interface",       { link = "@type" })
set(0, "@lsp.type.keyword",         { link = "@keyword" })
set(0, "@lsp.type.macro",           { fg = sly.magenta, bold = true })
set(0, "@lsp.type.method",          { link = "@method" })
set(0, "@lsp.type.namespace",       { link = "@namespace" })
set(0, "@lsp.type.parameter",       { link = "@parameter" })
set(0, "@lsp.type.property",        { link = "@property" })
set(0, "@lsp.type.struct",          { link = "@type" })
set(0, "@lsp.type.type",            { link = "@type" })
set(0, "@lsp.type.typeParameter",   { fg = sly.blue })
set(0, "@lsp.type.variable",        { link = "@variable" })

-- Modifiers (e.g., readonly, static, etc.)
set(0, "@lsp.typemod.variable.readonly",   { italic = true })
set(0, "@lsp.typemod.variable.static",     { bold = true })
set(0, "@lsp.typemod.variable.defaultLibrary", { fg = sly.magenta, italic = true })
