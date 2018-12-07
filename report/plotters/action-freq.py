import csv
import matplotlib.pyplot as plt
import matplotlib.colors as colors
from mpl_toolkits.mplot3d import Axes3D
import numpy as np
import pylab

class EpisodeActions:

    def __init__(self, episode):
        self.episode = episode
        self.forward_count = 0
        self.back_count = 0
        self.up_count = 0
        self.down_count = 0
        self.turn_left_count = 0
        self.turn_right_count = 0
        self.turn_around_count = 0
        self.pick_up_block_count = 0
        self.place_dirt_block_count = 0
        self.place_cobblestone_block_count = 0

    def incrementActionCount(self, action_code):

        if action_code == 1:
            self.forward_count += 1    
        elif action_code == 2:
            self.back_count += 1
        elif action_code == 3:
            self.up_count += 1
        elif action_code == 4:
            self.down_count += 1
        elif action_code == 5:
            self.turn_left_count += 1
        elif action_code == 6:
            self.turn_right_count += 1
        elif action_code == 7:
            self.turn_around_count += 1
        elif action_code == 8:
            self.pick_up_block_count += 1
        elif action_code == 9:
            self.place_dirt_block_count += 1
        else:
            self.place_cobblestone_block_count += 1


episodes = [ EpisodeActions(e) for e in range(0,1121) ] 

with open('../stats/action_record.csv', 'r') as csvfile:
    reader = csv.reader(csvfile)
    
    title_row = next(reader)

    # Find the index of the episode count and the action code
    ep_i = title_row.index('Episode')
    ac_i = title_row.index('action code')

    # Increment Coordinate objects as coordinates of csv are explored
    for i, row in enumerate(reader):
        print("row {}".format(i))

        # Based on the episode count and action code, increment the appropriate counter
        episode = int( row[ep_i] )
        action_code = int( row[ac_i] )

        episodes[ episode ].incrementActionCount( action_code )

# Make a multi-line graph displaying the frequency of actions
forward_f, back_f, up_f, down_f, left_f, right_f, around_f, pick_f, place_dirt_f, place_cobble_f = [], [], [], [], [], [], [], [], [], []

names = ['Move forward', 'Move back', 'Move up', 'Move down', 'Turn left', 'Turn right', 'Turn around', 'Pick up a block', 'Place a dirt block', 'Place a cobblestone block']

for ep in episodes:
    forward_f.append( ep.forward_count )
    back_f.append( ep.back_count )
    up_f.append( ep.up_count )
    down_f.append( ep.down_count )
    left_f.append( ep.turn_left_count )
    right_f.append( ep.turn_right_count )
    around_f.append( ep.turn_around_count )
    pick_f.append( ep.pick_up_block_count )
    place_dirt_f.append( ep.place_dirt_block_count )
    place_cobble_f.append( ep.place_cobblestone_block_count )

x = range(0,1121)

z = np.polyfit(x, forward_f, 5)
p = np.poly1d(z)
pylab.plot(x,p(x))

z = np.polyfit(x, back_f, 5)
p = np.poly1d(z)
pylab.plot(x,p(x))

z = np.polyfit(x, up_f, 5)
p = np.poly1d(z)
pylab.plot(x,p(x))

z = np.polyfit(x, down_f, 5)
p = np.poly1d(z)
pylab.plot(x,p(x))

z = np.polyfit(x, left_f, 5)
p = np.poly1d(z)
pylab.plot(x,p(x))

z = np.polyfit(x, right_f, 5)
p = np.poly1d(z)
pylab.plot(x,p(x))

z = np.polyfit(x, around_f, 5)
p = np.poly1d(z)
pylab.plot(x,p(x))

z = np.polyfit(x, pick_f, 5)
p = np.poly1d(z)
pylab.plot(x,p(x))

z = np.polyfit(x, place_dirt_f, 5)
p = np.poly1d(z)
pylab.plot(x,p(x))

z = np.polyfit(x, place_cobble_f, 5)
p = np.poly1d(z)
pylab.plot(x,p(x))

pylab.legend(names)
pylab.show()


