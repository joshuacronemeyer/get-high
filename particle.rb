require 'physical_object'
include PhysicalObject

class Particle
  MASS = 1.0
  COLLISION_TAG = :particle
  SIZE = 6

  def initialize(window, space, x, y)
    @window = window
    @space = space
    @bounds = [CP::Vec2.new(SIZE/2,SIZE/2), CP::Vec2.new(SIZE/2,-SIZE/2), CP::Vec2.new(-SIZE/2,-SIZE/2), CP::Vec2.new(-SIZE/2,SIZE/2)]
    create_pyhsical_object(x, y, MASS, COLLISION_TAG)
  end

  def draw(screen_x, screen_y, image)
    @shape.body.reset_forces
    x_offset = -screen_x + (Game::X_RES/2.0)
    y_offset = -screen_y + (Game::Y_RES/2.0)
    image.draw_rot(@shape.body.p.x + x_offset, @shape.body.p.y + y_offset, 0, @shape.body.a.radians_to_gosu)
    #draw_polygon(x_offset, y_offset)
  end

  def launch(vector)
    @shape.body.apply_force(vector, zero_vector)
  end

  def destroy
    @space.remove_body(@shape.body)
    @space.remove_shape(@shape)
  end

  def non_interactive!
    @shape.group=1
  end

  def elast
    0.5
  end

  def fric
    0.3
  end
end
