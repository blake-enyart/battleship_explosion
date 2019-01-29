require './lib/ship'
require './lib/cell'
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'

class CellTest < Minitest::Test

  def setup
    @cell = Cell.new("B4")
  end

  def test_cell_exist

    assert_instance_of Cell, @cell
  end

  def test_empty_method_detects_ship_not_present

    assert_nil @cell.ship
    assert_equal true, @cell.empty?
  end

end

#Block 2 Pry session


# require './lib/ship'
# # => true
#
# require './lib/cell'
# # => true
#
# cell = Cell.new("B4")
# # => #<Cell:0x00007f84f0ad4720...>
#
# cell.coordinate
# # => "B4"
#
# cell.ship
# # => nil
#
# cell.empty?
# # => true
#
# cruiser = Ship.new("Cruiser", 3)
# # => #<Ship:0x00007f84f0891238...>
#
# cell.place_ship(cruiser)
#
# cell.ship
# # => #<Ship:0x00007f84f0891238...>
#
# cell.empty?
# # => false
