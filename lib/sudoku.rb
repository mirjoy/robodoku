require './lib/solver'
require 'pry'

filename = ARGV[0]
puzzle = File.read('./lib/puzzle_file.txt')
binding.pry

solver = Solver.new
solution = solver.solve(puzzle)
puts solution
