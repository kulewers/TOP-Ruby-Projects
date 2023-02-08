module Mastermind
  class Game
    def initialize
      @hidden_code = Array.new(4)
      @attempts = 1
    end
    attr_accessor :hidden_code, :attempts

    def play
      puts 'Welcome to the Mastermind game!'
      generate_code(hidden_code)
      until attempts > 12
        print "\n"
        puts "Attempt ##{attempts}"
        guess = ask_for_guess
        if hidden_code == guess
          puts 'You win!'
          return
        end
        display_hints(hidden_code, guess)
      end
      puts 'You lose!'
      puts "Code was: #{hidden_code.join}"
    end

    def generate_code(array)
      array.map! { |_| Random.rand(1..6) }
    end

    def ask_for_guess
      @attempts += 1
      puts 'Make your guess:'
      guess = []
      loop do
        guess = gets.chomp.split('').map(&:to_i)
        unless guess.length == 4
          guess = []
        end
        if guess.length == 4 && guess.all? { |digit| digit.between?(1, 6)}
          break
        end
      end
      guess
    end

    def display_hints(code, guess)
      correct_pos = code.map.with_index { |digit, idx| guess[idx] == digit}
      hints = 'Hints: '
      correct_pos.each do |bool|
        if bool == true
          hints += '● '
        end
      end
      guess.select.with_index { |_, idx| !correct_pos[idx] }.each do |val|
        if code.select.with_index { |_, idx| !correct_pos[idx] }.include?(val)
          hints += '○ '
        end
      end
      puts hints
    end
  end
end

include Mastermind
Game.new.play

# generate code
# ask user for input
# check with #each_with_index whether the user input is correct
# output hints

# have an array of numbers in code
# have an array of numbers in a guess
# if code = [1,2,3,4] and guess = [5,4,3,2], desired output is ● ○ ○

# using map method
# code.map.with_index { |digit, idx| guess[idx] == digit }
# the output for [1,2,3,4] and [5,4,3,2] should be [flase, false, true, false]
# save the output in correct_pos array
# for each true add the white circle to output

# [3,4,3,4] with [4,3,4,3] desired output ○ ○ ○ ○
# code.select.with_index { |_, idx| !correct_pos[idx] }.each do |val|
#   if guess.select.with_index { |_, idx| !correct_pos[idx] }.include?(val)
#     output += '○ '
