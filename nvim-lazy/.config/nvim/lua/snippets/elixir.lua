local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local fmt = require("luasnip.extras.fmt").fmt

-- args is a table, where 1 is the text in Placeholder 1, 2 the text in
-- placeholder 2,...
local function copy(args)
  return args[1]
end

ls.add_snippets("elixir", {
  s("~H", fmt('~H""" \n\t{}\n """', { i(1) })),
  s("dfc", fmt('def {} (assigns) do\n~H""" \n\t{}\n """\nend', { i(1), i(2) })),
  s("dren", fmt('def render(assigns) do\n~H""" \n\t{}\n """\nend', { i(1) })),
  s("dhe", fmt('def handle_event("{}", {}, socket) do\n\t{}\nend', { i(1), i(2), i(3) })),
  s("dhp", fmt('def handle_params("{}", {}, socket) do\n\t{}\nend', { i(1), i(2), i(3) })),
  s("dhi", fmt("def handle_info({{:{}, {}}}, socket) do\n\t{}\nend", { i(1), i(2), i(3) })),
  s("dsin", fmt("def {}({}), do: {}", { i(1), i(2), i(3) })),
  s("dpsin", fmt("defp {}({}), do: {}", { i(1), i(2), i(3) })),
  s("=", fmt("<%= {} %>", { i(1) })),
  s("ep", fmt('%{{"{}" => {}}}', { i(1), i(2) })),
  s(
    "hife",
    fmt(
      [[
    <%= if {} do %>
      {}
    <% else %>
      {}
    <% end %>
    ]],
      { i(1), i(2), i(3) }
    )
  ),
  s(
    "hfor",
    fmt(
      [[
    <%= for {} <- {} do %>
      {}
    <% else %>
      {}
    <% end %>
    ]],
      { i(1), i(2), i(3), i(4) }
    )
  ),
  s(
    "dlcm",
    fmt(
      [[
    def mount(socket) do
      {}
      {{:ok, socket}}
    end
    ]],
      { i(1) }
    )
  ),
  s(
    "dlcu",
    fmt(
      [[
    def update(assigns, socket) do
      {}
      {{:ok, socket}}
    end
    ]],
      { i(1) }
    )
  ),
}, {
  key = "elixir",
})

return ls
