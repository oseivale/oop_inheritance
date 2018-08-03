
class System

@@bodies = []

def add(celestial_body)
  @celestial_body = celestial_body
  @@bodies << @celestial_body
  return @@bodies
end

def total_mass(total_mass)
  @total_mass += @celestial_body
  return @total_mass
end

def bodies
  return puts "#{@@bodies}"
end

end

class Body

# @@name = name
# @@mass = mass


end

class Planet < Body

  attr_accessor :day, :year

  def day(hours)
    @hours = hours
  end

  def year(days)
    @days = days
  end


end

class Star < Body
  attr_accessor :type

  def type
    puts "The Stars type is #{type}"
  end

end

class Moon < Body

  attr_accessor :month, :planet

  def month(days)
    @days = days
    puts "the moon takes #{days} to orbit."
  end

  def planet
    return @planet
  end

end

solar1 = System.new

puts solar1.add("val")

puts solar1.bodies
