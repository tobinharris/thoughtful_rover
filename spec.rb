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
    @rover.x = 1
    @rover.y = 1
    @rover.facing = 'N'
    @rover.bounds = [5,5]    
  end
  
  it "Should fail if not initialized properly" do
    @rover.self_test    
  end
  it "Should turn left" do
    
  end
end   

describe MissionControl do
  before(:each) do  
     program_string = <<-EOS
     5 5
     1 2 N
     LMLMLMLMM
     3 3 E
     MMRMMRMRRM
     EOS
          
     @mission_control = MissionControl.new
     @mission_control.load program_string
   end
   
  it "Should perform movements" do
    @mission_control.run
    puts @mission_control.rovers
  end     
  
end