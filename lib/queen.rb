require_relative 'piece'

class Queen < Piece
  
  move_mappings = { up_diagonals:   ['[-x, x]', '[x, x]'],
                    down_diagonals: ['[-x,-x]', '[x,-x]'],
                    horizontals:    ['[-x, 0]', '[x, 0]'],
                    verticals:      ['[0, -x]', '[0, x]'] }

  define_movements(move_mappings)

  MOVEMENTS = up_diagonals(8) + down_diagonals(8) + horizontals(8) + verticals(8)

end