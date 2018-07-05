defmodule Issues.GithubTest do
  use ExUnit.Case
  doctest Issues.Github

  import Issues.Github, only: [ fetch: 3 ]

  test "Existing github repo should return tuple of {:ok, body}" do
    {status, _} = fetch("elixir-lang", "elixir", 1)
    assert status == :ok
  end

  test "Unknown github repo should return tuple of {:error, error}" do
    {status, _} = fetch("bla", "bliblubb", 1)
    assert status == :error
  end
end