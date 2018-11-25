local debug = require("component").debug
local ocnav = require("component").navigation

-- Table of functions to return
local nav = {}

-- Persistant variables that Squirt will have access to. Squirt set's these on Episode 1
SQ_INIT_X = 0
SQ_INIT_Y = 0
SQ_INIT_Z = 0

--[[ Wrapper for debug's getX function. This function is off by 1 in the mod. Here,
    that is compensated for by subtracting 1 from the the return of getX. The subtraction
    only occurs here. So if the OpenComputers mod is ever updated so this problem is solved,
    just remove the -1]]
function nav.sqGetX()
    local thisX = debug.getX()
    thisX = thisX
    return thisX
end

--[[ Wrapper for debug's getY function. Not strictly needed in the same way the getX function
    is, but is included for consistency]]
function nav.sqGetY()
    local thisY = debug.getY()
    return thisY
end

--[[ Wrapper for debug's getY function. Not strictly needed in the same way the getX function
    is, but is included for consistency]]
function nav.sqGetZ()
    local thisZ = debug.getZ()
    return thisZ
end

--[[ Return the position of Squirt ]]
function nav.sqGetPos()
    local thisX, thisY, thisZ

    thisX = nav.sqGetX()
    thisY = nav.sqGetY()
    thisZ = nav.sqGetZ()

    return thisX, thisY, thisZ
end

--[[ Allows squirt to set the absolute init points without knowledge of them ]]
function nav.sqSetAbsInitPos()
    SQ_INIT_X, SQ_INIT_Y, SQ_INIT_Z = nav.sqGetPos()
end

-- TODO on all, handle weird cases with return codes
-- NOTE Back of envs must be facing East

--[[ Return Squirt's X position based on the episode count.
    NOTE: While currently Squirt's x pos is not dependent on episode
    count, it's good practice to have this function used as if it does.
    Just in case the setup changes in the future 
]]
function nav.sqGetEpisodicX(episode)
    local epX = nil

    epX = nav.sqGetX() - SQ_INIT_X

    return epX
end

--[[ Return Squirt's Y position based on the episode count.
    NOTE: While currently Squirt's y pos is not dependent on episode
    count, it's good practice to have this function used as if it does.
    Just in case the setup changes in the future 
]]
function nav.sqGetEpisodicY(episode)
    local epY = nil

    epY = nav.sqGetY() - SQ_INIT_Y

    return epY
end

--[[ Return Squirt's Z position based on the episode count ]]
function nav.sqGetEpisodicZ(episode)
    local epZ = nil

    -- 18 because each starting point is 18 blocks away
    epZ = nav.sqGetZ() - SQ_INIT_Z - (18 * episode)

    return epZ
end

--[[ Return Squirt's episodic position based on the episode count ]]
function nav.sqGetEpisodicPos(episode)
    local epX, epY, epZ

    epX = nav.sqGetEpisodicX(episode)
    epY = nav.sqGetEpisodicY(episode)
    epZ = nav.sqGetEpisodicZ(episode)

    return epX, epY, epZ
end

-- Local function below is taken from swim. I would've used that function, but I don't want this module to be aware of swim
--[[ Values of component.navigation.getFacing given here: https://github.com/MightyPirates/OpenComputers/issues/2984
    Also confirmed in game
    - North == 2
    - East == 5
    - South == 3
    - West == 4 

    This functions returns a string direction rather than the number. Returns nil if the number is unknown
]]
local function sqGetFacing()
    -- Get the number of the direction Squirt is facing
    facing_num = ocnav.getFacing()
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

--[[ Returns the next episodic position based on the current facing direction,
    and the action selected ]]
function nav.sqGetNextEpisodicPos(episode, action)
    local facing = sqGetFacing()
    local nextX, nextY, nextZ = nav.sqGetEpisodicPos(episode)

    if action == "forward" or action == "pick up block" or action == "place block" or action == "place dirt block" or action == "place cobblestone block" then
        if facing == "north" then
            -- Intent to move/interact with -Z
            nextZ = nextZ - 1
        elseif facing == "east" then
            -- Intent to move/interact with +X
            nextX = nextX + 1
        elseif facing == "south" then
            -- Intent to move/interact with +Z
            nextZ = nextZ + 1
        elseif facing == "west" then
            -- Intent to move/interact with -X
            nextX = nextX - 1
        end -- end forward
    
    elseif action == "back" then
        if facing == "north" then
            -- Intent to move +Z
            nextZ = nextZ + 1
        elseif facing == "east" then
            -- Intent to move -X
            nextX = nextX - 1
        elseif facing == "south" then
            -- Intent to move -Z
            nextZ = nextZ - 1
        elseif facing == "west" then
            -- Intent to move +X
            nextX = nextX + 1
        end -- end back

    elseif action == "up" then
        -- Intent to move +Y
        nextY = nextY + 1

    elseif action == "down" then
        -- Intent to move -Y
        nextY = nextY - 1
    end -- end all

    return nextX, nextY, nextZ
end
        


return nav
