class MousePointer
  def initialize(window)
    @window = window
  end

  def draw
   x = @window.mouse_x
   y = @window.mouse_y
   @window.draw_line(x-10, y, 0xFFFFFFFF, x+10, y, 0xFFFFFFFF, z=0, mode=:default)
   @window.draw_line(x, y-10, 0xFFFFFFFF, x, y+10, 0xFFFFFFFF, z=0, mode=:default)
  end
end
