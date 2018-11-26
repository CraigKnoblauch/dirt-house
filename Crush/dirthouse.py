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
       
        # Send Squirt random actions
        while True: 
            action_code = eac.getRandomAC()
            conn.sendall(action_code)

            data = conn.recv(1024)
            print(data)

            # # -- Additons
            # episode, step, x, y, z, facing, action, outcome = eac.parseSquirtMsg(data)
            # print("Episode: " + str(episode))
            # print("Step: " + str(step))
            # print(str(x) + " " + str(y) + " " + str(z))
            # print("Facing: " + str(facing))
            # print("Action: " + str(action))
            # print("Outcome: " + str(outcome))

            

    conn.close()