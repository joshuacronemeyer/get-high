require 'test/unit'
require 'map'
require 'tile'
require 'rubygems'
require 'mocha'
require 'gosu'
require 'chipmunk'
include Gosu
class MapTest < Test::Unit::TestCase

  def setup
    Image.expects(:new)
    Image.expects(:load_tiles)
    lines = ["GGEE\n", "EEGG\n", "GGGG\n"]
    File.expects(:readlines).returns(lines)
    space = stub(:add_body=>0, :add_shape=>0)
    @map = Map.new(:window, space, "filename")
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
    has_offset_between_elements(60, @tiles)
  
    first_column = @tiles.first
    assert_equal 0, get(first_column.first, :@shape).body.p.x
    second_column = @tiles[1]
    assert_equal 60, get(second_column.first, :@shape).body.p.x
  end

  def has_offset_between_elements(offset, tiles)
    tiles.each do |column|
      column.each_cons(2) do |element_y1, element_y2|
        location_y1 = get(element_y1, :@shape).body.p.y
        location_y2 = get(element_y2, :@shape).body.p.y
        assert_equal offset, (location_y2 - location_y1)
      end
    end
  end
  
  def test_tile_type_sets_correctly
    second_column = @tiles[1]
    assert_equal 0, get(second_column.first, :@type)
    assert_equal 1, get(second_column[1], :@type)
  end
end
