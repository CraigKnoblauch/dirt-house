import socket

HOST = "127.0.0.1"
PORT = 65432

# NOTE: The robot has no orientation, so the demo will have to be Crush commanding Squirt to continue again around the square

# Set up a server at local host
# Wait for a connection from Squirt
with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
    s.bind( (HOST, PORT) )
    s.listen()
    conn, addr = s.accept()

    # Squirt has connected, tell him to begin
    with conn:

        while True:
            # Tell Squirt to begin
            conn.sendall(b'begin')

            print("[CRUSH] - I've commanded Squirt to begin loop " + str(loopCounter) )

            # Print Squirt's observations. 
            # When squirt has finished, tell him to turn right and begin
            loopCounter = 0
            while True: 
                data = conn.recv(1024)
                print( "[CRUSH] - Squirt reports: " + str(data) )

                if( data == b'done' ):
                    print("[CRUSH] - Squirt is done")

                    # Wait for a confirmation from Squirt
                    data = ''
                    data = conn.recv(1024)
                    while data != b'done':
                        # Block
                        pass

                if( loopCounter < 3 ):
                    loopCounter += 1
                else:
                    break

                
