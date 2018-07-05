defmodule Issues.CliTest do
  use ExUnit.Case
  doctest Issues.CLI

  import Issues.CLI, only: [ parse_args: 1, sort_by_asc: 1 ]

  test ":help returned by option parsing with -h or --help options" do
    assert parse_args(["-h",      "anything"]) == :help
    assert parse_args(["--help",  "anything"]) == :help
  end

  test "three values returned if three given" do
    assert parse_args(["user", "project", "99"]) == {"user", "project", 99}
  end 

  test "three values returned (last to be 4) if two given" do
    assert parse_args(["user", "project"]) == {"user", "project", 4}
  end

  test "sort ascending by created_at" do
    result = sort_by_asc(created_at_list(["c", "a", "b", "h", "f"]))
    assert Enum.map(result, &(Map.get(&1, "created_at")) ) == ~w{a b c f h}
  end

  defp created_at_list(values) do
    for value <- values, do: %{"created_at" => value, "some_data" => "blabla"}
  end
end