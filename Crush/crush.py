import gym
from gym import spaces
from gym.utils import seeding 
import numpy as np
from east_australian_current import EAC

class Crush(gym.Env):

    def __init__(self):
        self.eac = EAC()
        self.action_space = spaces.Discrete(10)

        # HACK This allows us to find the postion tuple's index in the state variable. Update the list, and update self.state manually
        # 0 --> air
        # 1 --> dirt
        # 2 --> cobblestone
        self.state_list = [ (4, 2, 11), False, 0,
                            (4, 2, 12), False, 0,
                            (4, 2, 13), False, 0,
                            (3, 2, 11), False, 0,
                            (3, 2, 12), False, 0,
                            (2, 2, 11), False, 0,
                            (2, 2, 12), False, 0,
                            (2, 2, 13), False, 0,
                            (1, 2, 11), False, 0,
                            (1, 1, 11), False, 0,
                            (1, 0, 11), False, 0,
                            (1, 2, 12), False, 0,
                            (1, 2, 13), False, 0,
                            (1, 1, 13), False, 0,
                            (1, 0, 13), False, 0,
                            (1, 2, 14), False, 0,
                            (1, 1, 14), False, 0,
                            (1, 0, 14), False, 0,
                            (2, 2, 14), False, 0,
                            (2, 1, 14), False, 0,
                            (2, 0, 14), False, 0,
                            (3, 2, 14), False, 0,
                            (3, 0, 14), False, 0,
                            (4, 2, 14), False, 0,
                            (4, 1, 14), False, 0,
                            (4, 0, 14), False, 0,
                            (5, 2, 14), False, 0,
                            (5, 1, 14), False, 0,
                            (5, 0, 14), False, 0,
                            (5, 2, 13), False, 0,
                            (5, 1, 13), False, 0,
                            (5, 0, 13), False, 0,
                            (5, 2, 12), False, 0,
                            (5, 0, 12), False, 0,
                            (5, 2, 11), False, 0,
                            (5, 1, 11), False, 0,
                            (5, 0, 11), False, 0,
                            (5, 2, 10), False, 0,
                            (5, 1, 10), False, 0,
                            (5, 0, 10), False, 0,
                            (4, 2, 10), False, 0,
                            (4, 1, 10), False, 0,
                            (4, 0, 10), False, 0,
                            (3, 2, 10), False, 0,
                            (3, 0, 10), False, 0,
                            (2, 2, 10), False, 0,
                            (2, 1, 10), False, 0,
                            (2, 0, 10), False, 0,
                            (1, 2, 10), False, 0,
                            (1, 1, 10), False, 0,
                            (1, 0, 10), False, 0,
                            (3, 2, 13), False, 0,
                            (1, 0, 12), False, 0,
                            (1, 1, 12), False, 0,
                            (4, 0, 11), False, 0,
                            (4, 1, 11), False, 0,
                            (4, 0, 12), False, 0,
                            (4, 1, 12), False, 0,
                            (4, 0, 13), False, 0,
                            (4, 1, 13), False, 0,
                            (3, 0, 11), False, 0,
                            (3, 1, 11), False, 0,
                            (3, 0, 12), False, 0,
                            (3, 1, 12), False, 0,
                            (2, 0, 11), False, 0,
                            (2, 1, 11), False, 0,
                            (2, 0, 12), False, 0,
                            (2, 1, 12), False, 0,
                            (2, 0, 13), False, 0,
                            (2, 1, 13), False, 0,
                            (3, 1, 10), False, 0,
                            (5, 1, 12), False, 0,
                            (3, 1, 14), False, 0,
                            (3, 0, 13), False, 0,
                            (3, 1, 13), False, 0,
                            (0, 0, 9), False, 0,
                            (0, 0, 10), False, 0,
                            (0, 0, 11), False, 0,
                            (0, 0, 12), False, 0,
                            (0, 0, 13), False, 0,
                            (0, 0, 14), False, 0,
                            (0, 0, 15), False, 0,
                            (1, 0, 15), False, 0,
                            (2, 0, 15), False, 0,
                            (3, 0, 15), False, 0,
                            (4, 0, 15), False, 0,
                            (5, 0, 15), False, 0,
                            (6, 0, 15), False, 0,
                            (6, 0, 14), False, 0,
                            (6, 0, 13), False, 0,
                            (6, 0, 12), False, 0,
                            (6, 0, 11), False, 0,
                            (6, 0, 10), False, 0,
                            (6, 0, 9), False, 0,
                            (5, 0, 9), False, 0,
                            (4, 0, 9), False, 0,
                            (3, 0, 9), False, 0,
                            (2, 0, 9), False, 0,
                            (1, 0, 9), False, 0,
                            (0, 1, 9), False, 0,
                            (0, 1, 10), False, 0,
                            (0, 1, 11), False, 0,
                            (0, 1, 12), False, 0,
                            (0, 1, 13), False, 0,
                            (0, 1, 14), False, 0,
                            (0, 1, 15), False, 0,
                            (1, 1, 15), False, 0,
                            (2, 1, 15), False, 0,
                            (3, 1, 15), False, 0,
                            (4, 1, 15), False, 0,
                            (5, 1, 15), False, 0,
                            (6, 1, 15), False, 0,
                            (6, 1, 14), False, 0,
                            (6, 1, 13), False, 0,
                            (6, 1, 12), False, 0,
                            (6, 1, 11), False, 0,
                            (6, 1, 10), False, 0,
                            (6, 1, 9), False, 0,
                            (5, 1, 9), False, 0,
                            (4, 1, 9), False, 0,
                            (3, 1, 9), False, 0,
                            (2, 1, 9), False, 0,
                            (1, 1, 9), False, 0,
                            (0, 2, 9), False, 0,
                            (0, 2, 10), False, 0,
                            (0, 2, 11), False, 0,
                            (0, 2, 12), False, 0,
                            (0, 2, 13), False, 0,
                            (0, 2, 14), False, 0,
                            (0, 2, 15), False, 0,
                            (1, 2, 15), False, 0,
                            (2, 2, 15), False, 0,
                            (3, 2, 15), False, 0,
                            (4, 2, 15), False, 0,
                            (5, 2, 15), False, 0,
                            (6, 2, 15), False, 0,
                            (6, 2, 14), False, 0,
                            (6, 2, 13), False, 0,
                            (6, 2, 12), False, 0,
                            (6, 2, 11), False, 0,
                            (6, 2, 10), False, 0,
                            (6, 2, 9), False, 0,
                            (5, 2, 9), False, 0,
                            (4, 2, 9), False, 0,
                            (3, 2, 9), False, 0,
                            (2, 2, 9), False, 0,
                            (1, 2, 9), False, 0,
                            (0, 3, 9), False, 0,
                            (0, 3, 10), False, 0,
                            (0, 3, 11), False, 0,
                            (0, 3, 12), False, 0,
                            (0, 3, 13), False, 0,
                            (0, 3, 14), False, 0,
                            (0, 3, 15), False, 0,
                            (1, 3, 15), False, 0,
                            (2, 3, 15), False, 0,
                            (3, 3, 15), False, 0,
                            (4, 3, 15), False, 0,
                            (5, 3, 15), False, 0,
                            (6, 3, 15), False, 0,
                            (6, 3, 14), False, 0,
                            (6, 3, 13), False, 0,
                            (6, 3, 12), False, 0,
                            (6, 3, 11), False, 0,
                            (6, 3, 10), False, 0,
                            (6, 3, 9), False, 0,
                            (5, 3, 9), False, 0,
                            (4, 3, 9), False, 0,
                            (3, 3, 9), False, 0,
                            (2, 3, 9), False, 0,
                            (1, 3, 9), False, 0,
                            (1, 3, 10), False, 0,
                            (1, 3, 11), False, 0,
                            (1, 3, 12), False, 0,
                            (1, 3, 13), False, 0,
                            (1, 3, 14), False, 0,
                            (2, 3, 10), False, 0,
                            (2, 3, 11), False, 0,
                            (2, 3, 12), False, 0,
                            (2, 3, 13), False, 0,
                            (2, 3, 14), False, 0,
                            (3, 3, 10), False, 0,
                            (3, 3, 11), False, 0,
                            (3, 3, 12), False, 0,
                            (3, 3, 13), False, 0,
                            (3, 3, 14), False, 0,
                            (4, 3, 10), False, 0,
                            (4, 3, 11), False, 0,
                            (4, 3, 12), False, 0,
                            (4, 3, 13), False, 0,
                            (4, 3, 14), False, 0,
                            (5, 3, 10), False, 0,
                            (5, 3, 11), False, 0,
                            (5, 3, 12), False, 0,
                            (5, 3, 13), False, 0,
                            (5, 3, 14), False, 0 ]

        # List of all coordinates involved with the house, followed by if a block exists there, and if it's type if it does.
        self.state = np.array( self.state_list )

        self.state_size = (self.state).size

        # Number of blocks in the house
        self.observation_space = spaces.Box(low=np.array(0), high=np.array(196), dtype=np.int32)

        # TODO open an action record for writing
        self.action_record_name = "action_record.csv"
        # Open the action record, clear it, and set the header
        with open(self.action_record_name, "w") as action_record:
            action_record.write("Episode,Step,x,y,z,facing,action code,outcome\n")
        


    def updateState(pos, block_exists, block_type):
        # It's been verified at this point that pos is in the house
        
        # Find the index that pos is housed in
        i = (self.state_list).index( pos )

        # Change i + 1 to block_exists. Change i + 2 to block_type
        (self.state_list)[i + 1] = block_exists
        (self.state_list)[i + 2] = block_type

        # Re-load state
        self.state = self.state_list



    # Takes the string version of the action code. NOTE This is a point of failure if those action codes ever change.
    # This is a little manipulated. Because of the way we've done things, we can't execute an action in this function. Instead, action
    # has already been executed, and we're dissecting the response message for a reward
    def step(self, action, msg):
        done = False

        if (self.eac).getStep(msg) == 399:
            done = True

        reward = 0

        # Get the affected position
        x, y, z = (self.eac).getAffectedPos(msg)

        # What was the action based on the response
        action_name = (self.eac).getACName(action)

        # React to actions where it doesn't matter if they happened in the house section or not
        if action_name == "forward" or action_name == "back" or action_name == "up" or action_name == "down" or action_name == "turn left" or action_name == "turn right" or action_name == "turn around":

            # If any of these rewards were successful, -1, If the reason for failure was because the action would've taken squirt out of bounds, -100. If the action
            # failed for another reason, -10
            if (self.eac).getOutcome(msg) > 1:
                reward = -1
            elif (self.eac).isOutOfBounds(msg):
                reward = -100
            else:
                reward = -10

        # Determine if the state space was acted on
        if (self.eac).isPosPartOfHouse(x, y, z) and reward != 0:

            # Squirt should never be picking up a block in the house coordinates unless he placed it there. If he unsucessfully
            # picked up a block, give him a massive penalty, if he was successful, but the block came from where blocks should be, a massive penalty
            # if he was successful and a block should not be there, a small reward

            if action_name == "pick up block":
                # Did Squirt successfully pick up the block
                if (self.eac).getOutcome(msg) > 0:
                    # Did he do so where a block should exist?
                    if (self.eac).shouldPosHaveBlock(x, y, z):
                        reward = -100
                    else:
                        reward = +50

                    self.updateState( (x, y, z), False, 0 )

                # Squirt did not pick up a block
                else:
                    reward = -50

            # Squirt should only be placing dirt blocks in specific postions. If the placement was successful, and in a proper location, hefty reward.
            # If placement was successful in improper location, hefty neg reward. If placement was unsuccessful, hefty neg reward
            elif action_name == "place dirt block":
                # Did Squirt successfully place a block?
                if (self.eac).getOutcome(msg) > 0:
                    # should this position of the house have a block?
                    if (self.eac).shouldPosHaveBlock(x, y, z):
                        reward = +300
                    else:
                        reward = -300

                    self.updateState( (x, y, z), True, 1 )

                # Squirt did not successfully place a block, meaning it's not in his inventory at all.
                else:
                    reward = -200

            # Squirt should never be placing a cobblestone block. Automatic negitive reward
            elif action_name == "place cobblestone block":
                reward = -400

                # Did Squirt succeed?
                if (self.eac).getOutcome(msg) > 0:
                    self.updateState( (x, y, z), True, 2 )

        # The postion worked on was not part of the house
        else:

            # Check if Squirt attempted to pick up a block
            if action_name == "pick up block":
                # Did Squirt succeed in picking up a block?
                if (self.eac).getOutcome(msg) > 0:
                    # Squirt should never pick up a cobblestone block. If he did, -100
                    if (self.eac).getOutcome(msg) == 2: # /Squirt/sq-act.lua line 408
                        reward = -100

                    # If Squirt picked up a dirt block, reward him with +100
                    elif (self.eac).getOutcome(msg) == 1: # /Squirt/sq-act.lua line 407
                        reward = +100

                # Squirt did not pick up a block
                else:
                    reward = -200

            # Squirt should never be doing either of these whether they were unsuccessful or not. 
            elif action_name == "place dirt block" or action_name == "place cobblestone block":
                reward = -100


        return self.state, reward, done, {}

    def render(self, msg):
        episode, step, x, y, z, facing, action, outcome = (self.eac).parseSquirtMsg(msg)
        
        # Write Squirt's action to the record
        with open(self.action_record_name, "a") as record:
            record.write("{},{},{},{},{},{},{},{}\n".format(episode, step, x, y, z, facing, action, outcome))
        

        output = "Step {} of Episode {} -- Facing {} at ({}, {}, {}) Squirt performed {} which resulted in {}".format( step, episode, facing, x, y, z, (self.eac).getACName(action), outcome) 
        print(output)


    def reset(self):
        self.state_list = [ (4, 2, 11), False, 0,
                            (4, 2, 12), False, 0,
                            (4, 2, 13), False, 0,
                            (3, 2, 11), False, 0,
                            (3, 2, 12), False, 0,
                            (2, 2, 11), False, 0,
                            (2, 2, 12), False, 0,
                            (2, 2, 13), False, 0,
                            (1, 2, 11), False, 0,
                            (1, 1, 11), False, 0,
                            (1, 0, 11), False, 0,
                            (1, 2, 12), False, 0,
                            (1, 2, 13), False, 0,
                            (1, 1, 13), False, 0,
                            (1, 0, 13), False, 0,
                            (1, 2, 14), False, 0,
                            (1, 1, 14), False, 0,
                            (1, 0, 14), False, 0,
                            (2, 2, 14), False, 0,
                            (2, 1, 14), False, 0,
                            (2, 0, 14), False, 0,
                            (3, 2, 14), False, 0,
                            (3, 0, 14), False, 0,
                            (4, 2, 14), False, 0,
                            (4, 1, 14), False, 0,
                            (4, 0, 14), False, 0,
                            (5, 2, 14), False, 0,
                            (5, 1, 14), False, 0,
                            (5, 0, 14), False, 0,
                            (5, 2, 13), False, 0,
                            (5, 1, 13), False, 0,
                            (5, 0, 13), False, 0,
                            (5, 2, 12), False, 0,
                            (5, 0, 12), False, 0,
                            (5, 2, 11), False, 0,
                            (5, 1, 11), False, 0,
                            (5, 0, 11), False, 0,
                            (5, 2, 10), False, 0,
                            (5, 1, 10), False, 0,
                            (5, 0, 10), False, 0,
                            (4, 2, 10), False, 0,
                            (4, 1, 10), False, 0,
                            (4, 0, 10), False, 0,
                            (3, 2, 10), False, 0,
                            (3, 0, 10), False, 0,
                            (2, 2, 10), False, 0,
                            (2, 1, 10), False, 0,
                            (2, 0, 10), False, 0,
                            (1, 2, 10), False, 0,
                            (1, 1, 10), False, 0,
                            (1, 0, 10), False, 0,
                            (3, 2, 13), False, 0,
                            (1, 0, 12), False, 0,
                            (1, 1, 12), False, 0,
                            (4, 0, 11), False, 0,
                            (4, 1, 11), False, 0,
                            (4, 0, 12), False, 0,
                            (4, 1, 12), False, 0,
                            (4, 0, 13), False, 0,
                            (4, 1, 13), False, 0,
                            (3, 0, 11), False, 0,
                            (3, 1, 11), False, 0,
                            (3, 0, 12), False, 0,
                            (3, 1, 12), False, 0,
                            (2, 0, 11), False, 0,
                            (2, 1, 11), False, 0,
                            (2, 0, 12), False, 0,
                            (2, 1, 12), False, 0,
                            (2, 0, 13), False, 0,
                            (2, 1, 13), False, 0,
                            (3, 1, 10), False, 0,
                            (5, 1, 12), False, 0,
                            (3, 1, 14), False, 0,
                            (3, 0, 13), False, 0,
                            (3, 1, 13), False, 0,
                            (0, 0, 9), False, 0,
                            (0, 0, 10), False, 0,
                            (0, 0, 11), False, 0,
                            (0, 0, 12), False, 0,
                            (0, 0, 13), False, 0,
                            (0, 0, 14), False, 0,
                            (0, 0, 15), False, 0,
                            (1, 0, 15), False, 0,
                            (2, 0, 15), False, 0,
                            (3, 0, 15), False, 0,
                            (4, 0, 15), False, 0,
                            (5, 0, 15), False, 0,
                            (6, 0, 15), False, 0,
                            (6, 0, 14), False, 0,
                            (6, 0, 13), False, 0,
                            (6, 0, 12), False, 0,
                            (6, 0, 11), False, 0,
                            (6, 0, 10), False, 0,
                            (6, 0, 9), False, 0,
                            (5, 0, 9), False, 0,
                            (4, 0, 9), False, 0,
                            (3, 0, 9), False, 0,
                            (2, 0, 9), False, 0,
                            (1, 0, 9), False, 0,
                            (0, 1, 9), False, 0,
                            (0, 1, 10), False, 0,
                            (0, 1, 11), False, 0,
                            (0, 1, 12), False, 0,
                            (0, 1, 13), False, 0,
                            (0, 1, 14), False, 0,
                            (0, 1, 15), False, 0,
                            (1, 1, 15), False, 0,
                            (2, 1, 15), False, 0,
                            (3, 1, 15), False, 0,
                            (4, 1, 15), False, 0,
                            (5, 1, 15), False, 0,
                            (6, 1, 15), False, 0,
                            (6, 1, 14), False, 0,
                            (6, 1, 13), False, 0,
                            (6, 1, 12), False, 0,
                            (6, 1, 11), False, 0,
                            (6, 1, 10), False, 0,
                            (6, 1, 9), False, 0,
                            (5, 1, 9), False, 0,
                            (4, 1, 9), False, 0,
                            (3, 1, 9), False, 0,
                            (2, 1, 9), False, 0,
                            (1, 1, 9), False, 0,
                            (0, 2, 9), False, 0,
                            (0, 2, 10), False, 0,
                            (0, 2, 11), False, 0,
                            (0, 2, 12), False, 0,
                            (0, 2, 13), False, 0,
                            (0, 2, 14), False, 0,
                            (0, 2, 15), False, 0,
                            (1, 2, 15), False, 0,
                            (2, 2, 15), False, 0,
                            (3, 2, 15), False, 0,
                            (4, 2, 15), False, 0,
                            (5, 2, 15), False, 0,
                            (6, 2, 15), False, 0,
                            (6, 2, 14), False, 0,
                            (6, 2, 13), False, 0,
                            (6, 2, 12), False, 0,
                            (6, 2, 11), False, 0,
                            (6, 2, 10), False, 0,
                            (6, 2, 9), False, 0,
                            (5, 2, 9), False, 0,
                            (4, 2, 9), False, 0,
                            (3, 2, 9), False, 0,
                            (2, 2, 9), False, 0,
                            (1, 2, 9), False, 0,
                            (0, 3, 9), False, 0,
                            (0, 3, 10), False, 0,
                            (0, 3, 11), False, 0,
                            (0, 3, 12), False, 0,
                            (0, 3, 13), False, 0,
                            (0, 3, 14), False, 0,
                            (0, 3, 15), False, 0,
                            (1, 3, 15), False, 0,
                            (2, 3, 15), False, 0,
                            (3, 3, 15), False, 0,
                            (4, 3, 15), False, 0,
                            (5, 3, 15), False, 0,
                            (6, 3, 15), False, 0,
                            (6, 3, 14), False, 0,
                            (6, 3, 13), False, 0,
                            (6, 3, 12), False, 0,
                            (6, 3, 11), False, 0,
                            (6, 3, 10), False, 0,
                            (6, 3, 9), False, 0,
                            (5, 3, 9), False, 0,
                            (4, 3, 9), False, 0,
                            (3, 3, 9), False, 0,
                            (2, 3, 9), False, 0,
                            (1, 3, 9), False, 0,
                            (1, 3, 10), False, 0,
                            (1, 3, 11), False, 0,
                            (1, 3, 12), False, 0,
                            (1, 3, 13), False, 0,
                            (1, 3, 14), False, 0,
                            (2, 3, 10), False, 0,
                            (2, 3, 11), False, 0,
                            (2, 3, 12), False, 0,
                            (2, 3, 13), False, 0,
                            (2, 3, 14), False, 0,
                            (3, 3, 10), False, 0,
                            (3, 3, 11), False, 0,
                            (3, 3, 12), False, 0,
                            (3, 3, 13), False, 0,
                            (3, 3, 14), False, 0,
                            (4, 3, 10), False, 0,
                            (4, 3, 11), False, 0,
                            (4, 3, 12), False, 0,
                            (4, 3, 13), False, 0,
                            (4, 3, 14), False, 0,
                            (5, 3, 10), False, 0,
                            (5, 3, 11), False, 0,
                            (5, 3, 12), False, 0,
                            (5, 3, 13), False, 0,
                            (5, 3, 14), False, 0 ]

        self.state = np.array( self.state_list )

        return self.state

    # Taken from the various environments available at github.com/openai/gym
    def seed(self, seed=None):
        self.np_random, seed = seeding.np_random(seed)
        return [seed]