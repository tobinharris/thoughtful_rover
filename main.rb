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
       

class Program    
    attr_accessor :rovers   
    
    def load program_text
      @parse_tree = Parser.new.parse(program_text)      
      self.rovers = []
    end
    
    def run     
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
