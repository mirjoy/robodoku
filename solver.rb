require 'pry'
require './set_up'

class Solver

  attr_reader :set_up

  def initialize
    @set_up = SetUp.new
  end

  def solve(puzzle)
    return puzzle
  end

  def transform_data(input)
    set_up.makes_array_of_arrays(input)
  end

  def it_is_not_solved?(input)
    input.include?(0)
  end

  def find_remaining_num(arr)
    one_to_nine = [1, 2, 3, 4, 5, 6, 7, 8, 9]

    arr.map do |num|
      if one_to_nine.include?(num) || num.zero?
        one_to_nine.delete(num)
      end
    end
    return one_to_nine
  end

  def find_missing_nums_in_all_arrays(input)
    arrs = transform_data(input)

    arrs.map do |arr|
      find_remaining_num(arr)
    end
  end

  def insert_missing_nums_to_one_array(input, missing_nums)
    if input.count(0) == 1
      index_num = input.index(0)
      input[index_num] = missing_nums[0]
      return input
    else
      new_arr = input.map do |num|
        if num.zero?
          missing_nums
        else
          num
        end
      end
    end
  end

  def find_missing_num_by_index(arrs)
    one_to_nine = [1, 2, 3, 4, 5, 6, 7, 8, 9]

    arrs.each do |arr|
      counter = 0
      if one_to_nine.include?(arr[counter]) || arr[counter].zero?
        one_to_nine.delete(arr[counter])
      end
      counter += 1
    end
    return one_to_nine
  end

  def insert_missing_num_by_index(arrs)
    missing_nums = find_missing_num_by_index(arrs)

      new_arr = arrs.map do |arr|
        if arr[0] == 0
          missing_nums
        else
          arr
        end
      end

  end

end
