--[[ This module is responsible for moving and navigating within the world ]]

local squirt = require("robot")
local debug = require("component").debug
local nav = require("component").navigation
local sq_nav = require("sq-navigation")

-- Table of functions to return 
local swim = {}

--[[ Serves as a wrapper for a robot's forward function. Without this function, squirt would 
    report his position as the block he came from, rather than the block he's going to. ]]
function swim.sqForward()
    -- Get the coordinates before the move
    local initX, initY, initZ
    initX, initY, initZ = sq_nav.sqGetPos()
    
    -- Move squirt forward
    ret = squirt.forward()
    if ret == true then

        -- While squirt has not moved relative to his starting location
        while initX == sq_nav.sqGetX() and initY == sq_nav.sqGetY() and initZ == sq_nav.sqGetZ() do
            -- Block
        end

    end

    -- Return the forward's usual return
    return ret
end

return swim
    