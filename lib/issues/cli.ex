defmodule Issues.CLI do

  @default_count 4

  def run(argv) do
    argv
    |> parse_args
    |> process
    |> Issues.Printer.print
  end

  @doc """
  `argv` can be -h or --help, which return :help
  Otherwise a github user name, project name and (optionally) the number of entries

  Returns a tuple of {user, project, count} or :help
  """
  def parse_args(argv) do
    parse = OptionParser.parse(argv, switches: [help: :boolean], aliases: [h: :help])

    case parse do
      {[help: true], _, _ }           -> :help
      {_, [user, project, count], _}  -> {user, project, String.to_integer(count)}
      {_, [user, project], _}         -> {user, project, @default_count}
      _                               -> :help
    end
  end

  def process(:help) do
    IO.puts """
    usage: issues <user> <project> [count | #{@default_count}]
    """
    System.halt(0)
  end

  def process({user, project, count}) do
    Issues.Github.fetch(user, project)
    |> sort_by_asc
    |> Enum.take(count)
  end

  def sort_by_asc(issues_list) do
    issues_list
    |> Enum.sort(fn(i1, i2) -> Map.get(i1, "created_at") <= Map.get(i2, "created_at") end)
  end

end