defmodule Discuss.User do
  use Discuss.Web, :model

  schema "users" do
    field :email, :string
    field :username, :string
    field :provider, :string
    field :token, :string
    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:email, :username, :provider, :token])
    |> validate_required([:email, :username, :provider, :token])
  end

end