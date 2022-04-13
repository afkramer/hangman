# frozen_string_literal: true

# Contains the code for a command line
class Gui
  def display_introduction
    puts
    puts 'Welcome to Hangman!'
    puts
    puts 'You know how this game works, just remember back to your childhood!'
    puts 'Instead of displaying a hanged man, we will work with lives left.'
    puts "It's less gruesome."
    puts
    puts 'You have six tries to guess the word!'
    puts 'In this version, proper names and places are also allowed!'
  end

  def get_player_name
    puts
    puts
    print 'Please enter your name: '
    gets.chomp
  end

  def display_game_state(correct_letters, guesses, lives_left)
    words = []
    letters = []
    guesses.each { |guess| guess.length == 1 ? letters << guess : words << guess }
    puts
    puts
    puts "Lives left: #{lives_left.join(' ')}"
    puts
    puts "Letters guessed: #{letters.join(', ') if letters.length >= 1}"
    puts
    puts "Words guessed: #{words.join(', ') if letters.length >= 1}"
    puts
    puts "Word to guess: #{correct_letters.join(' ')}"
  end

  def get_guess(name)
    puts
    puts
    print "#{name}, please pick a letter to guess: "
    gets.chomp
  end

  def display_correct_answer(guess, number_found)
    len = guess.length
    display_extra_space
    print "Yes! There #{len == 1 ? 'was' : 'were' }"
    puts " #{number_found} occurence#{'s' if len > 1} of #{guess}!"
  end

  def display_extra_space
    puts
    puts
    puts
    puts
    puts
    puts
    puts
    puts
    puts
    puts
  end

  def display_wrong_answer(guess)
    display_extra_space
    if guess.length == 1
      puts "Sorry, there are no occurences of #{guess}."
    else
      puts "Sorry, the word is not #{guess}"
    end
    puts 'You lose one life.'
  end

  def display_already_guessed(guess)
    puts
    puts
    puts "You already guessed #{guess}"
  end

  def invalid_input
    puts
    puts
    puts "Sorry, that's invalid input."
  end

  def display_game_won(name, lives_left, word_to_guess)
    puts
    puts
    puts "Congratulations, #{name}! You figured out the word: #{word_to_guess}"
    puts "You won with #{lives_left} lives left."
  end

  def display_game_lost(name, word_to_guess)
    puts
    puts
    puts "Sorry, #{name}, you lost. The word was: #{word_to_guess}"
  end

  def display_game_statistics(name, games_won, games_lost)
    puts
    puts
    puts "#{name}, here are your statistics."
    puts "Games won: #{games_won}"
    puts "Games lost: #{games_lost}"
  end

  def get_continue_game
    puts
    puts
    puts 'Would you like to play again?'
    print 'Enter y to continue, any other key to stop: '
    gets.chomp
  end

  def display_thanks_for_playing
    puts
    puts
    puts 'Thanks for playing!'
  end

  def display_something_went_wrong
    puts
    puts
    puts 'Sorry, something went wrong. Try again soon!'
  end
end
