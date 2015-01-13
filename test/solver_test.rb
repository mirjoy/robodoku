require './lib/solver.rb'
require 'minitest/autorun'
require 'minitest/pride'

class SolverTest < Minitest::Test
  attr_reader :solver

  def setup
    @solver = Solver.new
    @one_to_nine = [1, 2, 3, 4, 5, 6, 7, 8, 9]
  end

  def test_it_exists
    assert Solver
  end

  def test_setup_works
    input = "8 659\n7156"
    assert_equal [[8, 0, 6, 5, 9], [7, 1, 5, 6]],
    solver.transform_data(input)
  end

  def test_it_is_not_solved
    input = [1, 2, 3, 0, 5]
    assert solver.it_is_not_solved?(input)
  end

  def test_solve_one_missing_number
    input = [8, 0, 6, 5, 9, 4, 3, 1, 7]
    assert_equal [2], solver.find_missing_nums(input)
  end

  def test_solves_two_missing_numbers
    input = [8, 0, 6, 5, 9, 4, 3, 1]
    assert_equal [2, 7], solver.find_missing_nums(input)
  end

  def test_it_finds_remaining_num_if_array_empty
    input = []
    assert_equal [1, 2, 3, 4, 5, 6, 7, 8, 9], solver.find_missing_nums(input)
  end

  def test_solves_missing_numbers_from_two_arrays
    line1 = "8659431\n86594317"
    assert_equal [[2, 7], [2]], solver.find_missing_nums_in_rows(line1)
  end

  def test_solves_missing_numbers_if_one_array_not_missing_anything
    line1 = "8659431\n826594317"
    assert_equal [[2, 7], []], solver.find_missing_nums_in_rows(line1)
  end

  def test_it_returns_nine_numbers_when_an_array_is_empty
    line1 = "8659431\n "
    assert_equal [[2, 7], [1, 2, 3, 4, 5, 6, 7, 8, 9]], solver.find_missing_nums_in_rows(line1)
  end

  def test_it_can_fill_in_one_missing_num
    input = [8, 0, 6, 5, 9, 4, 3, 1] #WHERE IS 7
    missing_num = [2]
    assert_equal [8, 2, 6, 5, 9, 4, 3, 1], solver.insert_missing_nums_to_one_array(input, missing_num)
  end

  def test_it_can_fill_in_two_missing_nums
    input = [8, 0, 6, 5, 9, 0, 3, 1]
    missing_num = [2, 4]
    assert_equal [8, [2, 4], 6, 5, 9, [2, 4], 3, 1], solver.insert_missing_nums_to_one_array(input, missing_num)
  end

  def test_it_can_find_one_missing_num_from_same_index
    arr_of_arrs = [[8], [2], [6], [5], [0], [4], [3], [1], [7]]
    assert_equal [9], solver.find_missing_num_by_index(arr_of_arrs)
  end

  def test_it_can_find_two_missing_nums_from_same_index
    arr_of_arrs = [[8], [0], [6], [5], [0], [4], [3], [1], [7]]
    assert_equal [2, 9], solver.find_missing_num_by_index(arr_of_arrs)
  end

  def test_it_can_insert_one_missing_num_by_index
    skip
    arr_of_arrs = [[8], [2], [6], [5], [0], [4], [3], [1], [7]]
    assert_equal [[8], [2], [6], [5], [[9]], [4], [3], [1], [7]],
    solver.insert_missing_nums_by_index(arr_of_arrs)
  end

  def test_it_can_insert_two_missing_nums_by_index
    skip
    arr_of_arrs = [[8], [2], [6], [5], [0], [4], [0], [1], [7]]
    assert_equal [[8], [2], [6], [5], [[3, 9]], [4], [[3, 9]], [1], [7]],
    solver.insert_missing_nums_by_index(arr_of_arrs)
  end

  def test_it_can_insert_two_missing_nums_by_index_into_longer_array
    skip
    arr_of_arrs = [[8, 1], [2, 2], [6, 3], [5, 4], [0, 5], [4, 6], [7, 0], [1, 8], [7, 9]]
    final_arr = [[8, 1], [2, 2], [6, 3], [5, 4], [[3, 9], 5], [4, 6], [7, [3, 9]], [1, 8], [7, 9]]
    assert_equal final_arr, solver.insert_missing_nums_by_index(arr_of_arrs)
  end

end
