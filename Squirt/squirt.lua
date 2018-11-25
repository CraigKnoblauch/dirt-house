--[[ Main executable script of Squirt.
    Connects to the EAC and accepts commands.
    Relays state information back to the EAC
]]
local sq_comms = require("sq-comms")
local sq_exe = require("sq-exe")
local sq_nav = require("sq-navigation")

-- Episode running stuff
-- NOTE These must be the same between Crush and Squirt
local NUM_STEPS = 400
local NUM_EPISODES = 3

-- Required initialization steps
local episode = 0
sq_nav.sqSetAbsInitPos()

-- Open a connection with the EAC
sq_comms.sqConnect()
sq_comms.sqRead()

-- Or could do a while true and have Crush send next episode command
-- For some number of episodes do some number of commands per episode
for episode = 0, NUM_EPISODES - 1, 1 do 
    for step = 0, NUM_STEPS - 1, 1 do
        
        -- QUESTION: How do I stop this race condition between
        -- Squirt reading and Crush writing
        action = sq_comms.sqRead()

        -- Act on the action code
        outcome = sq_exe.sqExecuteAction(action, episode)
        sq_comms.sqWrite(action, outcome, episode)
    end

    sq_exe.sqExecuteAction("011", episode + 1)
end

-- Close the connection
sq_comms.sqClose()