local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

return {
	-- console.log
	s("cl", fmt("console.log({});", { i(1, "variable") })),

	-- try/catch
	s(
		"try",
		fmt(
			[[
try {{
  {}
}} catch ({}) {{
  console.error({});
}}
]],
			{ i(1, "// code"), i(2, "error"), i(3, "error") }
		)
	),

	-- function
	s(
		"fun",
		fmt(
			[[
function {}({}): {} {{
  {}
}}
]],
			{ i(1, "myFunction"), i(2, "params"), i(3, "void"), i(4, "// code") }
		)
	),

	-- interface
	s(
		"iface",
		fmt(
			[[
interface {} {{
  {}: {};
}}
]],
			{ i(1, "MyInterface"), i(2, "property"), i(3, "string") }
		)
	),

	-- class
	s(
		"class",
		fmt(
			[[
class {} {{
  constructor({}) {{
    {}
  }}
}}
]],
			{ i(1, "MyClass"), i(2, "params"), i(3, "// init") }
		)
	),
}
