
class Rover  
  attr_accessor :x
  attr_accessor :y
  attr_accessor :facing  
  attr_accessor :commands
  attr_accessor :bounds      
  
  def initialize
    @move_in_direction_commands = {
                        'N'=>lambda{ self.y = self.y + 1 }, #north
                        'E'=>lambda{ self.x = self.x + 1 }, #east
                        'S'=>lambda{ self.y = self.y - 1 }, #south    
                        'W'=>lambda{ self.x = self.x - 1 } #west
                      }  
    @rotate_commands = {
                   'L' => lambda{rotate_left},
                   'R' => lambda{rotate_right},
                   'M' => lambda{move_forward}
                }                       
  end     
  
  def position 
    [self.x,self.y]
  end
  
  def errors
    errors = []
    errors << "Bounds should be set." unless self.bounds
    errors << "X co-ord cannot be nil." unless self.x
    errors << "Y co-ord cannot be nil." unless self.y
    errors << "Facing cannot be nil." unless self.facing 
    errors << "Facing cannot be nil." unless self.commands
    errors << "Facing must be one of N,E,S or W." unless self.facing =~ /[NESW]/
    errors << "Cannot be out of bounds." if self.bounds and self.x and self.y and (self.x > self.bounds[0] or self.y > self.bounds[1] or self.x < 0 or self.y < 0)
    errors
  end  
  
  def die_if_errors
    throw errors.join(' ') unless errors.empty?     
  end
  
  def follow_commands   
    die_if_errors
    self.commands.scan(/./) do |c|
      if @rotate_commands[c] then @rotate_commands[c].call else throw "Unknown Rover command #{c}" end       
      die_if_errors
    end
  end   
  
  def rotate_left         
    current = ['N','E','S','W'].index(self.facing)     
    throw "Not facing any direction '#{self.facing}'! " if current.nil? 
    self.facing = current == 0 ? 'W' : ['N','E','S','W'][current - 1]    
  end
  
  def rotate_right
    current = ['N','E','S','W'].index(self.facing)        
    throw "Not facing any direction '#{self.facing}'! " if current.nil? 
    self.facing = current == 3 ? 'N' : ['N','E','S','W'][current + 1]    
  end
  
  def move_forward
    @move_in_direction_commands[self.facing].call
  end     
  
  def to_s
    "#{x} #{y} #{facing}"   
  end
  
end