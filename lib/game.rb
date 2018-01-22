class Game

  VALID_MOVES = {
    1 => [2, 4, 5],
    2 => [1, 3, 5],
    3 => [2, 5, 6],
    4 => [1, 5, 7],
    5 => [1, 2, 3, 4, 6, 7, 8, 9],
    6 => [3, 5, 9],
    7 => [4, 5, 8],
    8 => [5, 7, 9],
    9 => [5, 6, 8]
  }

  def initialize
    @board = Array.new(3) { Array.new(3, " ") }
    @player = :B
    @all_black_pieces_placed = :false
    @all_white_pieces_placed = :false
  end

  def start
    puts "START THE GAME"
    print_board
    puts "#{@player}, please enter your move:"
    get_player_positioning
  end

  def print_board
    @board[0..1].each do |row|
      puts row.map { |cell| cell == " " ? "o" : cell }.join("-")
      puts '|\|/|' #fix this
    end
    puts @board[2].map{ |cell| cell == " " ? "o" : cell }.join("-")
  end

  def valid_move?(initial_position, new_position)
      x, y = convert_move_to_coordinate(new_position)
      w, z = convert_move_to_coordinate(initial_position)
      @board[z][w] == @player && @board[y][x] == " " && VALID_MOVES[initial_position.to_i].include?(new_position.to_i)
  end

  def get_player_positioning(move = gets.chomp)
    place_piece(move)
  end

  def get_player_move(moves = gets.chomp)
    initial_position, new_position = moves.split(',')
    return invalidate_move unless valid_move?(initial_position, new_position)
    move_piece(initial_position, new_position)
  end

  def invalidate_move
    puts "Move not valid - please try again"
    get_player_move
  end

  def move_piece(initial_position, new_position)
    x, y = convert_move_to_coordinate(new_position)
    @board[y][x] = @player
    x, y = convert_move_to_coordinate(initial_position)
    @board[y][x] = ' '
    update_game(@player)
  end

  def place_piece(move)
    x, y = convert_move_to_coordinate(move)
    @board[y][x] = @player
    update_game(@player)
  end

  def update_game(last_player)
    if game_over?(last_player)
      return :win
    else
      check_if_initial_moves_complete
      print_board
      switch_player
      puts "#{@player}, please enter your move:"
      if @player == :B
        @all_black_pieces_placed == :false ? get_player_positioning : get_player_move
      else
        @all_white_pieces_placed == :false ? get_player_positioning : get_player_move
      end
    end
  end

  def switch_player
    @player == :B ? @player = :W : @player = :B
  end

  def check_if_initial_moves_complete
    @all_black_pieces_placed = :true if @board.flatten.count(:B) == 3
    @all_white_pieces_placed = :true if @board.flatten.count(:W) == 3
  end

  def convert_move_to_coordinate(move)
  coordinate_mapping = {
      "1" => [0, 0],
      "2" => [1, 0],
      "3" => [2, 0],
      "4" => [0, 1],
      "5" => [1, 1],
      "6" => [2, 1],
      "7" => [0, 2],
      "8" => [1, 2],
      "9" => [2, 2]
    }
    coordinate_mapping[move]
  end

  def game_over?(marker)
    got_winner?(marker)
  end

  def got_winner?(marker)
    winning_positions.each do |position|
      return true if position == [marker, marker, marker]
    end
    false
  end

  def winning_positions
    horizontal_winning_positions + vertical_winning_positions + diagonal_winning_positions
  end

  def horizontal_winning_positions
    @board.map { |row| row[0..2] }
  end

  def vertical_winning_positions
    @board.transpose.map { |column| column[0..2] }
  end

  def diagonal_winning_positions
    [
      [@board[0][0], @board[1][1], @board[2][2]],
      [@board[0][2], @board[1][1], @board[2][0]],
    ]
  end

end

game = Game.new
game.start
