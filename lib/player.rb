# frozen_string_literal: true

require 'json'
require './lib/gui'  # remove after testing (BUT how did this work before???)

# Player class contains methods for the human player
class Player
  attr_accessor :name, :correct_guesses, :incorrect_guesses,
                :lives_left, :games_won, :games_lost

  def initialize
    @name = ''
    @incorrect_guesses = []
    @correct_guesses = []
    @gui = Gui.new
    @lives_left = []
    @games_won = 0
    @games_lost = 0
  end

  def save_player
    # write to a file
  end

  def load_player
    # retrieve the player from the file
  end

  def to_json
    JSON.dump({
                name: @name,
                incorrect_guesses: @incorrect_guesses,
                correct_guesses: @correct_guesses,
                lives_left: @lives_left,
                games_won: @games_won,
                games_lost: @games_lost
              })
  end

  def from_json(string)
    data = JSON.parse(string)
    @name = data['name']
    @incorrect_guesses = data['incorrect_guesses']
    @correct_guesses = data['correct_guesses']
    @lives_left = data['lives_left']
    @games_won = data['games_won']
    @games_lost = data['games_lost']
  end

  def reset_guesses
    @incorrect_guesses = []
    @correct_guesses = []
  end

  def get_guess
    guess = @gui.get_guess(@name).downcase
    if @incorrect_guesses.include?(guess) || @correct_guesses.include?(guess)
      @gui.display_already_guessed(guess)
      get_guess
    elsif /[a-z]/.match?(guess)
      guess
    else
      @gui.invalid_input
      get_guess
    end
  end
end
