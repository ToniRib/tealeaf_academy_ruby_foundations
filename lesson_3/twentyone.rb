# twentyone.rb

require 'pry'

SUITS = %w(h d c s)
NUM_CARDS = (2..10)
NAME_CARDS = %w(j q k a)
PLAYERS = %w(dealer player)

def initialize_deck
  values = NUM_CARDS.to_a.map { |num| num.to_s }.push(NAME_CARDS).flatten
  values.product(SUITS)
end

initialize_deck