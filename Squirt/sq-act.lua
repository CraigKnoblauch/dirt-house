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
    | Bedrock      |    7     |     0      |
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
    elseif id == 7 and meta == 0 then
        block = "bedrock"
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

--[[ Function to be used by this module only. Returns the inventory index
    to used for picking up a block, based on the block name. Returns 9 if the 
    block is unsupported ]]
local function getPickupInventoryIndex(block)
    local DEFAULT_INDEX = 9

    -- Default index for all blocks that are not supported in the below ifelse
    local index = DEFAULT_INDEX

    if block == "dirt" or block == "grass" then
        --[[ Start on index 1, is there space for the block? If not, move to the
            next index. If there isn't a spot to put the block, mark index as the
            default ]]
        index = 1
        -- Is there space for a dirt block at this index?
        while squirt.space(index) == 0 and index <= 4 do
            index = index + 1
        end

        -- If index rolled over 4, set it to the default
        if index > 4 then
            index = DEFAULT_INDEX
        end

    elseif block == "cobblestone" or block == "stone" then
        --[[ Start on index 5, is there space for the block? If not, move to the
            next index. If there isn't a spot to put the block, mark index as 9 ]]
        index = 5
        -- Is there space for a cobblestone block at this index
        while squirt.space(index) == 0 and index <= 8 do
            index = index + 1
        end

        -- If index rolloed over 8, set it to the default
        if index > 8 then
            index = DEFAULT_INDEX
        end
    end

    return index
end

--[[ Given a side, pick up the block on that side. Return the name of the block
    in that direction, and whether it was picked up or not.
    Possible returns:
    
    |---------------------------------------------------|
    | Return Code |               Info                  |
    |---------------------------------------------------|
    |  -3         | Invalid side used as input          |
    |  -2         | Attempting to bick up bedrock       |
    |  -1         | There is not block to pick up       |
    |   1         | The block picked up was dirt        |
    |   2         | The block picked up was cobblestone |
    |   3         | The block picked up was unknown     |
    |   0         | The time_t's rolled around          |
    |---------------------------------------------------|
]]
function act.sqPickUpBlock(side)
    local exitcode = 0
    -- Exit codes
    local BLOCK_DOES_NOT_EXIST = -1
    local BLOCK_IS_BEDROCK = -2
    local BLOCK_IS_DIRT = 1
    local BLOCK_IS_COBBLESTONE = 2
    local BLOCK_IS_UNKNOWN = 3

    local blockname = "invalid side"
    local picked_up = false
    local stat = ""

    -- Get the current inventory seleection slot
    local inventory_index = squirt.select() 

    if side == "front" then
        -- Get the name of the block in front of Squirt
        blockname = act.sqGetFrontBlockName()

        -- Select the proper inventory slot
        inventory_index = getPickupInventoryIndex(blockname)
        squirt.select(inventory_index)

        -- Pick up the block in front of Squirt
        picked_up, state = squirt.swing()

    elseif side == "right" then
        -- Get the name of the block to the right of Squirt
        blockname = act.sqGetRightBlockName()

        -- Select the proper inventory slot
        inventory_index = getPickupInventoryIndex(blockname)
        squirt.select(inventory_index)

        -- Turn Squirt to the right, get that block, then turn Squirt back
        sq_swim.sqTurnRight()
        picked_up, state = squirt.swing()
        sq_swim.sqTurnLeft()

    elseif side == "left" then
        -- Get the name of the block to the left of Squirt
        blockname = act.sqGetLeftBlockName()

        -- Select the proper inventory slot
        inventory_index = getPickupInventoryIndex(blockname)
        squirt.select(inventory_index)

        -- Turn Squirt to the left, get that block, then turn Squirt back
        sq_swim.sqTurnLeft()
        picked_up, state = squirt.swing()
        sq_swim.sqTurnRight()

    elseif side == "back" then
        -- Get the name of the block behind Squirt
        blockname = act.sqGetBackBlockName()

        -- Select the proper inventory slot
        inventory_index = getPickupInventoryIndex(blockname)
        squirt.select(inventory_index)

        -- Turn Squirt around, get that block, then turn Squirt back
        sq_swim.sqTurnAround()
        picked_up, state = squirt.swing()
        sq_swim.sqTurnAround()

    elseif side == "up" or side == "top" then
        -- Get the name of the block above Squirt
        blockname = act.sqGetTopBlockName()

        -- Select the proper inventory slot
        inventory_index = getPickupInventoryIndex(blockname)
        squirt.select(inventory_index)

        -- Get the block above of Squirt
        picked_up, state = squirt.swingUp()

    elseif side == "down" or side == "bottom" then
        -- Get the name of the block below Squirt
        blockname = act.sqGetBottomBlockName()

        -- Select the proper inventory slot
        inventory_index = getPickupInventoryIndex(blockname)
        squirt.select(inventory_index)

        -- Get the block beneath Squirt
        picked_up, state = squirt.swingDown()

    end

    -- Identify the exitcode to use based on the block that was picked up or not
    if (not picked_up and state == "block") or blockname == "bedrock" then
        exitcode = BLOCK_IS_BEDROCK

    elseif not picked_up or state == "air" then
        exitcode = BLOCK_DOES_NOT_EXIST

    elseif blockname == "invalid side" then
        exitcode = INVALID_SIDE

    -- NOTE blockname is given before the block is picked up. That's why we're checking
    -- both "dirt" and "grass"
    elseif blockname == "dirt" or blockname == "grass" then
        exitcode = BLOCK_IS_DIRT

    elseif blockname == "cobblestone" or blockname == "stone" then
        exitcode = BLOCK_IS_COBBLESTONE
    
    -- There was a block picked up, but it wasn't cobble or dirt
    else
        exitcode = BLOCK_IS_UNKNOWN
    end

    return exitcode

end

--[[ Function to be used by this module only. Returns the inventory index
    to be used for placing a block, based on the block name. 
    
    Returns -1 if the block is unsupported
    Returns -2 if there Squirt doesn't have the block to place

    Assumes supported blocks are ordered by quantity
]]
local function getPlaceInventoryIndex(block)
    local BLOCK_UNSUPPORTED = -1
    local BLOCK_NOT_IN_INVENTORY = -2

    local index = BLOCK_UNSUPPORTED

    if block == "dirt" then
        --[[ Start the index at four, move backwards in dirt space until the
            space is not empty. If this never occurs, set the index to -2 
        ]]
        index = 4
        while squirt.count(index) == 0 and index > 1 do
            index = index - 1
        end

        --[[ Previous while ends when index == 1 but count has not occurred. 
            This is because count(0) throws an error. If this occurs, set
            index to -2 ]]
        if index == 1 and squirt.count(index) == 0 then
            index = BLOCK_NOT_IN_INVENTORY
        end

    elseif block == "cobblestone" then
        --[[ Start the index at 8, move backwards in the cobblestone space
            until the space is not empty. If this never occurs, set the index 
            to -2 
        ]]
        index = 8
        while squirt.count(index) == 0 and index >= 5 do
            index = index - 1
        end

        -- If index rolled under 5, set it to -2
        if index < 5 then
            index = BLOCK_NOT_IN_INVENTORY
        end

    end

    return index
end

--[[ Given a side, returns if a block exists on that side.
    NOTE Since this function is only used internally, it's assuming
    the side is valide ]]
local function blockExists(side)
    local block_exists = nil

    if side == "front" then
        -- Detect block in front of squirt
        block_exists, _ = squirt.detect()

    elseif side == "right" then
        -- Turn Squirt to the right, detect, then turn Squirt back
        sq_swim.sqTurnRight()
        block_exists, _ = squirt.detect()
        sq_swim.sqTurnLeft()

    elseif side == "left" then
        -- Turn Squirt to the left, detect, then turn Squirt back
        sq_swim.sqTurnLeft()
        block_exists, _ = squirt.detect()
        sq_swim.sqTurnRight()

    elseif side == "back" or side == "behind" then
        -- Turn Squirt around, detect, then turn Squirt around
        sq_swim.sqTurnAround()
        block_exists, _ = squirt.detect()
        sq_swim.sqTurnAround()

    elseif side == "up" or side == "top" then
        -- Detect up
        block_exists, _ = squirt.detectUp()

    elseif side == "down" or side == "under" or side == "bottom" or side == "beneath" then
        -- Detect down
        block_exists, _ = squirt.detectDown()

    end

    return block_exists

end


-- TODO I think this is a badly designed function
--[[ Given a side and a block name, Place the block on that side. Returns a positive
    number if the block was placed successfully. Return a negative number otherwise.
    
    Returns -1 if the block is unsupported
    Returns -2 if Squirt doesn't have the block requested
    Returns -3 if there's already a block on the requested side
    Returns -4 if the side is invalid
    Returns -5 if a reference block does not exist. i.e. Cannot place a floating block
]]
function act.sqPlaceBlock(side, block)
    local BLOCK_UNSUPPORTED = -1
    local BLOCK_NOT_IN_INVENTORY = -2
    local BLOCK_DETECTED_ON_SIDE = -3
    local INVALID_SIDE = -4
    local NO_REFERENCE_BLOCK = -5

    local SUCCESS = 1
    local exitcode = SUCCESS

    -- Check that the side is supported. Return INVALID_SIDE if it is not
    if not ( side == "front" or 
             side == "right" or
             side == "left" or
             side == "back" or side == "behind" or
             side == "up" or side == "top" or
             side == "down" or side == "bottom" or side == "under" or side == "beneath"
            ) then
        
        return INVALID_SIDE

    end

    -- TODO Left off here. Functionalize this so the block detection, index finding, and picking up the block are seperate local functions
    
    -- Make sure there's not a block on that side
    if not blockExists(side) then

        -- Squirt selects the proper inventory index for the requested block
        if getPlaceInventoryIndex(block) < 0 then
            return getPlaceInventoryIndex(block)
        else
            squirt.select( getPlaceInventoryIndex(block) )
        end

    else 
        -- Return that a block was detected
        return BLOCK_DETECTED_ON_SIDE
    end

    -- Boolean used to track if the block was successfully placed
    local placed = true

    -- Turn to the side, place the block and turn back
    -- TODO QUESTION Should Squirt turn back?
    if side == "front" then
        -- Place a block in front of Squirt
        placed = squirt.place()

    elseif side == "right" then
        -- Turn Squirt to the right, place a block, turn back
        sq_swim.sqTurnRight()
        placed = squirt.place()
        sq_swim.sqTurnLeft()

    elseif side == "left" then
        -- Turn Squirt to the left, place a block, then back
        sq_swim.sqTurnLeft()
        placed = squirt.place()
        sq_swim.sqTurnRight()

    elseif side == "back" or side == "behind" then
        -- Turn Squirt around, place a block, then back
        sq_swim.sqTurnAround()
        placed = squirt.place()
        sq_swim.sqTurnAround()

    elseif side == "top" or side == "up" then
        -- Place a block up
        placed = squirt.placeUp()
    
    elseif side == "bottom" or side == "down" or side == "under" or side == "beneath" then
        -- Place block down
        placed = squirt.placeDown()
    
    end

    if not placed then
        return NO_REFERENCE_BLOCK
    else
        return SUCCESS
    end

end



            
return act
    


