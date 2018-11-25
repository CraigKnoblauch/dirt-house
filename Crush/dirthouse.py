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

    conn.close()