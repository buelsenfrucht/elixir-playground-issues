defmodule Issues.Printer do

  def print(list) do
    print_header()
    Enum.each(list, &(print_issue(&1)))
  end

  def print_header() do
    IO.puts """
      #  | created_at           | title                                   
    -----+----------------------+-------------------------------------------
    """
  end

  def print_issue(issue) do
    IO.puts "#{Map.get(issue, "number")} | #{Map.get(issue, "created_at")} | #{Map.get(issue, "title")}"
  end

end