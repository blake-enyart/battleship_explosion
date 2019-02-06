class Player

  attr_reader :board,
              :hit_history

  def initialize()
    @board = Board.new
    @hit_history = []
  end

  def new_board
    @board = Board.new
  end

  def player_sets_up_ships
    puts "I have laid out my ships on the grid."
    puts "You now need to lay out your two ships."
    puts "The Cruiser is two units long and the Submarine is three units long."
    puts @board.render(true)
    puts "Enter the squares for the Cruiser with a space
    between each cell and press enter (3 spaces):"
    # cruiser_place = gets.chomp.upcase.split(" ").to_a
    cruiser_place = ["A1", "A2", "A3"]
    cruiser = Ship.new("Cruiser", 3)

    player_place_ship_on_board(cruiser, cruiser_place)
    puts @board.render(true)
    puts "Enter the squares for the Submarine with a space
    between each cell and press enter (2 spaces):"
    # submarine_place = gets.chomp.upcase.split(" ").to_a
    submarine_place = ["B1", "B2"]
    submarine = Ship.new("Submarine", 2)

    player_place_ship_on_board(submarine, submarine_place)
  end

  def player_place_ship_on_board(ship, placement)
    while !@board.valid_placement?(ship, placement)
      puts "Those are invalid coordinates. Please try again:"
      placement = gets.chomp.upcase.split(" ").to_a
    end
      @board.place(ship, placement)
  end

  def player_turn(computer_board)
    puts "Enter the coordinate for your shot:"
    shot = gets.chomp.upcase

    while !computer_board.cells.keys.include?(shot) ||
    computer_board.cells[shot].fired_upon?
      if computer_board.cells[shot].fired_upon?
        puts "The coordinate you entered has been fired upon already. Please enter a valid coordinate:"
        shot = gets.chomp.upcase
      elsif !computer_board.cells.keys.include?(shot)
        puts "The coordinate you entered is not on the board. Please enter a valid coordinate:"
        shot = gets.chomp.upcase
      end
    end

    computer_board.cells[shot].fire_upon
    @hit_history << [shot, computer_board.cells[shot].render]
  end

  def computer_sets_up_ships
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)

    comp_place_ship_on_board(cruiser)
    comp_place_ship_on_board(submarine)
  end

  def comp_place_ship_on_board(ship)
    placement = []
    while !@board.valid_placement?(ship, placement)
      placement = @board.keys.sample(ship.length)
    end
    @board.place(ship, placement)
  end

  def mock_set_up_ships
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)

    cruiser_place = ['A1','A2','A3']
    sub_place = ['C1','C2']

    mock_place_ship_on_board(cruiser, cruiser_place)
    mock_place_ship_on_board(submarine, sub_place)
  end

  def mock_place_ship_on_board(ship, placement)
    @board.place(ship, placement)
  end

  def computer_turn(player)
    if @hit_history.length == 1 && @hit_history[-1][1] != 'X'
      smart_shot(player)
    end

    shot = @board.cells.keys.sample(1)[0]
    while player.board.cells[shot].fired_upon?
      shot = @board.keys.sample(1)[0]
    end

    player.board.cells[shot].fire_upon

    if ['X','H'].include?(player.board.cells[shot].render)
      @hit_history << [shot, player.board.cells[shot].render]
    end
  end

  def smart_shot(player)
    last_hit = @hit_history[-1][0]
    hit_column = last_hit[1]
    hit_row = last_hit[0]
    possible_shots = [hit_row+(hit_column.ord-1).chr.to_s,
                      hit_row+(hit_column.ord+1).chr.to_s,
                      (hit_row.ord-1).chr.to_s+hit_column,
                      (hit_row.ord+1).chr.to_s+hit_column]

    possible_shots.keep_if { |shot| @board.cells.key?(shot) }

    shot = possible_shots.sample(1)[0]
    player.board.cells[shot].fire_upon

    if ['X','H'].include?(player.board.cells[shot].render)
      @hit_history << [shot, player.board.cells[shot].render]
    end
    shot
  end
end
