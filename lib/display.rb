class Display

  def initialize(board:, path:)
    @board = board
    @display_board = Array.new(@board.size) { Array.new(@board.size)}
    @path = path
    setup_display_board
  end

  def setup_display_board
    @path.each_with_index do |location, index|
      if index == @path.count - 1
        @display_board[(location[0] - (@board.size - 1)).abs][location[1]] = "\u265E"
      else
        @display_board[(location[0] - (@board.size - 1)).abs][location[1]] = "\u2613"
      end
    end
  end

  def show
    system "clear"
    @display_board.each_with_index do |row, y|
      row.each_with_index do |cell, x|
        bg = "\e[106m"
        bg = "\e[107m" if y % 2 == 0 && x % 2 == 0
        bg = "\e[107m" if y % 2 == 1 && x % 2 == 1
        bf = "\e[30m"

        print "#{bg}#{bf} #{cell ? cell : ' '} "
      end
      print "\e[0m"
      puts
    end
  end

end