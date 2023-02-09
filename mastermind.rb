module Mastermind
  class Game
    def initialize
      @mode = nil
      @hidden_code = Array.new(4, 0)
    end
    attr_accessor :mode, :hidden_code

    def play
      puts 'Welcome to the Mastermind game!'
      puts "Select game mode: '1' for Maker, '2' for Breaker"
      mode = mode_select
      case mode
      when 1
        play_maker
      when 2
        play_breaker
      end
    end

    def play_maker
      attempt_count = 1
      puts "Create a code:"
      hidden_code = ask_for_code
      possible_solutions = []
      (1..6).each do |a|
        (1..6).each do |b|
          (1..6).each do |c|
            (1..6).each do |d|
              possible_solutions += [[a, b, c, d]]
            end
          end
        end
      end
      until attempt_count > 12
        print "\n"
        puts "Computer Attempt ##{attempt_count}"

        computer_guess = if attempt_count == 1
                           [1, 1, 2, 2]
                         else
                           possible_solutions[0]
                         end
        puts computer_guess.join
        similarity = code_similarity(hidden_code, computer_guess)
        if similarity[0] == 4
          puts "The code was solved in #{attempt_count} attempts"
          return
        end
        possible_solutions = eliminate_unfit(possible_solutions, computer_guess, hidden_code)
        display_hints(similarity)
        attempt_count += 1
      end
    end

    def play_breaker
      attempt_count = 1
      generate_code(hidden_code)
      loop do
        print "\n"
        puts "Attempt ##{attempt_count}"
        puts 'Make your guess:'
        guess = ask_for_code
        if hidden_code == guess
          puts 'You win!'
          return
        end
        attempt_count += 1
        if attempt_count > 12
          puts "You lose!\nThe code was: #{hidden_code.join}"
          return
        end
        similarity = code_similarity(hidden_code, guess)
        display_hints(similarity)
      end
    end

    def mode_select
      mode = nil
      loop do
        mode = gets.to_i
        if mode.between?(1, 2) then break end
      end
      mode
    end

    def generate_code(array)
      array.map! { |_| Random.rand(1..6) }
    end

    def ask_for_code
      code = []
      loop do
        code = gets.chomp.split('').map(&:to_i)
        code = Array.new(4, 0) unless code.length == 4
        if code.all? { |digit| digit.between?(1, 6)} then break end
      end
      code
    end

    def code_similarity(code1, code2)
      similarity = [0, 0]
      correct_pos = code1.map.with_index { |digit, idx| code2[idx] == digit }
      correct_pos.each { |bool| if bool then similarity[0] += 1 end }
      reduced_code1 = code1.select.with_index { |_, idx| !correct_pos[idx] }
      reduced_code2 = code2.select.with_index { |_, idx| !correct_pos[idx] }
      result = {}
      reduced_code1.tally.merge(reduced_code2.tally) { |k, v1, v2| result[k] = [v1, v2].min }
      result.flat_map { |k, v| [k] * v }.each { |_| similarity[1] += 1 }
      similarity
    end

    def display_hints(array)
      hints = 'Hints: '
      array.each_with_index do |hint_amount, idx|
        (1..hint_amount).each do |_|
          hints += if idx.zero?
                     '● '
                   else
                     '○ '
                   end
        end
      end
      puts hints
    end

    def eliminate_unfit(candidates, computer_guess, hidden_code)
      candidates.select do |candidate|
        code_similarity(computer_guess, hidden_code) == code_similarity(computer_guess, candidate)
      end
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

# make a function for checking similarity of 2 codes

# do hash of amount of all numbers and select the min value