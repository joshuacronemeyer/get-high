require 'rubygems'
require "enumerator"
require 'physical_object'
include PhysicalObject

class Tile
  GRASS = 0
  EARTH = 1
  FINISH = 0
  COLLISION_TAG = :tile
  FINISH_TAG = :finish
  MASS = 1.0/0.0

  def initialize(window, space, x, y, type)
    @fixed = true
    @window = window
    @space = space
    @type = GRASS if type == 'G'
    @type = EARTH if type == 'E'
    @type = FINISH if type == 'F'
    collision = COLLISION_TAG unless type == 'F'
    collision = FINISH_TAG if type == 'F'
    @bounds = [CP::Vec2.new(30.5,30.5), CP::Vec2.new(30.5,-30.5), CP::Vec2.new(-30.5,-30.5), CP::Vec2.new(-30.5,30.5)]
    create_pyhsical_object(x, y, MASS, collision) if @type
    add_finish_collision_function
  end

  def add_finish_collision_function
    @space.add_collision_func(:balloon, :finish) do |balloon, finish|
      exit #TODO hook this to the level clear animation.
    end
  end

  def draw screen_x, screen_y, tileset
    if @type
      x_offset = -screen_x + (Game::X_RES/2.0)
      y_offset = -screen_y + (Game::Y_RES/2.0)
      tileset[@type].draw_rot(@shape.body.p.x + x_offset, @shape.body.p.y + y_offset, 0, @shape.body.a.radians_to_gosu)
      #draw_polygon(x_offset, y_offset)
    end
  end

  def elast
    0.8
  end

  def fric
    0.5
  end
end
