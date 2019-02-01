

class Board
  attr_reader :cells,
              :keys

  def initialize
    @keys = ["A1", "A2", "A3", "A4", "B1", "B2", "B3", "B4", "C1", "C2", "C3", "C4", "D1", "D2", "D3", "D4"]
    @cells = {}
    @keys.map { |cell| @cells[cell] = Cell.new(cell)}
  end

  def valid_coordinate?(cell)
    @cells.keys.include?(cell)
  end

  def valid_placement?(ship, placement)
    overlap = true
    placement.each do |element|
      if (@cells[element].ship.class == Ship) && (@cells[element].ship != ship)
        overlap = false
      end
    end

    letters = letters_from_placement(placement)
    numbers = numbers_from_placement(placement)

    verify_ship_length(ship, placement) &&
    assert_correct_ship_placement(letters, numbers) &&
    overlap
  end

  def letters_from_placement(placement)
    split_cell = placement.map { |cell| cell.split(//) }.flatten

    split_cell.select { |element| split_cell.index(element).even? }
  end

  def numbers_from_placement(placement)
    split_cell = placement.map { |cell| cell.split(//) }.flatten

    split_cell.select { |element| split_cell.index(element).odd? }
  end

  def verify_ship_length(ship, placement)
    ship.length == placement.length
  end

  def assert_correct_ship_placement(letters, numbers)
    if [*'A'..'Z'].join.include?(letters.join)
      if numbers.join.count(numbers[0]) == numbers.length
        consecutive = true
      else
        consecutive = false
      end

      #need to adjust this to account for fringe cases of more
      #than single digit system
    elsif [*'1'..'9'].join.include?(numbers.join)
      if letters.join.count(letters[0]) == letters.length
        consecutive = true
      else
        consecutive = false
      end
    else
      consecutive = false
    end
    consecutive
  end

  def place(ship, placement)
    placement.each do |cell|
      @cells[cell].place_ship(ship)
    end
  end

  def render(show=false)
    board_layout = "  "
    numbers = numbers_from_placement(@keys).uniq!
    letters = letters_from_placement(@keys).uniq!

    numbers.each { |cell| board_layout << cell + ' ' }
    board_layout << "\n"
    letters.each { |cell|
      board_layout << cell + ' '
      row = @keys.select { |key| key.include?(cell) }
      for key in row do
        board_layout << @cells[key].render(show) + ' '
      end
      board_layout << "\n"
    }
    board_layout
  end
end
