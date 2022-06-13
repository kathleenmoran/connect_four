# frozen_string_literal: true

# messages displayed on console
module Displayable
  def player_move_prompt(player_number)
    puts "\nPlayer #{player_number}, please select a column:"
    gets.chomp
  end

  def invalid_move_message
    puts 'Invalid move.'
  end

  def win_game_message(player_number)
    puts "\nPlayer #{player_number} won!"
  end

  def tie_game_message
    puts "\nIt's a tie!"
  end
end
