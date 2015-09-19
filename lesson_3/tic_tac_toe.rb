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
  char == 'X' || char == 'O'
end

def display_marker(char)
  case char
  when 'X'
    prompt "You chose 'X', so the computer will be 'O'"
  when 'O'
    prompt "You chose 'O', so the computer will be 'X'"
  end
end

def player_places_marker(board, marker)
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

def computer_places_marker(board, marker)
  location = ''
  loop do
    location = MARKER_LOCATIONS.to_a.sample
    break if valid_location?(location, board)
  end
  board.store(location.to_i, marker)
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

def player_turn(board, marker)
  player_places_marker(board, marker)
  display_board(board)
end

def computer_turn(board, marker)
  puts "The computer is thinking..."
  sleep(1)
  computer_places_marker(board, marker)
  puts "The computer has chosen!"
  display_board(board)
end

def display_tie_message
  puts "Looks like it's a tie this time."
end

def joinor(array, delim=', ', word='or')
  array[-1] = "#{word} #{array.last}" if array.size > 1
  array.join(delim)
end

loop do # main game loop
  puts "Welcome to Tic Tac Toe!"
  puts "-----------------------"

  marker = ''
  prompt "Would you like to be X or O?"
  loop do
    marker = gets.chomp.upcase
    if valid_marker?(marker)
      display_marker(marker)
      break
    else
      prompt "Please choose either X or O"
    end
  end

  computer_marker = (marker == 'O') ? 'X' : 'O'

  board = initialize_board
  display_board(board)

  loop do # main turn loop
    player_turn(board, marker)
    if win?(board, marker)
      puts "You win!!"
      break
    elsif board_full?(board)
      puts display_tie_message
      break
    end

    computer_turn(board, computer_marker)
    if win?(board, computer_marker)
      puts "The computer beat you!!"
      break
    elsif board_full?(board)
      puts display_tie_message
      break
    end
  end

  prompt "Would you like to play again?"
  answer = gets.chomp
  break unless answer.downcase.start_with?('y')
end
