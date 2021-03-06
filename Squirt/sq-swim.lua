--[[ This module is responsible for moving and navigating within the world ]]

local squirt = require("robot")
local debug = require("component").debug
local sq_nav = require("sq-navigation")

-- Table of functions to return 
local swim = {}

--[[ Serves as a wrapper for a robot's forward function. Without this function, squirt would 
    report his position as the block he came from, rather than the block he's going to. 

    Returns 1 if success
    Returns -1 if fail
    Returns 0 if the time_t's roll around
]]
function swim.sqForward()
    local outcome = 0

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

    -- Convert forward's result into a number. 1 if true, -1 if false
    if ret then
        outcome = 1
    else
        outcome = -1
    end

    return outcome
end

--[[ Serves as a wrapper for a robot's back function. Without this function, squirt would 
    report his position as the block he came from, rather than the block he's going to. 

    Returns 1 if success
    Returns -1 if fail
    Returns 0 if the time_t's roll around
]]
function swim.sqBack()
    local outcome = 0
    
    -- Get the coordinates before the move
    local initX, initY, initZ
    initX, initY, initZ = sq_nav.sqGetPos()
    
    -- Move squirt back
    ret = squirt.back()
    if ret == true then

        -- While squirt has not moved relative to his starting location
        while initX == sq_nav.sqGetX() and initY == sq_nav.sqGetY() and initZ == sq_nav.sqGetZ() do
            -- Block
        end

    end

    -- Convert back's result into a number. 1 if true, -1 if false
    if ret then
        outcome = 1
    else
        outcome = -1
    end

    return outcome
end

--[[ Serves as a wrapper for a robot's up function. Without this function, squirt would 
    report his position as the block he came from, rather than the block he's going to. 

    Returns 1 if success
    Returns -1 if fail
    Returns 0 if the time_t's roll around
]]
function swim.sqUp()
    local outcome = 0

    -- Get the coordinates before the move
    local initX, initY, initZ
    initX, initY, initZ = sq_nav.sqGetPos()
    
    -- Move squirt up
    ret = squirt.up()
    if ret == true then

        -- While squirt has not moved relative to his starting location
        while initX == sq_nav.sqGetX() and initY == sq_nav.sqGetY() and initZ == sq_nav.sqGetZ() do
            -- Block
        end

    end

    -- Convert up's result into a number. 1 if true, -1 if false
    if ret then
        outcome = 1
    else
        outcome = -1
    end

    return outcome
end

--[[ Serves as a wrapper for a robot's down function. Without this function, squirt would 
    report his position as the block he came from, rather than the block he's going to. 
    
    Returns 1 if success
    Returns -1 if fail
    Returns 0 if the time_t's roll around
]]
function swim.sqDown()
    local outcome = 0

    -- Get the coordinates before the move
    local initX, initY, initZ
    initX, initY, initZ = sq_nav.sqGetPos()
    
    -- Move squirt down
    ret = squirt.down()
    if ret == true then

        -- While squirt has not moved relative to his starting location
        while initX == sq_nav.sqGetX() and initY == sq_nav.sqGetY() and initZ == sq_nav.sqGetZ() do
            -- Block
        end

    end

    -- Convert down's result into a number. 1 if true, -1 if false
    if ret then
        outcome = 1
    else
        outcome = -1
    end

    return outcome

end

--[[ Turn left. Unaware if additional functionality will be needed at this time 
    Returns 1 if successful turn, -1 if unsuccessful, 0 if the time_t's rolled around
]]
function swim.sqTurnLeft()
    local outcome = 0
    -- Turn left and record the result
    if squirt.turnLeft() then
        outcome = 1
    else
        outcome = -1
    end

    -- Update the GLOBAL Facing
    if outcome == 1 then
        sq_nav.sqUpdateFacing("left")
    end

    return outcome

end

--[[ Turn right. Unaware if additional functionality will be needed at this time 
    Returns 1 if successful turn, -1 if unsuccessful, 0 if the time_t's rolled around
]]
function swim.sqTurnRight()
    local outcome = 0
    -- Turn right and record the result
    if squirt.turnRight() then
        outcome = 1
    else
        outcome = -1
    end

    -- Update the global FACING
    if outcome == 1 then
        sq_nav.sqUpdateFacing("right")
    end

    return outcome
end

--[[ Turn around. Unaware if additional functionality will be needed at this time 
    Returns 1 if successful turn, -1 if unsuccessful, 0 if the time_t's rolled around
]]
function swim.sqTurnAround()
    local outcome = 0
    -- Turn around and record the result
    if squirt.turnAround() then
        outcome = 1
    else
        outcome = -1
    end

    -- Update the global FACING
    if outcome == 1 then
        sq_nav.sqUpdateFacing("around")        
    end

    return outcome
end

--[[ Takes Squirt to the postion specified in arguments 
    Assumes that there will be no blocks to run into 7 blocks above it's current pos 
    Also assumes that the destination Y will be beneath it after it's upward move ]]
function swim.sqGoToPos(destX, destY, destZ)
    -- Defines the Y flight height that Squirt should be at before moving forward.
    -- TODO Change this is if the environment changes
    local FLIGHT_Y = 17

    -- Move squirt up to the flight height so he's clear of obstructions in the environment
    -- NOTE: This can only be assumed to work in a specific environment and setting
    -- TODO: What if Squirt is above the flight height
    for i = math.floor(sq_nav.sqGetY()), FLIGHT_Y, 1 do 
        squirt.select(9)
        squirt.swingUp()
        swim.sqUp() 
    end

    -- Get Squirt's current postion
    local initX, initY, initZ
    initX, initY, initZ = sq_nav.sqGetPos()

    -- Get Squirt's orientation
    local facing = sq_nav.sqGetFacing()

    -- Calculate the difference between Squirt's current location and the destination
    local diffX, diffY, diffZ
    diffX = initX - destX
    diffY = initY - destY
    diffZ = initZ - destZ

    --[[ Travel to the correct X ]]
    ---------------------------------------------------------------
    -- If diffX < 0, face east
    if diffX < 0 then
        while facing ~= "east" do
            swim.sqTurnRight()
            facing = sq_nav.sqGetFacing()
        end

    -- If diffX > 0, face west
    elseif diffX > 0 then
        while facing ~= "west" do
            swim.sqTurnRight()
            facing = sq_nav.sqGetFacing()
        end

    -- In the event diffX == 0, do nothing
    end

    -- Travel the absolute value of diffX forward
    for i = 1, math.abs(diffX), 1 do swim.sqForward() end
    ---------------------------------------------------------------

    --[[ Travel to the correct Z. Remember Z is not up and down]]
    ---------------------------------------------------------------
    -- If diffZ < 0, face south
    if diffZ < 0 then
        while facing ~= "south" do
            swim.sqTurnRight()
            facing = sq_nav.sqGetFacing()
        end

    -- If diffZ > 0, face north
    elseif diffZ > 0 then
        while facing ~= "north" do
            swim.sqTurnRight()
            facing = sq_nav.sqGetFacing()
        end

    -- In the event diffZ == 0, do nothing
    end

    -- Travel the absolute value of diffZ forward
    for i = 1, math.abs(diffZ), 1 do swim.sqForward() end 
    ---------------------------------------------------------------

    --[[ Travel to destination Y (elevation) ]]
    -- Assume destination Y is beneath Squirt after the 7 block upward move 
    while math.abs( sq_nav.sqGetY() - destY ) > 0.5 do
        swim.sqDown()
    end
end

-- NOTE: Cannot have this functionality without the navigation component
-- --[[ Command squirt to navigate to the waypoint whose label is specified 
--     as argument ]]
-- function swim.sqGoToWaypoint(label)
--     -- Get all waypoints in a 1000 block area
--     -- NOTE TODO The 1000 blocks is completely arbitrary. What's a good distance.
--     local range = 1000
--     local waypoints_tbl = nav.findWaypoints(range)

--     --[[ All we care about are the labels and their positions. So, the following
--         code organizes the labels and their position tables into a set]]
--     waypoints_set = {}
    
--     -- TODO QUESTION Is this code too slow for OpenComputers?
--     -- TODO Change this to break when the label is found
--     -- For each table in waypoints_tbl, use the label as a key, and the postion table as a value
--     for i = 1, waypoints_tbl.n - 1, 1 do
--         waypoint_label = waypoints_tbl[i].label
--         waypoint_position = waypoints_tbl[i].position

--         waypoints_set[ waypoint_label ] = waypoint_position
--     end

--     -- TODO handle the case where the label is unknown
--     -- Get the destination position relative to Squirt
--     local relative_dest = waypoints_set[label]

--     --[[ The destination coordinates are relative to Squirt. The easiest way to resolve
--         this is to convert these coordinates into world coordinates. Then we can use the 
--         previously defined sqGoToPos function ]]

--     -- Get the current coordinates
--     local squirtX, squirtY, squirtZ
--     squirtX, squirtY, squirtZ = sq_nav.sqGetPos()

--     -- Get the relative destination coordinates
--     local relative_destX = relative_dest[1]
--     local relative_destY = relative_dest[2]
--     local relative_destZ = relative_dest[3]

--     -- Calculate the world destination coordinates
--     local world_destX = squirtX + relative_destX
--     local world_destY = squirtY + relative_destY
--     local world_destZ = squirtZ + relative_destZ

--     -- Send Squirt to the waypoint position
--     swim.sqGoToPos(world_destX, world_destY, world_destZ)
-- end

--[[ Moves Squirt to the beginning of the episode count given.
    Faces him east (forward) after taking him there. ]]
function swim.sqGoToEpisode(episode)
    --[[ The destination coordinates are relative to Squirt. The easiest way to resolve
        this is to convert these coordinates into world coordinates. Then we can use the 
        previously defined sqGoToPos function ]]

    -- Get the current coordinates
    local squirtX, squirtY, squirtZ
    squirtX, squirtY, squirtZ = sq_nav.sqGetPos()

    -- Get the relative episodic destination coordinates
    local relative_destX = sq_nav.sqGetEpisodicX(episode)
    local relative_destY = sq_nav.sqGetEpisodicY(episode)
    local relative_destZ = sq_nav.sqGetEpisodicZ(episode)

    -- Calculate the world destination coordinates
    -- minus compensates for world orientation
    local world_destX = squirtX - relative_destX
    local world_destY = squirtY - relative_destY
    local world_destZ = squirtZ - relative_destZ

    -- Send Squirt to the episode position
    swim.sqGoToPos(world_destX, world_destY, world_destZ)

    -- Face Squirt east
    local facing = sq_nav.sqGetFacing()

    if facing == "north" then
        swim.sqTurnRight()
    elseif facing == "south" then
        swim.sqTurnLeft()
    elseif facing == "west" then
        swim.sqTurnAround()
    end

end

return swim
    
