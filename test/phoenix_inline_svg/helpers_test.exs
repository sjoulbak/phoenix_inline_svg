defmodule PhoenixInlineSvg.HelpersTest do
  @moduledoc false

  use ExUnit.Case
  use Phoenix.ConnTest
  use Mix.Config

  alias PhoenixInlineSvg.Helpers

  setup do
    {:ok, conn: build_conn()}
  end

  describe "__using__" do
    # My approach for here was to assert the RuntimeError, but still wip.
    # test "should raise an error when no opt_app is given" do
    #   try do
    #     require PhoenixInlineSvg.Helpers
    #     PhoenixInlineSvg.Helpers.__using__([])
    #   rescue
    #     x in RuntimeError -> IO.inspect x
    #   end
    # end
  end

  describe "svg_image/2" do
    test "should show a svg", %{conn: conn} do
      {:safe, svg} = Helpers.svg_image(conn, "icon")
      assert svg == "<svg viewbox='0 0 60 60'><text x='0' y='40' font-family='monospace'>Test</text></svg>"
    end

    test "should throw an error when svg is not found", %{conn: conn} do
      {:safe, svg} = Helpers.svg_image(conn, "notsvg")
      assert svg == "<svg viewbox='0 0 60 60'><text x='0' y='40' font-size='30' font-weight='bold' font-family='monospace'>Err</text></svg>"
    end
  end

  describe "svg_image/3" do
    test "should show a svg", %{conn: conn} do
      {:safe, svg} = Helpers.svg_image(conn, "icon", "icons")
      assert svg == "<svg viewbox='0 0 60 60'><text x='0' y='40' font-family='monospace'>Test</text></svg>"
    end

    test "should show a svg with a wrap", %{conn: conn} do
      {:safe, svg} = Helpers.svg_image(conn, "icon", %{wrap: true})
      assert svg == "<i class='-svgs -icon-svg'><svg viewbox='0 0 60 60'>" <>
                    "<text x='0' y='40' font-family='monospace'>Test</text></svg>" <>
                    "</i>"
    end

    test "should throw an error when svg is not found", %{conn: conn} do
      {:safe, svg} = Helpers.svg_image(conn, "notsvg", "fakecollection")
      assert svg == "<svg viewbox='0 0 60 60'><text x='0' y='40' font-size='30' font-weight='bold' font-family='monospace'>Err</text></svg>"
    end

    test "should wrap a svg when the svg is not found", %{conn: conn} do
      {:safe, svg} = Helpers.svg_image(conn, "notsvg", %{wrap: true})
      assert svg == "<i class='-svgs -notsvg-svg'><svg viewbox='0 0 60 60'>" <>
                    "<text x='0' y='40' font-size='30' font-weight='bold' font-family='monospace'>Err</text></svg>" <>
                    "</i>"
    end
  end

  describe "config" do
    test "should use the default config", %{conn: conn} do
      # We need another approach for this, because otherwise it is possible to
      # have random failures.
      #
      # env = Application.get_env(:phoenix_inline_svg, :not_found)
      # Application.delete_env(:phoenix_inline_svg, :not_found)
      #
      # {:safe, svg} = Helpers.svg_image(conn, "icon")
      # assert svg == "<svg viewbox='0 0 60 60'><text x='0' y='40' font-family='monospace'>Test</text></svg>"
      #
      # Application.put_env(:phoneix_inline_svg, :not_found, env)
    end

    test "variabele :dir should have a default value" do
      assert Application.get_env(:phoenix_inline_svg, :dir) == "test/fixtures"
    end

    test "variabele :default_collection should have a default value" do
      assert Application.get_env(:phoenix_inline_svg, :default_collection) == ""
    end

    test "variabele :not_found should have a default value" do
      assert Application.get_env(:phoenix_inline_svg, :not_found) == "<svg viewbox='0 0 60 60'><text x='0' y='40' font-size='30' font-weight='bold' font-family='monospace'>Err</text></svg>"
    end
  end

  #  test "showing an svg"
  #  test "showing error when not found"
  #  test "config dir variable"
  #  test "config not found variable"
end
