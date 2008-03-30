class Map
  attr_reader :width, :height
  
  def initialize(window, filename)
    @sky = Image.new(window, "media/Space.png", true)
    @tileset = Image.load_tiles(window, "media/tileset.png", 60, 60, true)
    
    #read in map from file
    lines = File.readlines(filename).map { |line| line.chop }
    @tiles = populate_tiles(lines, window)
  end
  
  def populate_tiles(lines, window)
    @height = lines.size 
    @width = lines.first.size
    tiles = Array.new(@width) do |x|
      Array.new(@height) do |y|
        x_position = x * 60
        y_position = y * 60
        tile = Tile.new(window, x_position, y_position, lines[y][x,1])
        #TODO ensure physical immobility
        tile
      end
    end
    return tiles
  end
    
  def draw(screen_x, screen_y)
    # Sigh, stars!
    @sky.draw(0, 0, 0)
    # Draw all tiles
    @height.times do |y|
      @width.times do |x| 
        @tiles[x][y].draw(screen_x, screen_y, @tileset)
      end
    end
  end
end
