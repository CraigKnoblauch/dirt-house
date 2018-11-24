--[[ Main executable script of Squirt.
    Connects to the EAC and accepts commands.
    Relays state information back to the EAC
]]
local sq_act = require("sq-act")
local sq_nav = require("sq-navigation")
local sq_comms = require("sq-comms")
local sq_swim = require("sq-swim")

-- Open a connection with the EAC
sq_comms.sqConnect()
print("I have connected to Crush")

-- Get the command from Crush
read = sq_comms.sqRead()

print("Received " .. read)

-- 1 go forward
if read == "001" then
    sq_swim.sqForward()
    -- Ack
    sq_comms.sqWrite(sq_nav.sqGetX(),
                     sq_nav.sqGetY(),
                     sq_nav.sqGetZ(),
                     "001", "true")
else
    print("UNKNOWN ACTION CODE")
end

-- Only works for this demo. Wait for read to not equal 001
while read ~= "003" do
    read = sq_comms.sqRead()
end

sq_swim.sqUp()
-- Ack
sq_comms.sqWrite(sq_nav.sqGetX(),
                 sq_nav.sqGetY(),
                 sq_nav.sqGetZ(),
                 "003", "true")



-- Close the connection
sq_comms.sqClose()