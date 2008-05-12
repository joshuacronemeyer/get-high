require 'numeric'
require 'physical_object'
require 'map_reader'
include PhysicalObject

class Player
  MASS = 10.0
  COLLISION_TAG = :balloon

  def initialize(window, space, speed)
    @speed = speed
    @image = Image.new(window, "media/Balloon.png", true)
    @window = window
    @space = space
    @bounds = [CP::Vec2.new(6,21.5),CP::Vec2.new(29,5.5),CP::Vec2.new(30,-5.5),CP::Vec2.new(6,-21.5),CP::Vec2.new(-16,-14.5),CP::Vec2.new(-23,-8.5),CP::Vec2.new(-30,0),CP::Vec2.new(-23,8.5),CP::Vec2.new(-16,14.5)]
    start_position = determine_initial_position
    create_pyhsical_object(start_position.first, start_position.last, MASS, COLLISION_TAG)
    @shape.body.apply_force(@speed, zero_vector)
  end

  def x
    @shape.body.p.x
  end

  def y
    @shape.body.p.y
  end

  def body
    @shape.body
  end
  
  def increase_speed
    @speed = @speed - 20
  end

  def draw()
    @image.draw_rot(Game::X_RES/2.0, Game::Y_RES/2.0, 0, @shape.body.a.radians_to_gosu)
  end

  def determine_initial_position
    reader = MapReader.new("media/map.txt")
    map = reader.mapping_from_map_file do |char, x, y|
      if char.upcase == 'B'
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

  def elast
    0.8
  end

  def fric
    0.1
  end

end
