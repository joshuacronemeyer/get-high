require 'rubygems'
require 'test/unit'
require 'mocha'
require 'map_reader'

class MapReaderTest < Test::Unit::TestCase

  def test_mapping_from_file_with_block_for_mapping
    lines = ["11\n","22\n","33\n"]
    File.expects(:readlines).returns(lines)
    reader = MapReader.new("no_matter.rb")
    resulting_map = reader.mapping_from_map_file { |char, x, y| char.to_i + 1}
    assert_equal([[2,2],[3,3],[4,4]], resulting_map)
  end

  def test_mapping_from_file_with_proc_for_mapping
    lines = ["11\n","22\n","33\n"]
    File.expects(:readlines).returns(lines)
    reader = MapReader.new("no_matter.rb")
    j,c="j","c"
    #this test will verify our local vars are there when the proc is called
    mapping = lambda { |char, x, y| char + j + c } 
    resulting_map = reader.mapping_from_map_file(mapping)
    assert_equal([["1jc","1jc"],["2jc","2jc"],["3jc","3jc"]],resulting_map)
  end

  def test_mapping_from_file_records_x_y_positions_correctly
    lines = ["11\n","22\n","33\n"]
    File.expects(:readlines).returns(lines)
    reader = MapReader.new("no_matter.rb")
    mapping = lambda { |char, x, y| "#{x}#{y}"} 
    resulting_map = reader.mapping_from_map_file(mapping)
    assert_equal([["00","10"],["01","11"],["02","12"]],resulting_map)
  end
end
