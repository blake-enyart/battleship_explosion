require './lib/ship'
require './lib/cell'
require './lib/board'
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'

class BoardTest < Minitest::Test
  def setup
    @board = Board.new
  end
  
  def test_board_exists
    board = Board.new

    assert_instance_of Board, board
  end


  def test_instantiation_of_board_creates_hash
     assert_instance_of Hash, @board.cells
  end
end



# keys = ["A1", "A2", "A3", "A4", "B1", "B2", "B3", "B4", "C1", "C2", "C3", "C4", "D1", "D2", "D3", "D4"]
