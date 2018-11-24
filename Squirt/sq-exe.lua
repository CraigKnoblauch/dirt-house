local sq_swim = require("sq-swim")
local sq_act = require("sq-act")

-- Table of functions that this module will return
local exe = {}


-- This is how the action codes are assigned. Complimentary table in Crush/EAC ]]
FORWARD             = "001"
BACK                = "002"
UP                  = "003"
DOWN                = "004"
TURN_LEFT           = "005"
TURN_RIGHT          = "006"
TURN_AROUND         = "007"
PICK_UP_BLOCK       = "008"

--[[ Since the comms are so finnicky, and the messages to Squirt must be of fixed
    length, there are two options for place block. This way we don't have to have
    separate block codes to worry about ]]
PLACE_DIRT_BLOCK    = "009"
PLACE_COBBLE_BLOCK  = "010"

NEXT_EPISODE        = "011"

--[[ Decodes the action code given to direct Squirt.
    Returns what the function would have returned (It's at this point that I realized how bad it was to not define a standard return early on.)
    Returns "invalid action code" if the action code is unknown 
]]
function exe.executeAction(action_code)
    
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
