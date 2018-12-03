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
        self.state_list = [ 3, False, 0,
                            4, False, 0,
                            5, False, 0,
                            6, False, 0,
                            7, False, 0,
                            8, False, 0,
                            9, False, 0,
                            10, False, 0,
                            11, False, 0,
                            12, False, 0,
                            13, False, 0,
                            14, False, 0,
                            15, False, 0,
                            16, False, 0,
                            17, False, 0,
                            18, False, 0,
                            19, False, 0,
                            20, False, 0,
                            21, False, 0,
                            22, False, 0,
                            23, False, 0,
                            24, False, 0,
                            25, False, 0,
                            26, False, 0,
                            27, False, 0,
                            28, False, 0,
                            29, False, 0,
                            30, False, 0,
                            31, False, 0,
                            32, False, 0,
                            33, False, 0,
                            34, False, 0,
                            35, False, 0,
                            36, False, 0,
                            37, False, 0,
                            38, False, 0,
                            39, False, 0,
                            40, False, 0,
                            41, False, 0,
                            42, False, 0,
                            43, False, 0,
                            44, False, 0,
                            45, False, 0,
                            46, False, 0,
                            47, False, 0,
                            48, False, 0,
                            49, False, 0,
                            50, False, 0,
                            51, False, 0,
                            52, False, 0,
                            53, False, 0,
                            54, False, 0,
                            55, False, 0,
                            56, False, 0,
                            57, False, 0,
                            58, False, 0,
                            59, False, 0,
                            60, False, 0,
                            61, False, 0,
                            62, False, 0,
                            63, False, 0,
                            64, False, 0,
                            65, False, 0,
                            66, False, 0,
                            67, False, 0,
                            68, False, 0,
                            69, False, 0,
                            70, False, 0,
                            71, False, 0,
                            72, False, 0,
                            73, False, 0,
                            74, False, 0,
                            75, False, 0,
                            76, False, 0,
                            77, False, 0,
                            78, False, 0,
                            79, False, 0,
                            80, False, 0,
                            81, False, 0,
                            82, False, 0,
                            83, False, 0,
                            84, False, 0,
                            85, False, 0,
                            86, False, 0,
                            87, False, 0,
                            88, False, 0,
                            89, False, 0,
                            90, False, 0,
                            91, False, 0,
                            92, False, 0,
                            93, False, 0,
                            94, False, 0,
                            95, False, 0,
                            96, False, 0,
                            97, False, 0,
                            98, False, 0,
                            99, False, 0,
                            100, False, 0,
                            101, False, 0,
                            102, False, 0,
                            103, False, 0,
                            104, False, 0,
                            105, False, 0,
                            106, False, 0,
                            107, False, 0,
                            108, False, 0,
                            109, False, 0,
                            110, False, 0,
                            111, False, 0,
                            112, False, 0,
                            113, False, 0,
                            114, False, 0,
                            115, False, 0,
                            116, False, 0,
                            117, False, 0,
                            118, False, 0,
                            119, False, 0,
                            120, False, 0,
                            121, False, 0,
                            122, False, 0,
                            123, False, 0,
                            124, False, 0,
                            125, False, 0,
                            126, False, 0,
                            127, False, 0,
                            128, False, 0,
                            129, False, 0,
                            130, False, 0,
                            131, False, 0,
                            132, False, 0,
                            133, False, 0,
                            134, False, 0,
                            135, False, 0,
                            136, False, 0,
                            137, False, 0,
                            138, False, 0,
                            139, False, 0,
                            140, False, 0,
                            141, False, 0,
                            142, False, 0,
                            143, False, 0,
                            144, False, 0,
                            145, False, 0,
                            146, False, 0,
                            147, False, 0,
                            148, False, 0,
                            149, False, 0,
                            150, False, 0,
                            151, False, 0,
                            152, False, 0,
                            153, False, 0,
                            154, False, 0,
                            155, False, 0,
                            156, False, 0,
                            157, False, 0,
                            158, False, 0,
                            159, False, 0,
                            160, False, 0,
                            161, False, 0,
                            162, False, 0,
                            163, False, 0,
                            164, False, 0,
                            165, False, 0,
                            166, False, 0,
                            167, False, 0,
                            168, False, 0,
                            169, False, 0,
                            170, False, 0,
                            171, False, 0,
                            172, False, 0,
                            173, False, 0,
                            174, False, 0,
                            175, False, 0,
                            176, False, 0,
                            177, False, 0,
                            178, False, 0,
                            179, False, 0,
                            180, False, 0,
                            181, False, 0,
                            182, False, 0,
                            183, False, 0,
                            184, False, 0,
                            185, False, 0,
                            186, False, 0,
                            187, False, 0,
                            188, False, 0,
                            189, False, 0,
                            190, False, 0,
                            191, False, 0,
                            192, False, 0,
                            193, False, 0,
                            194, False, 0,
                            195, False, 0,
                            196, False, 0,
                            197, False, 0,
                            198, False, 0 ]

        # List of all coordinates involved with the house, followed by if a block exists there, and if it's type if it does.
        self.state = np.array( self.state_list )

        self.state_size = (self.state).size

        # Number of blocks in the house
        self.observation_space = spaces.Box(low=np.array(0), high=np.array(196), dtype=np.int32)

        self.state_record_name = "state_record.csv"
        # Open the state record, clear it, and set teh header
        with open(self.state_record_name, "w") as state_record:
            state_record.write("Episode,x,y,z,block exists,block type")

        self.action_record_name = "action_record.csv"
        # Open the action record, clear it, and set the header
        with open(self.action_record_name, "w") as action_record:
            action_record.write("Episode,Step,x,y,z,facing,action code,outcome\n")
        


    def updateState(self, pos, block_exists, block_type):
        # It's been verified at this point that pos is in the house
        
        # HACK
        search_num = (self.eac).getPosIndex(pos)

        # Find the index that pos is housed in
        i = (self.state_list).index( search_num )

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

    # HACK found here: https://stackoverflow.com/questions/2130016/splitting-a-list-into-n-parts-of-approximately-equal-length
    # Needed to record the state space in an understandable way
    def tixxitSplit(self):
        a = self.state_list 
        n = int( len( self.state_list ) / 3 )

        k, m = divmod(len(a), n)
        return list(a[i * k + min(i, m):(i + 1) * k + min(i + 1, m)] for i in range(n))

    def recordEpisodeState(self, episode):
        with open(self.state_record_name, "a") as state_record:
            for pos_list in self.tixxitSplit():

                pos = (self.eac).indexToPos( pos_list[0] )
                block_exists = pos_list[1]
                block_type = pos_list[2]

                state_record.write("{},{},{},{},{},{}\n".format(episode, pos[0], pos[1], pos[2], block_exists, block_type))

    def reset(self):
    
        self.state_list = [ 3, False, 0,
                            4, False, 0,
                            5, False, 0,
                            6, False, 0,
                            7, False, 0,
                            8, False, 0,
                            9, False, 0,
                            10, False, 0,
                            11, False, 0,
                            12, False, 0,
                            13, False, 0,
                            14, False, 0,
                            15, False, 0,
                            16, False, 0,
                            17, False, 0,
                            18, False, 0,
                            19, False, 0,
                            20, False, 0,
                            21, False, 0,
                            22, False, 0,
                            23, False, 0,
                            24, False, 0,
                            25, False, 0,
                            26, False, 0,
                            27, False, 0,
                            28, False, 0,
                            29, False, 0,
                            30, False, 0,
                            31, False, 0,
                            32, False, 0,
                            33, False, 0,
                            34, False, 0,
                            35, False, 0,
                            36, False, 0,
                            37, False, 0,
                            38, False, 0,
                            39, False, 0,
                            40, False, 0,
                            41, False, 0,
                            42, False, 0,
                            43, False, 0,
                            44, False, 0,
                            45, False, 0,
                            46, False, 0,
                            47, False, 0,
                            48, False, 0,
                            49, False, 0,
                            50, False, 0,
                            51, False, 0,
                            52, False, 0,
                            53, False, 0,
                            54, False, 0,
                            55, False, 0,
                            56, False, 0,
                            57, False, 0,
                            58, False, 0,
                            59, False, 0,
                            60, False, 0,
                            61, False, 0,
                            62, False, 0,
                            63, False, 0,
                            64, False, 0,
                            65, False, 0,
                            66, False, 0,
                            67, False, 0,
                            68, False, 0,
                            69, False, 0,
                            70, False, 0,
                            71, False, 0,
                            72, False, 0,
                            73, False, 0,
                            74, False, 0,
                            75, False, 0,
                            76, False, 0,
                            77, False, 0,
                            78, False, 0,
                            79, False, 0,
                            80, False, 0,
                            81, False, 0,
                            82, False, 0,
                            83, False, 0,
                            84, False, 0,
                            85, False, 0,
                            86, False, 0,
                            87, False, 0,
                            88, False, 0,
                            89, False, 0,
                            90, False, 0,
                            91, False, 0,
                            92, False, 0,
                            93, False, 0,
                            94, False, 0,
                            95, False, 0,
                            96, False, 0,
                            97, False, 0,
                            98, False, 0,
                            99, False, 0,
                            100, False, 0,
                            101, False, 0,
                            102, False, 0,
                            103, False, 0,
                            104, False, 0,
                            105, False, 0,
                            106, False, 0,
                            107, False, 0,
                            108, False, 0,
                            109, False, 0,
                            110, False, 0,
                            111, False, 0,
                            112, False, 0,
                            113, False, 0,
                            114, False, 0,
                            115, False, 0,
                            116, False, 0,
                            117, False, 0,
                            118, False, 0,
                            119, False, 0,
                            120, False, 0,
                            121, False, 0,
                            122, False, 0,
                            123, False, 0,
                            124, False, 0,
                            125, False, 0,
                            126, False, 0,
                            127, False, 0,
                            128, False, 0,
                            129, False, 0,
                            130, False, 0,
                            131, False, 0,
                            132, False, 0,
                            133, False, 0,
                            134, False, 0,
                            135, False, 0,
                            136, False, 0,
                            137, False, 0,
                            138, False, 0,
                            139, False, 0,
                            140, False, 0,
                            141, False, 0,
                            142, False, 0,
                            143, False, 0,
                            144, False, 0,
                            145, False, 0,
                            146, False, 0,
                            147, False, 0,
                            148, False, 0,
                            149, False, 0,
                            150, False, 0,
                            151, False, 0,
                            152, False, 0,
                            153, False, 0,
                            154, False, 0,
                            155, False, 0,
                            156, False, 0,
                            157, False, 0,
                            158, False, 0,
                            159, False, 0,
                            160, False, 0,
                            161, False, 0,
                            162, False, 0,
                            163, False, 0,
                            164, False, 0,
                            165, False, 0,
                            166, False, 0,
                            167, False, 0,
                            168, False, 0,
                            169, False, 0,
                            170, False, 0,
                            171, False, 0,
                            172, False, 0,
                            173, False, 0,
                            174, False, 0,
                            175, False, 0,
                            176, False, 0,
                            177, False, 0,
                            178, False, 0,
                            179, False, 0,
                            180, False, 0,
                            181, False, 0,
                            182, False, 0,
                            183, False, 0,
                            184, False, 0,
                            185, False, 0,
                            186, False, 0,
                            187, False, 0,
                            188, False, 0,
                            189, False, 0,
                            190, False, 0,
                            191, False, 0,
                            192, False, 0,
                            193, False, 0,
                            194, False, 0,
                            195, False, 0,
                            196, False, 0,
                            197, False, 0,
                            198, False, 0 ]

        self.state = np.array( self.state_list )

        return self.state

    # Taken from the various environments available at github.com/openai/gym
    def seed(self, seed=None):
        self.np_random, seed = seeding.np_random(seed)
        return [seed]