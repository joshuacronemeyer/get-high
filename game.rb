
require 'rubygems'
require 'gosu'
require 'chipmunk'
require 'map'
require 'tile'
require 'player'
require 'rope'
require 'mouse_pointer'
require 'particle'
require 'explosion'
include Gosu

class Game < Window
  PHYSICS_TIME_DELTA = 1.0/20.0
  VISCOUS_DAMPING = 0.7
  GRAVITY = 30
  X_RES = 640
  Y_RES = 480

  def initialize
    super(X_RES, Y_RES, false)
    self.caption = "get high"
    @space = CP::Space.new
    @space.damping = VISCOUS_DAMPING
    @space.gravity = CP::Vec2.new(0,GRAVITY)
    @player = Player.new(self, @space, CP::Vec2.new(0,-GRAVITY - 600))
    @rope = Rope.new(self, @space, @player.body)
    @map = Map.new(self, @space, "media/map.txt")
    @pointer = MousePointer.new(self)
    @particle_image = Image.new(self, "media/red_particle.png", true)
    @particles = []
end
  
  def update
    if button_down? Gosu::Button::MsLeft
      x = mouse_x + @player.x - (Game::X_RES/2.0)
      y = mouse_y + @player.y - (Game::Y_RES/2.0)
      @explosion.cleanup if @explosion
      @explosion = Explosion.new(self,@space,x,y)
    end
    @space.step(PHYSICS_TIME_DELTA)
  end
  
  def draw
    @map.draw @player.x, @player.y
    @player.draw
    @rope.draw @player.x, @player.y
    @pointer.draw
    @explosion.draw(@player.x, @player.y, @particle_image) if @explosion
  end
  
  def button_down(id)
    if id == Button::KbEscape then close end
  end
end

Game.new.show
