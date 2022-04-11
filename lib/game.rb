# frozen_string_literal: true

require './gui'
require './player'
require './word_bank'

# Contains methods for the game to run
class Game
  def initialize
    @player = Player.new
    @word_bank = WordBank.new
    @gui = Gui.new
    @lives_left = 6
    @letters_in_word = []
    @correct_letters = []
  end

  def play_game
    set_up_player
    continue_game = true
    while continue_game
      # play a round
      continue_game = continue_game?
    end
  end
  
  def set_up_player
    # Call gui method to get the player name
  end

  def play_round
    set_up_word
    while @lives_left > 0
      # Gui: display lives left and word to guess
      # get guess from user
      # check if the guess is in the word to guess
    end
  end

  def set_up_word
    # get a new word to guess from the gui and save to @letters_in_word
    # update correct_letters with nil for each letter in the word
  end

  def process_guess(letter)
    # check if the letter is in @letters_in_word
      # If yes, add the letters in the appropriate spots to @correct_letters
      # Use the GUI to tell the user their guess was successful
    # if no
      # use the GUI to tell the user they were unsuccessful
      # take one life off
  end

  def continue_game?
    # Call gui method if the game should continue
    # return true if user wants to continue, false if not
  end

end
