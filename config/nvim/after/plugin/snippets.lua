local snippets = require("snippets")
local indent = require("snippets.utils").match_indentation

snippets.set_ux(require("snippets.inserters.floaty"))
snippets.use_suggested_mappings()

local snips = {}

-- Global snippets
snips._global = {
  ["date"] = [[${=os.date("%Y-%m-%d")}]],
  --["helloworld"] = [[${=examplefn()}]],
}

-- Rust snippets
snips.rust = {}
snips.rust.print = [[println!("${2:$1}: {:?}", ${1});]]
snips.rust.testmod = [[
#[cfg(test)]
mod tests {
  use super::*;

  #[test]
  fn test_$0() {
  }

}]]
snips.rust.test = indent([[
#[test]
fn test_$0() {
}
]])

-- Markdown snippets
snips.markdown = {}
snips.markdown.link = indent([[
[$0]($1)
]])

-- Add to snippets.nvim
snippets.snippets = snips

--
-- luasnip experimentation below
--

local ls = require("luasnip")
local s = ls.s
local sn = ls.sn
local t = ls.t
local i = ls.i
local f = ls.f
local c = ls.c
local d = ls.d

local function copy(args)
  return args[1]
end

local function char_count_same(c1, c2)
  local line = vim.api.nvim_get_current_line()
  local _, ct1 = string.gsub(line, c1, "")
  local _, ct2 = string.gsub(line, c2, "")
  return ct1 == ct2
end

local function even_count(c)
  local line = vim.api.nvim_get_current_line()
  local _, ct = string.gsub(line, c, "")
  return ct % 2 == 0
end

local function neg(fn, ...)
  return not fn(...)
end

local function bash(_, _, command)
  local file = io.popen(command, "r")
  local res = {}
  for line in file:lines() do
    table.insert(res, line)
  end
  return res
end

ls.snippets = {
  all = {
    ls.snippet("date", ls.function_node(bash, {}, "date +'%Y-%m-%d'")),
  },
  rust = {
    ls.parser.parse_snippet({ trig = "fn" }, "/// $1\nfn $2($3) ${4:-> $5 }\\{\n\t$0\n\\}"),
  },
}
ls.filetype_set("cpp", { "c" })
