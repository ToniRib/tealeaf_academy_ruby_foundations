# calculator.rb asks the user for two numbers and a type of mathematical
# operation to perform. The operation can be add, subtract, multiply, or
# divide. It will then display the result to the user.

# welcome the user to the program
puts "Welcome to Calculator!"

# ask the user for two numbers
puts "What's the first number?"
number1 = gets.chomp
puts "What's the second number?"
number2 = gets.chomp

# ask the user for an operation to perform
puts "What operation would you like to perform?"
puts "1) add 2) subtract 3) multiply 4) divide"
operator = gets.chomp

# perform the operation on the two numbers
if operator == '1'
  result = number1.to_i + number2.to_i
elsif operator == '2'
  result = number1.to_i - number2.to_i
elsif operator == '3'
  result = number1.to_i * number2.to_i
else
  result = number1.to_f / number2.to_f
end

# output the result
puts "The result is: #{result}"