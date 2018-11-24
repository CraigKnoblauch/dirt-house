import socket
from east_australian_current import EAC

eac = EAC()

# Open a socket for Squirt to connect to
with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
    s.bind( (eac.HOST, eac.PORT) )

    # Wait for Squirt to initiate comms
    s.listen()

    conn, addr = s.accept()

    with conn:
        print("Squirt has connected")
       
        # Demo, command Squirt to move forward, 
        action_code = eac.getForwardAC()
        conn.sendall(action_code)

        data = conn.recv(1024)
        print(data)

    conn.close()