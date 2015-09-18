# tic_tac_toe.rb

def initialize_board
  puts ""
  puts "     |     |"
  puts "     |     |"
  puts "     |     |"
  puts "-----+-----+-----"
  puts "     |     |"
  puts "     |     |"
  puts "     |     |"
  puts "-----+-----+-----"
  puts "     |     |"
  puts "     |     |"
  puts "     |     |"
  puts ""
end

def display_board(board)
  puts ""
  puts "     |     |"
  puts "  " + board[:tl] + "  |  " + board[:tm] + "  |  " + board[:tr]
  puts "     |     |"
  puts "-----+-----+-----"
  puts "     |     |"
  puts "  " + board[:ml] + "  |  " + board[:mm] + "  |  " + board[:mr]
  puts "     |     |"
  puts "-----+-----+-----"
  puts "     |     |"
  puts "  " + board[:bl] + "  |  " + board[:bm] + "  |  " + board[:br]
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

def player_turn

end

puts "Welcome to Tic Tac Toe!"
puts "-----------------------"
initialize_board

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

board = {
  tl: ' ',
  tm: ' ',
  tr: ' ',
  ml: ' ',
  mm: ' ',
  mr: ' ',
  bl: ' ',
  bm: ' ',
  br: ' '
}

display_board(board)
