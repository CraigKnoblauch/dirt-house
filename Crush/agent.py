# Many thanks to the tutorial I followed at https://www.youtube.com/watch?v=OYhFoMySoVs&t=0s&list=WL&index=24

import random
import numpy as np
from collections import deque
from keras.models import Sequential
from keras.layers import Dense
from keras.optimizers import Adam

## Define the agent
class DQNAgent:

    def __init__(self, state_size, action_size, mem_length=2000,
                 gamma=0.9, epsilon=1.0, epsilon_decay=0.995, epsilon_min=0.01,
                 learning_rate=0.001):
        self.state_size = state_size
        self.action_size = action_size

        # Define memory
        self.memory = deque(maxlen=mem_length)

        # Hyper parameters
        self.gamma = gamma # Discount factor. How much to discount future reward
        self.epsilon = epsilon # Exploration rate
        self.epsilon_decay = epsilon_decay # With ongoing training, the agent must exploit knowledge
        self.epsilon_min = epsilon_min
        self.learning_rate = learning_rate # Step size for stoichastic gradient descent optimizer
        self.model = self.__build_model()

    ## Build dense nn for approximating Q*
    def __build_model(self):
        model = Sequential()

        # Hidden layers
        model.add(Dense(24, input_dim=self.state_size, activation='relu'))
        model.add(Dense(24, activation='relu'))

        # Input layer
        model.add(Dense(self.action_size, activation='linear'))

        model.compile(loss='mse', optimizer=Adam(lr=self.learning_rate))

        return model

    ## Takes on state, action, reward, next state, and done.
    def remember(self, state, action, reward, next_state, done):
        self.memory.append([state, action, reward, next_state, done])

    ## Act on our exploration/exploitation
    def act(self, state):
        if np.random.rand() <= self.epsilon:
            return random.randrange(self.action_size) # Exploration mode

        act_values = self.model.predict(state)
        return np.argmax(act_values[0])

    def replay(self, batch_size):
        minibatch = random.sample(self.memory, batch_size) # Randomly sample some memories

        for state, action, reward, next_state, done in minibatch:
            target = reward
            if not done:
                target = reward + self.gamma * np.amax(self.model.predict(next_state)[0])

            # Map maximized current reward to future reward
            target_f = self.model.predict(state)
            target_f[0][action] = target

            self.model.fit(state, target_f, epochs=1, verbose=False)

        if self.epsilon > self.epsilon_min:
            self.epsilon *= self.epsilon_decay

    def load(self, name):
        self.model.load_weights(name)

    def save(self, name):
        self.model.save_weights(name)


