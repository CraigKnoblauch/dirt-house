import socket
import random
import numpy as np
from east_australian_current import EAC
from crush import Crush
from agent import DQNAgent

eac = EAC()
crush = Crush()
agent = DQNAgent(crush.state_size, crush.action_space.n, learning_rate=0.01, epsilon=0.95)

NUM_EPISODES = 3
NUM_STEPS = 400

action_codes = list( (eac.actions).keys() )

GROUP_SIZE = 20

# Set hyper parameters
state_size = crush.state_size
action_size = crush.action_space.n
batch_size = 32 # For gradient descent, vary by powers of 2
n_episodes = 2000 # but who really cares. It's going infinitely
out_dir = 'model_output/dirthouse'

# Open a socket for Squirt to connect to
with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
    s.bind( (eac.HOST, eac.PORT) )

    # Wait for Squirt to initiate comms
    s.listen()

    conn, addr = s.accept()

    with conn:
        print("Squirt has connected")

        # Begin training.
        while True:
            state = crush.reset()
            state = np.reshape(state, [1, state_size])
            done = False

            while not done:
                action = agent.act(state)

                # Translate the action from an index in the action space into the action code
                action_code = eac.indexToAC(action)
                conn.sendall(action_code)
                msg = conn.recv(1024)

                next_state, reward, done, _ = crush.step(action, msg)

                next_state = np.reshape(next_state, [1, state_size])
                agent.remember(state, action, reward, next_state, done)

                state = next_state
    
        conn.close()