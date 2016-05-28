class Player

  attr_accessor :name 
  attr_accessor :lives
  attr_accessor :points

  def initialize(name)
    @name = name
    @lives = 3
    @points = 0
  end

  def gain_a_point()
    @points +=1
  end

  def lose_a_life()
    @lives -= 1
  end

end
