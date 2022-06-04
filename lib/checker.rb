class Checker
  attr_reader :color, :x, :y

  def initialize(color, pos_x, pos_y)
    @color = color
    @x = pos_x
    @y = pos_y
  end
end