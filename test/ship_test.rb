require './lib/ship'
require 'pry'
require 'minitest/autorun'
require 'minitest/pride'

class ShipTest < Minitest::Test

  def setup
    @ship = Ship.new("Cruiser", 3)
  end

  def test_ship_exist

    assert_instance_of Ship, @ship
  end

  def test_attributes_return_correctly

    assert_equal "Cruiser", @ship.name
    assert_equal 3, @ship.length
  end

  def test_health_decreases_with_hit_method_and_sinks
    @ship.health
    @ship.sunk?
    @ship.hit

    assert_equal 2, @ship.health
    @ship.hit

    assert_equal 1, @ship.health
    @ship.hit

    assert_equal true, @ship.sunk?
  end
end


# cruiser.name
# #=> "Cruiser"
#
# cruiser.length
# #=> 3
#
# cruiser.health
# #=> 3
#
# cruiser.sunk?
# #=> false
#
# cruiser.hit
#
# cruiser.health
# #=> 2
#
# cruiser.hit
#
# cruiser.health
# #=> 1
#
# cruiser.sunk?
# #=> false
#
# cruiser.hit
#
# cruiser.sunk?
# #=> true
