require_relative 'board'
require_relative 'knight'

board = Board.new
knight = Knight.new(board: board)

origin = [0, 0]
target = [1, 1]
path = knight.get_shortest_path_between(origin, target)

puts "Knight can get from #{origin} to #{target} in #{path.count - 1} moves."
path.each { |step| print "#{step} " }
puts

# Knight can get from [0, 0] to [1, 1] in 4 moves.
# [0, 0] [2, 1] [4, 2] [3, 0] [1, 1] 
