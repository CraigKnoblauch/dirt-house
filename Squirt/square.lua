local squirt
squirt = require("robot")

local debug
debug = require("component").debug

local net
net = require("internet")

local HOST, PORT
HOST = "127.0.0.1"
PORT = 65432

-- Blocks to look out for
local yellow, red, blue, lime, white
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


