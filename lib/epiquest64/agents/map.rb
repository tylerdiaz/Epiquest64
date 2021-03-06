require_relative '../locations/start'
require_relative '../locations/city'
require_relative '../locations/beach'

class Location
  ## LOCATION CLASS
  # A location can be `enter`ed
  # When entered, we can expect the location to return the id of another location
  # All location values are unique

  def initialize(controller)
    @controller = controller
  end
  def enter
    puts "THIS LOCATION's ENTER METHOD HAS NOT BEEN CONFIGURED YET"
    exit(1)
  end
  def id
    puts "THIS LOCATION's ID HAS NOT BEEN CONFIGURED YET"
    exit(1)
  end
end

# ALL LOCATION MODELS MUST BE STATED TO BE CHILDREN OF "LOCATION"
class Start < Location
  include StartModel
end

class City < Location
  include CityModel
end

class CityMarket < Location
  include CityMarketModel
end

class CityMarketFishing < Location
  include CityMarketFishingModel
end

class CityMarketFishingShop < Location
  include CityMarketFishingShopModel
end

class Beach < Location
  include BeachModel
end

class BeachFish < Location
  include BeachFishModel
end

class BeachDocks < Location
  include BeachDocksModel
end

class Finish < Location
  def enter()
    @controller.at('console').display("Game ends here")
    exit(0)
  end

  def id
    return '_FINISH'
  end
end

class Map
  ## MAP MODULE
  # The map will contain a hash, making it possible to access locations from the engine
  # e.g:
  # map.enter('_START') # Will call the .enter method of a location
  # map.locations('_START') # will return an instance of the Start location

  def initialize(controller)
    @@locations = {
      '_START' => Start.new(controller),
      '_CITY' => City.new(controller),
        '_CITY_MARKET' => CityMarket.new(controller),
          '_CITY_MARKET_FISH' => CityMarketFishing.new(controller),
            '_CITY_MARKET_FISH_SHOP' => CityMarketFishingShop.new(controller),
      '_BEACH' => Beach.new(controller),
        '_BEACH_FISH' => BeachFish.new(controller),
        '_BEACH_DOCKS' => BeachDocks.new(controller),
      '_FINISH' => Finish.new(controller)
    }
  end

  def enter(id)
    @@locations[id].enter
  end

  def locations(id)
    return @@locations[id] || @@locations['_CITY']
  end
end
