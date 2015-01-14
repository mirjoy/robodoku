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

  def test_it_makes_array_of_rows
    input = "8 659\n7156"
    assert_equal [[8, 0, 6, 5, 9], [7, 1, 5, 6]],
    set_up.makes_array_of_rows(input)
  end

  def test_it_makes_array_of_columns
    input = "43\n54\n67"
    assert_equal [[4, 5, 6], [3, 4, 7]],
    set_up.make_array_of_columns(input)
  end

  def test_it_splits_into_three_lines
    input = "8 6594317\n715638942\n394 21865\n163459278\n948267153\n257813694\n531942786\n482176539\n679385421\n"
    output = set_up.start_squares_by_breaking_into_three_lines(input)
    assert_equal [[[8, 0, 6, 5, 9, 4, 3, 1, 7],
    [7, 1, 5, 6, 3, 8, 9, 4, 2],
    [3, 9, 4, 0, 2, 1, 8, 6, 5]],
    [[1, 6, 3, 4, 5, 9, 2, 7, 8],
    [9, 4, 8, 2, 6, 7, 1, 5, 3],
    [2, 5, 7, 8, 1, 3, 6, 9, 4]],
    [[5, 3, 1, 9, 4, 2, 7, 8, 6],
    [4, 8, 2, 1, 7, 6, 5, 3, 9],
    [6, 7, 9, 3, 8, 5, 4, 2, 1]]], output
  end

  def test_it_makes_arr_of_squares
    skip
    input = "8 6594317\n715638942\n394 21865\n163459278\n948267153\n257813694\n531942786\n482176539\n679385421\n"
    output = set_up.make_array_of_squares(input)
    assert_equal [8, 0, 6, 7, 1, 5, 3, 9, 4], output[0]
  end

  def test_it_breaks_lines_into_3_arrays_of_3
    skip
    assert_equal [[8, 0, 6], [5, 9, 4], [3, 1, 7]]
  end

end
