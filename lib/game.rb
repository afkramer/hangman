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
    @letters_in_word = []
    @correct_letters = []
  end

  def play_game
    set_up_player
    continue_game = true
    while continue_game
      play_round
      continue_game = continue_game?
    end
  end

  def set_up_player
    @player.name = gui.get_player_name
  end

  def play_round
    set_up_word
    @player.lives_left = %w[* * * * * *]
    while @player.lives_left.length.positive?
      # Gui: display lives left and word to guess
      guess = player.get_guess
      process_guess(guess)
      break if game_won?
    end
    end_game(@player.lives_left.length)
  end

  def set_up_word
    @letters_in_word = @word_bank.choose_random_word.split('')
    @letters_in_word.each { @correct_letters << '_' }
  end

  def process_guess(guess)
    occurences = 0
    @letters_in_word.each_with_index do |letter, index|
      @correct_letters[index] = letter if letter == guess
      occurences += 1
    end
    if occurences > 0
      @gui.display_correct_answer(guess, occurences)
    else
      @gui.display_wrong_answer(guess)
      @player.lives_left.pop
    end
  end

  def game_won?
    # Check if there are no more nils left in @correct_letters
  end

  def end_game(lives_left)
    if lives_left.positive?
      @gui.display_game_won(@player.name, lives_left, @letters_in_word.join(''))
    else
      @gui.display_game_lost(@player.name, @letters_in_word.join(''))
    end
  end

  def continue_game?
    # Call gui method if the game should continue
    # return true if user wants to continue, false if not
  end
end
