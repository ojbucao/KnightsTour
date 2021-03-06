require_relative 'node'

class Board
  attr_reader :locations, :size

  def initialize(size: 8)
    @size = size
    @locations = size.times.flat_map do |n|
      size.times.map { |m| [n,m] }
    end
  end

  def include?(location)
    if location.is_a? Node
      locations.include? location.location
    else
      locations.include? location
    end
  end
end
