require 'rubygems'
require 'gosu'
require 'chipmunk'
require 'map'
require 'tile'
require 'player'
include Gosu

class Game < Window
  PHYSICS_TIME_DELTA = 1.0/20.0
  VISCOUS_DAMPING = 0.3
  X_RES = 640
  Y_RES = 480

  def initialize
    super(X_RES, Y_RES, false)
    self.caption = "get high"
    @space = CP::Space.new
    @space.damping = VISCOUS_DAMPING   
    @player = Player.new(self, @space)
    @map = Map.new(self, @space, "media/map.txt")
  end
  
  def update
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
  end
  
  def button_down(id)
    if id == Button::KbEscape then close end
  end
end

Game.new.show
