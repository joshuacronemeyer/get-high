require 'numeric'
class Rope
  MASS = 0.2
  COLLISION_TAG = :rope
  def zero_vector()
    CP::Vec2.new(0,0)
  end

  def initialize(window, space, connecting_body)
    @image = Image.new(window, "media/circle.png", true)
    @window = window
    @space = space
    @connecting_body = connecting_body
    @verts = [CP::Vec2.new(@connecting_body.p.x() -30, @connecting_body.p.y)]
    @shapes = []
    (1..10).each{|i| @verts << CP::Vec2.new(@verts.first.x, @verts.first.y + i*5)}
    @verts.each{|vert| @shapes << create_physical_object(vert.x, vert.y)}
    join_point = CP::Vec2.new(@connecting_body.p.x() -30, @connecting_body.p.y)
    @space.add_joint(CP::Joint::Pivot.new(@shapes.first.body, @connecting_body, join_point))
    add_joints()
  end
  
  def add_joints()
    @shapes.each_cons(2) do |s1, s2|
      join_point = CP::Vec2.new(s1.body.p.x, s1.body.p.y() +0.5)
      joint = CP::Joint::Pivot.new(s1.body, s2.body, join_point)
      @space.add_joint(joint)
    end
  end

  def create_physical_object(x,y)
    in_radius, out_radius = 0.25, 5
    moment_of_inertia = CP.moment_for_circle(MASS, in_radius, out_radius, zero_vector)
    body = CP::Body.new(MASS, moment_of_inertia)
    shape = CP::Shape::Circle.new(body, out_radius, zero_vector)
    shape.collision_type = COLLISION_TAG
    shape.body.p = CP::Vec2.new(x,y)
    shape.group=3
    shape.e = elast if self.respond_to?("elast")
    shape.u = fric if self.respond_to?("fric")
    @space.add_body(body) unless @fixed
    @space.add_shape(shape)
    shape
  end

  def draw(x,y)
    @shapes.each do |shape| 
      puts "#{shape.body.p.x}, #{shape.body.p.y}"
      x_offset = -x + (Game::X_RES/2.0)
      y_offset = -y + (Game::Y_RES/2.0)
      @image.draw_rot(shape.body.p.x + x_offset, shape.body.p.y + y_offset, 0, shape.body.a.radians_to_gosu)
    end
  end

end
