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

def display_results(player, computer)
  if win?(player, computer)
    prompt "You won!"
  elsif win?(computer, player)
    prompt "You lose!"
  else
    prompt "It's a tie!"
  end
end

loop do # main loop
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

  display_results(choice, computer_choice)

  prompt "Do you want to play again?"
  answer = gets.chomp
  break unless answer.downcase.start_with?('y')
end

prompt "Thank you for playing. Good bye!"
