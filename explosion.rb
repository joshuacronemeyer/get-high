require 'physical_object'
include PhysicalObject
#TODO try grouping these guys so they don't interact... might help explosion look better.
class Explosion
  def initialize(window, space, x, y)
    @particles = Array.new(50){|particle| Particle.new(window, space, x, y)}
    @particles.each do |particle| 
      particle.launch(radial_vector)
      particle.non_interactive!
    end
  end

  def draw(screen_x, screen_y, image)
    @particles.each{|particle| particle.draw(screen_x, screen_y, image)}
  end

  def random_vector
    x = positive_negative*rand(50000)
    y = positive_negative*rand(50000)
    CP::Vec2.new(x,y)
  end
  
  def radial_vector
    r = rand(6000)
    t = rand(360)
    x = r*Math.sin(t)
    y = r*Math.cos(t)
    CP::Vec2.new(x,y)
  end

  def positive_negative
    multiplier = 1
    multiplier = -1 if rand(0) > 0.5
    multiplier
  end

  def cleanup
    @particles.each{|particle| particle.destroy}
  end
end
