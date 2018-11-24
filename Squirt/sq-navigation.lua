local debug = require("component").debug

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
-- NOTE Back of envs must be facing West

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

return nav
