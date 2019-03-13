class Robot
  attr_accessor :bearing, :coordinates
  
  CARDINAL_POINTS = {north: [:east, :west, 1, 1],
                     east:  [:south, :north, 1, 0],
                     south: [:west, :east, -1, 1],
                     west:  [:north, :south, -1, 0]}

  def orient(direction)
    raise ArgumentError unless CARDINAL_POINTS.include?(direction)
    @bearing = direction
  end
  
  def at(x, y)
    @coordinates = [x, y]
  end
  
  def advance
    @coordinates[CARDINAL_POINTS[bearing][3]] += CARDINAL_POINTS[bearing][2]
  end
  
  def turn_right
    @bearing = CARDINAL_POINTS[bearing][0]
  end
  
  def turn_left
    @bearing = CARDINAL_POINTS[bearing][1]
  end
end

class Simulator  
  INST_TRANSLATOR = {'L' => :turn_left, 'R' => :turn_right, 'A' => :advance}

  def instructions(str)
    str.chars.map{ |x| INST_TRANSLATOR[x] }
  end
  
  def place(robot, args)
    robot.at(args[:x], args[:y])
    robot.orient(args[:direction])
  end
  
  def evaluate(robot, str)
    instructions(str).each{ |inst| robot.send(inst) }
  end
end