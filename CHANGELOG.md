# Chnagelog

<!-- %% CHANGELOG_ENTRIES %% -->

### 0.8.0 - 2019-01-01 16:48:41

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


### 0.7.0 - 2018-12-30 19:06:18

Adds a register where lexer developers can register their lexers.
This allows one to pick a lexer based on the language name.

The goal is for Makeup to be aware of the avaliable lexers.
In a project such as ExDoc this allows Makeup to support an unbounded number of languages just by declaring the lexer as a dependency.


### 0.6.0 - 2018-12-22 01:11:02

Fixes the combinators affected by compatibility breaks in `nimble_parsec` from `0.4.x` to `0.5.x`.

Pins `nimble_parsec` to version `0.5.0`.


### 0.5.6 - 2018-12-12

Make makeup depend on `nimble_parsec` v0.4.0, because v0.5.0 contains breaking changes.

