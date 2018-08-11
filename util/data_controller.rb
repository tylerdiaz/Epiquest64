require 'json'

module DataController_model
  def initialize
    data = File.read(__dir__ + '/../data/data.json')
    @data = JSON.parse(data)
  end

  def findById(id)
    @data.each do |key, value|
      if key === id
        return value
      end
    end

    return {}
  end

  def findOne(q)
    @data.each do |id, data|
      match = false
      q.keys.each do |key| # For each key in query
        if data[key] == q[key] # If the query[key] is == to the data[key]
          match = true
        else
          match = false
          break
        end
      end
      if match
        return data
      end
    end

    return {}
  end

  def find(q)
    results = {}

    @data.each do |id, data|
      match = false
      q.keys.each do |key| # For each key in query
        if data[key] == q[key] # If the query[key] is == to the data[key]
          match = true
        else
          match = false
          break
        end
      end
      if match
        results[id] = data
      end
    end

    return results
  end
end