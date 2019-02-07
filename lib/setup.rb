class Setup

  attr_accessor :board_comp,
                :board_player

  def initialize()
    @player = Player.new
    @player_board = @player.board

    @computer = Player.new
    @computer_board = @computer.board
  end

  def start_game
    puts
    puts "Welcome to BATTLESHIP!!!"
    puts "Enter p to play. Enter q to quit."
    input = gets.chomp.downcase
    input = "p"
    if input == "p"
      setup_board
      take_turn
      repeat_game
    elsif input == "q"
      return
    end
  end

  def setup_board
    @computer.computer_sets_up_ships
    @player.player_sets_up_ships
    render_board
  end

  def take_turn
    while @computer_board.render(true).include?('S') &&
    @player_board.render(true).include?('S')
      @player.player_turn(@computer)
      @computer.computer_turn(@player)
      puts
      puts
      render_board
      puts

      shot = @player.shot_history[-1][1].render
      computer_evaluates_player_shot(shot)

      shot = @computer.shot_history[-1][1].render(true)
      computer_evaluates_own_shot(shot)

      puts
      puts
    end

    end_game
    puts
  end

  def computer_evaluates_player_shot(shot)
    if shot.include?('H')
      puts "Your shot on #{@player.shot_history[-1][0]} was a hit!"
    elsif shot.include?('X')
      puts "You sank my #{@computer_board.cells[@player.shot_history[-1][0]].ship.name}!"
    else
      puts "Your shot on #{@player.shot_history[-1][0]} was a miss"
    end
  end

  def computer_evaluates_own_shot(shot)
    if  shot.include?('H')
      puts "My shot on #{@computer.shot_history[-1][0]} was a hit!"
    elsif shot.include?('X')
      puts "My shot sank your #{@player_board.cells[@computer.shot_history[-1][0]].ship.name}!"
    else
      puts "My shot on #{@computer.shot_history[-1][0]} was a miss"
    end
  end

  def end_game
    if @computer_board.render(true).include?('S')
      puts "I sank your ships! You lose!"
    else
      puts "You sank my ships! You win!"
    end
  end

  def render_board
    puts "="*10 + "COMPUTER BOARD" + "="*10
    puts @computer_board.render
    puts "="*10 + "PLAYER BOARD" + "="*10
    puts @player_board.render(true)
  end

  def repeat_game
    puts "Would you like to play again?"
    puts "Enter p to play. Enter q to quit."
    input = gets.chomp.downcase
    if input == "p"
      @computer_board = @computer.new_board
      @player_board = @player.new_board
      setup_board
      take_turn
      repeat_game
    elsif input == "q"
      return
    end
  end
end
