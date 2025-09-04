local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

return {
	-- Vue 3 <script setup>
	s(
		"vsetup",
		fmt(
			[[
<script setup lang="ts">
{}
</script>

<template>
  {}
</template>

<style scoped>
{}
</style>
]],
			{ i(1, "// script"), i(2, "<div>Hello Vue</div>"), i(3, "/* styles */") }
		)
	),

	-- reactive
	s("reactive", fmt("const {} = reactive({{\n  {}\n}});", { i(1, "state"), i(2, "// properties") })),

	-- ref
	s("ref", fmt("const {} = ref({});", { i(1, "variable"), i(2, "null") })),

	-- watch
	s(
		"watch",
		fmt(
			[[
watch({}, (newVal, oldVal) => {{
  {}
}});
]],
			{ i(1, "source"), i(2, "// code") }
		)
	),

	-- computed
	s("computed", fmt("const {} = computed(() => {});", { i(1, "value"), i(2, "/* expr */") })),
}
