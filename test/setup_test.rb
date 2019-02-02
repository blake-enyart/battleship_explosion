require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/setup'
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'

class SetupTest < Minitest::Test

  def test_setup_exist
    setup = Setup.new
    assert_instance_of Setup, setup
  end

  def test_exactly_5_ship_cells_for_computer
    setup = Setup.new
    setup.board_comp = Board.new
    setup.computer_places_ships

    assert_equal 5, setup.board_comp.render(true).count('S')
  end
end
