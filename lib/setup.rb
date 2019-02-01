class Setup

  def initialize()
    start_game
    @board
  end

  def start_game
    puts "Welcome to BATTLESHIP!!!"
    puts "Enter p to play. Enter q to quit."
    input = gets.chomp.downcase
    if input == "p"
      comp_place_ship
    elsif input == "q"
      return
    end
  end

  def comp_place_ship
    @board = Board.new

    place_ship_on_board("Submarine", 2)

    place_ship_on_board("Cruiser", 3)
    
  end

  def place_ship_on_board(name, length)
    ship = Ship.new(name, length)
    placement = @board.keys.sample(ship.length)
    while @board.valid_placement?(ship, placement) == false
      placement = @board.keys.sample(ship.length)
      if @board.valid_placement?(ship, placement)
        @board.place(ship, placement)
      end
    end
  end
end
