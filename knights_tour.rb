require_relative 'lib/board'
require_relative 'lib/knight'
require_relative 'lib/graph'
require_relative 'lib/display'

system "clear"
puts "Welcome to Knight's Tour."
puts "This program tries to find a unique path around the chessboard."
print "Enter the board size > "
size = gets.chomp.to_i

print "Enter the starting position (ex: 0,0) > "
start_pos = gets.chomp.split(',').map &:to_i

board = Board.new(size: size)
knight = Knight.new(board: board, start_pos: start_pos )
graph = Graph.new(board: board, piece: knight)

# Warning: This could take a long time!
result = graph.tour do |path|
  display = Display.new(board: board, path: path)
  display.show
  sleep 0.5
end

puts
puts "The final path is: "
puts result[:path].inspect
puts
puts "I had to backtrack #{result[:failed_paths].count} times to get it."


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
