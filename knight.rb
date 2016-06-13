require_relative 'board'
require_relative 'graph'

class Knight
  @@MOVEMENTS = [[-2,-1],[-2,1],[-1,-2],[-1,2],[1,-2],[1,2],[2,-1],[2,1]]

  attr_accessor :current_location

  def initialize(board:)
    @board = board
    @graph = Graph.new(board: @board, piece: self)
  end

  def possible_moves
    moves = @@MOVEMENTS.map do |move|
              [@current_location[0] + move[0], @current_location[1] + move[1]]
            end

    in_board_moves(moves)
  end

  def in_board_moves(moves)
    moves.select do |move|
      @board.locations.include?(move)
    end
  end

  def shortest_path_between(origin, target)
    origin_node = @graph.find_node(origin)
    target_node = @graph.find_node(target)
    @graph.find_shortest_path(origin_node, target_node)
  end
end

# knows current location
# knows valid moves
# knows it's own graph