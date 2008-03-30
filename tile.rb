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
    #draw_polygon if @type 
    tileset[@type].draw_rot(@shape.body.p.x, @shape.body.p.y, 0, @shape.body.a.radians_to_gosu) unless @type.nil?
  end
end
