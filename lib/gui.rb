# frozen_string_literal: true

# Contains the code for a command line
class Gui
  def display_introduction
    # Print an overview of how the game works
  end

  def get_player_name
    puts
    print 'Please enter your name: '
    gets.chomp
  end

  def display_game_state(correct_letters, lives_left)
    puts
    puts "Lives left: #{lives_left.join(' ')}"
    puts
    puts "Word to guess: #{correct_letters.join(' ')}"
  end

  def get_guess(name)
    puts
    print "#{name}, please pick a letter to guess: "
    gets.chomp
  end

  def display_correct_answer(guess, number_found)
    puts
    puts "Yes! There where #{number_found} occurences of #{guess}!"
  end

  def display_wrong_answer(guess)
    puts
    puts "Sorry, there are no occurences of #{guess}."
  end

  def invalid_input
    puts
    puts "Sorry, that's invalid input."
  end

  def display_game_won(name, lives_left, word_to_guess)
    puts
    puts "Congratulations, #{name}! You figured out the word: #{word_to_guess}"
    puts "You won with #{lives_left} lives left."
  end

  def display_game_lost(name, word_to_guess)
    puts
    puts "Sorry, #{name}, you lost. The word was: #{word_to_guess}"
  end
end
