defmodule WabanexWeb.SchemaTest do
  use WabanexWeb.ConnCase, async: true

  alias Wabanex.User
  alias Wabanex.Users.Create

  describe "users queries" do
    test "when a valid id is given, returns the user", %{conn: conn} do
      params = %{name: "rafael", email: "rafael@test.com", password: "12345678"}

      {:ok, %User{id: user_id}} = Create.call(params)

      query = """
        {
          getUser(id: "#{user_id}"){
            name
            email
          }
        }
      """

      response =
        conn
        |> post("/api/graphql", %{query: query})
        |> json_response(:ok)

        expected_response = %{"data" => %{"getUser" => %{"email" => "rafael@test.com", "name" => "rafael"}}}

      assert response == expected_response
    end

    test "when a invalid id is given, returns an", %{conn: conn} do
      query = """
        {
          getUser(id: "any"){
            name
            email
          }
        }
      """

      response =
        conn
        |> post("/api/graphql", %{query: query})
        |> json_response(:ok)

        expected_response = %{"errors" => [%{"locations" => [%{"column" => 13, "line" => 2}], "message" => "Argument \"id\" has invalid value \"any\"."}]}

      assert response == expected_response
    end
  end
end
