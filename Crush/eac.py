

## East Australian Current
# @class This class is responsible for send action requests to Squirt and for 
# interpreting responses From Squirt. Interpretation of a response includes 
# sending a reward to Crush
class EAC:

    def __init__(self):
        self.actions = {'noop': 0,
                        'forward': 1,
                        'back': 2,
                        'up': 3,
                        'down': 4,
                        'turn left': 5,
                        'turn right': 6,
                        'turn around': 7,
                        'pick up block': 8,
                        'place block': 9,
                        'next episode': 10 }