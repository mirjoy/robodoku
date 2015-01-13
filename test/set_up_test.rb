require './lib/set_up.rb'
require 'minitest/autorun'
require 'minitest/pride'

class SetUpTest < Minitest::Test
  attr_reader :set_up

  def setup
    @set_up = SetUp.new
  end

  def test_turns_to_array_with_one_empty_spot
    result = set_up.turn_puzzle_input_to_array("8 6594317")
    assert_equal [8, 0, 6, 5, 9, 4, 3, 1, 7], result
  end

  def test_turns_to_array_with_two_empty_spots
    result = set_up.turn_puzzle_input_to_array("8 6594 17")
    assert_equal [8, 0, 6, 5, 9, 4, 0, 1, 7], result
  end

  def test_it_splits_lines
    input = "8 6594317\n715638942"
    assert_equal ["8 6594317", "715638942"], set_up.split_lines(input)
  end

  def test_it_makes_array_of_arrays
    input = "8 659\n7156"
    assert_equal [[8, 0, 6, 5, 9], [7, 1, 5, 6]],
    set_up.makes_array_of_arrays(input)
  end

  def test_it_makes_array_of_columns
    input = "43\n54\n67"
    assert_equal [[4, 5, 6], [3, 4, 7], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0]],
    set_up.make_array_of_columns(input)
  end

end
