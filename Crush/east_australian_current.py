

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

    ## Takes state information from Squirt, and returns a reward to Crush
    def getReward(action, outcome):
        pass
