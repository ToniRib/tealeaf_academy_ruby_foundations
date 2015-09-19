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
  location = empty_positions(board).sample
  board.store(location.to_i, marker)
end

def place_piece!(board, cur_player, cur_marker)
  if cur_player == 'user'
    player_places_marker!(board, cur_marker)
  else
    computer_places_marker!(board, cur_marker)
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

def win?(board, marker)
  marker_positions = board.select { |_, val| val == marker }.keys.to_a
  combos = marker_positions.combination(3).to_a
  combos.any? { |combo| WINNING_SET.include?(combo) }
end

def display_tie_message
  puts "Looks like it's a tie this time."
end

def display_win_message(cur_player)
  case cur_player
  when 'user'
    puts "You won this round!"
  when 'computer'
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

def determine_starting_player
  PLAYERS.sample
end

def alternate_player(player)
  player == PLAYERS[0] ? PLAYERS[1] : PLAYERS[0]
end

def opposite_marker(marker)
  marker == MARKERS[0] ? MARKERS[1] : MARKERS[0]
end

def determine_starting_marker(cur_player, user, computer)
  case cur_player
  when 'user'
    user
  when 'computer'
    computer
  end
end

loop do # main game loop
  puts "Welcome to Tic Tac Toe!"
  puts "-----------------------"

  marker = ''
  prompt "Would you like to be #{joinor(MARKERS)}?"
  loop do
    marker = gets.chomp.upcase
    if valid_marker?(marker)
      display_marker(marker)
      break
    else
      prompt "Please choose either X or O"
    end
  end

  computer_marker = determine_computer_marker(marker)

  board = initialize_board

  current_player = determine_starting_player
  current_marker = determine_starting_marker(current_player, marker, computer_marker)

  loop do # main turn loop
    display_board(board)
    place_piece!(board, current_player, current_marker)
    current_player = alternate_player(current_player)
    current_marker = alternate_marker(current_marker)
    if win?(board, current_marker)
      display_win_message(current_player)
      break
    elsif board_full?(board)
      display_tie_message
      break
    end
  end

  prompt "Would you like to play again?"
  answer = gets.chomp
  break unless answer.downcase.start_with?('y')
end
