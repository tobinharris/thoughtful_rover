require 'rubygems'
require 'spec'

require 'MissionControl'
require 'Parser'
require 'Rover'


# ////////////////////////////////////////////////////////////////////////////////
#
# ////////////////////////////////////////////////////////////////////////////////
describe Parser do

  before(:each) do  
    program = <<-EOS
    5 5
    1 2 N
    LMLMLMLMM
    3 3 E
    MMRMMRMRRM
    EOS
    
    @parse_tree = Parser.new.parse(program)    
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

# ////////////////////////////////////////////////////////////////////////////////
#
# ////////////////////////////////////////////////////////////////////////////////
describe Rover do
  
  before(:each) do
    @rover = Rover.new 2, 2, 'N', [5,5], 'M'
  end
  
  it "Should give errors if not initialized with all values" do
    @rover = Rover.new nil, nil, nil, nil, nil
    @rover.get_errors.length.should == 5  
    
    @rover = Rover.new 2, 2, nil, nil, nil
    @rover.get_errors.length.should == 3
    
    @rover = Rover.new 2, 2, 'N', nil, nil
    @rover.get_errors.length.should == 1            
    
    @rover = Rover.new 2, 2, 'N', [5,5], nil
    @rover.get_errors.length.should == 1 
    
    @rover = Rover.new 2, 2, 'N', [5,5], 'LLMRM'
    @rover.get_errors.length.should == 0
  end   
  
  it "Should rotate right and then be facing east" do
    @rover.rotate_right
    @rover.facing.should == 'E'
  end
  
  it "Should rotate left and then be facign west" do
    @rover.rotate_left
    @rover.facing.should == 'W'
  end
                                                      
  it "Should rotate left twice and then be facing south" do
    @rover.rotate_left
    @rover.rotate_left
    @rover.facing.should == 'S'
  end      
  
  it "Should rotate right 4 times and then be facing north again" do
    @rover.rotate_right
    @rover.rotate_right
    @rover.rotate_right
    @rover.rotate_right      
    @rover.facing.should == 'N'
  end      
  
  it "Should be able to move north" do
    @rover.advance
    @rover.position.should == [2,3]
  end 
  
  it "Should be able to move south" do
     @rover.rotate_left
     @rover.rotate_left
     @rover.advance
     @rover.position.should == [2,1]
   end
  
end   

# ////////////////////////////////////////////////////////////////////////////////
#
# ////////////////////////////////////////////////////////////////////////////////
describe MissionControl do
  before(:all) do  
     @program = <<-EOS
     5 5
     1 2 N
     LMLMLMLMM
     3 3 E
     MMRMMRMRRM
     EOS
   end
   
  it "Should perform movements" do
    m = MissionControl.new
    m.deploy_rovers @program
    m.report.should == "1 3 N\n5 1 E"
  end     
  
end