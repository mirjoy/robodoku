require_relative 'solver'
require 'pry'

filename = ARGV[0]
puzzle = File.read('puzzle_file.txt')
solver = Solver.new
binding.pry
solution = solver.solve(puzzle)
puts solution
