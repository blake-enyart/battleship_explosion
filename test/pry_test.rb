pry(main)> require './lib/ship'
#=> true

pry(main)> cruiser = Ship.new("Cruiser", 3)
#=> #<Ship:0x00007feb05112d10...>

pry(main)> cruiser.name
#=> "Cruiser"

pry(main)> cruiser.length
#=> 3

pry(main)> cruiser.health
#=> 3

pry(main)> cruiser.sunk?
#=> false

pry(main)> cruiser.hit

pry(main)> cruiser.health
#=> 2

pry(main)> cruiser.hit

pry(main)> cruiser.health
#=> 1

pry(main)> cruiser.sunk?
#=> false

pry(main)> cruiser.hit

pry(main)> cruiser.sunk?
#=> true
