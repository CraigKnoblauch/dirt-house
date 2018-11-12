local debug = require("component").debug

-- TODO Need a class structure so we can have a persistant orientation

-- TODO QUESTION Is my world always 0?
local world = debug.getWorld(0)

-- Table of functions to return
local nav = {}

--[[ Wrapper for debug's getX function. This function is off by 1 in the mod. Here,
    that is compensated for by subtracting 1 from the the return of getX. The subtraction
    only occurs here. So if the OpenComputers mod is ever updated so this problem is solved,
    just remove the -1]]
function nav.sqGetX()
    local thisX = world.getX()
    thisX = thisX
    return thisX
end

--[[ Wrapper for debug's getY function. Not strictly needed in the same way the getX function
    is, but is included for consistency]]
function nav.sqGetY()
    local thisY = world.getY()
    return thisY
end

--[[ Wrapper for debug's getY function. Not strictly needed in the same way the getX function
    is, but is included for consistency]]
function nav.sqGetZ()
    local thisZ = world.getZ()
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

return nav
