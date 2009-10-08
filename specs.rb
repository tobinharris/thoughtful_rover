require 'main'
require 'Parser'
require 'Rover'

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

describe Program do
  before(:each) do  
     program_string = <<-EOS
     5 5
     1 2 N
     LMLMLMLMM
     3 3 E
     MMRMMRMRRM
     EOS
          
     @program = Program.new
     @program.load program_string
   end
   
  it "Should perform movements" do
    @program.run
    puts @program.rovers
  end     
  
end