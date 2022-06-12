# frozen_string_literal: true

# messages displayed on console
module Displayable
  def player_move_prompt(player_number)
    puts "Player #{player_number}, please select a column:"
    gets.chomp
  end

  def invalid_move_message
    puts 'Invalid move.'
  end
end
