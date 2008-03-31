require 'rubygems'
require "enumerator"
require 'physical_object'
include PhysicalObject

class Tile
  GRASS = 0
  EARTH = 1
  COLLISION_TAG = :tile
  MASS = 1.0/0.0

  def initialize(window, space, x, y, type)
    @window = window
    @space = space
    @type = GRASS if type == 'G'
    @type = EARTH if type == 'E'
    @bounds = [CP::Vec2.new(30,30), CP::Vec2.new(30,-30), CP::Vec2.new(-30,-30), CP::Vec2.new(-30,30)]
    create_pyhsical_object(x, y, MASS, COLLISION_TAG) if @type
  end

  def draw screen_x, screen_y, tileset
    if @type
      x_offset = -screen_x + (Game::X_RES/2.0)
      y_offset = -screen_y + (Game::Y_RES/2.0)
      tileset[@type].draw_rot(@shape.body.p.x + x_offset, @shape.body.p.y + y_offset, 0, @shape.body.a.radians_to_gosu)
      #draw_polygon(x_offset, y_offset)
    end
  end
end
