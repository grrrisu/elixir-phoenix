defmodule Cards do

  @moduledoc """
   Functions to create and handle a deck of playing cards.
  """

  def create_deck do
    values = ["Ace", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten", "Jack", "Queen", "King"]
    suits  = ["Spades", "Hearts", "Clubs", "Diamonds"]

    for suit <- suits, value <- values do
      "#{value} of #{suit}"
    end
  end

  @doc """
    returns a shuffled deck
  """
  def shuffle(deck) do
    Enum.shuffle(deck)
  end

  @doc """
    Determinates if a given card is in the deck

  ## Exmaples

      iex> deck = Cards.create_deck
      iex> Cards.contains?(deck, "Ace of Spades")
      true

  """
  def contains?(deck, card) do
    Enum.member?(deck, card)
  end

  @doc """
    deals a hand of size `hand_size`.
    returns the hand and the rest of the deck.

  ## Exmaples

      iex> deck = Cards.create_deck
      iex> {hand, _rest} = Cards.deal(deck, 1)
      iex> hand
      ["Ace of Spades"]

  """
  def deal(deck, hand_size) do
    Enum.split(deck, hand_size)
  end

  def save(deck, filename) do
    binary = :erlang.term_to_binary(deck)
    File.write(filename, binary)
  end

  def load(filename) do
    case File.read(filename) do
      { :ok, binary }     -> :erlang.binary_to_term(binary)
      { :error, reason }  -> "Error reading file: #{reason}"
    end
  end

  def create_hand(hand_size) do
    Cards.create_deck
    |> Cards.shuffle
    |> Cards.deal(hand_size)
  end

end
