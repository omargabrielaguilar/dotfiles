local c = require("colors.slytherin-palette")

return {
  normal = {
    a = { bg = c.green_bright, fg = c.bg, gui = "bold" },
    b = { bg = c.gray,         fg = c.fg },
    c = { bg = c.bg,           fg = c.fg },
  },
  insert = {
    a = { bg = c.cyan,         fg = c.bg, gui = "bold" },
    b = { bg = c.gray,         fg = c.fg },
    c = { bg = c.bg,           fg = c.fg },
  },
  visual = {
    a = { bg = c.magenta,      fg = c.bg, gui = "bold" },
    b = { bg = c.gray,         fg = c.fg },
    c = { bg = c.bg,           fg = c.fg },
  },
  replace = {
    a = { bg = c.red,          fg = c.bg, gui = "bold" },
    b = { bg = c.gray,         fg = c.fg },
    c = { bg = c.bg,           fg = c.fg },
  },
  command = {
    a = { bg = c.yellow,       fg = c.bg, gui = "bold" },
    b = { bg = c.gray,         fg = c.fg },
    c = { bg = c.bg,           fg = c.fg },
  },
  inactive = {
    a = { bg = c.bg,           fg = c.gray },
    b = { bg = c.bg,           fg = c.gray },
    c = { bg = c.bg,           fg = c.gray },
  },
}
