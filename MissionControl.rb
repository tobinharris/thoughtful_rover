class MissionControl      
  def deploy_rovers(program_text)        
    @rovers = []     
    parse_tree = Parser.new.parse(program_text)                 
    parse_tree[:rover_instructions].each do |instructions|            
      rover = Rover.new                    
      @rovers << rover
      rover.x = instructions[:initial_position][:x] 
      rover.y = instructions[:initial_position][:y]     
      rover.facing = instructions[:initial_position][:facing]  
      rover.commands = instructions[:movements]    
      rover.bounds = parse_tree[:upper_right_bounds]           
      rover.follow_commands             
    end    
  end  
  
  def report
    @rovers.join("\n")
  end
end
