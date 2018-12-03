import socket
import random
from east_australian_current import EAC
from crush import Crush
from agent import DQNAgent

agent = DQNAgent()
eac = EAC()
crush = Crush()

NUM_EPISODES = 3
NUM_STEPS = 400

action_codes = list( (eac.actions).keys() )

GROUP_SIZE = 20

# Set hyper parameters
state_size = 2
action_size = env.action_space.n
batch_size = 32 # For gradient descent, vary by powers of 2
n_episodes = 2000 # but who really cares. It's going infinitely
out_dir = 'model_output/dirthouse'

action_code = eac.getTurnRightAC()
        conn.sendall(action_code)
        msg = conn.recv(1024)
        print(msg)


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

                next_state, reward, done, _ = env.step(action, msg)

                next_state = np.reshape(next_state, [1, state_size])
                agent.remember(state, action, reward, next_state, done)

                state = next_state
    
        conn.close()