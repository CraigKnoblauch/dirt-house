--[[ This module is responsible for allowing Squirt to communicate with the EAC ]]

local squirt = require("robot")
local debug = require("component").debug
local nav = require("component").navigation
local it = require("component").internet
local sq_nav = require("sq-navigation")
local sq_swim = require("sq-swim")
local sq_act = require("sq-act")

-- Table to hold functions of this module we wish the caller to have
local comms = {}

-- The ip address that Squirt must connect to
local ADDRESS = "127.0.0.1"

-- The port that Squirt must connect to
local PORT = 65432

-- Handle to manage connection
-- Hacked to be a consistent variable
handle = nil

-- Number of bytes to read has been standardized to this number
local NUM_READ_BYTES = 5

--[[ Opens and assignes connection opened at ADDRESS:PORT, to the local handle ]]
function comms.sqConnect()
    handle = it.connect(ADDRESS, PORT)
end

--[[ Close the connection ]]
function comms.sqClose()
    handle.close()
end

--[[ Uses the local handle to read from the connection. If the handle has not
    yet been assigned, returns "ERROR: NO CONNECTION" ]]
function comms.sqRead()
    local read = "ERROR: NO CONNECTION"

    -- Check if the connection is open
    if handle ~= nil then
        read = handle.read(NUM_READ_BYTES)
    end

    return read
end

return comms