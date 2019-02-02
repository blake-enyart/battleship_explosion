# require './lib/turn'

class Setup

  attr_accessor :board_comp,
              :board_player

  def initialize()
    @board_comp = Board.new
    @board_player = Board.new
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
    computer_sets_up_ships
    player_sets_up_ships
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
    puts @board_player.render(true)
    puts "Enter the squares for the Cruiser with a space
    between each cell and press enter (3 spaces):"
    cruiser_place = ["A1", "A2", "A3"]
    # cruiser_place = gets.chomp.upcase.split(" ").to_a

    player_place_ship_on_board("Cruiser", 3, cruiser_place)
    puts @board_player.render(true)
    puts "Enter the squares for the Submarine with a space
    between each cell and press enter (2 spaces):"
    submarine_place = ["B1", "B2"]
    # submarine_place = gets.chomp.upcase.split(" ").to_a

    player_place_ship_on_board("Submarine", 2, submarine_place)
  end

  def player_place_ship_on_board(name, length, placement)
    ship = Ship.new(name, length)
    while !@board_player.valid_placement?(ship, placement)
      binding.pry
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
    while @board_comp.render(true).include?('S')
      if !@board_player.render(true).include?('S')
        break
      end
      player_turn

      computer_turn
      puts
      puts
      render_board
      puts
      shot = @board_comp.cells[@player_shot].render
      if shot.include?('H')
        puts "Your shot on #{@player_shot} was a hit!"
      elsif shot.include?('X')
        puts "You sank my #{@board_comp.cells[@player_shot].ship.name}!"
      else
        puts "Your shot on #{@player_shot} was a miss"
      end

      shot = @board_player.cells[@comp_shot].render
      if  shot.include?('H')
        puts "My shot on #{@comp_shot} was a hit!"
      elsif shot.include?('X')
        puts "My shot sank your #{board_player.cells[@comp_shot].ship.name}!"
      else
        puts "My shot on #{@comp_shot} was a miss"
      end
      puts
      puts
    end
  end

  def computer_turn
    @comp_shot = @board_comp.keys.sample(1)[0]
    while @board_player.cells[@comp_shot].fired_upon?
      @comp_shot = @board_comp.keys.sample(1)[0]
    end

    @board_player.cells[@comp_shot].fire_upon
  end

  def player_turn
    puts "Enter the coordinate for your shot:"
    @player_shot = gets.chomp.upcase
    while !@board_comp.cells.keys.include?(@player_shot)
      puts "Please enter a valid coordinate:"
      @player_shot = gets.chomp.upcase
    end
    @board_comp.cells[@player_shot].fire_upon
  end


  def render_board
    puts "="*10 + "COMPUTER BOARD" + "="*10
    puts @board_comp.render(true)
    puts "="*10 + "PLAYER BOARD" + "="*10
    puts @board_player.render(true)
  end

end
