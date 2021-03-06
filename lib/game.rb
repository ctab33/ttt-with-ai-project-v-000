class Game
  attr_accessor :board, :player_1, :player_2

  WIN_COMBINATIONS = [
 [0, 1, 2],
 [3, 4, 5],
 [6, 7, 8],
 [0, 3, 6],
 [1, 4, 7],
 [2, 5, 8],
 [2, 4, 6],
 [0, 4, 8]
]
  def initialize(player_1 = Players::Human.new("X"), player_2 = Players::Human.new("O"), board = Board.new)
    @player_1 = player_1
    @player_2 = player_2
    @board = board
  end

  def board
    @board
  end

  def current_player
    @board.turn_count % 2 == 0 ? @player_1 : @player_2
  end

  def over?
    won? || draw?
  end

  def won?
  WIN_COMBINATIONS.detect do |win_combination|

    win_index_1 = win_combination[0]
    win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]


    position_1 = @board.cells[win_index_1]
    position_2 = @board.cells[win_index_2]
    position_3 = @board.cells[win_index_3]

    position_1 == "X" && position_2 == "X" && position_3 == "X" ||
    position_1 == "O" && position_2 == "O" && position_3 == "O"
  end
end

  def draw?
    !won? && @board.full?
  end

  def winner
    if winning_positions = won? # winning_positions = return value of won?(board), which is an array or nil/false
      @board.cells[winning_positions[0]]
    end
  end

  def input_to_index(user_input)
    indexInput = user_input.to_i
    indexInput - 1
  end

  # def turn
  #   input = current_player.move(board)
  #   if !@board.valid_move?(input)
  #     turn
  #   end
  #   @board.update(input, current_player)
  #   @board.display
  # end

  def turn
    input = current_player.move(board)
    if board.valid_move?(input)
      board.update(input, current_player)
      board.display
    else
      board.display
      turn
    end
  end


  def play
    while !over?
      turn
    end

    if won?
      puts "Congratulations #{winner}!"
    else draw?
      puts "Cat's Game!"
    end
  end

end
