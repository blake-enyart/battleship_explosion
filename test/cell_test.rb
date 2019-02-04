require './lib/ship'
require './lib/cell'
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'

class CellTest < Minitest::Test

  def setup
    @cell = Cell.new("B4")
    @nina = Ship.new("Cruiser", 3)

    @cell_1 = Cell.new("B1")
    @cell_2 = Cell.new("C3")
  end

  def test_cell_exist

    assert_instance_of Cell, @cell
  end

  def test_empty_method_detects_ship_not_present

    assert_nil @cell.ship
    assert_equal true, @cell.empty?
  end

  def test_place_ship_fills_ship_attr_and_changes_empty_status

    @cell.place_ship(@nina)
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

  def test_render_period_if_ship_not_fired_upon
    @cell_2.place_ship(@nina)

    assert_instance_of Ship, @cell_2.ship
    assert_equal false, @cell_2.fired_upon?
    assert_equal ".", @cell_2.render
  end

  def test_render_period_if_empty_cell_not_fired_upon

    assert_nil @cell_1.ship
    assert_equal false, @cell_1.fired_upon?
    assert_equal ".", @cell_1.render
  end

  def test_render_shows_miss_when_firing_on_empty_cell

    assert_nil @cell.ship
    assert_equal ".", @cell.render
    assert_equal ".", @cell.render(true)

    @cell.fire_upon

    assert_equal "M", @cell.render
  end

  def test_render_hits_cell_with_ship
    @cell_2.place_ship(@nina)

    assert_equal 3, @cell_2.ship.health
    assert_equal false, @cell_2.fired_upon?
    assert_equal Ship, @cell_2.ship.class
    assert_equal "S", @cell_2.render(true)

    @cell_2.fire_upon

    assert_equal true, @cell_2.fired_upon?
    assert_equal 2, @cell_2.ship.health
    assert_equal "H", @cell_2.render
  end

  def test_render_sinks_ship
    @cell_2.place_ship(@nina)

    assert_equal "S", @cell_2.render(true)

    @cell_2.fire_upon

    assert_equal "H", @cell_2.render
    assert_equal 2, @cell_2.ship.health

    @cell_2.fire_upon

    assert_equal "H", @cell_2.render
    assert_equal 1, @cell_2.ship.health

    @cell_2.fire_upon

    assert_equal "X", @cell_2.render
    assert_equal 0, @cell_2.ship.health
    assert_equal true, @cell_2.ship.sunk?
  end
end
