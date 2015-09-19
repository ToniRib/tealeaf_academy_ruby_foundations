# twentyone.rb

# TODO: add messages into their own method

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

def convert_choice(word)
  case word
  when /^hi?t?$/
    'hit'
  when /^st?a?y?$/
    'stay'
  end
end

def valid_choice?(word)
  word == 'hit' || word == 'stay'
end

def initialize_deck
  values = NUM_CARDS.to_a.map(&:to_s).push(NAME_CARDS).flatten
  values.product(SUITS)
end

def remove_cards_from_deck(deck, cards)
  deck.reject! { |card| cards.include?(card) }
end

def display_one_card_of_dealer(hand)
  puts "Dealer has: #{hand.sample[0]} and unknown card"
end

def display_player_hand(hand)
  puts "You have: #{joinor(hand.collect { |i| i[0] })} for a total of #{calculate_total(hand)} points"
end

def display_dealer_hand(hand)
  puts "The dealer has: #{joinor(hand.collect { |i| i[0] })} for a total of #{calculate_total(hand)} points"
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

def detect_result(player, dealer)
  player_total = calculate_total(player)
  dealer_total = calculate_total(dealer)

  if player_total > 21
    :player_busted
  elsif dealer_total > 21
    :dealer_busted
  elsif player_total > dealer_total
    :player
  elsif player_total < dealer_total
    :dealer
  else
    :tie
  end
end

def display_result(player, dealer)
  result = detect_result(player, dealer)

  case result
  when :player_busted
    prompt "You busted! The dealer wins!"
  when :dealer_busted
    prompt "The dealer busted! You win!"
  when :player
    prompt "You win!"
  when :dealer
    prompt "The dealer wins!"
  when :tie
    prompt "It's a tie!"
  end
end

puts "----------------------"
puts "Welcome to Twenty One!"
puts "----------------------"

loop do # main game loop
  puts "\nDealing initial cards..."

  deck = initialize_deck
  player_hand = []
  dealer_hand = []

  2.times do
    deal_card(deck, player_hand)
    deal_card(deck, dealer_hand)
  end

  display_one_card_of_dealer(dealer_hand)
  display_player_hand(sort_hand!(player_hand))

  loop do # dealing and counting loop
    loop do # player turn loop
      prompt "What would you like to do, hit or stay?"
      answer = gets.chomp.downcase
      answer = convert_choice(answer)
      if valid_choice?(answer)
        deal_card(deck, player_hand) if answer == 'hit'
        display_player_hand(sort_hand!(player_hand))
        break if answer == 'stay' || busted?(player_hand)
      else
        prompt "Please type either hit (h) or stay (s)"
      end
    end

    if busted?(player_hand)
      display_result(player_hand, dealer_hand)
      break
    else
      puts "You chose to stay at #{calculate_total(player_hand)} points"
    end

    loop do # dealer turn loop
      deal_card(deck, dealer_hand) unless calculate_total(dealer_hand) >= 17
      display_dealer_hand(sort_hand!(dealer_hand))
      break if busted?(dealer_hand) || calculate_total(dealer_hand) >= 17
    end

    if busted?(dealer_hand)
      display_result(player_hand, dealer_hand)
      break
    end

    display_result(player_hand, dealer_hand)
    break
  end

  prompt "Would you like to play again?"
  answer = gets.chomp
  break unless answer.downcase.start_with?('y')
end

prompt "Thanks for playing Twenty One!"
