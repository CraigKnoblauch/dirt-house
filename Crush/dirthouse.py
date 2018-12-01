import socket
import random
from east_australian_current import EAC

eac = EAC()

NUM_EPISODES = 3
NUM_STEPS = 400

action_codes = list( (eac.actions).keys() )


# Open a socket for Squirt to connect to
with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
    s.bind( (eac.HOST, eac.PORT) )

    # Wait for Squirt to initiate comms
    s.listen()

    conn, addr = s.accept()

    with conn:
        print("Squirt has connected")
       
        # At Squirt's starting postion, place a block. Ask internally if the block is part of the house
        action_code = eac.getPickUpBlockAC()
        conn.sendall(action_code)
        msg = conn.recv(1024)
        print(msg)

        x, y, z = eac.getAffectedPos(msg)
        if eac.shouldPosHaveBlock(x, y, z):
            print("Pos is part of house")
        else:
            print("Pos is not part of house")

        
        # # Send squirt to 1,1,1. Turn him in all four directions and place a block in each direction
        # # Output the affected coordinates per placement. Should see, assuming we start at east
        # #
        # # 2,0,1 --> east
        # # 1,0,2 --> south
        # # 0,0,1 --> west
        # # 1,0,0 --> north

        # # Send Squirt Forward, turn Right, forward, turn left
        # action_code = eac.getForwardAC()
        # conn.sendall(action_code)

        # msg = conn.recv(1024)
        # print(msg)

        # action_code = eac.getTurnRightAC()
        # conn.sendall(action_code)

        # msg = conn.recv(1024)
        # print(msg)

        # action_code = eac.getForwardAC()
        # conn.sendall(action_code)

        # msg = conn.recv(1024)
        # print(msg)

        # action_code = eac.getTurnLeftAC()
        # conn.sendall(action_code)

        # msg = conn.recv(1024)
        # print(msg)

        # # Place a block East --> 2, 0, 1
        # action_code = eac.getPlaceDirtBlockAC()
        # conn.sendall(action_code)
        # msg = conn.recv(1024)
        # x, y, z = eac.getAffectedPos(msg)

        # print("---------------------------------------")
        # print("EAST: " + str(msg) + " ~ Squirt")
        # if x == 2 and y == 0 and z == 1:
        #     print("EAST PLACEMENT: PASS")
        # else:
        #     print("EAST PLACEMENT: FAIL")
        #     print(str(x) + str(y) + str(z))

        # # Turn Right
        # action_code = eac.getTurnRightAC()
        # conn.sendall(action_code)
        # msg = conn.recv(1024)


        # # Place a block South --> 1, 0, 2
        # action_code = eac.getPlaceDirtBlockAC()
        # conn.sendall(action_code)
        # msg = conn.recv(1024)
        # x, y, z = eac.getAffectedPos(msg)

        # print("---------------------------------------")
        # print("SOUTH: " + str(msg) + " ~ Squirt")
        # if x == 1 and y == 0 and z == 2:
        #     print("SOUTH PLACEMENT: PASS")
        # else:
        #     print("SOUTH PLACEMENT: FAIL")
        #     print(str(x) + str(y) + str(z))

        # # Turn Right
        # action_code = eac.getTurnRightAC()
        # conn.sendall(action_code)
        # msg = conn.recv(1024)

        #  # Place a block West --> 0, 0, 1
        # action_code = eac.getPlaceDirtBlockAC()
        # conn.sendall(action_code)
        # msg = conn.recv(1024)
        # x, y, z = eac.getAffectedPos(msg)

        # print("---------------------------------------")
        # print("WEST: " + str(msg) + " ~ Squirt")
        # if x == 0 and y == 0 and z == 1:
        #     print("WEST PLACEMENT: PASS")
        # else:
        #     print("WEST PLACEMENT: FAIL")
        #     print(str(x) + str(y) + str(z))

        # # Turn Right
        # action_code = eac.getTurnRightAC()
        # conn.sendall(action_code)
        # msg = conn.recv(1024)

        # # Place a block North --> 1, 0, 0
        # action_code = eac.getPlaceDirtBlockAC()
        # conn.sendall(action_code)
        # msg = conn.recv(1024)
        # x, y, z = eac.getAffectedPos(msg)

        # print("---------------------------------------")
        # print("NORTH: " + str(msg) + " ~ Squirt")
        # if x == 1 and y == 0 and z == 0:
        #     print("NORTH PLACEMENT: PASS")
        # else:
        #     print("NORTH PLACEMENT: FAIL")
        #     print(str(x) + str(y) + str(z))

        # # Turn Right
        # action_code = eac.getTurnRightAC()
        # conn.sendall(action_code)
        # msg = conn.recv(1024)

        # # Return to start
        # action_code = eac.getTurnLeftAC()
        # conn.sendall(action_code)
        # msg = conn.recv(1024)

        # action_code = eac.getForwardAC()
        # conn.sendall(action_code)
        # msg = conn.recv(1024)

        # action_code = eac.getTurnRightAC()
        # conn.sendall(action_code)
        # msg = conn.recv(1024)

        # action_code = eac.getBackAC()
        # conn.sendall(action_code)
        # msg = conn.recv(1024)
        
    
        conn.close()