require 'display'

describe 'Display' do 
  it 'outputs a chessboard' do
    b = Board.new(size: 5)
    k = Knight.new(board: b, start_pos: [0, 0])
    g = Graph.new(board: b, piece: k)
    g.tour do |p|
      d = Display.new(board: b, path: p)
      d.show
      sleep 0.5
    end
  end

end