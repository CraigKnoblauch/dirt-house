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

--[[ Returns a handle to the connection opened at ADDRESS:PORT ]]
function comms.sqConnect()
    return it.connect(ADDRESS, PORT)
end

return comms