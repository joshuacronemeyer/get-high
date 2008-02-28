require 'rubygems'
require 'gosu'
require 'rope'

class Kite
  RATE_OF_TURN = 6.5 
  attr_reader :angle, :string
  def initialize(window, tether_x, tether_y)
    @angle = 0.0
    @string = Rope.new(window, 100, tether_x, tether_y)
    @image = Gosu::Image.new(window, 'kite.png', false)
  end

  def left
    @angle -= RATE_OF_TURN
  end

  def right
    @angle += RATE_OF_TURN
  end
  
  def longer
    @string.longer
  end

  def shorter
    @string.shorter
  end

  def draw
    @image.draw_rot(@string.endX, @string.endY , 0, @angle)
    @string.draw
  end
  
  def move
    @string.move(@angle)
  end
end
