require_relative 'lib/board'
require_relative 'lib/knight'
require_relative 'lib/graph'
require_relative 'lib/display'

system "clear"
puts "Welcome to Knight's Sprint."
puts "This program finds the shortest path between 2 squares."
print "Enter the board size > "
size = gets.chomp.to_i

print "Enter the starting position (ex: 0,0) > "
origin = gets.chomp.split(',').map &:to_i

print "Enter the target position (ex: 7,7) > "
target = gets.chomp.split(',').map &:to_i

board = Board.new(size: size)
knight = Knight.new(board: board, start_pos: [0, 0])
graph = Graph.new(board: board, piece: knight)

path = graph.find_shortest_path(origin: origin, target: target)

(0..(path.size - 1)).each do |x|
  p = path[0..x]
  display = Display.new(board: board, path: p)
  display.show
  sleep 1
end

puts
puts "Knight can get from #{origin} to #{target} in #{path.count - 1} moves."
puts

# Knight can get from [0, 0] to [1, 1] in 4 moves.
# [0, 0] [2, 1] [4, 2] [3, 0] [1, 1] 