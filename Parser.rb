class Parser
  BOUNDS_EXPRESSION =  "([0-9]) ([0-9])"
  INITIAL_LOCATION_EXPRESSION = "([0-9]) ([0-9]) ([NESW])"   
  MOVEMENTS_EXPRESSION = "[LRM]+" 
    
  def initialize 
    @parse_tree = {:upper_right_bounds => nil, :rover_instructions => []} 
  end
  
  def parse program_text
    raise "parse expects a string" unless program_text.class == String       
    lines = program_text.split(/\n/)
    parse_upper_right lines[0]      
    1.step(lines.length-1, 2) do |i|              
      parse_rover_instructions lines[i], lines[i+1]
    end      
    @parse_tree                    
  end
  
  def parse_upper_right line
    matches = line.match BOUNDS_EXPRESSION
    @parse_tree[:upper_right_bounds] = matches[1].to_i, matches[2].to_i
  end 
  
  def parse_rover_instructions first, second
    @parse_tree[:rover_instructions] << {:initial_position=> parse_position(first), :movements=>second.strip}
  end
  
  def parse_position line      
    matches = line.match INITIAL_LOCATION_EXPRESSION
    [matches[1].to_i, matches[2].to_i, matches[3]]
  end 
end