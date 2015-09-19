# twentyone.rb

require 'pry'

SUITS = %w(Hearts Diamonds Clubs Spades)
NUM_CARDS = (2..10)
NAME_CARDS = %w(Jack Queen King Ace)
PLAYERS = %w(dealer player)

def prompt(message)
  puts "\n=> #{message}"
end

def joinor(array, delim=', ', word='and')
  array[-1] = "#{word} #{array.last}" if array.size > 1
  if array.size < 3
    array.join(' ')
  else
    array.join(delim)
  end
end

def initialize_deck
  values = NUM_CARDS.to_a.map.to_s.push(NAME_CARDS).flatten
  values.product(SUITS)
end

def deal_initial_cards(deck)
  deck.sample(2)
end

def remove_cards_from_deck(deck, cards)
  deck.reject! { |card| cards.include?(card) }
end

def display_one_card_of_dealer(hand)
  puts "Dealer has: #{hand.sample[0]} and unknown card"
end

def display_player_hand(hand)
  puts "You have: #{joinor(hand.collect { |i| i[0] })}"
end

def display_dealer_hand(hand)
  puts "The dealer has: #{joinor(hand.collect { |i| i[0] })}"
end

def busted?(hand)
  calculate_total(hand) > 21
end

def deal_card(deck, hand)
  card = deck.sample
  hand.push(card)
  remove_cards_from_deck(deck, card)
end

def calculate_total(hand)
  total = 0
  values = hand.collect { |i| i[0] }
  non_aces = values.select { |val| val != 'Ace' }
  num_aces = values.count('Ace')

  non_aces.each do |val|
    total += convert_card_to_value(val)
  end

  num_aces.times do |i|
    if (i == 0) && (total + 11 <= 21)
      total += 11
    else
      total += 1
    end
  end
  total
end

def display_total(hand)
  puts "Total: #{calculate_total(hand)} points"
end

def convert_card_to_value(card)
  if card.to_i != 0
    card.to_i
  else
    10
  end
end

def sort_hand!(hand)
  if hand.include?('Ace')
    aces = hand.select { |card| card == 'Ace' }
    hand.select! { |card| card == 'Ace' }.sort!.push(aces).flatten!
  else
    hand.sort!
  end
end

def compare_cards(hand1, hand2)
  calculate_total(hand1) > calculate_total(hand2)
end

puts "----------------------"
puts "Welcome to Twenty One!"
puts "----------------------"

loop do # main game loop
  puts "\nDealing initial cards..."

  deck = initialize_deck
  player_hand = deal_initial_cards(deck)
  remove_cards_from_deck(deck, player_hand)
  dealer_hand = deal_initial_cards(deck)
  remove_cards_from_deck(deck, dealer_hand)

  display_one_card_of_dealer(dealer_hand)
  display_player_hand(sort_hand!(player_hand))

  loop do # dealing and counting loop
    loop do # player turn loop
      prompt "What would you like to do, hit or stay?"
      answer = gets.chomp.downcase
      deal_card(deck, player_hand) if answer == 'hit'
      display_player_hand(sort_hand!(player_hand))
      break if answer == 'stay' || busted?(player_hand)
    end

    display_total(player_hand)

    if busted?(player_hand)
      puts "You busted! The dealer wins!"
      break
    else
      puts "You chose to stay."
    end

    loop do # dealer turn loop
      deal_card(deck, dealer_hand) unless calculate_total(dealer_hand) >= 17
      display_dealer_hand(sort_hand!(dealer_hand))
      break if busted?(dealer_hand) || calculate_total(dealer_hand) >= 17
    end

    display_total(dealer_hand)

    if busted?(dealer_hand)
      puts "The dealer busted! You win!"
      break
    end

    if compare_cards(player_hand, dealer_hand)
      puts "You won!"
      break
    else
      puts "The dealer beat you!"
      break
    end
  end

  prompt "Would you like to play again?"
  answer = gets.chomp
  break unless answer.downcase.start_with?('y')
end
