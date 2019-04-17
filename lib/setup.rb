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

    while input != 'p' && input != 'q'
      puts 'Invalid entry. Please enter p to play or q to quit.'
      input = gets.chomp.downcase
    end

    if input == "p"
      setup_board
      take_turn
      repeat_game
    else
      return
    end
  end

  def setup_board
    @computer.computer_sets_up_ships
    @player.player_sets_up_ships
    render_board
  end

  def computer_sets_up_ships
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)

    comp_place_ship_on_board(cruiser)
    comp_place_ship_on_board(submarine)
  end

  def comp_place_ship_on_board(ship)
    placement = []
    while !@board_comp.valid_placement?(ship, placement)
      placement = @board_comp.keys.sample(ship.length)
    end
    @board_comp.place(ship, placement)
  end

  def player_sets_up_ships
    puts "I have laid out my ships on the grid."
    puts "You now need to lay out your two ships."
    puts "The Cruiser is two units long and the Submarine is three units long."
    puts @board_player.render(true)
    puts "Enter the squares for the Cruiser with a space
    between each cell and press enter (3 spaces):"
    # cruiser_place = gets.chomp.upcase.split(" ").to_a
    cruiser_place = ["A1", "A2", "A3"]
    player_place_ship_on_board("Cruiser", 3, cruiser_place)
    puts @board_player.render(true)
    puts "Enter the squares for the Submarine with a space
    between each cell and press enter (2 spaces):"
    # submarine_place = gets.chomp.upcase.split(" ").to_a
    submarine_place = ["B4", "C4"]
    player_place_ship_on_board("Submarine", 2, submarine_place)
  end

  def player_place_ship_on_board(name, length, placement)
    ship = Ship.new(name, length)
    while !@board_player.valid_placement?(ship, placement)
      puts "Those are invalid coordinates. Please try again:"
      placement = gets.chomp.upcase.split(" ").to_a
      if @board_player.valid_placement?(ship, placement)
        @board_player.place(ship, placement)
        break
      end
    end

    if @board_player.valid_placement?(ship, placement)
      @board_player.place(ship, placement)
    end
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
