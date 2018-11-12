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
    ret = squirt.forward()
    if ret == true then

        -- While squirt has not moved relative to his starting location
        while initX == nav.sqGetX() and initY == nav.sqGetY() and initZ == nav.sqGetZ() do
            -- Block
        end

    end

    -- Return the forward's usual return
    return ret
end

--[[ Serves as a wrapper for a robot's back function. Without this function, squirt would 
    report his position as the block he came from, rather than the block he's going to. ]]
function mv.sqBack()
    -- Get the coordinates before the move
    local initX, initY, initZ
    initX, initY, initZ = nav.sqGetPos()
    
    -- Move squirt back
    ret = squirt.back()
    if ret == true then

        -- While squirt has not moved relative to his starting location
        while initX == nav.sqGetX() and initY == nav.sqGetY() and initZ == nav.sqGetZ() do
            -- Block
        end

    end

    -- Return the back's usual return
    return ret
end

--[[ Serves as a wrapper for a robot's up function. Without this function, squirt would 
    report his position as the block he came from, rather than the block he's going to. ]]
function mv.sqUp()
    -- Get the coordinates before the move
    local initX, initY, initZ
    initX, initY, initZ = nav.sqGetPos()
    
    -- Move squirt up
    ret = squirt.up()
    if ret == true then

        -- While squirt has not moved relative to his starting location
        while initX == nav.sqGetX() and initY == nav.sqGetY() and initZ == nav.sqGetZ() do
            -- Block
        end

    end

    -- Return the up's usual return
    return ret
end

--[[ Serves as a wrapper for a robot's down function. Without this function, squirt would 
    report his position as the block he came from, rather than the block he's going to. ]]
function mv.sqDown()
    -- Get the coordinates before the move
    local initX, initY, initZ
    initX, initY, initZ = nav.sqGetPos()
    
    -- Move squirt down
    ret = squirt.down()
    if ret == true then

        -- While squirt has not moved relative to his starting location
        while initX == nav.sqGetX() and initY == nav.sqGetY() and initZ == nav.sqGetZ() do
            -- Block
        end

    end

    -- Return the down's usual return
    return ret
end

return mv
