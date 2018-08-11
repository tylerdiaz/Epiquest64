require_relative 'util/data_controller'

class DataController
  include DataController_model
end

module Controller
  def initialize(game_data)
    @game_data = game_data
    @data_controller = DataController.new
  end
  def get(prop)
    return @game_data[prop]
  end
  def set(prop, value)
    @game_data[prop] = value
  end
  def addTime(seconds = 0) # Changes from real life seconds to game hours / days
    # 8.64 seconds in a day
    # 1 second in game time is 0.0001
    # 1 real second is 70% times faster in game

    seconds_in_day = 86400
    game_time_factor = 0.00017 #0.0001 (1 game sec) * 1.7 (70%)
    seconds_in_game_day = seconds_in_day * game_time_factor

    game_seconds = (seconds * game_time_factor) # Game seconds are %70 faster
    days_passed = (game_seconds * seconds_in_game_day).floor

    @game_data['time'] += game_seconds % seconds_in_game_day
    @game_data['days'] = (@game_data['time'] / 24).floor
  end
  def timeOfDay
    time = @game_data['time']
    case
    when time >= 23 && time <= 1 # 10PM - 1AM
      return 'midnight'
    when time >= 1 && time <= 11 # 1AM - 11AM
      return 'morning'
    when time >= 11 && time <= 13 # 11AM - 1PM
      return 'midday'
    when time >= 13 && time <= 18 # 1PM - 6PM
      return 'afternoon'
    when time >= 18 && time <= 23 # 6PM - 10PM
      return 'night'
    end
  end
  def addToInventory(item)
    if (item['type'] === '_money')
      @game_data['user'].money += item.price
    else
      @game_data['user'].inventory << item
    end
  end
  def data_findOne(q)
    return @data_controller.findOne(q)
  end
  def data_findById(id)
    return @data_controller.findById(id)
  end
  def data_find(q)
    return @data_controller.find(q)
  end
end