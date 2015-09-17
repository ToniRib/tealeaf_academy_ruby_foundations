# rock_paper_scissors.rb

VALID_CHOICES = %w(rock paper scissors spock lizard)
WINNING_CHOICES = {
  'rock' => %w(lizard scissors),
  'paper' => %w(rock spock),
  'scissors' => %w(lizard paper),
  'spock' => %w(scissors rock),
  'lizard' => %w(spock paper)
}

def prompt(message)
  puts "=> #{message}"
end

def win?(first, second)
  WINNING_CHOICES[first].include?(second)
end

def which_choice?(word)
  case word
  when /^ro?c?k?$/
    'rock'
  when /^pa?p?e?r?$/
    'paper'
  when /^li?z?a?r?d?$/
    'lizard'
  when /^sci?s?s?o?r?s?$/
    'scissors'
  when /^spo?c?k?$/
    'spock'
  end
end

def display_results(winner)
  case winner
  when 'player'
    prompt "You won!"
  when 'computer'
    prompt "You lose!"
  when 'tie'
    prompt "It's a tie!"
  end
end

def determine_winner(player, computer)
  if win?(player, computer)
    winner = 'player'
  elsif win?(computer, player)
    winner = 'computer'
  else
    winner = 'tie'
  end
end

loop do # main loop

  player_score = 0
  computer_score = 0

  loop do # inner loop for scoring
    choice = ''

    loop do
      loop do
        prompt "Choose one: #{VALID_CHOICES.join(', ')}"
        choice = gets.chomp

        if choice.start_with?('s') && choice.length == 1
          prompt "If choosing scissors or spock, please type at least 2 letters"
        else
          break
        end
      end

      choice = which_choice?(choice)

      if VALID_CHOICES.include?(choice)
        break
      else
        prompt("That's not a valid choice.")
      end
    end

    computer_choice = VALID_CHOICES.sample

    puts "You chose: #{choice}; Computer chose: #{computer_choice}"

    winner = determine_winner(choice, computer_choice)

    display_results(winner)

    if winner == 'player'
      player_score += 1
    elsif winner == 'computer'
      computer_score += 1
    end

    puts "Player Score: #{player_score}, Computer Score: #{computer_score}"

    if player_score == 5
      prompt "You've won the game! Congratulations!"
      break
    elsif computer_score == 5
      prompt "Sorry, but the computer won this round."
      break
    end

  end

  prompt "Do you want to play again?"
  answer = gets.chomp
  break unless answer.downcase.start_with?('y')
end

prompt "Thank you for playing. Good bye!"
