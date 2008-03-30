module PhysicalObject
  
  def zero_vector()
    CP::Vec2.new(0,0)
  end

  def create_pyhsical_object(x, y, mass, collision_tag)
    moment_of_inertia = CP.moment_for_poly(mass, @bounds, zero_vector)
    body = CP::Body.new(mass, moment_of_inertia)
    @shape = CP::Shape::Poly.new(body, @bounds, zero_vector)
    @shape.collision_type = collision_tag
    @shape.body.p = CP::Vec2.new(x,y)
    @space.add_body(body)
    @space.add_shape(@shape)
  end

  def draw_polygon
    #this method is great to throw in your draw method
    #when you are trying to see what is going on with collisions
    #or if you just want to use polygons.
    #Beware the performance hit for drawing lots of polygons.
    @bounds.each_cons(2) do |pair| 
      a = @shape.body.local2world(pair.first)
      b = @shape.body.local2world(pair[1])
      @window.draw_line(a.x, a.y, 0xFFFFFFFF, b.x, b.y, 0xFFFFFFFF, z=0, mode=:default)
    end
    @window.draw_line(@shape.body.local2world(@bounds.last).x, @shape.body.local2world(@bounds.last).y, 
                      0xFFFFFFFF, @shape.body.local2world(@bounds.first).x, @shape.body.local2world(@bounds.first).y, 0xFFFFFFFF, z=0, mode=:default)
  end
end
