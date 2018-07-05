defmodule Issues.GithubTest do
  use ExUnit.Case
  doctest Issues.Github

  import Issues.Github, only: [ fetch: 2 ]

  test "Existing github repo should return tuple of {:ok, body}" do
    {status, _} = fetch("elixir-lang", "elixir")
    assert status == :ok
  end

  # test "Unknown github repo should return tuple of {:error, error}" do
  #   {status, _} = fetch("bla", "bliblubb")
  #   assert status == :error
  # end
end