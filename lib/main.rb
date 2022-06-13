require_relative 'game'

def play_game
  Game.new.play_game
  ask_to_play_again
end

def quit_game
  puts "\nThanks for playing!"
  exit
end

def ask_to_play_again
  puts "\nWould you like to play again? (Y/N)"
  user_input = gets.chomp.downcase
  if %w[y yes].include?(user_input)
    play_game
  elsif %w[n no].include?(user_input)
    quit_game
  else
    puts "That's an invalid response."
    ask_to_play_again
  end
end

play_game