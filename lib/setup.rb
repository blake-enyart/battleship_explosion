require './lib/turn'

class Setup

  def initialize()
    start_game
    @board_comp
    @board_player
  end

  def start_game
    puts "Welcome to BATTLESHIP!!!"
    puts "Enter p to play. Enter q to quit."
    input = gets.chomp.downcase
    if input == "p"
      setup_board
    elsif input == "q"
      return
    end
  end

  def setup_board
    @board_comp = Board.new

    comp_place_ship_on_board("Submarine", 2)

    comp_place_ship_on_board("Cruiser", 3)

    player_place_ships

    turn = Turn.new

    turn.initiate_game(@board_comp, @board_player)
  end

  def comp_place_ship_on_board(name, length)
    ship = Ship.new(name, length)
    placement = @board_comp.keys.sample(ship.length)
    while @board_comp.valid_placement?(ship, placement) == false
      placement = @board_comp.keys.sample(ship.length)
      if @board_comp.valid_placement?(ship, placement)
        @board_comp.place(ship, placement)
      end
    end
  end

  def player_place_ships
    puts "I have laid out my ships on the grid."
    puts "You now need to lay out your two ships."
    puts "The Cruiser is two units long and the Submarine is three units long."
    @board_player = Board.new
    puts @board_player.render
    puts "Enter the squares for the Cruiser with a space
    between each cell and press enter (3 spaces):"
    cruiser_place = gets.chomp.upcase.split(" ").to_a

    player_place_ship_on_board("Cruiser", 3, cruiser_place)

    puts "Enter the squares for the Submarine with a space
    between each cell and press enter (2 spaces):"
    submarine_place = gets.chomp.upcase.split(" ").to_a

    player_place_ship_on_board("Submarine", 2, submarine_place)
  end

  def player_place_ship_on_board(name, length, placement)
    ship = Ship.new(name, length)
    while @board_player.valid_placement?(ship, placement) == false
      puts "Those are invalid coordinates. Please try again:"
      placement = gets.chomp.upcase.split(" ").to_a
      if @board_player.valid_placement?(ship, placement)
        @board_player.place(ship, placement)
      end
    end

    if @board_player.valid_placement?(ship, placement)
      @board_player.place(ship, placement)
    end
  end
end
