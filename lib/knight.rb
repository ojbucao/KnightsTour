require_relative 'board'

class Knight
  @@MOVEMENTS = [[-2,-1],[-2,1],[-1,-2],[-1,2],[1,-2],[1,2],[2,-1],[2,1]]

  attr_accessor :current_location
  attr_reader :graph, :board, :start_pos

  def initialize(board:, start_pos: [0,1])
    @board = board
    @start_pos = start_pos
    @current_location = start_pos
  end

  def get_possible_moves
    moves = @@MOVEMENTS.map do |move|
              [@current_location[0] + move[0], @current_location[1] + move[1]]
            end

    in_board_moves(moves)
  end

  private

  def in_board_moves(moves)
    moves.select do |move|
      @board.include?(move)
    end
  end

end