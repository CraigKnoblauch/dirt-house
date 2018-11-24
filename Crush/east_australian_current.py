

## East Australian Current
# @class This class is responsible for send action requests to Squirt and for 
# interpreting responses From Squirt. Interpretation of a response includes 
# sending a reward to Crush
class EAC:

    def __init__(self):
        self.actions = {'noop': 0,
                        'forward': b'001',
                        'back': 2,
                        'up': b'003',
                        'down': 4,
                        'turn left': 5,
                        'turn right': 6,
                        'turn around': 7,
                        'pick up block': 8,
                        'place block': 9,
                        'next episode': 10 }

        self.HOST = "127.0.0.1"
        self.PORT = 65432

    ## Return the action code for noop
    def getNoopAC(self):
        return self.actions['noop']

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
        
    ## Return the action code for place block
    def getPlaceBlockAC(self):
        return self.actions['place block']

    ## Return the action code for next episode
    def getNextEpisodeAC(self):
        return self.actions['next episode']

    ## Takes state information from Squirt, and returns a reward to Crush
    def getReward(action, outcome):
        pass
