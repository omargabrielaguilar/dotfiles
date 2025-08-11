-- lua/biignoisee/snippets/php.lua
local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

return {
	s("jsonpretty", fmt("echo json_encode({}, JSON_PRETTY_PRINT);\ndie();", { i(1, "variable") })),
	s("dd", fmt("var_dump({});\ndie();", { i(1, "variable") })),
	s(
		"try",
		fmt(
			[[
try {{
  {}
}} catch ({}) {{
  {}
}}
]],
			{ i(1, "// código"), i(2, "Exception $e"), i(3, "// manejo del error") }
		)
	),
	s(
		"pubf",
		fmt(
			[[
public function {}({}) {{
  {}
}}
]],
			{ i(1, "methodName"), i(2, "params"), i(3, "// code...") }
		)
	),
}
