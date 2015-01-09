require 'pry'

class SetUp

  def turn_puzzle_input_to_array(input)
    input = input.chars

    input.map do |i|
      i.to_i
    end
  end

  def split_lines(input)
    input.split(/\n/)
  end

  def makes_array_of_arrays(input)
    array_of_strings = split_lines(input)

    array_of_strings.map do |string|
      turn_puzzle_input_to_array(string)
    end
  end

end
