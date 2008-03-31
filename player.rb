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
    create_pyhsical_object(Game::X_RES/2.0, Game::Y_RES/2.0, MASS, COLLISION_TAG)
  end

  def x
    @shape.body.p.x
  end

  def y
    @shape.body.p.y
  end

  def turn_left
    @shape.body.t -= 9000.0
  end

  def turn_right
    @shape.body.t += 9000.0
  end

  def accelerate
    @shape.body.apply_force((@shape.body.a.radians_to_vec2 * (3000.0)), CP::Vec2.new(0.0, 0.0))
  end

  def draw()
    @shape.body.reset_forces
    @image.draw_rot(Game::X_RES/2.0, Game::Y_RES/2.0, 0, @shape.body.a.radians_to_gosu)
  end
end
