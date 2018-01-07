class Game

  attr_reader :board

  def initialize
    @board = Array.new(3) { Array.new(3, " ") }
    @player = 'X'
    @all_pieces_placed = :false
  end

  def start
    puts "START THE GAME"
    print_board
    puts "Enter your move:"
    get_player_positioning
  end

  def print_board
    @board[0..1].each do |row|
      puts row.map { |cell| cell == " " ? "o" : cell }.join("-")
      puts '|\|/|'
    end
    puts @board[2].map{ |cell| cell == " " ? "o" : cell }.join("-")
  end

  def get_player_positioning(move = gets.chomp)
    place_piece(move)
  end

  def get_player_move(moves = gets.chomp)
    initial_position, new_position = moves.split(',')
    move_piece(initial_position, new_position)
  end

  def move_piece(initial_position, new_position)
    x, y = convert_move_to_coordinate(new_position)
    @board[y][x] = @player
    x, y = convert_move_to_coordinate(initial_position)
    @board[y][x] = ' '
    update_game
  end

  def place_piece(move)
    x, y = convert_move_to_coordinate(move)
    @board[y][x] = @player
    update_game
  end

  def update_game
    check_if_initial_moves_complete
    print_board
    puts "Enter your move:"
    p @all_pieces_placed
    p @board
    @all_pieces_placed == :false ? get_player_positioning : get_player_move
  end

  def check_if_initial_moves_complete
    @all_pieces_placed = :true if @board.flatten.count('X') == 3
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

end

game = Game.new
game.start
