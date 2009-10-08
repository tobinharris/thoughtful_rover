class Parser
    
  def initialize 
    @parse_tree = {:upper_right_bounds => {:x=>nil, :y=>nil}, :rover_instructions => []} 
  end
  
  def parse program_text
    raise "parse expects program_text to be a string" unless program_text.class == String       
    lines = program_text.split(/\n/)
    parse_upper_right_bounds lines[0]      
    1.step(lines.length-1, 2) do |i|              
      parse_rover_instructions lines[i], lines[i+1]
    end      
    @parse_tree                    
  end
  
  private 
  
  def parse_upper_right_bounds line
    matches = line.match /([0-9]) ([0-9])/
    @parse_tree[:upper_right_bounds] = matches[1].to_i, matches[2].to_i
  end 
  
  def parse_rover_instructions line_1, line_2
    @parse_tree[:rover_instructions] << {:initial_position=> parse_initial_position(line_1), :movements=>parse_movements(line_2)}
  end
  
  def parse_initial_position line      
    matches = line.match /([0-9]) ([0-9]) ([NESW])/
    {:x=>matches[1].to_i, :y=>matches[2].to_i, :facing=>matches[3]}
  end 
  
  def parse_movements line
    matches = line.match /([LRM]+)/
    matches[1]
  end
end