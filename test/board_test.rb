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
    # @board.place(@cruiser, ["A1", "A2", "A3"])
    #
    # @board.valid_placement?(@submarine, ["A1", "B1"])
    # binding.pry

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

    assert_equal false,  @board.valid_placement?(@cruiser, ["A31", "A2", "A1"])
    assert_equal false,  @board.valid_placement?(@cruiser, ["A3", "A2", "A1"])
    assert_equal false,  @board.valid_placement?(@submarine, ["A1", "C1"])
    assert_equal true, @board.valid_placement?(@cruiser, ["A1", "A2", "A3"])
  end

  def test_place_puts_same_ship_in_multiple_cells
    @board.place(@submarine, ["A1", "A2"])

    assert_instance_of Cell, @board.cells["A1"]
    assert_equal @submarine, @board.cells["A1"].ship
    assert_instance_of Cell, @board.cells["A2"]
    assert_equal @submarine, @board.cells["A2"].ship
    assert_instance_of Cell, @board.cells["A3"]
    refute_equal @submarine, @board.cells["A3"].ship
  end

  def test_ships_cannot_overlap
    @board.place(@cruiser, ["A1", "A2", "A3"])
    # @board.valid_placement?(@cruiser, ["A1", "A2", "A3"])

    assert_equal true, @board.valid_placement?(@cruiser, ["A1", "A2", "A3"])

    refute_equal true, @board.valid_placement?(@submarine, ["A1", "B1"])
  end

  def test_render_displays_board_hidden_and_shows_ship_with_true
    @board.place(@cruiser, ["A1", "A2", "A3"])
    expected = "  1 2 3 4 \nA . . . . \nB . . . . \nC . . . . \nD . . . . \n"

    assert_equal expected, @board.render
    apple = "  1 2 3 4 \nA S S S . \nB . . . . \nC . . . . \nD . . . . \n"

    assert_equal apple, @board.render(true)
  end
end

