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

local BACK_NUM = 32
local back_expectations = {}
back_expectations[1]  = true
back_expectations[2]  = true
back_expectations[3]  = false
back_expectations[4]  = false
back_expectations[5]  = false
back_expectations[6]  = true
back_expectations[7]  = true
back_expectations[8]  = false
back_expectations[9]  = false
back_expectations[10] = false
back_expectations[11] = true
back_expectations[12] = true
back_expectations[13] = true
back_expectations[14] = false
back_expectations[15] = false
back_expectations[16] = false
back_expectations[17] = false
back_expectations[18] = false
back_expectations[19] = false
back_expectations[20] = false
back_expectations[21] = false
back_expectations[22] = false
back_expectations[23] = false
back_expectations[24] = false
back_expectations[25] = false
back_expectations[26] = false
back_expectations[27] = false
back_expectations[28] = false
back_expectations[29] = false
back_expectations[30] = false
back_expectations[31] = false
back_expectations[32] = false

local FORWARD_NUM = 32
local forward_expectations = {}
forward_expectations[1]  = false
forward_expectations[2]  = false
forward_expectations[3]  = true
forward_expectations[4]  = true
forward_expectations[5]  = true
forward_expectations[6]  = false
forward_expectations[7]  = false
forward_expectations[8]  = true
forward_expectations[9]  = true
forward_expectations[10] = true
forward_expectations[11] = false
forward_expectations[12] = false
forward_expectations[13] = false
forward_expectations[14] = true
forward_expectations[15] = true
forward_expectations[16] = false
forward_expectations[17] = false
forward_expectations[18] = false
forward_expectations[19] = false
forward_expectations[20] = false
forward_expectations[21] = false
forward_expectations[22] = false
forward_expectations[23] = false
forward_expectations[24] = false
forward_expectations[25] = false
forward_expectations[26] = false
forward_expectations[27] = false
forward_expectations[28] = false
forward_expectations[29] = false
forward_expectations[30] = false
forward_expectations[31] = false
forward_expectations[32] = false

local PLACE_NUM = 32
local place_expectations = {}
place_expectations[1]  = false
place_expectations[2]  = false
place_expectations[3]  = true
place_expectations[4]  = true
place_expectations[5]  = true
place_expectations[6]  = false
place_expectations[7]  = false
place_expectations[8]  = true
place_expectations[9]  = true
place_expectations[10] = true
place_expectations[11] = false
place_expectations[12] = false
place_expectations[13] = false
place_expectations[14] = true
place_expectations[15] = true
place_expectations[16] = false
place_expectations[17] = false
place_expectations[18] = false
place_expectations[19] = false
place_expectations[20] = false
place_expectations[21] = false
place_expectations[22] = false
place_expectations[23] = false
place_expectations[24] = false
place_expectations[25] = false
place_expectations[26] = false
place_expectations[27] = false
place_expectations[28] = false
place_expectations[29] = false
place_expectations[30] = false
place_expectations[31] = false
place_expectations[32] = false

local PICK_UP_NUM = 32
local pick_up_expectations = {}
pick_up_expectations[1]  = false
pick_up_expectations[2]  = false
pick_up_expectations[3]  = true
pick_up_expectations[4]  = true
pick_up_expectations[5]  = true
pick_up_expectations[6]  = false
pick_up_expectations[7]  = false
pick_up_expectations[8]  = true
pick_up_expectations[9]  = true
pick_up_expectations[10] = true
pick_up_expectations[11] = false
pick_up_expectations[12] = false
pick_up_expectations[13] = false
pick_up_expectations[14] = true
pick_up_expectations[15] = true
pick_up_expectations[16] = false
pick_up_expectations[17] = false
pick_up_expectations[18] = false
pick_up_expectations[19] = false
pick_up_expectations[20] = false
pick_up_expectations[21] = false
pick_up_expectations[22] = false
pick_up_expectations[23] = false
pick_up_expectations[24] = false
pick_up_expectations[25] = false
pick_up_expectations[26] = false
pick_up_expectations[27] = false
pick_up_expectations[28] = false
pick_up_expectations[29] = false
pick_up_expectations[30] = false
pick_up_expectations[31] = false
pick_up_expectations[32] = false

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
----------------------------------------------------------
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
----------------------------------------------------------

function traverse(outcomes, action)
    -- Test 1 through 4
    outcomes[1] = e.isActionOutOfBounds(action)
    r.turnRight()
    outcomes[2] = e.isActionOutOfBounds(action)
    r.turnRight()
    outcomes[3] = e.isActionOutOfBounds(action)
    r.turnRight()
    outcomes[4] = e.isActionOutOfBounds(action)
    r.turnRight() -- Now facing forward

    -- Go up 1, forward 15, down 1
    r.up()
    for 1, 15, 1 do r.forward() end
    r.down()

    -- Test 5 through 8
    outcomes[5] = e.isActionOutOfBounds(action)
    r.turnRight()
    outcomes[6] = e.isActionOutOfBounds(action)
    r.turnRight()
    outcomes[7] = e.isActionOutOfBounds(action)
    r.turnRight()
    outcomes[8] = e.isActionOutOfBounds(action)
    r.turnRight() -- Now facing forward

    -- Turn right, go up 1, forward 15, down 1, turn left
    r.turnRight()
    r.up()
    for 1, 15, 1 do r.forward() end
    r.down()
    r.turnLeft()

    -- Test 9 through 12
    outcomes[9] = e.isActionOutOfBounds(action)
    r.turnRight()
    outcomes[10] = e.isActionOutOfBounds(action)
    r.turnRight()
    outcomes[11] = e.isActionOutOfBounds(action)
    r.turnRight()
    outcomes[12] = e.isActionOutOfBounds(action)
    r.turnRight() -- Now facing forward

    -- Turn around, go up 1, forward 15, down 1, turn around
    r.turnAround()
    r.up()
    for 1, 15, 1 do r.forward() end
    r.down()
    r.turnAround()

    -- Test 13 through 16
    outcomes[13] = e.isActionOutOfBounds(action)
    r.turnRight()
    outcomes[14] = e.isActionOutOfBounds(action)
    r.turnRight()
    outcomes[15] = e.isActionOutOfBounds(action)
    r.turnRight()
    outcomes[16] = e.isActionOutOfBounds(action)
    r.turnRight() -- Now facing forward

    -- Go up, go forward 1, turn left, go forward 1, turn right, go down 1
    r.up()
    r.forward()
    r.turnLeft()
    r.forward()
    r.turnRight()
    r.down()

    -- Test 17 through 20
    outcomes[17] = e.isActionOutOfBounds(action)
    r.turnRight()
    outcomes[18] = e.isActionOutOfBounds(action)
    r.turnRight()
    outcomes[19] = e.isActionOutOfBounds(action)
    r.turnRight()
    outcomes[20] = e.isActionOutOfBounds(action)
    r.turnRight() -- Now facing forward

    -- Go up 1, go forward 13, go down 1
    r.up()
    for 1, 13, 1 do r.forward() end
    r.down()

    -- Test 21 through 24
    outcomes[21] = e.isActionOutOfBounds(action)
    r.turnRight()
    outcomes[22] = e.isActionOutOfBounds(action)
    r.turnRight()
    outcomes[23] = e.isActionOutOfBounds(action)
    r.turnRight()
    outcomes[24] = e.isActionOutOfBounds(action)
    r.turnRight() -- Now facing forward

    -- Go up 1, turn left, go forward 13, turn right, go down
    r.up()
    r.turnLeft()
    for 1, 13, 1 do r.forward() end
    r.turnRight()
    r.down()

    -- Test 25 through 28
    outcomes[25] = e.isActionOutOfBounds(action)
    r.turnRight()
    outcomes[26] = e.isActionOutOfBounds(action)
    r.turnRight()
    outcomes[27] = e.isActionOutOfBounds(action)
    r.turnRight()
    outcomes[28] = e.isActionOutOfBounds(action)
    r.turnRight() -- Now facing forward

    -- Go up 1, turn around, go forward 13, turn around, go down
    r.up()
    r.turnAround()
    for 1, 13, 1 do r.forward() end
    r.turnAround()
    r.down()

    -- Test 29 through 32
    outcomes[29] = e.isActionOutOfBounds(action)
    r.turnRight()
    outcomes[30] = e.isActionOutOfBounds(action)
    r.turnRight()
    outcomes[31] = e.isActionOutOfBounds(action)
    r.turnRight()
    outcomes[32] = e.isActionOutOfBounds(action)
    r.turnRight() -- Now facing forward

    -- Go up, turn left, go forward, turn right, go back, go down
    r.up()
    r.turnleft()
    r.forward()
    r.turnRight()
    r.back()
    r.down()
    -- Now at origin
end

function results(outcomes, expectations, str)
    for i=1, 32, 1 do
        if outcomes[i] == expectations[i] then
            print(str.." "..tostring(i).." --> SUCCESS")
        else
            print(str.." "..tostring(i).." --> FAIL")
        end
    end
end

traverse(forward, FORWARD)
traverse(back, BACK)
traverse(pick_up, PICK_UP_BLOCK)
traverse(place, PLACE_DIRT_BLOCK)

results(forward, forward_expectations, "FORWARD")
results(back, back_expectations, "BACK")
results(pick_up, pick_up_expectations, "PICK UP BLOCK")
results(place, place_expectations, "PLACE BLOCK")



