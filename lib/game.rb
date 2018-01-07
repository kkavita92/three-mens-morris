class Game

  def initialize
    @board = Array.new(3) { Array.new(3, " ") }
    @player = 'X'
    @all_pieces_placed = :false
  end

  def start
    puts "START THE GAME"
    print_board
    puts "Enter your move:"
    get_player_move
  end

  def print_board
    @board[0..1].each do |row|
      puts row.map { |cell| cell == " " ? "o" : cell }.join("-")
      puts '|\|/|'
    end
    puts @board[2].map{ |cell| cell == " " ? "o" : cell }.join("-")
  end

  def get_player_move(move = gets.chomp)
    play(move)
  end

  def play(move)
    x, y = convert_move_to_coordinate(move)
    @board[y][x] = @player
    print_board
    puts "Enter your move:"
    get_player_move
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
