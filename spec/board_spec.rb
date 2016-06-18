require 'spec_helper'
require_relative '../lib/board'

describe Board do
  describe '#initialize' do
    context 'when not given a parameter' do
      it 'creates a board with default size 8' do
        board = Board.new
        size = 64
        expect(board.locations.size).to eq(size)
      end
    end

    context 'when given a parameter' do
      it 'creates a board the size of the input parameter' do
        board = Board.new(size: 4)
        size = 16
        expect(board.locations.size).to eq(size)
      end
    end
  end

  describe '#include?' do
    let(:board) { Board.new(size: 4) }

    it 'takes a coordinate (array) and returns true or false' do
      expect(board).to include([1,1])
      expect(board).not_to include([6,6])
    end

    it 'takes a Node and returns true or false' do
      inside_node = Node.new(location: [1,1])
      outside_node = Node.new(location: [6,6])
      expect(board).to include(inside_node)
      expect(board).not_to include(outside_node)
    end
  end

end