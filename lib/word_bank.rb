# frozen_string_literal: true

class WordBank
  def initialize
    @possible_words = load_possible_words
  end

  def load_possible_words
    dict_location = 'google-10000-english-no-swears.txt'
    if File.exist?(dict_location)
      contents = []
      File.open(dict_location, 'r') do |file|
        until file.eof?
          contents << file.readline.chomp
        end
      end
      @possible_words = contents.select { |word| word.length >= 5 && word.length <= 12 }
    else
      'Error loading words'
    end
  end
