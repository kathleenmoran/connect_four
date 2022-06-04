# frozen_string_literal: true

require_relative 'constants'

# the board of a game of connect four
class Board
  def initialize(values = Array.new(Constants::HEIGHT) { Array.new(Constants::WIDTH) })
    @values = values
  end

  def win?(last_checker)
    horizontal_win?(last_checker) || vertical_win?(last_checker) || diagonal_win?(last_checker)
  end

  def place_checker(y_coord, color)
    checker = nil
    @values.transpose[y_coord].each_with_index do |value, x_coord|
      unless value.nil?
        checker = Checker.new(color, x_coord - 1, y_coord)
        @values[x_coord - 1][y_coord] = checker
        break
      end
      @values[x_coord][y_coord] = Checker.new(color, x_coord, y_coord) if x_coord == Constants::HEIGHT - 1
    end
    checker
  end

  private

  def horizontal_win?(last_checker)
    winning_array?(@values[last_checker.x], last_checker)
  end

  def vertical_win?(last_checker)
    winning_array?(@values.transpose[last_checker.y], last_checker)
  end

  def diagonal_win?(last_checker)
    winning_array?(left_diagonal(last_checker.x, last_checker.y), last_checker) ||
      winning_array?(right_diagonal(last_checker.x, last_checker.y), last_checker)
  end

  def left_diagonal(x_coord, y_coord)
    min_coord = [x_coord, y_coord].min
    diagonal = []
    (Constants::HEIGHT - 1).times do |i|
      new_x = x_coord - min_coord + i
      new_y = y_coord - min_coord + i
      break unless in_bounds?(new_x, new_y)

      diagonal << @values[new_x][new_y]
    end
    diagonal
  end

  def right_diagonal(x_coord, y_coord)
    diagonal = []
    (Constants::HEIGHT - 1).times do |new_x|
      new_y = x_coord + y_coord - new_x
      diagonal << @values[new_x][new_y] if in_bounds?(x_coord, y_coord)
    end
    diagonal
  end

  def in_bounds?(x_coord, y_coord)
    x_coord.between?(0, Constants::HEIGHT - 1) && y_coord.between?(0, Constants::WIDTH - 1)
  end

  def winning_array?(array, last_checker)
    in_a_row = 0
    array.each do |checker|
      if checker&.color == last_checker.color
        in_a_row += 1
      else
        in_a_row = 0
      end
      return true if in_a_row == Constants::WINNING_CONDITION
    end
    false
  end
end
