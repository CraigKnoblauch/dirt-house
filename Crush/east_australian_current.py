import random

## East Australian Current
# @class This class is responsible for send action requests to Squirt and for 
# interpreting responses From Squirt. Interpretation of a response includes 
# sending a reward to Crush
class EAC:

    def __init__(self):
        self.actions = {'forward': b'001',
                        'back': b'002',
                        'up': b'003',
                        'down': b'004',
                        'turn left': b'005',
                        'turn right': b'006',
                        'turn around': b'007',
                        'pick up block': b'008',
                        'place dirt block': b'009',
                        'place cobblestone block': b'010'}
                        #'next episode': b'011' }

        self.HOST = "127.0.0.1"
        self.PORT = 65432

        # The coordinates of blocks that make up the house, including air
        self.house = {'dirt': [ (4, 2, 11), 
                                (4, 2, 12),
                                (4, 2, 13),
                                (3, 2, 11),
                                (3, 2, 12),
                                (2, 2, 11),
                                (2, 2, 12),
                                (2, 2, 13),
                                (1, 2, 11),
                                (1, 1, 11),
                                (1, 0, 11),
                                (1, 2, 12),
                                (1, 2, 13),
                                (1, 1, 13),
                                (1, 0, 13),
                                (1, 2, 14),
                                (1, 1, 14),
                                (1, 0, 14),
                                (2, 2, 14),
                                (2, 1, 14),
                                (2, 0, 14),
                                (3, 2, 14),
                                (3, 0, 14),
                                (4, 2, 14),
                                (4, 1, 14),
                                (4, 0, 14),
                                (5, 2, 14),
                                (5, 1, 14),
                                (5, 0, 14),
                                (5, 2, 13),
                                (5, 1, 13),
                                (5, 0, 13),
                                (5, 2, 12),
                                (5, 0, 12),
                                (5, 2, 11),
                                (5, 1, 11),
                                (5, 0, 11),
                                (5, 2, 10),
                                (5, 1, 10),
                                (5, 0, 10),
                                (4, 2, 10),
                                (4, 1, 10),
                                (4, 0, 10),
                                (3, 2, 10),
                                (3, 0, 10),
                                (2, 2, 10),
                                (2, 1, 10),
                                (2, 0, 10),
                                (1, 2, 10),
                                (1, 1, 10),
                                (1, 0, 10),
                                (3, 2, 13) ],

                      'air': [ (1, 0, 12), 
                                (1, 1, 12),
                                (4, 0, 11),
                                (4, 1, 11),
                                (4, 0, 12),
                                (4, 1, 12),
                                (4, 0, 13),
                                (4, 1, 13),
                                (3, 0, 11),
                                (3, 1, 11),
                                (3, 0, 12),
                                (3, 1, 12),
                                (2, 0, 11),
                                (2, 1, 11),
                                (2, 0, 12),
                                (2, 1, 12),
                                (2, 0, 13),
                                (2, 1, 13),
                                (3, 1, 10),
                                (5, 1, 12),
                                (3, 1, 14),
                                (3, 0, 13),
                                (3, 1, 13),
                                (0, 0, 9),
                                (0, 0, 10),
                                (0, 0, 11),
                                (0, 0, 12),
                                (0, 0, 13),
                                (0, 0, 14),
                                (0, 0, 15),
                                (1, 0, 15),
                                (2, 0, 15),
                                (3, 0, 15),
                                (4, 0, 15),
                                (5, 0, 15),
                                (6, 0, 15),
                                (6, 0, 14),
                                (6, 0, 13),
                                (6, 0, 12),
                                (6, 0, 11),
                                (6, 0, 10),
                                (6, 0, 9),
                                (5, 0, 9),
                                (4, 0, 9),
                                (3, 0, 9),
                                (2, 0, 9),
                                (1, 0, 9),
                                (0, 1, 9),
                                (0, 1, 10),
                                (0, 1, 11),
                                (0, 1, 12),
                                (0, 1, 13),
                                (0, 1, 14),
                                (0, 1, 15),
                                (1, 1, 15),
                                (2, 1, 15),
                                (3, 1, 15),
                                (4, 1, 15),
                                (5, 1, 15),
                                (6, 1, 15),
                                (6, 1, 14),
                                (6, 1, 13),
                                (6, 1, 12),
                                (6, 1, 11),
                                (6, 1, 10),
                                (6, 1, 9),
                                (5, 1, 9),
                                (4, 1, 9),
                                (3, 1, 9),
                                (2, 1, 9),
                                (1, 1, 9),
                                (0, 2, 9),
                                (0, 2, 10),
                                (0, 2, 11),
                                (0, 2, 12),
                                (0, 2, 13),
                                (0, 2, 14),
                                (0, 2, 15),
                                (1, 2, 15),
                                (2, 2, 15),
                                (3, 2, 15),
                                (4, 2, 15),
                                (5, 2, 15),
                                (6, 2, 15),
                                (6, 2, 14),
                                (6, 2, 13),
                                (6, 2, 12),
                                (6, 2, 11),
                                (6, 2, 10),
                                (6, 2, 9),
                                (5, 2, 9),
                                (4, 2, 9),
                                (3, 2, 9),
                                (2, 2, 9),
                                (1, 2, 9),
                                (0, 3, 9),
                                (0, 3, 10),
                                (0, 3, 11),
                                (0, 3, 12),
                                (0, 3, 13),
                                (0, 3, 14),
                                (0, 3, 15),
                                (1, 3, 15),
                                (2, 3, 15),
                                (3, 3, 15),
                                (4, 3, 15),
                                (5, 3, 15),
                                (6, 3, 15),
                                (6, 3, 14),
                                (6, 3, 13),
                                (6, 3, 12),
                                (6, 3, 11),
                                (6, 3, 10),
                                (6, 3, 9),
                                (5, 3, 9),
                                (4, 3, 9),
                                (3, 3, 9),
                                (2, 3, 9),
                                (1, 3, 9),
                                (1, 3, 10),
                                (1, 3, 11),
                                (1, 3, 12),
                                (1, 3, 13),
                                (1, 3, 14),
                                (2, 3, 10),
                                (2, 3, 11),
                                (2, 3, 12),
                                (2, 3, 13),
                                (2, 3, 14),
                                (3, 3, 10),
                                (3, 3, 11),
                                (3, 3, 12),
                                (3, 3, 13),
                                (3, 3, 14),
                                (4, 3, 10),
                                (4, 3, 11),
                                (4, 3, 12),
                                (4, 3, 13),
                                (4, 3, 14),
                                (5, 3, 10),
                                (5, 3, 11),
                                (5, 3, 12),
                                (5, 3, 13),
                                (5, 3, 14) ]
                     }

    ## Return the action code for forward
    def getForwardAC(self):
        return self.actions['forward']

    ## Return the action code for back
    def getBackAC(self):
        return self.actions['back']

    ## Return the action code for up
    def getUpAC(self):
        return self.actions['up']

    ## Return the action code for down
    def getDownAC(self):
        return self.actions['down']

    ## Return the action code for turn left
    def getTurnLeftAC(self):
        return self.actions['turn left']

    ## Return the action code for turn right
    def getTurnRightAC(self):
        return self.actions['turn right']
    
    ## Return the action code for turn around
    def getTurnAroundAC(self):
        return self.actions['turn around']

    ## Return the action code for pick up block
    def getPickUpBlockAC(self):
        return self.actions['pick up block']
        
    ## Return the action code for place dirt block
    def getPlaceDirtBlockAC(self):
        return self.actions['place dirt block']

    ## Return the action code for place cobblestone block
    def getPlaceCobblestoneBlockAC(self):
        return self.actions['place cobblestone block']

    # ## Return the action code for next episode
    # def getNextEpisodeAC(self):
    #     return self.actions['next episode']

    ## Return a random action code
    def getRandomAC(self):
        i = random.randint(0, 9)

        if i == 0:
            return self.getForwardAC()
        elif i == 1:
            return self.getBackAC()
        elif i == 2:
            return self.getUpAC()
        elif i == 3:
            return self.getDownAC()
        elif i == 4: 
            return self.getTurnLeftAC()
        elif i == 5:
            return self.getTurnRightAC()
        elif i == 6:
            return self.getTurnAroundAC()
        elif i == 7:
            return self.getPickUpBlockAC()
        elif i == 8:
            return self.getPlaceDirtBlockAC()
        elif i == 9:
            return self.getPlaceCobblestoneBlockAC()
        else:
            return self.getForwardAC()

    ## 
    # Parses Squirt's return message
    # @param msg The message Squirt writes back to Crush after each action
    # @return episode, step, x, y, z, facing, action, outcome in that order. 
    #
    # episode --> The episode number Squirt executed the action on
    # step    --> The step count Squirt exectured the action on
    # x, y, z --> Squirt's coordinate when he executed the action
    # facing  --> The cardinal direction Squirt was facing when he executed the action
    # action  --> The action code Squirt used to execute the action
    # outcome --> The outcome code of that action Squirt executed
    def parseSquirtMsg(self, msg):

        # TODO What about the case where msg == b''
        
        components = str(msg).split(",")
        
        episode = (components[0])[2:] # Get rid of b'
        step = components[1]
        x = (components[2])[:-2] # Get's rid of .0
        y = (components[3])[:-2] # Get's rid of .0
        z = (components[4])[:-2] # Get's rid of .0
        facing = components[5]
        action = components[6]
        outcome = (components[7])[:-1] # Get rid of '

        return str(episode), str(step), str(x), str(y), str(z), str(facing), str(action), str(outcome)

    ##
    # Takes action and state information from squirt to determine where the environment is being
    # changed. Only really useful when a block is picked up or placed.
    # @param msg The message Squirt wrote back after completing the action
    # @return x, y, z The position affected by Squirt's action
    #
    # TODO In need of refactor. Ideally this should be called when one of the actions is known
    def getAffectedPos(self, msg):

        # Parse Squirt's message 
        _, _, sqX, sqY, sqZ, facing, action, outcome = self.parseSquirtMsg(msg)

        # It's highly possible the action is of no concern. In that case, the following if block
        # will not be explored. The default return will therefore be the position Squirt acted in
        x, y, z = int(sqX), int(sqY), int(sqZ)

        # The actions that matter are placing blocks, and picking up blocks
        if action == "008" or "009" or "010":

            # React to the direction Squirt was facing.
            # 
            # |--------------------------|
            # |  Facing  | Affected Axis |
            # |--------------------------|
            # | "north"  |       -Z      |
            # | "east"   |       +X      |
            # | "south"  |       +Z      |
            # | "west"   |       -X      |
            # |--------------------------|

            if facing == "north":
                z -= 1
            elif facing == "east":
                x += 1
            elif facing == "south":
                z += 1
            elif facing == "west":
                x -= 1
                
        return x, y, z

    ##
    # Determines if the affected posisition is part of the house.
    # @param x, y, z The position affected by one of Squirt's actions. This position can be gotten from the
    # getAffectedPos function.
    # @return boolean True if the position is part of the house. False otherwise
    def isPosPartOfHouse(x, y, z):
        # Make a tuple of the arguments
        pos = (x, y, z)

       # See if this tuple is part of house['dirt'] or house['air']
        return (pos in self.house['dirt']) or (pos in self.house['air'])

    ##
    # Determines if the position in question should have a block placed in it. Should be called only if the
    # pos in question is part of the house.
    def shouldPosHaveBlock(x, y, z)
        return pos in self.house['dirt']

    ## Takes state information from Squirt, and returns a reward to Crush
    def getReward(action, outcome):
        pass
