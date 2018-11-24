--[[ Main executable script of Squirt.
    Connects to the EAC and accepts commands.
    Relays state information back to the EAC
]]
local sq_act = require("sq-act")
local sq_nav = require("sq-nav")
local sq_comms = require("sq-comms")
local sq_swim = require("sq-swim")

-- Open a connection with the EAC
sq_comms.sqConnect()

-- Inform the EAC Squirt is ready for a command
sq_comms.sqWrite("ready")

-- Wait for something to be read
read = ""
while read == "" do
    read = sq_comms.sqRead()
end

-- 1 go forward
if read == "001" then
    sq_swim.sqForward()
else
    print("UNKNOWN ACTION CODE")
end

-- Close the connection
sq_comms.sqClose()