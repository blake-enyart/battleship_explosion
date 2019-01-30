class Cell

  attr_reader :coordinate,
              :ship

  def initialize(coordinate)
    @coordinate = coordinate
    @fired = false
  end

  def empty?
    ship.class != Ship
  end

  def place_ship(ship)
    @ship = ship
  end

  def fired_upon?
    @fired
  end

  def fire_upon
    ship.hit if ship.class == Ship
    @fired = true
  end

  def render(show=false)
    if fired_upon?
      if ship
        "H"
      elsif !ship
        "M"
      elsif sunk?
        "X"
      end
    elsif show
      if ship
        "S"
      else
        "."
      end
    else
      "."
    end
  end
end
