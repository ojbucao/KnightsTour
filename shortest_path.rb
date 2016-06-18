require_relative 'lib/board'
require_relative 'lib/knight'
require_relative 'lib/graph'

board = Board.new(size: 5)
knight = Knight.new(board: board, start_pos: [0, 0])
graph = Graph.new(board: board, piece: knight)
origin = [0, 0]
target = [1, 1]

path = graph.find_shortest_path(origin: origin, target: target)

puts "Knight can get from #{origin} to #{target} in #{path.count - 1} moves."
path.each { |step| print "#{step} " }
puts

# Knight can get from [0, 0] to [1, 1] in 4 moves.
# [0, 0] [2, 1] [4, 2] [3, 0] [1, 1] 