class Rules

  def winning_positions(board)
    horizontal_winning_positions(board) + vertical_winning_positions(board) + diagonal_winning_positions(board)
  end

  def horizontal_winning_positions(board)
    board.map { |row| row[0..2] }
  end

  def vertical_winning_positions(board)
    board.transpose.map { |column| column[0..2] }
  end

  def diagonal_winning_positions(board)
    [
      [board[0][0], board[1][1], board[2][2]],
      [board[0][2], board[1][1], board[2][0]],
    ]
  end

end
