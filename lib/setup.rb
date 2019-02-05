class Setup

  attr_accessor :board_comp,
                :board_player

  def initialize()
    @board_comp = Board.new
    @board_player = Board.new
  end

  def start_game
    puts
    puts "Welcome to BATTLESHIP!!!"
    puts "Enter p to play. Enter q to quit."
    input = gets.chomp.downcase
    if input == "p"
      setup_board
      take_turn
      repeat_game
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
      computer_evaluates_player_shot(shot)

      shot = @board_player.cells[@comp_shot].render
      computer_evaluates_own_shot(shot)

      puts
      puts
    end

    end_game
    puts
  end

  def computer_turn
    @comp_shot = @board_comp.keys.sample(1)[0]
    if @board_player.render(true).include?('H')
      smart_shot
    end

    while @board_player.cells[@comp_shot].fired_upon?
      @comp_shot = @board_comp.keys.sample(1)[0]
    end

    @board_player.cells[@comp_shot].fire_upon
  end

  def smart_shot()
    previous_shots = []

    if @board_player.render(true).count('H') == 1
      @board_player.cells.each do |cell, cell_object|
        if cell_object.render(true) == 'H'
          previous_shots << cell
        end
      end
      letters = @board_player.letters_from_placement(previous_shots)
      numbers = @board_player.numbers_from_placement(previous_shots)

      possible_shots = [((letters[0].ord)+1).chr.to_s + numbers[0],
                      ((letters[0].ord)-1).chr.to_s + numbers[0],
                      letters[0]+((numbers[0].ord)+1).chr.to_s,
                      letters[0]+((numbers[0].ord)-1).chr.to_s]
      possible_shots.keep_if { |shot| @board_player.cells.keys.include?(shot) }

    elsif @board_player.render(true).count('H') > 1
      @board_player.cells.each do |cell, cell_object|
        if cell_object.render(true) == 'H'
          previous_shots << cell
        end
      end

      letters = @board_player.letters_from_placement(previous_shots)
      numbers = @board_player.numbers_from_placement(previous_shots)

      if letters.uniq == 1
        possible_shots = [letters[0]+((numbers[0].ord)+1).chr.to_s,
                        letters[0]+((numbers[0].ord)-1).chr.to_s]
      elsif numbers.uniq == 1
        possible_shots = [((letters[0].ord)+1).chr.to_s + numbers[0],
                        ((letters[0].ord)-1).chr.to_s + numbers[0]]
      end
    end
    @comp_shot = possible_shots.sample(1)[0]
    @board_player.cells[@comp_shot].fire_upon
    binding.pry
  end




  def player_turn
    puts "Enter the coordinate for your shot:"
    @player_shot = gets.chomp.upcase

    while !@board_comp.cells.keys.include?(@player_shot) ||
      @board_comp.cells[@player_shot].fired_upon?
      puts "The coordinate you entered has been fired upon or is invalid. Please enter a valid coordinate:"
      @player_shot = gets.chomp.upcase
    end

    @board_comp.cells[@player_shot].fire_upon
  end

  def computer_evaluates_player_shot(shot)
    if shot.include?('H')
      puts "Your shot on #{@player_shot} was a hit!"
    elsif shot.include?('X')
      puts "You sank my #{@board_comp.cells[@player_shot].ship.name}!"
    else
      puts "Your shot on #{@player_shot} was a miss"
    end
  end

  def computer_evaluates_own_shot(shot)
    if  shot.include?('H')
      puts "My shot on #{@comp_shot} was a hit!"
    elsif shot.include?('X')
      puts "My shot sank your #{board_player.cells[@comp_shot].ship.name}!"
    else
      puts "My shot on #{@comp_shot} was a miss"
    end
  end

  def end_game
    if @board_comp.render(true).include?('S')
      puts "I sank your ships! You lose!"
    else
      puts "You sank my ships! You win!"
    end
  end

  def render_board
    puts "="*10 + "COMPUTER BOARD" + "="*10
    puts @board_comp.render(true)
    puts "="*10 + "PLAYER BOARD" + "="*10
    puts @board_player.render(true)
  end

  def repeat_game
    puts "Would you like to play again?"
    puts "Enter p to play. Enter q to quit."
    input = gets.chomp.downcase
    if input == "p"
      @board_comp = Board.new
      @board_player = Board.new
      setup_board
      take_turn
      repeat_game
    elsif input == "q"
      return
    end
  end
end
