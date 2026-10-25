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

  describe "root/1" do
    test "reads the root element's name and raw attributes" do
      xml = ~s(<odds_change product="1" event_id="sr:match:1" timestamp="42" request_id="7"><odds/></odds_change>)

      assert XML.root(xml) ==
               {:ok,
                {"odds_change", %{"product" => "1", "event_id" => "sr:match:1", "timestamp" => "42", "request_id" => "7"}}}
    end

    test "skips the XML declaration and drops namespace prefixes" do
      xml = ~s(<?xml version="1.0" encoding="UTF-8"?><ns:alive ns:product="3" subscribed="0"/>)

      assert XML.root(xml) == {:ok, {"alive", %{"product" => "3", "subscribed" => "0"}}}
    end

    test "stops at the root start tag without validating the rest" do
      assert {:ok, {"bet_stop", %{"product" => "1"}}} = XML.root(~s(<bet_stop product="1"><unclosed>))
    end

    test "returns an error when the start tag cannot be parsed" do
      assert {:error, _reason} = XML.root("<not valid")
      assert {:error, _reason} = XML.root("")
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
