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
  end
end
