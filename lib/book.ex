defmodule Biblex.Book do
  use Ecto.Schema
  import Ecto.Changeset

  @required_params [:title, :author, :isbn, :price]

  embedded_schema do
    field :title, :string
    field :author, :string
    field :isbn, :string
    field :price, :decimal
  end

  def changeset(params) do
    %__MODULE__{}
    |> cast(params, @required_params)
    |> validate_required(@required_params)
    |> validate_length(:isbn, is: 13)
    |> validate_number(:price, greater_than_or_equal_to: 0)
  end
end
