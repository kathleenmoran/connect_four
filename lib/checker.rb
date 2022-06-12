# frozen_string_literal: true

require_relative 'constants'

# the board of a game of connect four
class Checker
  attr_reader :color, :x, :y

  def initialize(color, x_coord, y_coord)
    @color = color
    @x = x_coord
    @y = y_coord
  end

  def ==(other)
    @color == other.color && @x == other.x && @y == other.y
  end

  def to_str
    return ' 🔴 ' if @color == :red
    return ' 🟡 ' if @color == :yellow
  end
end
