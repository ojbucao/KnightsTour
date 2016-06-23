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
puts