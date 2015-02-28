require './point'

class Car
  DIRECTIONS = %w{N NE SE S SW NW}
  attr_reader :coords, :speed, :direction

  def initialize(direction='N', x=0, y=0, speed=0)
    @coords = Point.new(x, y)
    @speed, @direction = speed, direction
  end

  def faster
    @speed += 1
    move
  end

  def slower
    return unless moving?
    @speed -= 1
    move
  end

  # L : turn left, not allowed if speed is 0; [N, NE, SE, S, SW, NW] -> [NW, N, NE, SE, S, SW]
  def left
    return unless moving?
    @direction = DIRECTIONS[DIRECTIONS.index(direction)-1]
    move
  end

  # R : turn right, not allowed if speed is 0; [N, NE, SE, S, SW, NW] -> [NE, SE, S, SW, NW, N]
  def right
    return unless moving?
    @direction = DIRECTIONS[DIRECTIONS.index(direction)+1]
    move
  end

  def possible_actions
    ary = [:faster]
    ary += [:slower, :left, :right] if moving?
    ary
  end

  # def possible_next_steps

  # end

  def moving?
    speed > 0
  end

  def move
    
  end
end