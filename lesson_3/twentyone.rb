# twentyone.rb

require 'pry'

SUITS = %w(Hearts Diamonds Clubs Spades)
NUM_CARDS = (2..10)
NAME_CARDS = %w(Jack Queen King Ace)
PLAYERS = %w(dealer player)

def prompt(message)
  puts "\n=> #{message}"
end

def initialize_deck
  values = NUM_CARDS.to_a.map { |num| num.to_s }.push(NAME_CARDS).flatten
  values.product(SUITS)
end

def deal_initial_cards(deck)
  cards = deck.sample(2)
end

def remove_cards_from_deck(deck, cards)
  deck.reject! { |card| cards.include?(card) }
end

def display_one_card_of_dealer(hand)
  puts "Dealer has: #{hand.sample[0]} and unknown card"
end

def display_player_hand(hand)
  puts "You have: #{hand[0][0]} and #{hand[1][0]}"
end

puts "----------------------"
puts "Welcome to Twenty One!"
puts "----------------------"
puts "\nDealing initial cards..."

deck = initialize_deck
player_hand = deal_initial_cards(deck)
remove_cards_from_deck(deck, player_hand)
dealer_hand = deal_initial_cards(deck)
remove_cards_from_deck(deck, dealer_hand)

display_one_card_of_dealer(dealer_hand)
display_player_hand(player_hand)

prompt "What would you like to do?"
answer = gets.chomp.downcase