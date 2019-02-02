class Turn

  def initialize
    @game
  end

  def initiate_game(computer_board, player_board)
    puts "="*10 + "COMPUTER BOARD" + "="*10
    puts computer_board.render
    puts "="*10 + "PLAYER BOARD" + "="*10
    puts player_board.render(true)
  end

end
