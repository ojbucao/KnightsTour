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