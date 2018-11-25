s = require("sq-swim")
n = require("sq-navigation")
e = require("sq-exe")
r = require("robot")

-- Set the episode init points here
n.sqSetAbsInitPos()

-- Action codes
local FORWARD             = "001"
local BACK                = "002"
local UP                  = "003"
local DOWN                = "004"
local TURN_LEFT           = "005"
local TURN_RIGHT          = "006"
local TURN_AROUND         = "007"
local PICK_UP_BLOCK       = "008"
local PLACE_DIRT_BLOCK    = "009"
local PLACE_COBBLE_BLOCK  = "010"

local out = nil
local action = nil

-- Tables to hold results
local up = {}
local down = {}
local forward = {}
local back = {}
local pick_up = {}
local place = {}

-- Expectations 
-- false: Not out of bounds
-- true: out of bounds
local DOWN_NUM = 3
local down_expectations = {}
down_expectations[1] = false -- At ceiling
down_expectations[2] = false  
down_expectations[3] = true  

local UP_NUM = 3
local up_expectations = {}
up_expectations[1] = false
up_expectations[2] = false
up_expectations[3] = true

local FORWARD_NUM = 32
local forward_expectations = {}
forward_expectations[1]  = true
forward_expectations[2]  = true
forward_expectations[3]  = false
forward_expectations[4]  = false
forward_expectations[5]  = false
forward_expectations[6]  = true
forward_expectations[7]  = true
forward_expectations[8]  = false
forward_expectations[9]  = false
forward_expectations[10] = false
forward_expectations[11] = true
forward_expectations[12] = true
forward_expectations[13] = true
forward_expectations[14] = false
forward_expectations[15] = false
forward_expectations[16] = true
forward_expectations[17] = true
forward_expectations[18] = true
forward_expectations[19] = true
forward_expectations[20] = true
forward_expectations[21] = true
forward_expectations[22] = true
forward_expectations[23] = true
forward_expectations[24] = true
forward_expectations[25] = true
forward_expectations[26] = true
forward_expectations[27] = true
forward_expectations[28] = true
forward_expectations[29] = true
forward_expectations[30] = true
forward_expectations[31] = true
forward_expectations[32] = true

local BACK_NUM = 32
local back_expectations = {}
back_expectations[1]  = false
back_expectations[2]  = false
back_expectations[3]  = true
back_expectations[4]  = true
back_expectations[5]  = true
back_expectations[6]  = false
back_expectations[7]  = false
back_expectations[8]  = true
back_expectations[9]  = true
back_expectations[10] = true
back_expectations[11] = false
back_expectations[12] = false
back_expectations[13] = false
back_expectations[14] = true
back_expectations[15] = true
back_expectations[16] = false
back_expectations[17] = true
back_expectations[18] = true
back_expectations[19] = true
back_expectations[20] = true
back_expectations[21] = true
back_expectations[22] = true
back_expectations[23] = true
back_expectations[24] = true
back_expectations[25] = true
back_expectations[26] = true
back_expectations[27] = true
back_expectations[28] = true
back_expectations[29] = true
back_expectations[30] = true
back_expectations[31] = true
back_expectations[32] = true

local PLACE_NUM = 32
local place_expectations = {}
place_expectations[1]  = true
place_expectations[2]  = true
place_expectations[3]  = false
place_expectations[4]  = false
place_expectations[5]  = false
place_expectations[6]  = true
place_expectations[7]  = true
place_expectations[8]  = false
place_expectations[9]  = false
place_expectations[10] = false
place_expectations[11] = true
place_expectations[12] = true
place_expectations[13] = true
place_expectations[14] = false
place_expectations[15] = false
place_expectations[16] = true
place_expectations[17] = true
place_expectations[18] = true
place_expectations[19] = true
place_expectations[20] = true
place_expectations[21] = true
place_expectations[22] = true
place_expectations[23] = true
place_expectations[24] = true
place_expectations[25] = true
place_expectations[26] = true
place_expectations[27] = true
place_expectations[28] = true
place_expectations[29] = true
place_expectations[30] = true
place_expectations[31] = true
place_expectations[32] = true

local PICK_UP_NUM = 32
local pick_up_expectations = {}
pick_up_expectations[1]  = true
pick_up_expectations[2]  = true
pick_up_expectations[3]  = false
pick_up_expectations[4]  = false
pick_up_expectations[5]  = false
pick_up_expectations[6]  = true
pick_up_expectations[7]  = true
pick_up_expectations[8]  = false
pick_up_expectations[9]  = false
pick_up_expectations[10] = false
pick_up_expectations[11] = true
pick_up_expectations[12] = true
pick_up_expectations[13] = true
pick_up_expectations[14] = false
pick_up_expectations[15] = false
pick_up_expectations[16] = true
pick_up_expectations[17] = true
pick_up_expectations[18] = true
pick_up_expectations[19] = true
pick_up_expectations[20] = true
pick_up_expectations[21] = true
pick_up_expectations[22] = true
pick_up_expectations[23] = true
pick_up_expectations[24] = true
pick_up_expectations[25] = true
pick_up_expectations[26] = true
pick_up_expectations[27] = true
pick_up_expectations[28] = true
pick_up_expectations[29] = true
pick_up_expectations[30] = true
pick_up_expectations[31] = true
pick_up_expectations[32] = true

-- Test UP boundaries
action = UP
up[1] = e.isActionOutOfBounds(action)
-- Go up 4 blocks
for i=1, 4, 1 do r.up() end
up[2] = e.isActionOutOfBounds(action)
-- Go up 4 blocks
for i=1, 4, 1 do r.up() end
up[3] = e.isActionOutOfBounds(action)

-- Check UP results
for i=1, UP_NUM, 1 do
    if up_expectations[i] == up[i] then
        print("UP "..tostring(i).." --> SUCCESS")
    else
        print("UP "..tostring(i).." --> FAIL")
    end
end

-- Test DOWN boundaries
action = DOWN
down[1] = e.isActionOutOfBounds(action)
-- Go down 4 blocks
for i=1, 4, 1 do r.down() end
down[2] = e.isActionOutOfBounds(action)
-- Go down 4 blocks
for i=1, 4, 1 do r.down() end
down[3] = e.isActionOutOfBounds(action)

-- Check DOWN results
for i=1, DOWN_NUM, 1 do
    if down_expectations[i] == down[i] then
        print("DOWN "..tostring(i).." --> SUCCESS")
    else
        print("DOWN "..tostring(i).." --> FAIL")
    end
end



