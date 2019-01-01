RELEASE_TYPE: minor

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