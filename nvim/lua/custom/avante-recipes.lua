local populate_edit_window = function(request)
  require("avante.api").edit()
  local code_bufnr = vim.api.nvim_get_current_buf()
  local code_winid = vim.api.nvim_get_current_win()
  if code_bufnr == nil or code_winid == nil then
    return
  end
  vim.api.nvim_buf_set_lines(code_bufnr, 0, -1, false, { request })
  -- Optionally set the cursor position to the end of the input
  vim.api.nvim_win_set_cursor(code_winid, { 1, #request + 1 })
  -- Simulate Ctrl+S keypress to submit
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-s>", true, true, true), "v", true)
end

-- NOTE: most templates are inspired from ChatGPT.nvim -> chatgpt-actions.json
local avante_grammar_correction = "Correct the text to standard English, but keep any code blocks inside intact."
local avante_keywords = "Extract the main keywords from the following text"
local avante_code_readability_analysis = [[
  You must identify any readability issues in the code snippet.
  Some readability issues to consider:
  - Unclear naming
  - Unclear purpose
  - Redundant or obvious comments
  - Lack of comments
  - Long or complex one liners
  - Too much nesting
  - Long variable names
  - Inconsistent naming and code style.
  - Code repetition
  You may identify additional problems. The user submits a small section of code from a larger file.
  Only list lines with readability issues, in the format <line_num>|<issue and proposed solution>
  If there's no issues with code respond with only: <OK>
]]
local avante_optimize_code = "Optimize the following code"
local avante_summarize = "Summarize the following text"
local avante_translate = "Translate this into Chinese, but keep any code blocks inside intact"
local avante_explain_code = "Explain the following code"
local avante_complete_code = "Complete the following codes written in " .. vim.bo.filetype
local avante_add_docstring = "Add docstring to the following codes"
local avante_fix_bugs = "Fix the bugs inside the following codes if any"
local avante_add_tests = "Implement tests for the following code"

-- Define key mappings using vim.keymap.set
local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

local mappings = {
  { mode = { "n", "v" }, key = "<leader>ag", question = avante_grammar_correction, desc = "Grammar Correction(ask)" },
  { mode = { "n", "v" }, key = "<leader>ak", question = avante_keywords, desc = "Keywords(ask)" },
  {
    mode = { "n", "v" },
    key = "<leader>al",
    question = avante_code_readability_analysis,
    desc = "Code Readability Analysis(ask)",
  },
  { mode = { "n", "v" }, key = "<leader>ao", question = avante_optimize_code, desc = "Optimize Code(ask)" },
  { mode = { "n", "v" }, key = "<leader>am", question = avante_summarize, desc = "Summarize text(ask)" },
  { mode = { "n", "v" }, key = "<leader>an", question = avante_translate, desc = "Translate text(ask)" },
  { mode = { "n", "v" }, key = "<leader>ax", question = avante_explain_code, desc = "Explain Code(ask)" },
  { mode = { "n", "v" }, key = "<leader>ac", question = avante_complete_code, desc = "Complete Code(ask)" },
  { mode = { "n", "v" }, key = "<leader>ad", question = avante_add_docstring, desc = "Docstring(ask)" },
  { mode = { "n", "v" }, key = "<leader>ab", question = avante_fix_bugs, desc = "Fix Bugs(ask)" },
  { mode = { "n", "v" }, key = "<leader>au", question = avante_add_tests, desc = "Add Tests(ask)" },
  { mode = "v", key = "<leader>aG", question = avante_grammar_correction, desc = "Grammar Correction" },
  { mode = "v", key = "<leader>aK", question = avante_keywords, desc = "Keywords" },
  { mode = "v", key = "<leader>aO", question = avante_optimize_code, desc = "Optimize Code(edit)" },
  { mode = "v", key = "<leader>aC", question = avante_complete_code, desc = "Complete Code(edit)" },
  { mode = "v", key = "<leader>aD", question = avante_add_docstring, desc = "Docstring(edit)" },
  { mode = "v", key = "<leader>aB", question = avante_fix_bugs, desc = "Fix Bugs(edit)" },
  { mode = "v", key = "<leader>aU", question = avante_add_tests, desc = "Add Tests(edit)" },
}

local function set_keymap(map)
  keymap(map.mode, map.key, function()
    if map.mode == "v" then
      populate_edit_window(map.question)
    else
      require("avante.api").ask({ question = map.question })
    end
  end, { desc = map.desc, unpack(opts) })
end

vim.iter(mappings):each(set_keymap)

local ok, menu = pcall(require, "menu")
if ok then
  vim.keymap.set({ "n", "v" }, "<leader>aM", function()
    menu.open(vim
      .iter(mappings)
      :map(function(map)
        return {
          name = map.desc,
          rtxt = map.key,
          cmd = function()
            if map.mode == "v" then
              populate_edit_window(map.question)
            else
              require("avante.api").ask({ question = map.question })
            end
          end,
        }
      end)
      :totable())
  end, {})
end
