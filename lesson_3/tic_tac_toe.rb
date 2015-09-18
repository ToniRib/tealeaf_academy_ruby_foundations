# tic_tac_toe.rb

require 'pry'

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

def initialize_board
  new_board = {}
  (1..9).each { |position| new_board[position] = ' ' }
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
    prompt "Where would you like to place your marker? (1 - 9)"
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
    location = (1..9).to_a.sample
    break if valid_location?(location, board)
  end
  board.store(location.to_i, marker)
end

def valid_location?(loc, board)
  board[loc.to_i] == ' '
end

def board_full?(board)
  board.all? { |_, val| val != ' ' }
end

def win?(board, marker)
  marker_positions = board.select { |_, val| val == marker }.keys.to_a
  binding.pry
end

def player_turn(board, marker)
  player_places_marker(board, marker)
  display_board(board)
  if win?(board, marker)
    prompt "You win!"
  elsif board_full?(board)
    prompt "Looks like it's a tie!"
  end
end

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

loop do # main game loop
  player_turn(board, marker)
  puts "The computer is thinking..."
  sleep(1)
  computer_places_marker(board, computer_marker)
  puts "The computer has chosen!"
  display_board(board)
  break if board_full?(board)
end
