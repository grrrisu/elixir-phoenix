defmodule Discuss.TopicController do
  use Discuss.Web, :controller

  alias Discuss.Topic

  def index(conn, _params) do
    topics = Repo.all(Topic)
    render conn, "index.html", topics: topics
  end

  def new(conn, _params) do
    changeset = Topic.changeset( %Topic{} )
    render conn, "new.html", changeset: changeset
  end

  def create(conn, %{"topic" => topic}) do
    changeset = Topic.changeset( %Topic{}, topic )

    case Repo.insert(changeset) do
      {:ok, _topic} ->
        conn
        |> put_flash("Topic created", :info)
        |> redirect(to: topic_path(conn, :index))

      {:error, changeset} ->
        conn
        |> put_flash("Failed to create topic", :error)
        |> render("new.html", changeset: changeset)
    end
  end

end
