require './lib/ship'
require 'pry'
require 'minitest/autorun'
require 'minitest/pride'

class ShipTest < Minitest::Test

  def test_ship_exist
    ship = Ship.new()

    assert_instance_of Ship, ship
  end
end


# cruiser = Ship.new("Cruiser", 3)
#
# cruiser.name
#
# cruiser.length
#
# cruiser.health
#
# cruiser.sunk?
#
# cruiser.hit
#
# cruiser.health
#
# cruiser.hit
#
# cruiser.health
#
# cruiser.sunk?
#
# cruiser.hit
#
# cruiser.sunk?
