#/bin/ruby 
require 'MissionControl'

# The rover is programmed using a 
# big chunk of text that conforms to a grammar
program = <<-EOS
5 5
1 2 N
LMLMLMLMM
3 3 E
MMRMMRMRRM
EOS

# MissionControl can deploy rovers by following a program
mc = MissionControl.new
mc.deploy_rovers(program)

# Report all that for handy viewing
puts "INPUT\n=====\n\n#{program}\n\nOUTPUT\n======\n\n#{mc.report}"
