class Cell

  attr_reader :coordinate,
              :ship

  def initialize(coordinate)
    @coordinate = coordinate
    @ship = nil
  end

  def empty?
    return @ship.class != Ship
  end

  def place_ship(ship)
    return @ship = ship
  end

  def fired_upon?
    return @ship.health != @ship.length
  end

  def fire_upon
    return @ship.hit
  end
end
