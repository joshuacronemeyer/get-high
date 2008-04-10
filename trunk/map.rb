require 'map_reader'

class Map
  attr_reader :width, :height
  
  def initialize(window, space, filename)
    @sky = Image.new(window, "media/Space.png", true)
    @tileset = Image.load_tiles(window, "media/tileset.png", 60, 60, true)
    reader = MapReader.new(filename)
    @tiles = populate_tiles(reader, window, space)
  end
  
  def populate_tiles(reader, window, space)
    mapping_proc = lambda { |char,x,y| Tile.new(window, space, x*60, y*60, char)}
    @tiles = reader.mapping_from_map_file(mapping_proc)
  end

  def height
    return @tiles.size
  end

  def width
    return @tiles.first.size
  end

  def draw(screen_x, screen_y)
    # Sigh, stars!
    @sky.draw(0, 0, 0)
    # Draw all tiles
    height.times do |y|
      width.times do |x| 
        @tiles[y][x].draw(screen_x, screen_y, @tileset)
      end
    end
  end
end
