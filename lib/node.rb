class Node
  attr_accessor :location, :neighbors

  def initialize(location:)
    @location = location
    @neighbors = []
  end
end
