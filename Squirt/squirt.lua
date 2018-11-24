--[[ Main executable script of Squirt.
    Connects to the EAC and accepts commands.
    Relays state information back to the EAC
]]
local sq_comms = require("sq-comms")
local sq_exe = require("sq-exe")

-- Open a connection with the EAC
sq_comms.sqConnect()
print("I have connected to Crush")

-- Get the command from Crush
sq_comms.sqRead()
action = sq_comms.sqRead()

print("Received " .. action)

-- Act on the action code
outcome = sq_exe.sqExecuteAction(action)
sq_comms.sqWrite(action, outcome)

-- Close the connection
sq_comms.sqClose()