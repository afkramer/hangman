# frozen_string_literal: true

require './lib/gui'
require './lib/player'
require './lib/word_bank'

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
      if play_round == 'error'
        @gui.display_something_went_wrong
        break
      end
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
    if set_up_word == 'error'
      return 'error'
    end

    @player.lives_left = %w[* * * * * *]
    while @player.lives_left.length.positive?
      @gui.display_game_state(@correct_letters, @player.lives_left)
      guess = @player.get_guess
      process_guess(guess)
      break if game_won?
    end
    end_game
  end

  def set_up_word
    if @word_bank.possible_words.is_a?(Array)
      @letters_in_word = @word_bank.choose_random_word.split('')
      @letters_in_word.each { @correct_letters << '_' }
    else
      'error'
    end
  end

  def process_guess(guess)
    guess_type(guess) == 'word' ? process_word(guess) : process_letter(guess)
  end

  def guess_type(guess)
    guess.length > 1 ? 'word' : 'letter'
  end

  def process_letter(guess)
    occurences = 0
    @letters_in_word.each_with_index do |letter, index|
      if letter == guess
        @correct_letters[index] = guess
        occurences += 1
      end
    end
    show_right_or_wrong(guess, occurences)
  end

  def process_word(guess)
    # If the guess is correct then the game won message should be shown
    puts "guess: #{guess}  @letters_in_word: #{@letters_in_word.join('')}"
    if guess == @letters_in_word.join('')
      @correct_letters = guess.split('')
    else
      show_right_or_wrong(guess, 0)
    end
  end

  def show_right_or_wrong(guess, occurences)
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

  def end_game
    if @player.lives_left.length.positive?
      @player.games_won += 1
      @gui.display_game_won(@player.name, @player.lives_left.length, @letters_in_word.join(''))
    else
      @player.games_lost += 1
      @gui.display_game_lost(@player.name, @letters_in_word.join(''))
    end
    @gui.display_game_statistics(@player.name, @player.games_won, @player.games_lost)
  end

  def continue_game?
    response = @gui.get_continue_game.downcase
    response == 'y'
  end
end
