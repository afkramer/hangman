# frozen_string_literal: true

# WordBank initializes a dictionary of possible words
# Random words are provided for the game
class WordBank
  def initialize
    @possible_words = load_possible_words
  end

  def load_possible_words
    dict_location = 'google-10000-english-no-swears.txt'
    if File.exist?(dict_location)
      contents = []
      File.open(dict_location, 'r') do |file|
        contents << file.readline.chomp until file.eof?
      end
      @possible_words = contents.select { |word| word.length >= 5 && word.length <= 12 }
    else
      'No word bank available'
    end
  end

  def choose_random_word
    @possible_words.sample
  end
end
