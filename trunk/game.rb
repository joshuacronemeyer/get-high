require 'rubygems'
require 'gosu'
require 'chipmunk'
require 'map'
require 'tile'
include Gosu

class Game < Window
  attr_reader :map

  def initialize
    super(640, 480, false)
    self.caption = "get high"
    @map = Map.new(self, "media/map.txt")
#    @cptn = CptnRuby.new(self, 400, 100)
    # Scrolling is stored as the position of the top left corner of the screen.
    @screen_x = @screen_y = 0
  end
  def update
    move_x = 0
    move_x -= 5 if button_down? Button::KbLeft
    move_x += 5 if button_down? Button::KbRight
#    @cptn.update(move_x)
#    @cptn.collect_gems(@map.gems)
    # Scrolling follows player
#    @screen_x = [[@cptn.x - 320, 0].max, @map.width * 50 - 640].min
#    @screen_y = [[@cptn.y - 240, 0].max, @map.height * 50 - 480].min
  end
  def draw
    @map.draw @screen_x, @screen_y
  end
  def button_down(id)
    if id == Button::KbEscape then close end
  end
end

Game.new.show
