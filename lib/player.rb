# frozen_string_literal: true

# Player class contains methods for the human player
class Player
  attr_accessor :name, :lives_left, :games_won, :games_lost

  def initialize
    @name = ''
    @guesses = []
    @gui = Gui.new
    @lives_left = []
    @games_won = 0
    @games_lost = 0
  end

  def get_guess
    guess = @gui.get_guess(@name).downcase
    if @guesses.include?(guess)
      @gui.display_already_guessed(guess)
      get_guess
    elsif /[a-z]/.match?(guess) && guess.length == 1
      @guesses << guess
      guess
    else
      @gui.invalid_input
      get_guess
    end
  end
end
