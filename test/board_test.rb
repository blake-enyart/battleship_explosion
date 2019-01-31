require './lib/ship'
require './lib/cell'
require './lib/board'
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'

class BoardTest < Minitest::Test
  def setup
    @board = Board.new
    @cruiser = Ship.new("Cruiser", 3)
    @submarine = Ship.new("Submarine", 2)
  end

  def test_board_exists
    board = Board.new

    assert_instance_of Board, board
  end


  def test_instantiation_of_board_creates_hash
     assert_instance_of Hash, @board.cells
  end

  def test_whether_board_has_16_key_value_pairs
    assert_instance_of Hash, @board.cells
    assert_equal 16, @board.cells.length
  end

  def test_key_points_to_cell_object_in_board
    assert_instance_of Cell, @board.cells["A1"]
  end

  def test_valid_coordinate_method

    assert_equal true, @board.valid_coordinate?("D4")
    assert_equal false, @board.valid_coordinate?("A5")
    assert_equal false, @board.valid_coordinate?("A22")
  end

  def test_valid_ship_length

    assert_equal false, @board.verify_ship_length(@cruiser, ["A1", "A2"])
    assert_equal true, @board.verify_ship_length(@cruiser, ["A1", "A2", "A3"])
    assert_equal false, @board.verify_ship_length(@submarine, ["A1", "A2", "A4"])
  end

  def test_diagonal_placements_are_rejected

    assert_equal false,  @board.valid_placement?(@cruiser, ["A1", "A2", "A4"])
    assert_equal false,  @board.valid_placement?(@submarine, ["A1", "B2"])
    assert_equal true, @board.valid_placement?(@cruiser, ["A1", "A2", "A3"])
  end

  def test_backwards_and_nonsequential_placements_rejected

    assert_equal false,  @board.valid_placement?(@cruiser, ["A3", "A2", "A1"])
    assert_equal false,  @board.valid_placement?(@submarine, ["A1", "C1"])
    assert_equal true, @board.valid_placement?(@cruiser, ["A1", "A2", "A3"])
  end
end





# keys = ["A1", "A2", "A3", "A4", "B1", "B2", "B3", "B4", "C1", "C2", "C3", "C4", "D1", "D2", "D3", "D4"]
