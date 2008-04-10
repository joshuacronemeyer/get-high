class MapReader
  include Enumerable

  def initialize(filename)
    @filename = filename
    @lines = File.readlines(@filename).map { |line| line.chop }
  end
  
 def mapping_from_map_file(mapping_proc=nil, &mapping)
    mapped_grid = []
    @lines.each_with_index do |string, y|
      row = []
      string.length.times do |x|
        #apply mapping proc or block to every tile on the map.
        cur_char = string[x, 1]
        if mapping_proc
          row << mapping_proc.call(cur_char, x, y)
        else
          row << yield(cur_char, x, y)
        end
      end
      mapped_grid << row
    end
    return mapped_grid
  end
end
