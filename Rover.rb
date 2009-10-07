class Rover
  attr_accessor :x
  attr_accessor :y
  attr_accessor :facing  
  attr_accessor :commands
  attr_accessor :bounds      
  
  def initialize
    @possible_steps = {
    'N'=>lambda{ self.x = self.x + 1 }, #north
    'E'=>lambda{ self.y = self.y + 1 }, #east
    'S'=>lambda{ self.x = self.x - 1 }, #south    
    'W'=>lambda{ self.y = self.y - 1 } #west
    }   
  end
  
  def follow_commands    
    self.commands.scan(/./) do |c|
      case c
      when 'L'
        rotate_left
      when 'R'     
        rotate_right
      when 'M'      
        move_forward
      else
        throw "Unknown Rover command #{c}"
      end        
    end
  end
  
  
  def rotate_left     
    current = ['N','E','S','W'].index(self.facing)
    self.facing = current == 0 ? 'W' : ['N','E','S','W'][current - 1]
    
  end
  
  def rotate_right
    current = ['N','E','S','W'].index(self.facing)
    self.facing = current == 3 ? 'N' : ['N','E','S','W'][current + 1]    
  end
  
  def move_forward
    @possible_steps[self.facing].call
  end     
  
  def to_s
    "#{x} #{y} #{facing}"   
  end
  
end