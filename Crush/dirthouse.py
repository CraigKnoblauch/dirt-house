import socket
from east_australian_current import EAC

eac = EAC()

NUM_EPISODES = 3
NUM_STEPS = 400

# Open a socket for Squirt to connect to
with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
    s.bind( (eac.HOST, eac.PORT) )

    # Wait for Squirt to initiate comms
    s.listen()

    conn, addr = s.accept()

    with conn:
        print("Squirt has connected")
       
        # Demo, command Squirt to move back, 
        action_code = eac.getBackAC()
        conn.sendall(action_code)

        data = conn.recv(1024)
        print(data)

        # Demo, command Squirt to move down, 
        action_code = eac.getDownAC()
        conn.sendall(action_code)

        data = conn.recv(1024)
        print(data)

        # Demo, command Squirt to turn left, 
        action_code = eac.getTurnLeftAC()
        conn.sendall(action_code)

        data = conn.recv(1024)
        print(data)

        # Demo, command Squirt to turn right, 
        action_code = eac.getTurnRightAC()
        conn.sendall(action_code)

        data = conn.recv(1024)
        print(data)

        # Demo, command Squirt to turn around, 
        action_code = eac.getTurnAroundAC()
        conn.sendall(action_code)

        data = conn.recv(1024)
        print(data)

        # Demo, command Squirt to pick up block, 
        action_code = eac.getPickUpBlockAC()
        conn.sendall(action_code)

        data = conn.recv(1024)
        print(data)

        # Demo, command Squirt to place dirt, 
        action_code = eac.getPlaceDirtBlockAC()
        conn.sendall(action_code)

        data = conn.recv(1024)
        print(data)

        # Demo, command Squirt to place cobblestone, 
        action_code = eac.getPlaceCobblestoneBlockAC()
        conn.sendall(action_code)

        data = conn.recv(1024)
        print(data)

    conn.close()