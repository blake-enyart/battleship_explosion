require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/setup'
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'

class SetupTest < Minitest::Test

  def setup
    @setup = Setup.new
  end
  def test_setup_exist

    assert_instance_of Setup, @setup
  end

  def test_setup_correctly_creates_two_board_objects

    assert_instance_of Board, @setup.board_comp
    assert_instance_of Board, @setup.board_player
  end

  def test_computer_sets_up_exactly_5_ships_cells_on_board
    @setup.computer_sets_up_ships

    assert_equal 5, @setup.board_comp.render(true).count('S')
  end
end
