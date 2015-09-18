# tic_tac_toe.rb

require 'pry'

def initialize_board
  new_board = {}
  (1..9).each { |position| new_board[position] = ' '}
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
  prompt "Where would you like to place your marker? (1 - 9)"
  location = gets.chomp
  board.store(location.to_i, marker)
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

loop do
  player_places_marker(board, marker)
  display_board(board)
  break
end
