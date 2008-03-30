require 'rubygems'
require 'gosu'
require 'chipmunk'
include Gosu

class Tile
  GRASS = 0
  EARTH = 1

  def initialize(window, x, y, type)
    # 60x60 tiles
    @x, @y = x, y
    @type = GRASS if type == 'G'
    @type = EARTH if type == 'E'
  end
  
  def draw screen_x, screen_y, tileset
    tileset[@type].draw(@x, @y, 0) unless @type.nil?
  end
end
