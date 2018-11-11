# Dirt House
A project to teach an OpenComputers robot, named Squirt, to build a dirt house in Minecraft.

This project depends on two components:
- Crush: A DQN computational engine. Crush's job is to direct Squirt's actions based on what Squirt does in the Minecraft environment.
- Squirt: An OpenComputers robot. Squirt uses an API, built around OpenComputer functionality, to accept orders from Crush, navigate it's environment, and send reports to Crush.

# Crush
This section gives a broad overview of Crush; his responsibilities and operation. For more detail, refer to [Crush's README](https://www.github.com/CraigKnoblauch/dirt-house/master/Crush/README.md).
Crush creates a DQN with tensorflow and keras. 
