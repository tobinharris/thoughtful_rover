#
#  Reponsible for taking a rover program and deploying necessary rovers to carry it out 
#           
require 'Parser' 
require 'Rover'

class MissionControl      
  def deploy_rovers(program_text)        
    @rovers = []     
    parse_tree = Parser.new.parse(program_text)                 
    parse_tree[:rover_instructions].each do |instructions|            
      rover = Rover.new instructions[:initial_position][:x],
                        instructions[:initial_position][:y],
                        instructions[:initial_position][:facing],      
                        instructions[:movements],
                        parse_tree[:upper_right_bounds]    
      @rovers << rover
      rover.deploy             
    end    
  end  
  
  def report
    @rovers.join("\n")
  end
end
