require_relative 'board'

class Piece
  move_mappings = {}

  attr_accessor :current_location
  attr_reader :start_pos

  def self.define_movements(move_mappings)
    move_mappings.each do |name, offsets|
      define_singleton_method(name) do |upper_limit|
        range = (1..upper_limit)
        moves = range.map { |x| eval(offsets[0]) } + range.map { |x| eval(offsets[1]) }
        moves.sort
      end
    end
  end

  def initialize(board:, start_pos: [0,0])
    @board = board
    @start_pos = start_pos
    @current_location = start_pos
  end

  def get_possible_moves
    moves = self.class::MOVEMENTS.map do |move|
              [@current_location[0] + move[0], @current_location[1] + move[1]]
            end

    in_board_moves(moves).sort
  end

  private

  def in_board_moves(moves)
    moves.select do |move|
      @board.include?(move)
    end
  end

end