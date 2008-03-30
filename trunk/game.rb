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
  attr_reader :map

  def initialize
    super(640, 480, false)
    self.caption = "get high"
    @space = CP::Space.new
    @space.damping = VISCOUS_DAMPING   
    @player = Player.new(self, @space)
    @map = Map.new(self, @space, "media/map.txt")
    @screen_x = @screen_y = 0
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
    @map.draw @screen_x, @screen_y
    @player.draw()
  end
  
  def button_down(id)
    if id == Button::KbEscape then close end
  end
end

Game.new.show
