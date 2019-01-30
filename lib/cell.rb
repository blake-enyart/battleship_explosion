class Cell

  attr_reader :coordinate,
              :ship

  def initialize(coordinate)
    @coordinate = coordinate
  end

  def empty?
    ship.class != Ship
  end

  def place_ship(ship)
    @ship = ship
  end

  def fired_upon?
     ship.health != ship.length
  end

  def fire_upon
    if ship.class == Ship
      return ship.hit
    end
    true
  end

  def render(argument=false)
    state = [".","M","S","H","X"]
    if ship = nil
      state[0]
    elsif (ship == nil) && fire_upon
      state[1]
    elsif (ship.class == Ship)
      state[2]
    elsif (ship.class == Ship) && fire_upon
      state[3]
    else
      "X"
    end
  end
end
