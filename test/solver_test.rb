require './lib/solver.rb'
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'

class SolverTest < Minitest::Test
  attr_reader :solver

  def setup
    @solver = Solver.new('./lib/puzzle_file.txt')
    @one_to_nine = [1, 2, 3, 4, 5, 6, 7, 8, 9]
  end

  def test_it_exists
    assert Solver
  end

  def test_setup_works
    input = "8 659\n7156"
    assert_equal [[8, 0, 6, 5, 9], [7, 1, 5, 6]],
    solver.transform_data_from_rows(input)
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
    input = [8, 0, 6, 5, 9, 4, 3, 1, 7]
    missing_num = [2]
    assert_equal [8, [2], 6, 5, 9, 4, 3, 1, 7], solver.insert_missing_nums_to_one_array(input, missing_num)
  end

  def test_it_can_fill_in_two_missing_nums
    input = [8, 0, 6, 5, 9, 0, 3, 1]
    missing_num = [2, 4]
    assert_equal [8, [2, 4], 6, 5, 9, [2, 4], 3, 1], solver.insert_missing_nums_to_one_array(input, missing_num)
  end

  def test_it_can_find_one_missing_num_from_same_column
    strings = "026594317\n715638942\n394721865\n163459278\n948267153\n257813694\n531942786\n482176539\n679385421"
    assert_equal [[8], [], [], [], [], [], [], [], [],],
    solver.find_missing_nums_in_columns(strings)
  end

  def test_it_can_find_two_missing_nums_from_a_different_column
    strings = " 26594317\n715 38942\n394721865\n163459278\n948267153\n257813694\n531942786\n482176539\n679385421"
    assert_equal [[8], [], [], [6], [], [], [], [], [],],
    solver.find_missing_nums_in_columns(strings)
  end

  def test_it_can_find_two_missing_nums_from_the_same_column
    strings = " 26594317\n715 38942\n 94721865\n163459278\n948267153\n257813694\n531942786\n482176539\n679385421"
    assert_equal [[3, 8], [], [], [6], [], [], [], [], [],],
    solver.find_missing_nums_in_columns(strings)
  end

  def test_it_cam_insert_missing_nums_in_a_column
    strings = " 26594317\n715 38942\n 94721865\n163459278\n948267153\n257813694\n531942786\n482176539\n679385421"
    assert_equal [[[8], 2, 6, 5, 9, 4, 3, 1, 7], [7, 1, 5, [8], 3, 8, 9, 4, 2], [[8], 9, 4, 7, 2, 1, 8, 6, 5], [1, 6, 3, 4, 5, 9, 2, 7, 8], [9, 4, 8, 2, 6, 7, 1, 5, 3], [2, 5, 7, 8, 1, 3, 6, 9, 4], [5, 3, 1, 9, 4, 2, 7, 8, 6], [4, 8, 2, 1, 7, 6, 5, 3, 9], [6, 7, 9, 3, 8, 5, 4, 2, 1]],
    solver.insert_missing_nums_to_all_rows(strings)
  end

  def test_it_cam_insert_one_missing_num_per_row
    strings = " 26594317\n715 38942\n 94721865\n163459278\n948267153\n257813694\n531942786\n482176539\n679385421"
    assert_equal [[[8], 2, 6, 5, 9, 4, 3, 1, 7], [7, 1, 5, [6], 3, 8, 9, 4, 2], [[3], 9, 4, 7, 2, 1, 8, 6, 5], [1, 6, 3, 4, 5, 9, 2, 7, 8], [9, 4, 8, 2, 6, 7, 1, 5, 3], [2, 5, 7, 8, 1, 3, 6, 9, 4], [5, 3, 1, 9, 4, 2, 7, 8, 6], [4, 8, 2, 1, 7, 6, 5, 3, 9], [6, 7, 9, 3, 8, 5, 4, 2, 1]],
    solver.insert_missing_nums_to_all_rows(strings)
  end

  def test_it_can_flatten__one_arr_when_solved
    skip
    arr = [[8], 2, 6, 5, 9, 4, 3, 1, 7]
    assert_equal [8, 2, 6, 5, 9, 4, 3, 1, 7]
    solver.flatten_when_solved(arr)
  end

  def test_it_can_flatten_when_solved
    skip
    strings = " 26594317\n715 38942\n 94721865\n163459278\n948267153\n257813694\n531942786\n482176539\n679385421"
    big_arr = solver.insert_missing_nums_to_all_rows(strings)
    assert_equal [[8, 2, 6, 5, 9, 4, 3, 1, 7], [7, 1, 5, 6, 3, 8, 9, 4, 2], [3, 9, 4, 7, 2, 1, 8, 6, 5], [1, 6, 3, 4, 5, 9, 2, 7, 8], [9, 4, 8, 2, 6, 7, 1, 5, 3], [2, 5, 7, 8, 1, 3, 6, 9, 4], [5, 3, 1, 9, 4, 2, 7, 8, 6], [4, 8, 2, 1, 7, 6, 5, 3, 9], [6, 7, 9, 3, 8, 5, 4, 2, 1]],
    solver.flatten_when_solved(big_arr)
  end

  def test_it_can_fill_in_one_missing_num_from_file
    skip
    final_output = solver.insert_missing_nums_to_all_rows(solver.board)
    assert_equal "826594317\n715638942\n394721865\n163459278\n948267153\n257813694\n531942786\n482176539\n679385421\n", solver.put_it_back_together(final_output)
  end

  def test_it_can_fill_in_two_missing_nums_from_file
    skip
    final_output = solver.insert_missing_nums_to_all_rows(solver.board)
    assert_equal "826594317\n715638942\n394721865\n163459278\n948267153\n257813694\n531942786\n482176539\n679385421\n", solver.put_it_back_together(final_output)
  end

  def test_it_cam_insert_missing_nums_in_a_column
    skip
    strings = " 26594317\n715 38942\n 94721865\n163459278\n948267153\n257813694\n531942786\n482176539\n679385421"
    assert_equal ["tbd"], solver.insert_missing_nums_to_all_columns(strings).include?([8])
  end

end
