--[[ This module is responsible for allowing Squirt cognizance of his environment ]]

local squirt = require("robot")
local debug = require("component").debug
local nav = require("component").navigation
local sq_nav = require("sq-navigation")
local sq_swim = require("sq-swim")

-- Table to hold functions of this module we wish the caller to have
local act = {}

-- Local world object for debug
-- TODO QUESTION Is the world object always 0
local world = debug.getWorld(0)

--[[ local function to be used by sq-act's functions only. This function takes a block's id,
    and it's metadata, and returns the string name of the block. 
    
    Squirt will be working in a very limited environment. Therefore, only 4 blocks are supported:
    
    |--------------------------------------|
    | Block String | Block ID | Block Meta |
    |--------------------------------------|
    | Grass        |    2     |     0      |
    | Dirt         |    3     |     0      |
    | Stone        |    1     |     0      |
    | Cobblestone  |    4     |     0      |
    |--------------------------------------|

]]
local function getBlockName(id, meta)
    block = "unknown"

    -- Based on the table shown above, classify the block
    if id == 2 and meta == 0 then
        block = "grass"
    elseif id == 3 and meta == 0 then
        block = "dirt"
    elseif id == 1 and meta == 0 then
        block = "stone"
    elseif id == 4 and meta == 0 then
        block = "cobblestone"
    end

    return block
end

--[[ Local function to only be used with functions in sq-act module.
    Returns the coordinates of one block in front of squirt ]]
local function getFrontPos()
    
    -- Get Squirt's current position
    local squirtX, squirtY, squirtZ
    squirtX, squirtY, squirtZ = sq_nav.sqGetPos()

    -- Make copies of squirt's postion to be edited
    local blockX, blockY, blockZ = squirtX, squirtY, squirtZ

    -- Determine which direction Squirt is facing
    local facing = sq_swim.sqGetFacing()

    --[[ Based on the direction Squirt is facing, we can determine which
        axis must be incremented our decremented to give the block in front 
        of Squirt
        
        North --> -Z
        East  --> +X
        South --> +Z
        West  --> -X
    ]]
    if facing == "north" then
        -- Decrement Z by 1
        blockZ = blockZ - 1
    elseif facing == "east" then
        -- Increment X by 1
        blockX = blockX + 1
    elseif facing == "south" then
        -- Increment Z by 1
        blockZ = blockZ + 1
    elseif facing == "west" then
        -- Decrement X by 1
        blockX = blockX - 1
    end

    return blockX, blockY, blockZ
end
    
--[[ Return the name of the block in front of squirt. Only blocks in the
    local getBlockName function are supported. ]]
function act.sqGetFrontBlockName()

    -- Get the coordinate of the block in front of Squirt
    local frontX, frontY, frontZ
    frontX, frontY, frontZ = getFrontPos()

    -- Get the block id and meta data with world object
    local id = world.getBlockId(frontX, frontY, frontZ)
    local meta = world.getMetadata(frontX, frontY, frontZ)

    -- Get the block name in front of squirt
    local block = getBlockName(id, meta)

    return block
end

return act
    


