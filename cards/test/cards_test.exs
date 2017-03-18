defmodule CardsTest do
  use ExUnit.Case
  doctest Cards

  test "creates 52 cards" do
    assert 52 == length(Cards.create_deck)
  end

  test "shuffle a deck" do
    deck = Cards.create_deck
    refute deck == Cards.shuffle(deck)
  end
end
