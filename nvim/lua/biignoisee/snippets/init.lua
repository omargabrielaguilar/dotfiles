local ls = require("luasnip")

local php = require("biignoisee.snippets.php")
local javascript = require("biignoisee.snippets.javascript")
local typescript = require("biignoisee.snippets.typescript")
local vue = require("biignoisee.snippets.vue")

local snippets = {}

snippets.php = php
snippets.javascript = javascript
snippets.typescript = typescript
snippets.vue = vue

return snippets
