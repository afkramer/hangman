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
    display_introduction
    set_up_player
    continue_game = true
    while continue_game
      play_round
      continue_game = continue_game?
    end
  end

  def display_introduction
    @gui.display_introduction
  end

  def set_up_player
    @player.name = @gui.get_player_name
  end

  def play_round
    set_up_word
    @player.lives_left = %w[* * * * * *]
    while @player.lives_left.length.positive?
      @gui.display_game_state(correct_letters, lives_left)
      guess = @player.get_guess
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
      @correct_letters[index] = guess if letter == guess
      occurences += 1
    end
    if occurences.positive?
      @gui.display_correct_answer(guess, occurences)
    else
      @gui.display_wrong_answer(guess)
      @player.lives_left.pop
    end
  end

  def game_won?
    @correct_letters.none? { |element| element == '_' }
  end

  def end_game(lives_left)
    if lives_left.positive?
      @games_won += 1
      @gui.display_game_won(@player.name, lives_left, @letters_in_word.join(''))
    else
      @games_lost += 1
      @gui.display_game_lost(@player.name, @letters_in_word.join(''))
    end
    @gui.display_game_statistics(@player.name, @player.games_won, @player.games_lost)
  end

  def continue_game?
    response = @gui.get_continue_game.downcase
    response == 'y'
  end
end
