
class Rover
  attr_accessor :x
  attr_accessor :y
  attr_accessor :facing  
  attr_accessor :commands
  attr_accessor :bounds      
  
  def initialize
    @move_commands = {
                        'N'=>lambda{ self.x = self.x + 1 }, #north
                        'E'=>lambda{ self.y = self.y + 1 }, #east
                        'S'=>lambda{ self.x = self.x - 1 }, #south    
                        'W'=>lambda{ self.y = self.y - 1 } #west
                      }  
    @rotate_commands = {
                   'L' => rotate_left,
                   'R' => rotate_right,
                   'M' => move_forward
                }                       
  end
  
  def follow_commands    
    self.commands.scan(/./) do |c|
      if @rotate_commands[c] then @rotate_commands[c].call else throw "Unknown Rover command #{c}" end       
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
    @move_commands[self.facing].call
  end     
  
  def to_s
    "#{x} #{y} #{facing}"   
  end
  
end