require 'rubygems'
require 'enumerator'
require 'gosu'

class Joint
  attr_accessor :x,:y,:velX,:velY
  def initialize(x,y,velX,velY)
    @x,@y,@velX,@velY = x,y,velX,velY
  end
  def to_s
    "x=#{x} y=#{y} velX=#{velX} velY=#{velY}"
  end
end

class Rope
  UP = Object.new
  DOWN = Object.new
  SEGMENT_LENGTH = 1
  GRAVITY = 0.098
  attr_reader :joints
  def initialize(window,length,startX,startY)
    @window = window
    @joints = []
    @tetherX = startX
    @tetherY = startY
    (0..(length/SEGMENT_LENGTH)).each do |i| 
      x = startX
      y = startY - (SEGMENT_LENGTH * i)
      @joints << Joint.new(x,y,0,0)
    end
  end

  def endX
    @joints.last.x
  end

  def endY
    @joints.last.y
  end
  
  def move(angle)
    #the angle of the kite determines our force vector
    radians = radians(angle)
    force = force_function(radians)
    @joints.last.x += (Math.sin(radians) * force.abs)
    @joints.last.y -= (Math.cos(radians) * force.abs)

    propigate_force(DOWN)
    #make one end of the rope unmoveable
#    @joints.first.x = @tetherX
#@joints.first.y = @tetherY

    ground_check
    propigate_force(UP)
  end
 
  def longer
    @joints = [Joint.new(@tetherX,@tetherY,@tetherX,@tetherY+SEGMENT_LENGTH)].concat(@joints)
  end

  def shorter
    @joints.delete_at(0)
  end
 
  def draw
    @joints.each_cons(2){|segment| @window.draw_line(segment.first.x, segment.first.y, 0xFFFFFFFF, segment.last.x, segment.last.y, 0xFFFFFFFF, z=0, mode=:default)}
  end
 
  def ground_check
    #you can't go below ground.
    @joints.each{|joint| joint.y = @tetherY if (joint.y >= @tetherY)}
  end

  def force_function(radians)
    return 20
  end

  def propigate_force(direction)
    joints = @joints
    joints = @joints.reverse if (direction == DOWN)
    joints.each_cons(2) do |joint_pair|
      i = joint_pair.first.x - joint_pair.last.x
      j = joint_pair.first.y - joint_pair.last.y
      magnitude = Math.hypot(i,j)
      extension = magnitude - SEGMENT_LENGTH

      #apply force
      if (magnitude != 0)
        joint_pair.last.velX = ((i / magnitude) * extension)
        joint_pair.last.velY = ((j / magnitude) * extension + GRAVITY)
      end
      #apply resultant velocity
      joint_pair.last.x = joint_pair.last.x + joint_pair.last.velX
      joint_pair.last.y = joint_pair.last.y + joint_pair.last.velY
    end
  end
  
  def radians(deg)
    return (Math::PI/180)*deg
  end
end

