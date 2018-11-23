--[[ This module is responsible for allowing Squirt to communicate with the EAC ]]

local squirt = require("robot")
local debug = require("component").debug
local nav = require("component").navigation
local sq_nav = require("sq-navigation")
local sq_swim = require("sq-swim")
local sq_act = require("sq-act")

-- Table to hold functions of this module we wish the caller to have
local comms = {}



return comms