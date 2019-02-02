class Turn

  def initialize(computer_board, player_board)
    @computer_board = computer_board
    @player_board = player_board
    @comp_shot = nil
    @player_shot = nil
  end

  def initiate_game
    puts "="*10 + "COMPUTER BOARD" + "="*10
    puts @computer_board.render
    puts "="*10 + "PLAYER BOARD" + "="*10
    puts @player_board.render(true)
    take_turn
  end

  def take_turn
    while true # @computer_board.render(true).include?('S')
      player_turn

      computer_turn
      puts
      puts
      render_board
      puts
      shot = @computer_board.cells[@player_shot].render
      if shot.include?('X') || shot.include?('H')
        puts "Your shot on #{@player_shot} was a hit!"
      else
        puts "Your shot on #{@player_shot} was a miss"
      end

      shot = @player_board.cells[@comp_shot].render
      if shot.include?('X') || shot.include?('H')
        puts "My shot on #{@comp_shot} was a hit!"
      else
        puts "My shot on #{@comp_shot} was a miss"
      end
      puts
      puts
    end
  end

  def computer_turn
    @comp_shot = @computer_board.keys.sample(1)[0]
    @player_board.cells[@comp_shot].fire_upon
  end

  def player_turn
    puts "Enter the coordinate for your shot:"
    @player_shot = gets.chomp.upcase
    while !@computer_board.cells.keys.include?(@player_shot)
      puts "Please enter a valid coordinate:"
      @player_shot = gets.chomp.upcase
    end
    @computer_board.cells[@player_shot].fire_upon
  end


  def render_board
    puts "="*10 + "COMPUTER BOARD" + "="*10
    puts @computer_board.render
    puts "="*10 + "PLAYER BOARD" + "="*10
    puts @player_board.render(true)
  end
end
