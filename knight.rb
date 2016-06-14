require_relative 'board'
require_relative 'graph'

class Knight
  @@MOVEMENTS = [[-2,-1],[-2,1],[-1,-2],[-1,2],[1,-2],[1,2],[2,-1],[2,1]]

  attr_accessor :current_location
  attr_reader :graph, :board, :start_pos

  def initialize(board:, start_pos: [0,3])
    @board = board
    @start_pos = start_pos
    @graph = Graph.new(board: @board, piece: self)
    @current_location = start_pos
  end

  def get_possible_moves
    moves = @@MOVEMENTS.map do |move|
              [@current_location[0] + move[0], @current_location[1] + move[1]]
            end

    in_board_moves(moves)
  end

  def get_shortest_path_between(origin, target)
    origin_node = @graph.find_node(origin)
    target_node = @graph.find_node(target)
    @graph.find_shortest_path(origin_node, target_node)
  end

  private

  def in_board_moves(moves)
    moves.select do |move|
      @board.include?(move)
    end
  end
  
end