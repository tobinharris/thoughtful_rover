#
# Responsible for taking commands and moving about within the given plateau bounds 
#
class Rover    
  attr_reader :x
  attr_reader :y
  attr_reader :facing  
  attr_reader :commands
  attr_reader :bounds      
    
  # Assuming this is an immutable "Fire And Forget" rover 
  def initialize(x, y, facing, movements, bounds)
    
    @x = x
    @y = y
    @facing = facing
    @movements = movements
    @bounds = bounds
      
    # dictionary of move and advance commands                    
    @commands = {
                   'L' => lambda{rotate_left},
                   'R' => lambda{rotate_right},
                   'M' => lambda{advance}
                }                       
                
    # dictionary of commands for executing moves in particular directions
    @directional_commands = {
                        'N'=>lambda{ @y = @y + 1 }, #north
                        'E'=>lambda{ @x = @x + 1 }, #east
                        'S'=>lambda{ @y = @y - 1 }, #south    
                        'W'=>lambda{ @x = @x - 1 }  #west
                      } 
  end     
  
  # Handy method to get current x,y coords
  def position 
    [self.x,self.y]
  end 
   
  # Is Rover in a valid state?
  def get_errors
    arr = []
    arr << "Bounds should be set." unless @bounds
    arr << "X co-ord cannot be nil." unless @x
    arr << "Y co-ord cannot be nil." unless @y
    arr << "Facing cannot be nil." unless @facing 
    arr << "Facing cannot be nil." unless @commands
    arr << "Facing must be one of N,E,S or W." unless @facing =~ /[NESW]/
    arr << "Cannot be out of bounds." if @bounds and @x and @y and (@x > @bounds[0] or @y > @bounds[1] or @x < 0 or @y < 0)
    arr
  end  
  
  # If anything goes wrong, rover will self destruct.
  # There are probably less costly options :)
  def explode_if_broken_invariants
    throw "Bang! " + get_errors.join(' ') unless get_errors.empty?     
  end
  
  # Drop the rover on the plateau and start executing commands
  def deploy   
    explode_if_broken_invariants
    @movements.scan(/./) do |c|
      if @commands[c] then @commands[c].call else throw "Unknown Rover command #{c}" end       
      explode_if_broken_invariants
    end
  end   
    
  def rotate_left         
    current = ['N','E','S','W'].index(self.facing)     
    throw "Not facing any direction '#{self.facing}'! " if current.nil? 
    @facing = current == 0 ? 'W' : ['N','E','S','W'][current - 1]    
  end
  
  def rotate_right
    current = ['N','E','S','W'].index(self.facing)        
    throw "Not facing any direction '#{self.facing}'! " if current.nil? 
    @facing = current == 3 ? 'N' : ['N','E','S','W'][current + 1]    
  end
  
  # Move forward in whatever direction the rover is facing.
  def advance
    @directional_commands[self.facing].call
  end     
  
  # This is the most useful string representation of a Rover, .inspect would do for more in-depth
  def to_s
    "#{x} #{y} #{facing}"   
  end
  
end