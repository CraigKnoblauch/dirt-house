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

--[[ Serves as a wrapper for a robot's back function. Without this function, squirt would 
    report his position as the block he came from, rather than the block he's going to. ]]
function swim.sqBack()
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

    -- Return the back's usual return
    return ret
end

--[[ Serves as a wrapper for a robot's up function. Without this function, squirt would 
    report his position as the block he came from, rather than the block he's going to. ]]
function swim.sqUp()
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

    -- Return the up's usual return
    return ret
end

--[[ Serves as a wrapper for a robot's down function. Without this function, squirt would 
    report his position as the block he came from, rather than the block he's going to. ]]
function swim.sqDown()
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

    -- Return the down's usual return
    return ret
end

--[[ Turn left. Unaware if additional functionality will be needed at this time ]]
function swim.sqTurnLeft()
    -- Turn left
    squirt.turnLeft()
end

--[[ Turn right. Unaware if additional functionality will be needed at this time ]]
function swim.sqTurnRight()
    -- Turn right
    squirt.turnRight()
end

--[[ Turn around. Unaware if additional functionality will be needed ]]
function swim.sqTurnAround()
    -- Turn around
    squirt.turnAround()
end

--[[ Values of component.navigation.getFacing given here: https://github.com/MightyPirates/OpenComputers/issues/2984
    Also confirmed in game
    - North == 2
    - East == 5
    - South == 3
    - West == 4 

    This functions returns a string direction rather than the number. Returns nil if the number is unknown
  ]]
function swim.sqGetFacing()
    -- Get the number of the direction Squirt is facing
    facing_num = nav.getFacing()
    facing_str = "nil"

    -- Determine the direction Squirt is facing
    if facing_num == 2 then
        facing_str = "north"
    elseif facing_num == 5 then
        facing_str = "east"
    elseif facing_num == 3 then
        facing_str = "south"
    elseif facing_num == 4 then
        facing_str = "west"
    end

    return facing_str
end

--[[ Takes Squirt to the postion specified in arguments 
    Assumes that there will be no blocks to run into 7 blocks above it's current pos 
    Also assumes that the destination Y will be beneath it after it's upward move ]]
function swim.sqGoToPos(destX, destY, destZ)
    -- Move squirt 7 blocks up so he's clear of obstructions in the environment
    -- NOTE: This can only be assumed to work in a specific environment and setting
    for i = 1, 7, 1 do swim.sqUp() end

    -- Get Squirt's current postion
    local initX, initY, initZ
    initX, initY, initZ = sq_nav.sqGetPos()

    -- Get Squirt's orientation
    local facing = swim.sqGetFacing()

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
            facing = swim.sqGetFacing()
        end

    -- If diffX > 0, face west
    elseif diffX > 0 then
        while facing ~= "west" do
            swim.sqTurnRight()
            facing = swim.sqGetFacing()
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
            facing = swim.sqGetFacing()
        end

    -- If diffZ > 0, face north
    elseif diffZ > 0 then
        while facing ~= "north" do
            swim.sqTurnRight()
            facing = swim.sqGetFacing()
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

--[[ Command squirt to navigate to the waypoint whose label is specified 
    as argument ]]
function swim.sqGoToWaypoint(label)
    -- Get all waypoints in a 1000 block area
    -- NOTE TODO The 1000 blocks is completely arbitrary. What's a good distance.
    local range = 1000
    local waypoints_tbl = nav.findWaypoints(range)

    --[[ All we care about are the labels and their positions. So, the following
        code organizes the labels and their position tables into a set]]
    waypoints_set = {}
    
    -- TODO QUESTION Is this code too slow for OpenComputers?
    -- TODO Change this to break when the label is found
    -- For each table in waypoints_tbl, use the label as a key, and the postion table as a value
    for i = 1, waypoints_tbl.n - 1, 1 do
        waypoint_label = waypoints_tbl[i].label
        waypoint_position = waypoints_tbl[i].position

        waypoints_set[ waypoint_label ] = waypoint_position
    end

    -- Get the destination position relative to Squirt
    local relative_dest = waypoints_set[label]

    --[[ The destination coordinates are relative to Squirt. The easiest way to resolve
        this is to convert these coordinates into world coordinates. Then we can use the 
        previously defined sqGoToPos function ]]

    -- Get the current coordinates
    local squirtX, squirtY, squirtZ
    squirtX, squirtY, squirtZ = sq_nav.sqGetPos()

    -- Get the relative destination coordinates
    local relative_destX = relative_dest[1]
    local relative_destY = relative_dest[2]
    local relative_destZ = relative_dest[3]

    -- Calculate the world destination coordinates
    local world_destX = squirtX + relative_destX
    local world_destY = squirtY + relative_destY
    local world_destZ = squirtZ + relative_destZ

    -- Send Squirt to the waypoint position
    swim.sqGoToPos(world_destX, world_destY, world_destZ)
end

return swim
    
