require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/setup'
require './lib/player'
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'

class PlayerTest < Minitest::Test

  def setup
    @player = Player.new
    @computer = Player.new
  end

  def test_player_exist

    assert_instance_of Player, @player
  end

  def test_computer_places_correct_number_of_ship_cells
    @computer.computer_sets_up_ships

    assert_equal 5, @computer.board.render(true).count('S')
  end

  def test_computer_fires_smart_with_hit
    @player.mock_set_up_ships
    @player.board.cells['A2'].fire_upon
    @computer.hit_history << ['A2','H']
    possible_shots = ['A1','A3','B2']

    assert_equal true, possible_shots.include?(@computer.smart_shot(@player))
  end

  def test_computer_fires_genius_shot_with_2_hits
    @player.mock_set_up_ships
    @player.board.cells['A2'].fire_upon
    @player.board.cells['A3'].fire_upon
    @computer.hit_history << ['A2','H'] << ['A3', 'H']
    possible_shots = ['A1','A4']

    assert_equal true, possible_shots.include?(@computer.genius_shot(@player))
  end
end
