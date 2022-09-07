defmodule Biblex do
  import Ecto.Changeset, only: [apply_action: 2, traverse_errors: 2]
  alias Biblex.Book

  def create_book(params) do
    params
    |> Book.changeset()
    |> apply_action(:create)
    |> handle_create()
  end

  defp handle_create({:ok, book}), do: %{status: :ok, result: book}

  defp handle_create({:error, changeset}) do
    %{status: :bad_request, result: translate_errors(changeset)}
  end

  defp translate_errors(changeset) do
    traverse_errors(changeset, fn {msg, opts} ->
      Regex.replace(~r"%{(\w+)}", msg, fn _, key ->
        opts
        |> Keyword.get(String.to_existing_atom(key), key)
        |> to_string()
      end)
    end)
  end
end
