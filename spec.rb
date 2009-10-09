require 'rubygems'
require 'spec'

require 'MissionControl'
require 'Parser'
require 'Rover'

describe Parser do

  before(:each) do  
    program_string = <<-EOS
    5 5
    1 2 N
    LMLMLMLMM
    3 3 E
    MMRMMRMRRM
    EOS
    
    @parse_tree = Parser.new.parse(program_string)    
  end
  
  it "Should allocate first line of input is the upper-right coordinates of the plateau" do
    @parse_tree[:upper_right_bounds].should == [5,5]
  end
  
  it "Should allocate other four lines as two sets of rover instructions" do
    @parse_tree[:rover_instructions].length.should == 2
  end
  
  it "Should allocate first line of input to the rover's initial position" do               
    @parse_tree[:rover_instructions][0][:initial_position].should == {:x=>1, :y=>2, :facing=>'N'} 
    @parse_tree[:rover_instructions][1][:initial_position].should == {:x=>3, :y=>3, :facing=>'E'}
  end            
end    

describe Rover do
  
  before :each do
    @rover = Rover.new
  end     
  
  def reset_rover
    @rover.x = 2
    @rover.y = 2
    @rover.facing = 'N'
    @rover.bounds = [5,5]   
    @rover.commands = 'M'
  end
  
  it "Should give errors if not initialized with all values" do
    @rover.errors.length.should == 6   
    @rover.x = 2
    @rover.y = 2
    @rover.errors.length.should == 4
    @rover.facing = 'N'
    @rover.errors.length.should == 2
    @rover.bounds = [5,5]
    @rover.errors.length.should == 1 
    @rover.commands = 'M'
    @rover.errors.length.should == 0
  end   
  
  it "Should rotate right and face east if facing north" do
    reset_rover
    @rover.rotate_right
    @rover.facing.should == 'E'
  end
  
  it "Should rotate left and face west if facing north" do
    reset_rover
    @rover.rotate_left
    @rover.facing.should == 'W'
  end
  
  
  it "Should rotate left twice and face south if facing north" do
    reset_rover
    @rover.rotate_left
    @rover.rotate_left
    @rover.facing.should == 'S'
  end      
  
  it "Should be able to move north" do
    reset_rover
    @rover.position.should == [2,2]
    @rover.move_forward
    @rover.position.should == [2,3]
  end
  
end   

describe MissionControl do
  before(:each) do  
     @program_string = <<-EOS
     5 5
     1 2 N
     LMLMLMLMM
     3 3 E
     MMRMMRMRRM
     EOS
          
     @mission_control = MissionControl.new     
   end
   
  it "Should perform movements" do
    @mission_control.deploy_rovers(@program_string)
    puts @mission_control.rovers
  end     
  
end