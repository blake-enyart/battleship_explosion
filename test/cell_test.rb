require './lib/ship'
require './lib/cell'
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'

class CellTest < Minitest::Test

  def setup
    @cell = Cell.new("B4")
    @nina = Ship.new("Cruiser", 3)
  end

  def test_cell_exist

    assert_instance_of Cell, @cell
  end

  def test_empty_method_detects_ship_not_present

    assert_nil @cell.ship
    assert_equal true, @cell.empty?
  end

  def test_place_ship_fills_ship_attr_and_changes_empty_status

    assert_equal @nina, @cell.place_ship(@nina)
    assert_equal false, @cell.empty?
    assert_equal @nina, @cell.ship
  end

  def test_fired_upon_recognizes_status_with_input
    @cell.place_ship(@nina)

    assert_equal false, @cell.fired_upon?
    assert_equal 3, @cell.ship.health
    @cell.fire_upon

    assert_equal 2, @cell.ship.health
    assert_equal true, @cell.fired_upon?
  end
end

##PRY BLOCK 3

# require './lib/ship'
# # => true
#
# require './lib/cell'
# # => true
#
# cell = Cell.new("B4")
# # => #<Cell:0x00007f84f0ad4720...>
#
# cruiser = Ship.new("Cruiser", 3)
# # => #<Ship:0x00007f84f0891238...>
#
# cell.place_ship(cruiser)
#
# cell.fired_upon?
# # => false
#
# cell.fire_upon
#
# cell.ship.health
# # => 2
#
# cell.fired_upon?
# # => true


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
