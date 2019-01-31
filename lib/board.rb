

class Board
  attr_reader :cells

  def initialize
    keys = ["A1", "A2", "A3", "A4", "B1", "B2", "B3", "B4", "C1", "C2", "C3", "C4", "D1", "D2", "D3", "D4"]
    @cells = {}
    keys.map { |cell| @cells[cell] = Cell.new(cell)}
  end

  def valid_coordinate?(cell)
    @cells.keys.include?(cell)
  end

  def valid_placement?(ship, placement)

    letters = letters_from_placement(placement)
    numbers = numbers_from_placement(placement)

    verify_ship_length(ship, placement) && assert_correct_ship_placement(letters, numbers)
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
end
