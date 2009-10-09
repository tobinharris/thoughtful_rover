class MissionControl      
  def deploy_rovers(program_text)        
    @rovers = []     
    parse_tree = Parser.new.parse(program_text)                 
    parse_tree[:rover_instructions].each do |instructions|            
      rover = Rover.new :x=> instructions[:initial_position][:x],
                        :y=> instructions[:initial_position][:y],
                        :facing => instructions[:initial_position][:facing],      
                        :commands => instructions[:movements],
                        :bounds => parse_tree[:upper_right_bounds]    
      @rovers << rover
      rover.deploy             
    end    
  end  
  
  def report
    @rovers.join("\n")
  end
end
