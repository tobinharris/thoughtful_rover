require 'Parser' 
require 'Rover'

#
#  Reponsible for taking a rover program and deploying necessary rovers to carry it out 
#           
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
  
  # Reports on the position of the rovers
  def report
    @rovers.join("\n") if @rovers
  end
end
