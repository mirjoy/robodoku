class SetUp

  def turn_puzzle_input_to_array(input)
    input.chars.map {|i| i.to_i}
  end

  def split_lines(input)
    input.split(/\n/)
  end

  def makes_array_of_rows(input)
    split_lines(input).map do |string|
      turn_puzzle_input_to_array(string)
    end
  end

  def make_array_of_columns(input)
    arr_of_columns = []
    num = 0

    until num == 9
      new_arr = split_lines(input).map do |string|
          string[num].to_i
      end
      arr_of_columns << new_arr
      num += 1
    end
    arr_of_columns
  end

end
