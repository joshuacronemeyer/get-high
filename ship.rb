require 'numeric'
require 'physical_object'
require 'map_reader'
include PhysicalObject

class Ship
  MASS = 10.0
  COLLISION_TAG = :ship

  def initialize(window, space)
    @image = Image.new(window, "media/Starfighter.bmp", true)
    @window = window
    @space = space
    @bounds = [CP::Vec2.new(-25.0, -25.0), CP::Vec2.new(-25.0, 25.0), CP::Vec2.new(25.0, 1.0), CP::Vec2.new(25.0, -1.0)]
    start_position = determine_initial_position
    create_pyhsical_object(start_position.first, start_position.last, MASS, COLLISION_TAG)
  end

  def x
    @shape.body.p.x
  end

  def y
    @shape.body.p.y
  end

  def turn_left
    @shape.body.t -= 8000.0
  end

  def turn_right
    @shape.body.t += 8000.0
  end

  def accelerate
    @shape.body.apply_force((@shape.body.a.radians_to_vec2 * (3000.0)), zero_vector)
  end

  def draw()
    @shape.body.reset_forces
    @image.draw_rot(Game::X_RES/2.0, Game::Y_RES/2.0, 0, @shape.body.a.radians_to_gosu)
  end

  def determine_initial_position
    reader = MapReader.new("media/map.txt")
    map = reader.mapping_from_map_file do |char, x, y|
      if char.upcase == 'S'
        [x*60, y*60]
      else
        nil 
      end
    end
    
    map.each do |row|
      row.each do |element|
        return element if element
      end
    end
  end
end
