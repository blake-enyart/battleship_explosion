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

  def test_computer_fires_accurately
    skip
    @player.mock_set_up_ships(cruiser_place: ['A1','A2','A3'], sub_place: ['C1','C2'])
    @player.board.cells['A2'].fire_upon

    assert_equal 'H',d
  end

  def test_computer_fires_smart_with_hit
    @player.mock_set_up_ships(cruiser_place: ['A1','A2','A3'], sub_place: ['C1','C2'])
    @player.board.cells['A2'].fire_upon
    @computer.hit_history << ['A2',@player.board.cells['A2']]
    possible_shots = ['A1','A3','B2']

    assert_equal true, possible_shots.include?(@computer.smart_shot(@player))
  end

  def test_computer_chooses_smart_shot_correctly
    @player.mock_set_up_ships(cruiser_place: ['A1','A2','A3'], sub_place: ['C1','C2'])
    @player.board.cells['A2'].fire_upon
    @computer.hit_history << ['A2',@player.board.cells['A2']]
    possible_shots = ['A1','A3','B2']

    assert_equal true, possible_shots.include?(@computer.computer_turn(@player))
  end

  def test_computer_fires_genius_shot_with_2_hits
    @player.mock_set_up_ships(cruiser_place: ['A1','A2','A3'], sub_place: ['C1','C2'])
    @player.board.cells['A2'].fire_upon
    @player.board.cells['A3'].fire_upon
    @computer.hit_history << ['A2',@player.board.cells['A2']]
    @computer.hit_history << ['A3',@player.board.cells['A3']]
    possible_shots = ['A1','A4']

    assert_equal true, possible_shots.include?(@computer.genius_shot(@player))
  end

  def test_computer_clears_hit_history_for_sunk_ship
    @player.mock_set_up_ships(cruiser_place: ['A1','A2','A3'], sub_place: ['C1','C2'])
    @player.board.cells['A1'].fire_upon
    @computer.hit_history << ['A1',@player.board.cells['A1']]
    @player.board.cells['A2'].fire_upon
    @computer.hit_history << ['A2',@player.board.cells['A2']]

    assert_equal 2, @computer.hit_history.count
    @computer.genius_shot(@player)
    expected = []

    assert_equal expected, @computer.reset_hit_history_with_sink
  end

  def test_computer_fires_smart_shot_with_sunk_ship_next_hit_ship
    @player.mock_set_up_ships(cruiser_place: ['A1','A2','A3'], sub_place: ['B1','B2'])
    @player.board.cells['B1'].fire_upon
    @player.board.cells['B2'].fire_upon
    @computer.hit_history << ['B1',@player.board.cells['B1']]
    @computer.hit_history << ['B2',@player.board.cells['B2']]

    @player.board.cells['A1'].fire_upon
    @computer.hit_history << ['A1',@player.board.cells['A1']]
    possible_shots = ['A2']
    assert_equal true, possible_shots.include?(@computer.computer_turn(@player))
  end

  def test_computer_escapes_genius_shot_with_two_ships_hit
    @player.mock_set_up_ships(cruiser_place: ['B1','B2','B3'], sub_place: ['C1','C2'])
    @player.board.cells['B1'].fire_upon
    @computer.hit_history << ['B1',@player.board.cells['B1']]
    @player.board.cells['C1'].fire_upon
    @computer.hit_history << ['C1',@player.board.cells['C1']]

    @computer.computer_turn(@player)
    @computer.computer_turn(@player)
    @computer.computer_turn(@player)

    assert_equal 11, @player.board.render.count('.')
  end
end
