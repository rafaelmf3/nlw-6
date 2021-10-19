defmodule Wabanex.IMCTest do
  use ExUnit.Case, async: true

  alias Wabanex.IMC

  describe "calculate/1" do
    test "when the file exists, returns the data" do
      params =%{"filename" => "students.csv"}

      response = IMC.calculate(params)

      expected_response = {:ok, %{"carol" => 24.515595463137995, "diego" => 24.870037807183365, "rafael" => 25.254017013232513}}

      assert response == expected_response
    end

    test "when wrong filename is given, returns an error" do
      params =%{"filename" => "any.csv"}

      response = IMC.calculate(params)

      expected_response = {:error, "Error while opening the file"}

      assert response == expected_response
    end
  end
end
