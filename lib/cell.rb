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
    ship.hit if !empty?
    @fired = true
  end

  def render(show=false)
    if fired_upon?
      if ship
        if ship.sunk?
          "X"
        else
          "H"
        end
      else
        "M"
      end
    elsif show && ship
        "S"
    else
      "."
    end
  end
end
