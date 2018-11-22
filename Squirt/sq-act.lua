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
    | Air          |    0     |     0      |
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
    elseif id == 0 and meta == 0 then
        block = "air"
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

--[[ Local function to only be used with functions in sq-act module.
    Returns the coordinates of one block behind of squirt ]]
local function getBackPos()

    -- Get Squirt's current position
    local squirtX, squirtY, squirtZ
    squirtX, squirtY, squirtZ = sq_nav.sqGetPos()

    -- Make copies of squirt's postion to be edited
    local blockX, blockY, blockZ = squirtX, squirtY, squirtZ

    -- Determine which direction Squirt is facing
    local facing = sq_swim.sqGetFacing()

    --[[ Based on the direction Squirt is facing, we can determine which
        axis must be incremented our decremented to give the block behind
        of Squirt
        
        North --> -Z
        East  --> +X
        South --> +Z
        West  --> -X
    ]]
    if facing == "north" then
        -- Increment Z by 1
        blockZ = blockZ + 1
    elseif facing == "east" then
        -- Decrement X by 1
        blockX = blockX - 1
    elseif facing == "south" then
        -- Decrement Z by 1
        blockZ = blockZ - 1
    elseif facing == "west" then
        -- Increment X by 1
        blockX = blockX + 1
    end

    return blockX, blockY, blockZ
end
        
--[[ Return the name of the block behind of squirt. Only blocks in the
    local getBlockName function are supported. ]]
function act.sqGetBackBlockName()

    -- Get the coordinate of the block behind of Squirt
    local backX, backY, backZ
    backX, backY, backZ = getBackPos()

    -- Get the block id and meta data with world object
    local id = world.getBlockId(backX, backY, backZ)
    local meta = world.getMetadata(backX, backY, backZ)

    -- Get the block name behind of squirt
    local block = getBlockName(id, meta)

    return block
end

--[[ Local function to only be used with functions in sq-act module.
    Returns the coordinates of one block to the right of squirt ]]
local function getRightPos()

    -- Get Squirt's current position
    local squirtX, squirtY, squirtZ
    squirtX, squirtY, squirtZ = sq_nav.sqGetPos()

    -- Make copies of squirt's postion to be edited
    local blockX, blockY, blockZ = squirtX, squirtY, squirtZ

    -- Determine which direction Squirt is facing
    local facing = sq_swim.sqGetFacing()

    --[[ Based on the direction Squirt is facing, we can determine which
        axis must be incremented our decremented to give the block to the right
        of Squirt
        
        North --> -Z
        East  --> +X
        South --> +Z
        West  --> -X
    ]]
    if facing == "north" then
        -- Increment X by 1
        blockX = blockX + 1
    elseif facing == "east" then
        -- Increment Z by 1
        blockZ = blockZ + 1
    elseif facing == "south" then
        -- Decrement X by 1
        blockX = blockX - 1
    elseif facing == "west" then
        -- Decrement Z by 1
        blockZ = blockZ - 1
    end

    return blockX, blockY, blockZ
end
        
--[[ Return the name of the block to the right of squirt. Only blocks in the
    local getBlockName function are supported. ]]
function act.sqGetRightBlockName()

    -- Get the coordinate of the block to the right of Squirt
    local rightX, rightY, rightZ
    rightX, rightY, rightZ = getRightPos()

    -- Get the block id and meta data with world object
    local id = world.getBlockId(rightX, rightY, rightZ)
    local meta = world.getMetadata(rightX, rightY, rightZ)

    -- Get the block name to the right of squirt
    local block = getBlockName(id, meta)

    return block
end

--[[ Local function to only be used with functions in sq-act module.
    Returns the coordinates of one block to the left of squirt ]]
local function getLeftPos()

    -- Get Squirt's current position
    local squirtX, squirtY, squirtZ
    squirtX, squirtY, squirtZ = sq_nav.sqGetPos()

    -- Make copies of squirt's postion to be edited
    local blockX, blockY, blockZ = squirtX, squirtY, squirtZ

    -- Determine which direction Squirt is facing
    local facing = sq_swim.sqGetFacing()

    --[[ Based on the direction Squirt is facing, we can determine which
        axis must be incremented our decremented to give the block to the left
        of Squirt
        
        North --> -Z
        East  --> +X
        South --> +Z
        West  --> -X
    ]]
    if facing == "north" then
        -- Decrement X by 1
        blockX = blockX - 1
    elseif facing == "east" then
        -- Decrement Z by 1
        blockZ = blockZ - 1
    elseif facing == "south" then
        -- Increment X by 1
        blockX = blockX + 1
    elseif facing == "west" then
        -- Increment Z by 1
        blockZ = blockZ + 1
    end

    return blockX, blockY, blockZ
end
        
--[[ Return the name of the block to the left of squirt. Only blocks in the
    local getBlockName function are supported. ]]
function act.sqGetLeftBlockName()

    -- Get the coordinate of the block to the left of Squirt
    local leftX, leftY, leftZ
    leftX, leftY, leftZ = getLeftPos()

    -- Get the block id and meta data with world object
    local id = world.getBlockId(leftX, leftY, leftZ)
    local meta = world.getMetadata(leftX, leftY, leftZ)

    -- Get the block name to the left of squirt
    local block = getBlockName(id, meta)

    return block
end

--[[ Local function to only be used with functions in sq-act module.
    Returns the coordinates of one block on top of squirt ]]
local function getTopPos()

    -- Get Squirt's current position
    local squirtX, squirtY, squirtZ
    squirtX, squirtY, squirtZ = sq_nav.sqGetPos()

    -- Make copies of squirt's postion to be edited
    local blockX, blockY, blockZ = squirtX, squirtY, squirtZ

    -- Increment Y by 1
    blockY = blockY + 1

    return blockX, blockY, blockZ
end
        
--[[ Return the name of the block on top of squirt. Only blocks in the
    local getBlockName function are supported. ]]
function act.sqGetTopBlockName()

    -- Get the coordinate of the block on top of Squirt
    local topX, topY, topZ
    topX, topY, topZ = getTopPos()

    -- Get the block id and meta data with world object
    local id = world.getBlockId(topX, topY, topZ)
    local meta = world.getMetadata(topX, topY, topZ)

    -- Get the block name on top of squirt
    local block = getBlockName(id, meta)

    return block
end

--[[ Local function to only be used with functions in sq-act module.
    Returns the coordinates of one block beneath squirt ]]
local function getBottomPos()

    -- Get Squirt's current position
    local squirtX, squirtY, squirtZ
    squirtX, squirtY, squirtZ = sq_nav.sqGetPos()

    -- Make copies of squirt's postion to be edited
    local blockX, blockY, blockZ = squirtX, squirtY, squirtZ

    -- Decrement Y by 1
    blockY = blockY - 1

    return blockX, blockY, blockZ
end
        
--[[ Return the name of the block beneath squirt. Only blocks in the
    local getBlockName function are supported. ]]
function act.sqGetBottomBlockName()

    -- Get the coordinate of the block beneath Squirt
    local bottomX, bottomY, bottomZ
    bottomX, bottomY, bottomZ = getBottomPos()

    -- Get the block id and meta data with world object
    local id = world.getBlockId(bottomX, bottomY, bottomZ)
    local meta = world.getMetadata(bottomX, bottomY, bottomZ)

    -- Get the block name beneath squirt
    local block = getBlockName(id, meta)

    return block
end

--[[ Given a side, pick up the block on that side. Return the name of the block
    in that direction, and whether it was picked up or not.
    Returns "invalid side", false if the side provided is invalid. ]]
function act.sqPickUpBlock(side)
    blockname = "invalid side"
    picked_up = false

    if side == "front" then
        -- Get the name of the block in front of Squirt
        blockname = act.sqGetFrontBlockName()

        -- Pick up the block in front of Squirt
        picked_up, _ = squirt.swing()

    elseif side == "right" then
        -- Get the name of the block to the right of Squirt
        blockname = act.sqGetRightBlockName()

        -- Turn Squirt to the right, get that block, then turn Squirt back
        sq_swim.sqTurnRight()
        picked_up, _ = squirt.swing()
        sq_swim.sqTurnLeft()

    elseif side == "left" then
        -- Get the name of the block to the left of Squirt
        blockname = act.sqGetLeftBlockName()

        -- Turn Squirt to the left, get that block, then turn Squirt back
        sq_swim.sqTurnLeft()
        picked_up, _ = squirt.swing()
        sq_swim.sqTurnRight()

    elseif side == "back" then
        -- Get the name of the block behind Squirt
        blockname = act.sqGetBackBlockName()

        -- Turn Squirt around, get that block, then turn Squirt back
        sq_swim.sqTurnAround()
        picked_up, _ = squirt.swing()
        sq_swim.sqTurnAround()

    elseif side == "up" or side == "top" then
        -- Get the name of the block above Squirt
        blockname = act.sqGetTopBlockName()

        -- Get the block above of Squirt
        picked_up, _ = squirt.swingUp()

    elseif side == "down" or side == "bottom" then
        -- Get the name of the block below Squirt
        blockname = act.sqGetBottomBlockName()

        -- Get the block beneath Squirt
        picked_up, _ = squirt.swingDown()

    end

    return blockname, picked_up

end

--[[ Function to be used by this module only. Returns the inventory index
    to used based on the block name. Returns 9 if the block is unsupported ]]
function act.getInventoryIndex(block)
    DEFAULT_INDEX = 9

    -- Default index for all blocks that are not supported in the below ifelse
    index = DEFAULT_INDEX

    -- TODO handle the case where the inventory indices are full
    if block == "dirt" then
        --[[ Start on index 1, is there space for the block? If not, move to the
            next index. If there isn't a spot to put the block, mark index as the
            default ]]
        index = 1
        -- Is there space for a dirt block at this index?
        while squirt.space(index) ~= 0 and index <= 4 do
            index = index + 1
        end

        -- If index rolled over 4, set it to the default
        if index > 4 then
            index = DEFAULT_INDEX
        end

    elseif block == "cobblestone" then
        --[[ Start on index 5, is there space for the block? If not, move to the
            next index. If there isn't a spot to put the block, mark index as 9 ]]
        index = 5
        -- Is there space for a cobblestone block at this index
        while squirt.space(index) ~= 0 and index <= 8 do
            index = index + 1
        end

        -- If index rolloed over 8, set it to the default
        if index > 8 then
            index = DEFAULT_INDEX
        end
    end

    return index
end
            
return act
    


