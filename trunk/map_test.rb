require 'test/unit'
require 'map'
require 'tile'
require 'rubygems'
require 'mocha'
require 'gosu'
include Gosu
class MapTest < Test::Unit::TestCase

  def setup
    Image.expects(:new)
    Image.expects(:load_tiles)
    lines = ["GGEE\n", "EEGG\n", "GGGG\n"]
    File.expects(:readlines).returns(lines)
    @map = Map.new(:window, "filename")
    @tiles = get @map, :@tiles
  end
  
  def test_map_has_correct_size
    assert_equal 4, @map.width
    assert_equal 3, @map.height
  end
  
  def get(target, val)
    target.instance_variable_get(val)
  end
  
  def test_tiles_get_correct_offsets
    first_column = @tiles.first
    assert_equal 0, get(first_column.first, :@x)
    assert_equal 0, get(first_column.first, :@y)
    assert_equal 60, get(first_column[1], :@y)
    assert_equal 120, get(first_column[2], :@y)
    
    second_column = @tiles[1]
    assert_equal 60, get(second_column.first, :@x)
    assert_equal 0, get(second_column.first, :@y)
    assert_equal 60, get(second_column[1], :@y)
    assert_equal 120, get(second_column[2], :@y)
  end
  
  def test_tile_type_sets_correctly
    second_column = @tiles[1]
    assert_equal 0, get(second_column.first, :@type)
    assert_equal 1, get(second_column[1], :@type)
  end
end