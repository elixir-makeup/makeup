RELEASE_TYPE: major

Upgrade the HTML formatter so that you can use different kinds of tags around the tokens.

Previous versions always used the `<span>` tag (e.g. `<span class="n">name</span>`).
You can now use other HTML tags using the `:highlight_tag` option:

```elixir
alias Makeup.Formatters.HTML.HTMLFormatter
HTMLFormatter.format_as_iolist(tokens, highlight_tag: "font")
```