require './lib/solver.rb'
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'

class SolverTest < Minitest::Test
  attr_reader :solver

  def setup
    @solver = Solver.new('./test/support/puzzle_file.txt')
    @one_to_nine = [1, 2, 3, 4, 5, 6, 7, 8, 9]
  end

  def test_it_exists
    assert Solver
  end

  def test_setup_works
    input = "8 659\n 7156"
    output = solver.set_up.transform_data(input)
    assert_equal [[8, 0, 6, 5, 9], [0, 7, 1, 5, 6]],
    output[0]
  end

  def test_it_is_not_solved
    input = [1, 2, 3, 0, 5]
    assert solver.solved?(input)
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
    line1 = "8 659431 \n8 6594317"
    assert_equal [[2, 7], [2]], solver.find_missing_nums_in_rows(line1)
  end

  def test_solves_missing_numbers_if_one_array_not_missing_anything
    line1 = "8 659431 \n826594317"
    assert_equal [[2, 7], []], solver.find_missing_nums_in_rows(line1)
  end

  def test_it_returns_nine_numbers_when_an_array_is_empty
    line1 = "8659 43 1\n         "
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

  def test_it_cam_insert_one_missing_num_per_row
    strings = " 26594317\n715 38942\n 94721865\n163459278\n948267153\n257813694\n531942786\n482176539\n679385421"
    assert_equal [[[8], 2, 6, 5, 9, 4, 3, 1, 7], [7, 1, 5, [6], 3, 8, 9, 4, 2], [[3], 9, 4, 7, 2, 1, 8, 6, 5], [1, 6, 3, 4, 5, 9, 2, 7, 8], [9, 4, 8, 2, 6, 7, 1, 5, 3], [2, 5, 7, 8, 1, 3, 6, 9, 4], [5, 3, 1, 9, 4, 2, 7, 8, 6], [4, 8, 2, 1, 7, 6, 5, 3, 9], [6, 7, 9, 3, 8, 5, 4, 2, 1]],
    solver.insert_missing_nums_to_all_rows(strings)
  end

  def test_it_can_flatten_one_num_when_row_solved
    arr = [[8], 2, 6, 5, 9, 4, [3, 1], [1, 3], 7]
    assert_equal [8, 2, 6, 5, 9, 4, [3, 1], [1, 3], 7],
    solver.flatten_lonely_num(arr)
  end

  def test_it_can_fill_in_one_missing_num_from_file
    solver.board = File.read('./test/support/puzzle_missing_one_num.txt')
    final_output = solver.insert_missing_nums_to_all_rows(solver.board)
    assert_equal "826594317\n715638942\n394721865\n163459278\n948267153\n257813694\n531942786\n482176539\n679385421\n",
    solver.put_it_back_together(final_output)
  end

  def test_it_can_fill_in_two_missing_nums_from_file
    skip
    solver.board = File.read('./test/support/puzzle_missing_two_nums.txt')
    final_output = solver.insert_missing_nums_to_all_rows(solver.board)
    assert_equal "826594317\n715638942\n394721865\n163459278\n948267153\n257813694\n531942786\n482176539\n679385421\n",
    solver.put_it_back_together(final_output)
  end

  def test_it_can_check_missing_nums_again_columns
    input = [8, [2, 4], 6, 5, 9, 4, 3, 1]
    assert_equal [8, [2], 6, 5, 9, 4, 3, 1],
    solver.remove_existing_nums_from_possibility(input)
  end

  def test_find_existing_nums
    input = [8, [2, 4], 6, 5, 9, 4, 3, 1]
    assert_equal [8, 6, 5, 9, 4, 3, 1],
    solver.find_existing_nums(input)
  end

  def test_it_can_flatten_when_solved
    input = [8, [2], 6, 5, 9, 4, 3, 1]
    assert_equal [8, 2, 6, 5, 9, 4, 3, 1],
    solver.flatten_lonely_num(input)
  end

  def test_a_puzzle_is_complete
    solver.board = File.read('./test/support/puzzle_complete.txt')
    assert_equal true, solver.puzzle_complete?(solver.board_disassemble)
  end

  def test_it_transforms_data
    solver.board = "826594317\n"
    assert_equal [8, 2, 6, 5, 9, 4, 3, 1, 7], solver.board_disassemble[0][0]
  end

  def test_it_can_solve_a_very_easy_puzzle
    solver.board = File.read('./test/support/puzzle_complete.txt')
    assert_equal true, solver.puzzle_complete?(solver.board_disassemble)
  end
end
