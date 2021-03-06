# frozen_string_literal: true

require 'json'
require './lib/gui'
require './lib/player'
require './lib/word_bank'

# Contains methods for the game to run
class Game
  attr_accessor :letters_in_word, :correct_letters, :player # remove after testing!

  def initialize
    @player = Player.new
    @word_bank = WordBank.new
    @gui = Gui.new
    @letters_in_word = []
    @correct_letters = []
  end

  def play_game
    display_introduction
    continue_game = true
    while continue_game
      if play_round == 'error'
        @gui.display_something_went_wrong
        break
      end
      continue_game = continue_game?
    end
    @gui.display_thanks_for_playing
  end

  def display_introduction
    @gui.display_introduction
  end

  def save_game
    dir = './saved_games'
    unless Dir.exist?(dir)
      Dir.mkdir(dir)
    end
    filepath = get_file_path_for_save(dir)
    data = "#{to_json}\t#{@player.to_json}"
    File.open(filepath, 'w') { |file| file.puts(data)}
    @gui.display_game_saved
  end

  def get_file_path_for_save(dir)
    file = @gui.get_save_file_name
    while File.exist?("#{dir}/#{file}")
      @gui.display_file_in_use
      file = @gui.get_save_file_name
    end
    "#{dir}/#{file}"
  end

  def load_game
    # Load a previous game
    dir = './saved_games'
    unless Dir.exist?(dir)
      @gui.display_folder_gone
      return 0
      # TODO: make sure the player can still play a round
    end
    filepath = get_file_path_for_load(dir)
    data = File.open(filepath, 'r').readline.split("\t")
    from_json(data[0])
    @player.from_json(data[1])
    @gui.display_game_loaded
  end

  def get_file_path_for_load(dir)
    file = @gui.get_load_file_name
    until File.exist?("#{dir}/#{file}")
      @gui.display_file_not_found
      file = @gui.get_load_file_name
      # user has to have the option to abort if the file doesn't exist
    end
    "#{dir}/#{file}"
  end

  def to_json
    JSON.dump({
                letters_in_word: @letters_in_word,
                correct_letters: @correct_letters
              })
  end

  def from_json(string)
    data = JSON.parse(string)
    @letters_in_word = data['letters_in_word']
    @correct_letters = data['correct_letters']
  end

  def set_up_player
    @player.name = @gui.get_player_name
  end

  def play_round
    if @gui.get_load_game.downcase == 'y'
      load_game
    else
      set_up_player if @player.name == ''
      @player.lives_left = %w[* * * * * *]
      reset_words
      return 'error' if set_up_word == 'error'
    end

    while @player.lives_left.length.positive?
      @gui.display_game_state(@correct_letters, @player.incorrect_guesses, @player.lives_left)
      guess = @player.get_guess
      break if process_guess(guess) == 'save'
      break if game_won?
    end
    end_game
  end

  def reset_words
    @letters_in_word = []
    @correct_letters = []
    @player.reset_guesses
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
    if guess == 'save'
      save_game
      'save'
    elsif guess == @letters_in_word.join('')
      @correct_letters = guess.split('')
    else
      show_right_or_wrong(guess, 0)
    end
  end

  def show_right_or_wrong(guess, occurences)
    if occurences.positive?
      @gui.display_correct_answer(guess, occurences)
      @player.correct_guesses << guess
    else
      @gui.display_wrong_answer(guess)
      @player.lives_left.pop
      @player.incorrect_guesses << guess
    end
  end

  def game_won?
    @correct_letters.none? { |element| element == '_' }
  end

  def end_game
    return if @player.lives_left.length.positive? && @correct_letters.include?('_')

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


# game = Game.new
# game.player.name = 'Norma'
# game.player.incorrect_guesses = %w[a b c d]
# game.player.correct_guesses = %w[e f g h]
# game.player.lives_left = %w[* * * *]
# game.player.games_won = 3
# game.player.games_lost = 5
# game.letters_in_word = %w[c a r r o t]
# game.correct_letters = %w[c a _ _ _ _]
# game.save_game

# game2 = Game.new
# game2.load_game
# p game2.letters_in_word
# p game2.correct_letters
# puts game2.player.name
# p game2.player.incorrect_guesses
# p game2.player.correct_guesses
# p game2.player.lives_left
# puts game2.player.games_won
# puts game2.player.games_lost
