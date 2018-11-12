local squirt = require("robot")
local debug = require("component").debug
local nav = require("navigation")

-- Table of functions to return
local mv = {}

--[[ Serves as a wrapper for a robot's forward function. Without this function, squirt would 
    report his position as the block he came from, rather than the block he's going to. ]]
function mv.sqForward()
    -- Get the coordinates before the move
    local initX, initY, initZ
    initX, initY, initZ = nav.sqGetPos()
    
    -- Move squirt forward
    squirt.forward()

    -- While squirt has not moved relative to his starting location
    while initX == nav.sqGetX() and initY == nav.sqGetY() and initZ == nav.sqGetZ() do
        -- Block
    end

    -- Return the current position. 
    return nav.sqGetX(), nav.sqGetY(), nav.sqGetZ()
end
