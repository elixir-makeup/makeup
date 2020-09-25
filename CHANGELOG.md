# Changelog

### 1.0.4 - 2020-09-25

Fix warnings and update NimbleParsec dependency.


### 1.0.3 - 2020-06-07

Allow styles to be given as atoms when generating stylesheets.


### 1.0.2 - 2020-05-28

Update NimbleParsec dependency.


### 1.0.1 - 2020-03-24

Remove warnings on recent Elixir versions.


### 1.0.0 - 2019-07-15

Upgrade the HTML formatter so that you can use different kinds of tags around the tokens.

Previous versions always used the `<span>` tag (e.g. `<span class="n">name</span>`).
You can now use other HTML tags using the `:highlight_tag` option:

```elixir
alias Makeup.Formatters.HTML.HTMLFormatter
HTMLFormatter.format_as_iolist(tokens, highlight_tag: "font")
```


### 0.8.0 - 2019-01-01

This release adds a new file extension registry for lexers.
This means that it's now possible to lookup lexers by file extension.
Since the previous release it was already possible to lookup lexers by language name.
For example:

```elixir
elixir_lexer = Makeup.Registry.fetch_lexer_by_extension!("elixir")
```

Now you can also do this this:

```elixir
elixir_lexer = Makeup.Registry.get_lexer_by_extension!("ex")
```

Documentation of the registry functionality was also improved.


### 0.7.0 - 2018-12-30

Adds a register where lexer developers can register their lexers.
This allows one to pick a lexer based on the language name.

The goal is for Makeup to be aware of the avaliable lexers.
In a project such as ExDoc this allows Makeup to support an unbounded number of languages just by declaring the lexer as a dependency.


### 0.6.0 - 2018-12-22

Fixes the combinators affected by compatibility breaks in `nimble_parsec` from `0.4.x` to `0.5.x`.

Pins `nimble_parsec` to version `0.5.0`.
