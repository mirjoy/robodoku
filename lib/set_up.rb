class SetUp

  def turn_puzzle_input_to_array(input)
    input.chars.map {|i| i.to_i}
  end

  def transform_data(input)
    rows = makes_array_of_rows(input)
    columns = make_array_of_columns(input)
    [rows, columns]
  end

  def makes_array_of_rows(input)
    input.split(/\n/).map do |string|
      turn_puzzle_input_to_array(string)
    end
  end

  def make_array_of_columns(input)
    makes_array_of_rows(input).transpose
  end

  def make_array_of_squares(input)
    three_lines = start_squares_by_breaking_into_three_lines(input)

    three_lines.map do |arr|
      new_arr = arr.each_slice(3)
    end

  end

  def start_squares_by_breaking_into_three_lines(input)
    lines = makes_array_of_rows(input)
      lines.each_slice(3).to_a
  end

  def break_square_lines_into_three_arrs_of_three(lines)
    lines.map do |line|
      line.each_slice(3).to_a
    end
  end
end
