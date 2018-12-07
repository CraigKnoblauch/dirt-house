import csv
import matplotlib.pyplot as plt
import matplotlib.colors as colors
from mpl_toolkits.mplot3d import Axes3D
import numpy as np

# Hold the totals of all actions
forward = 0
back = 0
up = 0
down = 0
turn_left = 0
turn_right = 0
turn_around = 0
pick_up_block = 0
place_dirt_block = 0
place_cobblestone_block = 0
TOTAL = 0

with open('../stats/action_record.csv', 'r') as csvfile:
    reader = csv.reader(csvfile)
    
    title_row = next(reader)

    # Find the index of the action codes
    aci = title_row.index('action code')

    # Increment Coordinate objects as coordinates of csv are explored
    for i, row in enumerate(reader):
        print("row {}".format(i))

        # Based on the action code, increment the appropriate counter
        ac = int( row[aci] )

        if ac == 1:
            forward += 1    
        elif ac == 2:
            back += 1
        elif ac == 3:
            up += 1
        elif ac == 4:
            down += 1
        elif ac == 5:
            turn_left += 1
        elif ac == 6:
            turn_right += 1
        elif ac == 7:
            turn_around += 1
        elif ac == 8:
            pick_up_block += 1
        elif ac == 9:
            place_dirt_block += 1
        else:
            place_cobblestone_block += 1

TOTAL = forward + back + up + down + turn_around + turn_left + turn_right + pick_up_block + place_cobblestone_block + place_dirt_block
actions = [forward, back, up , down, turn_left, turn_right, turn_around, pick_up_block, place_dirt_block, place_cobblestone_block]

# Make a pie chart
names = ['Move forward', 'Move back', 'Move up', 'Move down', 'Turn left', 'Turn right', 'Turn around', 'Pick up a block', 'Place a dirt block', 'Place a cobblestone block']
action_pie, _ = plt.pie(actions, autopct='%.2f')

plt.legend(action_pie, names, loc="best")
plt.axis('equal')
plt.tight_layout()
plt.show()








