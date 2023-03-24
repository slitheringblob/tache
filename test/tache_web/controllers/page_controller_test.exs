defmodule TacheWeb.PageControllerTest do
  @moduledoc """
  This module contains unit tests for the PageController
  """
  use TacheWeb.ConnCase

  @valid_create_user_data %{"gender" => "male", "password" => "jaydeeptest11", "username" => "jaydeeptest11"}
  @invalid_create_user_data %{"gender" => "", "password" => "jaydeeptest11", "username" => "jaydeeptest11"}
  @valid_auth_user_data %{"password"=> "jaydeeptest11", "username"=> "jaydeeptest11"}

  describe "Testing Base Connections" do
    test "GET /", %{conn: conn} do
      conn = get(conn, "/")
      assert html_response(conn, 200)
    end

    test "GET /login", %{conn: conn} do
      conn = get(conn, "/login")
      assert html_response(conn, 200)
    end

    test "GET /signup", %{conn: conn} do
      conn = get(conn, "/signup")
      assert html_response(conn, 200)
    end
  end

  describe "create_user/2" do
    test "create new valid user", %{conn: conn} do
      conn = post(conn, "/signup", user: @valid_create_user_data)
      assert html_response(conn, 302)
    end

    test "create new invalid user", %{conn: conn} do
      conn = post(conn, "/signup", user: @invalid_create_user_data)
      assert html_response(conn, 200)
    end
  end

  describe "authenticate_user/2" do
    test "auth for valid user", %{conn: conn} do

      conn = post(conn, "/signup", user: @valid_create_user_data)
      conn = post(conn, "/login", user: @valid_auth_user_data)
      assert html_response(conn, 302)
    end

  end
end
