# frozen_string_literal: true

# Contains the code for a command line
class Gui
  def get_player_name
    puts
    print 'Please enter your name: '
    gets.chomp
  end
  
  def get_guess(name)
    puts
    print "#{name}, please pick a letter to guess: "
    gets.chomp
  end

  def invalid_input
    puts
    puts "Sorry, that's invalid input."
  end
end
