require_relative 'piece'

class Knight < Piece

  offsets = [-2, -1, 1, 2]

  MOVEMENTS = offsets.permutation.to_a(2).reject { |x| x[0].abs == x[1].abs }.sort

end