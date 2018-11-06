squirt = require("robot")
debug = require("component").debug
net = require("internet")

-- The current world, TODO error checking
world = debug.getWorld(0)

-- Network parameters
HOST = "127.0.0.1"
PORT = 65432

-- Blocks to look out for
WOOL_ID = 35

yellow = {}
yellow["id"] = 35
yellow["meta"] = 4

red = {}
red["id"] = 35
red["meta"] = 4

blue = {}
blue["id"] = 35
blue["meta"] = 11

lime = {}
lime["id"] = 35
lime["meta"] = 5

white = {}
white["id"] = 35
white["meta"] = 0


--[[ Flow of this program:
Squirt must move forward, constantly checking the block beneath him.
1. He should start on a yellow wool block (35:4). 
2. He must move forward until the block beneath him is not
   white wool (35). 
3. Report to Crush the block id and meta data
4. Turn left
5. Repeat 2 through 4 until the block beneath him is yellow wool
6. What for an order from Crush to move to a new coordinate or end.
7. Repeat 1 through 6 until Crush commands to end
--]]

-- What is the block under Squirt?
function getBlockUnder()
   local block = {}
   
   local myX, myY, myZ
   myX = debug.getX()
   myY = debug.getY()
   myZ = debug.getZ()
   
   block["id"] = world.getBlockId(myX, myY-1, myZ)
   block["meta"] = world.getMetadata(myX, myY-1, myZ)
   
   return block
end

-- Print the block under Squirt
blockUnder = getBlockUnder()

if blockUnder["id"] == WOOL_ID then
   if blockUnder["meta"] == yellow["meta"] then
      print("Block is Yellow Wool")
   elseif blockUnder["meta"] == red["meta"] then
      print("Block is Red wool")
   elseif blockUnder["meta"] == blue["meta"] then
      print("Block is Blue Wool")
   elseif blockUnder["meta"] == lime["meta"] then
      print("Block is Lime Wool")
   elseif blockUnder["meta"] == white["meta"] then
      print("Block is White Wool")
else
   print("Block is NOT Wool")
end
   
   

