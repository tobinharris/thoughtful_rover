# square surface
#   grid
#   position
#     0, 0, N 
#     -------
#     | | | |
#     -------
#     |x| | | 
#     -------
# several rovers
#   objective: complete view of terrain
# controlled by letters L, R and M


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

class Parser
  @@bounds_expression =  "([0-9]) ([0-9])"
  @@initial_location_expression = "([0-9]) ([0-9]) ([NESW])"   
  @@movements_expression = "[LRM]+"
  
 
  
  attr_accessor :rovers
    
  def initialize 
    self.rovers = []    
    @parse_tree = {:upper_right_bounds => nil, :rover_instructions => []} 
  end
  
  def parse program_text
    raise "parse expects a string" unless program_text.class == String       
    lines = program_text.split(/\n/)
    parse_upper_right lines[0]      
    1.step(lines.length-1, 2) do |i|              
      parse_rover_instructions lines[i], lines[i+1]
    end      
    @parse_tree                    
  end
  
  def parse_upper_right line
    matches = line.match @@bounds_expression
    @parse_tree[:upper_right_bounds] = matches[1].to_i, matches[2].to_i
  end 
  
  def parse_rover_instructions first, second
    @parse_tree[:rover_instructions] << {:initial_position=> parse_position(first), :movements=>second.strip}
  end
  
  def parse_position line      
    matches = line.match /([0-9]) ([0-9]) ([NESW])/
    [matches[1].to_i, matches[2].to_i, matches[3]]
  end     
  
  def execute     
    @parse_tree[:rover_instructions].each do |instr|      
      rover = Rover.new                    
      self.rovers << rover
      rover.x = instr[:initial_position][0] 
      rover.y = instr[:initial_position][1]     
      rover.facing = instr[:initial_position][2]  
      rover.commands = instr[:movements]    
      rover.bounds = @parse_tree[:upper_right_bounds]     
      rover.follow_commands             
    end
  end      
end

require 'rubygems'
require 'spec'

describe Parser do

  before(:each) do  
    program_string = <<-EOS
    5 5
    1 2 N
    LMLMLMLMM
    3 3 E
    MMRMMRMRRM
    EOS
    
    @program = Parser.new
    @parse_tree = @program.parse(program_string)    
  end
  
  it "Should allocate first line of input is the upper-right coordinates of the plateau" do
    @parse_tree[:upper_right_bounds].should == [5,5]
  end
  
  it "Should allocate other four lines as input for two rovers" do
    @parse_tree[:rover_instructions].length.should == 2
  end
  
  it "Should allocate first line gives the rover's position" do               
    @parse_tree[:rover_instructions][0][:initial_position].should == [1,2,'N'] 
    @parse_tree[:rover_instructions][1][:initial_position].should == [3,3,'E'] 
  end          
  
  it "Should perform movements" do
    @program.execute    
    puts @program.rovers
  end

end