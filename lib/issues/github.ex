defmodule Issues.Github do

  @user_agent [{"User-agent", "buelsenfrucht jascha@khamelion.de"}]
  @github_url Application.get_env(:issues, :github_url)

  def fetch(user, project, _count) do
    issues_url(user, project)
    |> HTTPoison.get(@user_agent)
    |> handle_response
  end

  defp issues_url(user, project) do
    "#{@github_url}/repos/#{user}/#{project}/issues"
  end

  defp handle_response({:ok, %{status_code: 200, body: body}}) do
    {:ok, Poison.Parser.parse!(body) }
  end

  defp handle_response({_, %{body: body}}) do
    {:error, Poison.Parser.parse!(body) }
  end

end