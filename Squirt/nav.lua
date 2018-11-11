local squirt = require("robot")
local debug = require("component").debug

-- Table of functions to return
local nav = {}

--[[ Serves as a wrapper for a robot's forward function. Without this function, squirt would 
    report his position as the block he came from, rather than the block he's going to. ]]
function nav.sqForward()
    -- Get the coordinates before the move
    local initX, initY, initZ
    initX = debug.getX() - 1
    initY = debug.getY()
    initZ = debug.getZ()

    -- While squirt has not moved relative to his starting location
    while initX == debug.getX() - 1 and initY == debug.getY() and initZ == debug.getZ() do
        -- Block
    end

    -- Return the current position. 
    return debug.getX() - 1, debug.getY(), debug.getZ()
end

return nav
