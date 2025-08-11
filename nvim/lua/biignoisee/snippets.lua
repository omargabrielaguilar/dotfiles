-- lua/biignoisee/snippets.lua
local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

return {
	php = {
		-- Snippet para json_encode con pretty print (nuevo)
		s(
			"jsonpretty",
			fmt(
				[[
    echo json_encode({}, JSON_PRETTY_PRINT);
    die();
    ]],
				{
					i(1, "variable"),
				}
			)
		),

		-- Snippet para var_dump + die
		s(
			"dd",
			fmt(
				[[
    var_dump({});
    die();
    ]],
				{
					i(1, "variable"),
				}
			)
		),

		-- Snippet para try-catch
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
				{
					i(1, "// código"),
					i(2, "Exception $e"),
					i(3, "// manejo del error"),
				}
			)
		),

		-- Snippet para función pública (nuevo)
		s(
			"pubf",
			fmt(
				[[
    public function {}({})
    {{
        {}
    }}
    ]],
				{
					i(1, "methodName"),
					i(2, "params"),
					i(3, "// code..."),
				}
			)
		),
	},

	javascript = {
		s(
			"clg",
			fmt("console.log({})", {
				i(1, "variable"),
			})
		),

		s(
			"af",
			fmt("() => {{ {} }}", {
				i(1, "// función"),
			})
		),
	},

	blade = {
		s(
			"foreach",
			fmt(
				[[
    @foreach ({} as {})
        {}
    @endforeach
    ]],
				{
					i(1, "$items"),
					i(2, "$item"),
					i(3, "// contenido"),
				}
			)
		),
	},
}
