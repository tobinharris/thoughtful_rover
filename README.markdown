README
======

About
-----
Prepared for ThoughtWorks by Tobin Harris

[http://tobinharris.com](http://tobinharris.com)

[tobin@tobinharris.com](mailto:tobin@tobinharris.com)

Explanation
-----------------

MissionControl is where things kick off. 

* It takes a program_text from it's operators
* It then parses that using the Parser
* It then takes the resultant syntax tree (a hash) and creates appropriate rovers
* It tells the rovers to deploy, which makes them run their commands (sequences of L,R or M)
* That's it!

![](http://yuml.me/diagram/plain%3Bdir%3ALR%3B/class/%5BMissionControl%5D-.-creates%201%3E%5BParser%7Cparse%20program%5D%2C%20%5BMissionControl%5D-.-creates%20*%3E%5BRover%7Cdeploy%5D)

Assumptions For Tobins Rover
----------------------------
* The text entered into a program follows a strict grammar. The parser is intolerant to violations of that grammar. 
* Rovers are fire and forget. Once you drop them on the surface, they won't be re-programmed.
* Rovers die if they go out of bounds. The don't "bounce" off the bounds or intelligently re-orient themselves.
* Rovers operate in serial and don't get in each others way, so no need to worry about collision detection.

Excuses
-------
Eh hem. Ruby is a second language for me compared to .NET. I'm still learning the idioms, so excuse any unnecessary long-handedness. 