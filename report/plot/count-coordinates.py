import csv
import matplotlib.pyplot as plt
import matplotlib.colors as colors
from mpl_toolkits.mplot3d import Axes3D
import numpy as np


class Coordinate:

    def __init__(self, x, y, z):
        self.x = int(x)
        self.y = int(y)
        self.z = int(z)

        # Increment this value each time a coordinate is found
        self.count = 0

        # Color assigned based on the count. Starts as Light purple
        self.color = 0xff00ff

    # Checks between the equivalence of this coordinate and some other coordinate object
    def __eq__(self, some_coord):
        x_eq = ( self.x == some_coord.x )
        y_eq = ( self.y == some_coord.y )
        z_eq = ( self.z == some_coord.z )

        return x_eq and y_eq and z_eq

    # Define how the attributes of this class will be printed
    def __str__(self):
        return "( {}, {}, {} ) = {}".format(self.x, self.y, self.z, self.count)

    # Increment count
    def incrementCount(self):
        self.count += 1

    # Convert coordinates from minecraft coordinates to plottable coordinates
    def transpose(self):
        tempX, tempY, tempZ = self.x, self.y, self.z

        self.x = tempZ
        self.y = tempX
        self.z = tempY


# Generate all the coordinates we need to keep track of
compare_to = []
for x in range(0,16):
    for z in range(0,16):
        for y in range(0,9):
            compare_to.append( Coordinate(x, y, z) )

# Confirm that the count of coordinates is equal to 16x16x9
assert( len(compare_to) == 16*16*9 )

with open('action_record.csv', 'r') as csvfile:
    reader = csv.reader(csvfile)
    
    title_row = next(reader)

    # Find the indices of the coordinates
    x_i = title_row.index('x')
    y_i = title_row.index('y')
    z_i = title_row.index('z')

    # Increment Coordinate objects as coordinates of csv are explored
    for i, row in enumerate(reader):
        print("row {}".format(i))

        # Coordinate of the row
        row_coordinate = Coordinate( row[x_i], row[y_i], row[z_i] )

        # Find where the row coordinate matches up to the compare Coordinates
        matching_coordinate_i = compare_to.index( row_coordinate )

        # Increment the count of the matching coordinate
        (compare_to[ matching_coordinate_i ]).incrementCount()

        # For testing only
        if i == 300:
            break

# Sort the compare to coordinates by count, greatest to least
compare_to.sort(key=lambda x: x.count, reverse=True)

# Get the max count
MAX_COUNT = compare_to[0].count

# Use max count to normalize the counts of the coordinates
coord_norm = colors.Normalize(vmin=0, vmax=MAX_COUNT)

# Get the spectral color map
cmap = plt.cm.get_cmap('Spectral')

fig = plt.figure()
ax = fig.add_subplot(111, projection='3d')

# For each set of style and range settings, plot n random points in the box
# defined by x in [23, 32], y in [0, 100], z in [zlow, zhigh].
for coord in compare_to:
    coord.transpose()
    xs = coord.x
    ys = coord.y
    zs = coord.z

    norm_color_val = coord_norm( coord.count )

    ax.scatter(xs, ys, zs, c=cmap( norm_color_val ), marker='o')

ax.set_xlabel('X Label')
ax.set_ylabel('Y Label')
ax.set_zlabel('Z Label')

plt.show()





