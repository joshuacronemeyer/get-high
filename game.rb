require 'rubygems'
require 'gosu'
require 'chipmunk'
require 'map'
require 'tile'
require 'player'
require 'mouse_pointer'
require 'particle'
require 'explosion'
include Gosu

class Game < Window
  PHYSICS_TIME_DELTA = 1.0/20.0
  VISCOUS_DAMPING = 0.4
  X_RES = 640
  Y_RES = 480

  def initialize
    super(X_RES, Y_RES, false)
    self.caption = "get high"
    @space = CP::Space.new
    @space.damping = VISCOUS_DAMPING   
    @player = Player.new(self, @space)
    @map = Map.new(self, @space, "media/map.txt")
    @pointer = MousePointer.new(self)
    @particle_image = Image.new(self, "media/red_particle.png", true)
    @particles = []
end
  
  def update
    if button_down? Gosu::Button::MsLeft
      x = mouse_x + @player.x - (Game::X_RES/2.0)
      y = mouse_y + @player.y - (Game::Y_RES/2.0)
      #@particles << Particle.new(self,@space,x,y)
      @explosion.cleanup if @explosion
      @explosion = Explosion.new(self,@space,x,y)
    end
    if button_down? Gosu::Button::KbLeft
      @player.turn_left
    end
    if button_down? Gosu::Button::KbRight
      @player.turn_right
    end

    if button_down? Gosu::Button::KbUp
      @player.accelerate
    end
    @space.step(PHYSICS_TIME_DELTA)
  end
  
  def draw
    @map.draw @player.x, @player.y
    @player.draw
    @pointer.draw
    #@particles.each{|particle| particle.draw(@player.x, @player.y, @particle_image)}
    @explosion.draw(@player.x, @player.y, @particle_image) if @explosion
  end
  
  def button_down(id)
    if id == Button::KbEscape then close end
  end
end

Game.new.show
