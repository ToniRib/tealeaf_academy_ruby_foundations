# mortgage_calculator.rb

require 'pry'

def prompt(message)
  puts "=> #{message}"
end

def valid_positive_float?(num)
  # returns true is number is a positive float and not empty
  !!(num =~ /^\d+\.?\d*$/) && !num.empty?
end

def valid_positive_int?(num)
  # returns true is number is a positive integer and not empty
  !!(num =~ /^\d+$/) && !num.empty?
end

loop do # main loop
  prompt "Welcome to the Morgage Calculator!"

  loan_amount = ''

  loop do
    prompt "What is the loan amount? (do not enter $ or ,)"
    loan_amount = gets.chomp
    if !valid_positive_float?(loan_amount)
      prompt "Please enter a positive number with no $ or commas"
    else
      break
    end
  end

  interest_rate = ''

  loop do
    prompt "What is the interest rate?"
    prompt "Please enter in the format 8 for 8% or 1.5 for 1.5%"
    interest_rate = gets.chomp
    if !valid_positive_float?(interest_rate)
      prompt "Please enter a positive number with no percent sign"
    else
      break
    end
  end

  years = ''

  loop do
    prompt "What is the loan duration (in years)?"
    years = gets.chomp
    if !valid_positive_int?(years)
      prompt "Please enter a positive integer"
    else
      break
    end
  end

  prompt "Calculating monthly payment..."

  annual_interest_rate = interest_rate.to_f / 100
  monthly_interest_rate = annual_interest_rate / 12
  months = years.to_i * 12

  monthly_payment = loan_amount.to_f *
                    (monthly_interest_rate * ((1 + monthly_interest_rate)**months)) /
                    (((1 + monthly_interest_rate)**months) - 1)

  prompt "Your monthly payment will be $#{format('%02.2f',monthly_payment)}"

  prompt "Would you like to calculate another mortgage payment?"
  answer = gets.chomp

  break unless answer.downcase.start_with?('y')
end

prompt "Thanks for using the Mortgage Calculator! See you next time!"
