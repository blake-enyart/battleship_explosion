require './lib/ship'
require 'pry'
require 'minitest/autorun'
require 'minitest/pride'

class CellTest < Minitest::Test

  def setup
    @cell = Cell.new()
  end

  def test_cell_exist

    assert_instance_of Cell, @cell
  end
end
