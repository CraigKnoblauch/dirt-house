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
        self.house = {'air': [ (),
                               (),
                               ()
                             ],

                      'dirt': [ (), 
                                (),
                              ]
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

    ##
    # Determines if the position in question should have a block placed in it. Should be called only if the
    # pos in question is part of the house.
    def shouldPosHaveBlock(x, y, z)

    ## Takes state information from Squirt, and returns a reward to Crush
    def getReward(action, outcome):
        pass
