require 'numeric'
require 'physical_object'
include PhysicalObject

class Player
  MASS = 10.0
  COLLISION_TAG = :ship
  
  def initialize(window, space)
    @image = Image.new(window, "media/Starfighter.bmp", true)
    @window = window
    @space = space
    @bounds = [CP::Vec2.new(-25.0, -25.0), CP::Vec2.new(-25.0, 25.0), CP::Vec2.new(25.0, 1.0), CP::Vec2.new(25.0, -1.0)]
    create_pyhsical_object(150, 150, MASS, COLLISION_TAG)
  end
  
  def turn_left
    @shape.body.t -= 10000.0
  end

  def turn_right
    @shape.body.t += 10000.0
  end

  def accelerate
    @shape.body.apply_force((@shape.body.a.radians_to_vec2 * (3000.0)), CP::Vec2.new(0.0, 0.0))
  end

  def draw()
    @shape.body.reset_forces
    #draw_polygon
    @image.draw_rot(@shape.body.p.x, @shape.body.p.y, 0, @shape.body.a.radians_to_gosu)
  end
end
