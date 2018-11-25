local sq_swim = require("sq-swim")
local sq_act = require("sq-act")
local sq_nav = require("sq-navigation")

-- Table of functions that this module will return
local exe = {}

-- This is BAD design, but it's too late to make this OO
-- This value tracks what episode Squirt is on. It's used to adjust relative positions
SQ_EXE_EPISODE_COUNT = 0


-- This is how the action codes are assigned. Complimentary table in Crush/EAC ]]
local FORWARD             = "001"
local BACK                = "002"
local UP                  = "003"
local DOWN                = "004"
local TURN_LEFT           = "005"
local TURN_RIGHT          = "006"
local TURN_AROUND         = "007"
local PICK_UP_BLOCK       = "008"

--[[ Since the comms are so finnicky, and the messages to Squirt must be of fixed
    length, there are two options for place block. This way we don't have to have
    separate block codes to worry about ]]
local PLACE_DIRT_BLOCK    = "009"
local PLACE_COBBLE_BLOCK  = "010"

local NEXT_EPISODE        = "011"

--[[ Function local to this module. Used to check if the action requested of Squirt will operate
    out of bounds. ]]
function exe.isActionOutOfBounds(action_code) 
    local nextX, nextY, nextZ
    local isOutOfBounds = false

    -- Get the anticipated block that this action will affect
    if action_code == FORWARD then
        nextX, nextY, nextZ = sq_nav.sqGetNextEpisodicPos(SQ_EXE_EPISODE_COUNT, "forward")

    elseif action_code == BACK then
        nextX, nextY, nextZ = sq_nav.sqGetNextEpisodicPos(SQ_EXE_EPISODE_COUNT, "back")

    elseif action_code == UP then
        nextX, nextY, nextZ = sq_nav.sqGetNextEpisodicPos(SQ_EXE_EPISODE_COUNT, "up")

    elseif action_code == DOWN then
        nextX, nextY, nextZ = sq_nav.sqGetNextEpisodicPos(SQ_EXE_EPISODE_COUNT, "down")

    elseif action_code == PICK_UP_BLOCK then
        nextX, nextY, nextZ = sq_nav.sqGetNextEpisodicPos(SQ_EXE_EPISODE_COUNT, "pick up block")

    elseif action_code == PLACE_COBBLE_BLOCK or action_code == PLACE_DIRT_BLOCK then
        nextX, nextY, nextZ = sq_nav.sqGetNextEpisodicPos(SQ_EXE_EPISODE_COUNT, "place block")
        
    end

    --[[ Next position is out of bounds if:
        X < 0, Z < 0, Y < 0
        X > 15, Z > 15, Y > 8
    ]]
    if nextX >= 0 and nextZ >= 0 and nextY >= 0 and nextX <= 15 and nextZ <= 15 and nextY <= 8 then
        isOutOfBounds = false
    else
        isOutOfBounds = true
    end

    return isOutOfBounds
end
    

--[[ Decodes the action code given to direct Squirt.
    Returns what the function would have returned (It's at this point that I realized how bad it was to not define a standard return early on.)
    Returns "invalid action code" if the action code is unknown 
]]
function exe.sqExecuteAction(action_code)

    -- TODO, do NOT allow Squirt to perform actions on the boundaries
    
    -- Use action codes defined above to call correct action
    if action_code == FORWARD then
        return sq_swim.sqForward()

    elseif action_code == BACK then
        return sq_swim.sqBack()

    elseif action_code == UP then
        return sq_swim.sqUp()

    elseif action_code == DOWN then
        return sq_swim.sqDown()

    elseif action_code == TURN_LEFT then
        return sq_swim.sqTurnLeft()

    elseif action_code == TURN_RIGHT then
        return sq_swim.sqTurnRight()

    elseif action_code == TURN_AROUND then
        return sq_swim.sqTurnAround()

    elseif action_code == PICK_UP_BLOCK then
        -- Hardcoded front, because, I make bad design choices when I'm tired.
        -- Talking about sq-act
        return sq_act.sqPickUpBlock("front")

    elseif action_code == PLACE_DIRT_BLOCK then
        return sq_act.sqPlaceBlock("front", "dirt")

    elseif action_code == PLACE_COBBLE_BLOCK then
        return sq_act.sqPlaceBlock("front", "cobblestone")
    else
        return "invalid action code"
    end

    -- Ugh, no end return statement. Dijsktra is rolling over in his grave
end

return exe
