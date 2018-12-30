defmodule Makeup.Registry do
  @moduledoc """
  A registry that allows users to dynamically register new makeup lexers.

  Lexers should register themselves on application start.
  That way, you can add support for new programming languages by depending on the relevant lexers.
  This is useful for projects such as ExDoc, which might contain code
  in a number of different programming languages.
  """

  @registry_key :lexer_name_registry

  @doc false
  def create_name_registry() do
    Application.put_env(:makeup, @registry_key, %{})
  end

  defp get_name_registry() do
    Application.get_env(:makeup, @registry_key)
  end

  defp put_name_registry(registry) do
    Application.put_env(:makeup, @registry_key, registry)
  end

  @doc """
  Adds a new lexer to Makeup's registry under the given `name`.

  This function expects a lexer
  """
  def register_lexer_with_name(name, {lexer, options}) when is_binary(name) do
    old_registry = get_name_registry()
    updated_registry = Map.put(old_registry, name, {lexer, options})
    put_name_registry(updated_registry)
  end

  @doc """
  Fetches a lexer from Makeup's registry.

  Returns either `{:ok, {lexer, options}}` or `:error`.
  This behaviour is based on `Map.fetch/2`.
  """
  def fetch_lexer_by_name(name) do
    Map.fetch(get_name_registry(), name)
  end

  @doc """
  Fetches a lexer from Makeup's registry.

  Returns either `{lexer, options}` or raises an `KeyError`.
  This behaviour is based on `Map.fetch!/2`.
  """
  def fetch_lexer_by_name!(name) do
    Map.fetch!(get_name_registry(), name)
  end
end
