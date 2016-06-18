require_relative 'lib/board'
require_relative 'lib/knight'
require_relative 'lib/graph'

board = Board.new(size: 8)
knight = Knight.new(board: board, start_pos: [0, 0])
graph = Graph.new(board: board, piece: knight)

# Warning: This could take a long time!
graph.tour do |path|
	system "clear"
	puts path.inspect
	sleep 0.2
	puts
end

# [
#   [0, 0], [2, 1], [4, 0], [6, 1], [7, 3], [6, 5], [7, 7], [5, 6], 
#   [7, 5], [6, 7], [4, 6], [2, 7], [0, 6], [1, 4], [0, 2], [1, 0], 
#   [3, 1], [5, 0], [7, 1], [6, 3], [5, 1], [7, 0], [6, 2], [7, 4], 
#   [6, 6], [4, 7], [2, 6], [0, 7], [1, 5], [0, 3], [1, 1], [3, 0], 
#   [4, 2], [2, 3], [0, 4], [1, 6], [3, 7], [2, 5], [1, 7], [0, 5], 
#   [1, 3], [0, 1], [2, 0], [4, 1], [6, 0], [7, 2], [6, 4], [7, 6], 
#   [5, 7], [3, 6], [5, 5], [3, 4], [2, 2], [4, 3], [3, 5], [5, 4], 
#   [3, 3], [1, 2], [2, 4], [4, 5], [5, 3], [3, 2], [4, 4], [5, 2]
# ]
