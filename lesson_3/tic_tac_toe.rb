# tic_tac_toe.rb

require 'pry'

EMPTY_SPACE = ' '
WINNING_SET = [
  [1, 2, 3],
  [4, 5, 6],
  [7, 8, 9],
  [1, 4, 7],
  [2, 5, 8],
  [3, 6, 9],
  [1, 5, 9],
  [3, 5, 7]
]
MARKER_LOCATIONS = (1..9)
PLAYERS = %w(user computer)
MARKERS = %w(X O)

def initialize_board
  new_board = {}
  MARKER_LOCATIONS.each { |position| new_board[position] = EMPTY_SPACE }
  new_board
end

def display_board(board)
  puts ""
  puts "     |     |"
  puts "  #{board[1]}  |  #{board[2]}  |  #{board[3]}"
  puts "     |     |"
  puts "-----+-----+-----"
  puts "     |     |"
  puts "  #{board[4]}  |  #{board[5]}  |  #{board[6]}"
  puts "     |     |"
  puts "-----+-----+-----"
  puts "     |     |"
  puts "  #{board[7]}  |  #{board[8]}  |  #{board[9]}"
  puts "     |     |"
  puts ""
end

def prompt(message)
  puts "=> #{message}"
end

def valid_marker?(char)
  MARKERS.include?(char)
end

def display_marker(char)
  case char
  when MARKERS[0]
    prompt "You chose #{MARKERS[0]}, so the computer will be #{MARKERS[1]}"
  when MARKERS[1]
    prompt "You chose #{MARKERS[1]}, so the computer will be #{MARKERS[0]}"
  end
end

def player_places_marker!(board, marker)
  location = ''
  loop do
    prompt "Where would you like to place your marker? #{joinor(empty_positions(board))}"
    location = gets.chomp
    if valid_location?(location, board)
      break
    else
      prompt "Please select a valid location that has not been chosen yet"
    end
  end
  board.store(location.to_i, marker)
end

def computer_places_marker!(board, marker)
  location = nil

  # offense
  WINNING_SET.each do |line|
    location = find_at_risk_location(line, board, marker)
    break if location
  end

  # defense
  if !location
    WINNING_SET.each do |line|
      location = find_at_risk_location(line, board, alternate_marker(marker))
      break if location
    end
  end

  if !location
    location = empty_positions(board).sample
  end

  board.store(location.to_i, marker)
end

def find_at_risk_location(line, board, marker)
  if board.values_at(*line).count(marker) == 2
    board.select { |k, v| line.include?(k) && v == EMPTY_SPACE }.keys.first
  else
    nil
  end
end

def place_piece!(board, player)
  if player[:name] == PLAYERS[0]
    player_places_marker!(board, player[:marker])
  else
    computer_places_marker!(board, player[:marker])
  end
end

def valid_location?(loc, board)
  board[loc.to_i] == EMPTY_SPACE
end

def empty_positions(board)
  board.select { |_, val| val == EMPTY_SPACE }.keys
end

def board_full?(board)
  board.all? { |_, val| val != EMPTY_SPACE }
end

def win?(board, player)
  marker_positions = find_marker_positions(board, player[:marker])
  combos = marker_positions.combination(3).to_a
  combos.any? { |combo| WINNING_SET.include?(combo) }
end

def find_marker_positions(board, marker)
  board.select { |_, val| val == marker }.keys.to_a
end

def display_tie_message
  puts "Looks like it's a tie this time."
end

def display_win_message(player)
  case player[:name]
  when PLAYERS[0]
    puts "You won this round!"
  when PLAYERS[1]
    puts "The computer beat you!"
  end
end

def joinor(array, delim=', ', word='or')
  array[-1] = "#{word} #{array.last}" if array.size > 1
  if array.size < 3
    array.join(' ')
  else
    array.join(delim)
  end
end

def randomize_starting_player(players_array)
  PLAYERS.sample == PLAYERS[0] ? players_array[0] : players_array[1]
end

def alternate_player(cur_player, all_players)
  cur_player == all_players[0] ? all_players[1] : all_players[0]
end

def alternate_marker(mark)
  mark == MARKERS[0] ? MARKERS[1] : MARKERS[0]
end

def display_whose_turn(player)
  if player[:name] == PLAYERS[0]
    puts "Your move:"
  else
    puts "Computer's move"
  end
end

def add_point_to_winner(player)
  player[:score] += 1
end

def display_scores(players)
  puts "Your Score: #{players[0][:score]}, Computer's Score: #{players[1][:score]}"
end

def announce_winner(player)
  if player[:name] == PLAYERS[0]
    puts "#{player[:name].capitalize} has scored 5 points and won the game! Congratulations!"
  else
    puts "The computer scored 5 points and defeated you! So sorry for your loss."
  end
end


puts "Welcome to Tic Tac Toe!"
puts "-----------------------"

marker = ''
prompt "Would you like to be #{MARKERS[0]} or #{MARKERS[1]}?"
loop do
  marker = gets.chomp.upcase
  if valid_marker?(marker)
    display_marker(marker)
    break
  else
    prompt "Please choose either X or O"
  end
end

game_players = [
  {
    name: PLAYERS[0],
    marker: marker,
    score: 0
  },
  {
    name: PLAYERS[1],
    marker: alternate_marker(marker),
    score: 0
  }
]

loop do # main game loop
  board = initialize_board
  puts "Let's begin!"
  display_board(board)

  current_player = randomize_starting_player(game_players)

  loop do # main turn loop
    place_piece!(board, current_player)
    display_whose_turn(current_player)
    display_board(board)

    if win?(board, current_player)
      add_point_to_winner(current_player)
      display_win_message(current_player)
      display_scores(game_players)
      break
    elsif board_full?(board)
      display_tie_message
      break
    end

    current_player = alternate_player(current_player, game_players)
  end

  if game_players.any? { |player| player[:score] > 4 }
    announce_winner(current_player)
    break
  end

  prompt "Would you like to play again?"
  answer = gets.chomp
  break unless answer.downcase.start_with?('y')
end
