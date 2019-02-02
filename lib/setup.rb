require './lib/turn'

class Setup

  attr_accessor :board_comp,
              :board_player

  def initialize()
    @board_comp
    @board_player
  end

  def start_game
    puts "Welcome to BATTLESHIP!!!"
    puts "Enter p to play. Enter q to quit."
    input = gets.chomp.downcase
    if input == "p"
      setup_board
      take_turn
    elsif input == "q"
      return
    end
  end

  def setup_board
    @board_comp = Board.new
    computer_places_ships
    @board_player = Board.new
    player_sets_up_ships
  end

  def take_turn
    turn = Turn.new(@board_comp, @board_player)
    turn.initiate_game
  end

  def computer_places_ships
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)

    comp_place_ship_on_board(cruiser)
    comp_place_ship_on_board(submarine)
  end

  def comp_place_ship_on_board(ship)
    placement = []
    while !@board_comp.valid_placement?(ship, placement)
      placement = @board_comp.keys.sample(ship.length)
      if @board_comp.valid_placement?(ship, placement)
        @board_comp.place(ship, placement)
        break
      end
    end
  end

  def player_sets_up_ships
    puts "I have laid out my ships on the grid."
    puts "You now need to lay out your two ships."
    puts "The Cruiser is two units long and the Submarine is three units long."
    puts @board_player.render
    puts "Enter the squares for the Cruiser with a space
    between each cell and press enter (3 spaces):"
    cruiser_place = ["A1", "A2", "A3"]
    # cruiser_place = gets.chomp.upcase.split(" ").to_a

    player_place_ship_on_board("Cruiser", 3, cruiser_place)

    puts "Enter the squares for the Submarine with a space
    between each cell and press enter (2 spaces):"
    submarine_place = ["B1", "B2"]
    # submarine_place = gets.chomp.upcase.split(" ").to_a

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
  end
end
