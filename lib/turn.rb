class Turn

  def initialize(computer_board, player_board)
    @computer_board = computer_board
    @player_board = player_board
  end

  def initiate_game
    puts "="*10 + "COMPUTER BOARD" + "="*10
    puts @computer_board.render
    puts "="*10 + "PLAYER BOARD" + "="*10
    puts @player_board.render(true)
    take_turn
  end

  def take_turn
    puts "Enter the coordinate for your shot:"
    shot = gets.chomp.upcase
    if @computer_board.cells.keys.include?(shot)
      @computer_board.cells[shot].fire_upon
    end

    computer_turn
  end

  def computer_turn
    

  end
end
