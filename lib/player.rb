# frozen_string_literal: true

# Player class contains methods for the human player

class Player
  attr_accessor :name, :lives_left

  def initialize
    @name = ''
    @guesses = []
    @gui = Gui.new
    @lives_left = 0
  end

  def get_guess
    guess = gui.get_guess.downcase
    if /[a-z]/.match?(guess) && guess.length == 1 && !@guesses.include?(guess)
      @guesses << guess
      guess
    else
      gui.invalid_input
      get_guess
    end
  end
end
