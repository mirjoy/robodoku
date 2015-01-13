require './lib/set_up'

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
    arrs = transform_data(input)

    arrs.map do |arr|
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
    end
  end

  def find_missing_num_by_index(arrs)
    one_to_nine = [1, 2, 3, 4, 5, 6, 7, 8, 9]

    arrs.each do |arr|
      counter = 0
      if one_to_nine.include?(arr[counter])
        one_to_nine.delete(arr[counter])
      end
      counter += 1
    end
    return one_to_nine
  end

  def insert_missing_nums_by_index(arrs)

  end


  # def insert_missing_nums_in_one_array(arr)
  #   arrs.map do |arr|
  #     insert_missing_nums_by_index(arr)
  #   end
  # end
  #
  # def insert_missing_nums_by_index(arrs)
  #   missing_nums = find_missing_num_by_index(arrs)
  #
  #   arr_of_indexes = (0..8).to_a
  #
  #   arr_of_indexes.map do |num|
  #     if a[num] == 0
  #       [missing_nums]
  #     else
  #       a
  #     end
  #   end
  # end

end
