# 
# Responsible for parsing a Mars Rover program text and returning a concrete syntax tree.
#
class Parser
 
  def parse(program_text)
    raise "parse expects program_text to be a string" unless program_text.class == String       
    
    # Concrete Parse Tree will hold information from the program text    
    @parse_tree = {:upper_right_bounds => {:x=>nil, :y=>nil}, :rover_instructions => []} 
        
    #working on a line at a time seems reasonable for this grammar
    lines = program_text.split(/\n/)
    
    #first line is the upper right bounds, lets
    parse_upper_right_bounds lines[0]      
    
    #rover instructions are 2 lines each, so take 2-4, 5-6 etc
    1.step(lines.length-1, 2) do |i|              
      parse_rover_instructions lines[i], lines[i+1]
    end      
    @parse_tree                    
  end
  
  private 
  
  def parse_upper_right_bounds(line)
    matches = line.match /([0-9]) ([0-9])/
    @parse_tree[:upper_right_bounds] = matches[1].to_i, matches[2].to_i   
    throw "Parse error: Upper Right Bounds not valid '#{matches[0]}'" if @parse_tree[:upper_right_bounds][0].nil? or @parse_tree[:upper_right_bounds][1].nil?
  end 
  
  def parse_rover_instructions(line_1, line_2)
    @parse_tree[:rover_instructions] << {:initial_position=> parse_initial_position(line_1), :movements=>parse_movements(line_2)}
  end
  
  def parse_initial_position(line)      
    matches = line.match /([0-9]) ([0-9]) ([NESW])/
    {:x=>matches[1].to_i, :y=>matches[2].to_i, :facing=>matches[3]}
  end 
  
  def parse_movements(line)
    matches = line.match /([LRM]+)/
    matches[1]
  end
end