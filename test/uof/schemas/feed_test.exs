defmodule UOF.Schemas.FeedTest do
  use ExUnit.Case, async: true

  alias UOF.Schemas.Feed
  alias UOF.Schemas.XML

  describe "XML.decode/2 with registry/0" do
    test "decodes an alive message into the matching struct" do
      assert {:ok, %Feed.Alive{product: 1, timestamp: 1_234_567_890, subscribed: 1}} =
               XML.decode(
                 ~s(<alive product="1" timestamp="1234567890" subscribed="1"/>),
                 Feed.registry()
               )
    end

    test "decodes an odds_change, walking nested embeds" do
      xml =
        ~s(<odds_change product="3" event_id="sr:match:1" timestamp="1234"><odds><market id="1"/></odds></odds_change>)

      assert {:ok, %Feed.OddsChange{product: 3, event_id: "sr:match:1", odds: odds}} =
               XML.decode(xml, Feed.registry())

      assert %Feed.OddsChangeOdds{} = odds
    end

    test "returns an error tuple for an unrecognised root element" do
      assert {:error, {:unknown_message, "nonsense"}} =
               XML.decode("<nonsense/>", Feed.registry())
    end
  end

  test "registry/0 lists every supported feed message" do
    assert Enum.sort(Map.keys(Feed.registry())) ==
             Enum.sort(~w(odds_change bet_settlement bet_stop bet_cancel rollback_bet_cancel
                  rollback_bet_settlement fixture_change alive snapshot_complete))
  end
end
