# calculator.rb asks the user for two numbers and a type of mathematical
# operation to perform. The operation can be add, subtract, multiply, or
# divide. It will then display the result to the user.

require 'yaml'
MESSAGES = YAML.load_file('calculator_messages.yml')

def prompt(message)
  puts "=> #{message}"
end

def number?(num)
  # matches any negative or positive number and can be an integer or float
  /^-?\d+\.?\d*$/.match(num)
end

def operation_to_message(op)
  case op
  when '1'
    'Adding'
  when '2'
    'Subtracting'
  when '3'
    'Multiplying'
  when '4'
    'Dividing'
  end
end

prompt MESSAGES['welcome']

name = ''

loop do
  name = gets.chomp
  if name.empty?
    prompt MESSAGES['valid_name']
  else
    break
  end
end

prompt "Hi #{name}!"

loop do # main loop
  number1 = ''

  loop do
    prompt MESSAGES['first_number']
    number1 = gets.chomp
    if number?(number1)
      break
    else
      prompt MESSAGES['invalid_number']
    end
  end

  number2 = ''

  loop do
    prompt MESSAGES['second_number']
    number2 = gets.chomp
    if number?(number2)
      break
    else
      prompt MESSAGES['invalid_number']
    end
  end

  operator_prompt = <<-MSG
    What operation would you like to perform?
    1) add
    2) subtract
    3) multiply
    4) divide
  MSG
  prompt operator_prompt

  operator = ''

  loop do
    operator = gets.chomp

    if %w(1 2 3 4).include?(operator)
      break
    else
      prompt MESSAGES['valid_operator']
    end
  end

  prompt "#{operation_to_message(operator)} the two numbers..."

  result =  case operator
            when '1'
              number1.to_i + number2.to_i
            when '2'
              number1.to_i - number2.to_i
            when '3'
              number1.to_i * number2.to_i
            when '4'
              number1.to_f / number2.to_f
            end

  prompt "The result is: #{result}"

  prompt MESSAGES['additional_calculation']
  answer = gets.chomp
  break unless answer.downcase.start_with?('y')
end

prompt MESSAGES['goodbye']
