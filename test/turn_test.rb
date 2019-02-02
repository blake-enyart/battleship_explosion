require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require_relative '../lib/cell'
require_relative '../lib/setup'
require_relative '../lib/ship'
require_relative '../lib/board'
require_relative '../lib/cell'
require_relative '../lib/turn'


class TurnTest < Minitest::Test

  def test_turn_exists
    assert_instance_of Turn, turn
  end
end
