require './lib/set_up'

class Solver

  attr_reader :set_up

  def initialize
    @set_up = SetUp.new
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
    one_to_nine = [1, 2, 3, 4, 5, 6, 7, 8, 9]

    arr.map do |num|
      if one_to_nine.include?(num) || num.zero?
        one_to_nine.delete(num)
      end
    end
    return one_to_nine
  end

  def find_missing_nums_in_rows(input)
    transform_data_from_rows(input).map do |arr|
      find_missing_nums(arr)
    end
  end

  def find_missing_nums_in_columns(input)
    transform_data_from_columns(input).map do |arr|
      find_missing_nums(arr)
    end
  end

  def insert_missing_nums_to_one_array(input, missing_nums)
    if input.count(0) == 1
      input[input.index(0)] = missing_nums[0]
      return input
    else
      new_arr = input.map do |num|
        if num.zero?
          missing_nums
        else
          num
        end
      end
      return new_arr
    end
  end

  def insert_missing_nums_to_all_rows(input)
    array_of_rows = transform_data_from_rows(input)
    missing_nums = find_missing_nums_in_rows(input)

    array_of_rows.map do |arr|
      insert_missing_nums_to_one_array(arr, missing_nums)
    end
  end

  def insert_missing_nums_to_all_columns(input)
    array_of_rows = transform_data_from_columns(input)
    missing_nums = find_missing_nums_in_columns(input)

    array_of_rows.map do |arr|
      insert_missing_nums_to_one_array(arr, missing_nums)
    end
  end
end
