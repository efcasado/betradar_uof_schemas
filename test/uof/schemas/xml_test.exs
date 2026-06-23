defmodule UOF.Schemas.XMLTest do
  use ExUnit.Case, async: true

  alias UOF.Schemas.API.Users.BookmakerDetails
  alias UOF.Schemas.Common.Response
  alias UOF.Schemas.Feed
  alias UOF.Schemas.XML

  describe "decode/1 with the global registry" do
    test "dispatches a feed message to its generated schema" do
      xml = ~s(<alive product="1" timestamp="1234567890" subscribed="1"/>)

      assert {:ok, %Feed.Alive{product: 1, timestamp: 1_234_567_890, subscribed: 1}} =
               XML.decode(xml)
    end

    test "dispatches an API response to its generated schema" do
      xml = ~s(<bookmaker_details response_code="OK" bookmaker_id="123" virtual_host="/unifiedfeed/123"/>)

      assert {:ok, %BookmakerDetails{response_code: "OK", bookmaker_id: 123}} = XML.decode(xml)
    end

    test "dispatches the shared <response> envelope to Common.Response" do
      xml = ~s(<response response_code="NOT_FOUND"><message>no such event</message></response>)

      assert {:ok, %Response{response_code: "NOT_FOUND", message: "no such event"}} =
               XML.decode(xml)
    end

    test "returns an error for an unrecognised root element" do
      assert {:error, {:unknown_message, "nope"}} = XML.decode("<nope/>")
    end
  end

  describe "decode/2 with a schema module (static)" do
    test "decodes attributes into the given schema, casting scalar types" do
      xml =
        ~s(<bookmaker_details response_code="OK" bookmaker_id="123" virtual_host="/unifiedfeed/123" expire_at="2026-06-22T10:00:00Z"/>)

      assert {:ok, details} = XML.decode(xml, BookmakerDetails)

      assert %BookmakerDetails{
               response_code: "OK",
               bookmaker_id: 123,
               virtual_host: "/unifiedfeed/123"
             } = details

      assert %DateTime{} = details.expire_at
    end
  end

  describe "decode/2 with a registry (dynamic)" do
    test "dispatches on the root element to the registered module" do
      registry = %{"alive" => Feed.Alive}

      assert {:ok, %Feed.Alive{product: 1}} =
               XML.decode(~s(<alive product="1" timestamp="1" subscribed="1"/>), registry)
    end

    test "returns an error for a root element absent from the registry" do
      assert {:error, {:unknown_message, "nope"}} = XML.decode("<nope/>", %{})
    end
  end
end
