import socket
from east-australian-current import EAC

eac = EAC()

# Open a socket for Squirt to connect to
with open socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
    s.bind( (eac.HOST, eac.PORT) )

    # Wait for Squirt to initiate comms
    s.listen()

    conn, addr = s.accept()

    with conn:
        print("Squirt has connected")
        data = conn.recv(1024)
        if data == b'ready':
            # Demo, command Squirt to move forward, 
            action_code = eac.getForwardAC()
            conn.sendall(action_code)

            data = conn.recv(1024)
            print(data)
        else:
            print("ERROR: Received \"" + data + "\" from Squirt")

    conn.close()