defmodule Wabanex.UserTest do
  use Wabanex.DataCase, async: true

  alias Wabanex.User

  describe "changeset/1" do
    test "when all params are valid, returns a valid changeset" do
      params = %{name: "rafael", email: "rafael@test.com", password: "12345678"}

      response = User.changeset(params)

      assert %Ecto.Changeset{
        valid?: true,
        changes: %{name: "rafael", email: "rafael@test.com", password: "12345678"},
        errors: []
      } = response
    end

    test "when there invalid params, returns an error" do
      params = %{name: "r", email: "rafael@test.com", password: "12345"}

      response = User.changeset(params)

      expected_response = %{name: ["should be at least 2 character(s)"], password: ["should be at least 8 character(s)"]}

      assert errors_on(response) == expected_response
    end
  end

end
