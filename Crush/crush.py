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

        loopCounter = 0
        while True:
            # Tell Squirt to begin
            conn.sendall(b'begin')

            print("[CRUSH] - I've commanded Squirt to begin loop " + str(loopCounter) )

            # Wait for Squirt to report he is done
            data = conn.recv(1024)

            print("[CRUSH] - I've received " + str(data) + " from Squirt")

            while data != b'done':
                data = conn.recv(1024)

            if( loopCounter < 3 ):
                loopCounter += 1

                # Command Squirt to go again
                conn.sendall(b'begin')

            else:
                # Command Squirt to stop
                conn.sendall(b'stop!')
                break
        
        # Wait for unsubscribe from Squirt
        data = conn.recv(1024)

        while data != b'unsubscribe':
            data = conn.recv(1024)

        print("[CRUSH] - I have recieved from Squirt: " + str(data))

    s.close()


                
