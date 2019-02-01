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

end
