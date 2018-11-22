# Dirt House
A project to teach an OpenComputers robot, named Squirt, to build a dirt house in Minecraft.

This project depends on two components:
- Crush: A DQN computational engine. Crush's job is to direct Squirt's actions based on what Squirt does in the Minecraft environment.
- Squirt: An OpenComputers robot. Squirt uses an API, built around OpenComputer functionality, to accept orders from Crush, navigate it's environment, and send reports to Crush.

# Crush
This section gives a broad overview of Crush; his responsibilities and operation. For more detail, refer to [Crush's README](https://www.github.com/CraigKnoblauch/dirt-house/master/Crush/README.md).
Crush creates a DQN with tensorflow and keras. 

# East Australian Current (EAC)
This is the medium by which Crush and Squirt communicate. This is the basic operation:
1. The EAC sends a command to Squirt
2. The EAC receives Squirt's relative position, and the outcome of Squirt's action. 
3. The EAC determines a reward to feed to Crush. 
4. The EAC sends a new command from Crush to Squirt
