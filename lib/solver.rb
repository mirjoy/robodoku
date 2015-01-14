require './lib/set_up'

class Solver

  attr_reader :set_up, :board
  attr_accessor :file

  def initialize(file)
    @set_up = SetUp.new
    @board = File.read(file)
  end

  def start_board
    @board = file
  end

  def solve(puzzle)
    return puzzle
  end

  def transform_data_from_rows(input)
    set_up.makes_array_of_rows(input)
  end

  def transform_data_from_columns(input)
    set_up.make_array_of_columns(input)
  end

  def it_is_not_solved?(input)
    input.include?(0)
  end

  def find_missing_nums(arr)
    one_to_nine = (1..9).to_a

    arr.each do |num|
      if one_to_nine.include?(num) || num.zero?
        one_to_nine.delete(num)
      end
    end
    return one_to_nine
  end

  # find arrays in the column
  # compare contents of the array to what is already
  # in the column

  def find_missing_nums_in_rows(input)
    transform_data_from_rows(input).map do |arr_of_known_nums|
      find_missing_nums(arr_of_known_nums)
    end
  end

  def find_missing_nums_in_columns(input)
    transform_data_from_columns(input).map do |arr_of_known_nums|
      find_missing_nums(arr_of_known_nums)
    end
  end

  def insert_missing_nums_to_one_array(input, missing_nums)
    input.map do |num|
      if num.zero?
        missing_nums
      else
        num
      end
    end
  end

  def insert_missing_nums_to_all_rows(input)
    array_of_rows = transform_data_from_rows(input)
    missing_nums = find_missing_nums_in_rows(input)

    array_of_rows.map do |arr|
      insert_missing_nums_to_one_array(arr, missing_nums[array_of_rows.index(arr)])
    end
  end

  def insert_missing_nums_to_all_columns(input)
    array_of_columns = transform_data_from_columns(input)
    missing_nums = find_missing_nums_in_columns(input)

    array_of_columns.map do |arr|
      insert_missing_nums_to_one_array(arr, missing_nums[array_of_columns.index(arr)])
    end
  end

  def put_it_back_together(arr_of_arrs)
    arr_of_arrs.reduce('') do |final_string, arr|
      final_string + arr.join + "\n"
    end
  end

  def flatten_one_arr_when_solved(arr)
    if arr.all? {|ele| ele.length == 1}
        arr.flatten
      end
  end
end
