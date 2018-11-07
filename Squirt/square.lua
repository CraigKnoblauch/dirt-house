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
red["meta"] = 14

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
    myX = debug.getX() - 1 -- X is consistently off by 1.
    myY = debug.getY()
    myZ = debug.getZ()
   
    block["id"] = world.getBlockId(myX, myY-1, myZ)
    block["meta"] = world.getMetadata(myX, myY-1, myZ)
   
    return block
end

-- What is the name of this block. 
-- NOTE: Limited to the blocks I know
function getBlockName(id, meta)
    block_name = "UNKNOWN"

    if id == yellow["id"] and meta == yellow["meta"] then 
        block_name = "yellow wool"
    elseif id == red["id"] and meta == red["meta"] then
        block_name = "red wool"
    elseif id == blue["id"] and meta == blue["meta"] then
        block_name = "blue wool"
    elseif id == lime["id"] and meta == lime["meta"] then
        block_name = "lime wool"
    elseif id == white["id"] and meta == white["meta"] then
        block_name = "white wool"
    end

    return block_name
end

--[[ Blocking function to call after a Squirt move call. Squirt will 
    assume it's in the same position if I call a position dependent
    functionality right after a move. Therefore, we must block Squirt 
    so he cannot ask qualities about his surroundings until he has
    actually moved ]]
function blockOnTravel(intiX, initY, initZ) 
    while initX == (debug.getX() - 1) and initY == debug.getY() and initZ == debug.getZ() do
        -- BLOCK
    end
end

block_under = getBlockUnder()
block_name = getBlockName( block_under["id"], block_under["meta"] )

print(block_name)

-- If Squirt is on the starting block, he moves off.
-- NOTE: Assuming he's moving in the correct direction
if block_name == "yellow wool" then

    myX = debug.getX() - 1
    myY = debug.getY()
    myZ = debug.getZ()

    squirt.forward()

    blockOnTravel(myX, myY, myZ)
end

print(block_name)

-- While Squirt is off of the starting square
while block_name ~= "yellow wool" do

    -- While Squirt is on the track
    while block_name == "white wool" do
        myX = debug.getX() - 1
        myY = debug.getY()
        myZ = debug.getZ()

        squirt.forward()

        blockOnTravel(myX, myY, myZ)
        
        block_under = getBlockUnder()
        block_name = getBlockName( block_under["id"], block_under["meta"] )
        print(block_name)
    end

    squirt.turnRight()

    print(block_name)
end
   
   

