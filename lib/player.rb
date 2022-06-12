# frozen_string_literal: true

require_relative 'constants'
require_relative 'displayable'

# a player of a game
class Player
  include Displayable
  def initialize(color, number)
    @color = color
    @number = number
  end

  def make_move
    player_input = player_move_prompt(@number)
    if string_is_int?(player_input)
      player_input.to_i
    else
      make_move
    end
  end

  private

  def string_is_int?(player_input)
    player_input.to_i.to_s == player_input
  end
end
