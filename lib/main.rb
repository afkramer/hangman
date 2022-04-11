# frozen_string_literal: true

require './lib/game'

def main
  game = Game.new
  game.play_game
end

main
