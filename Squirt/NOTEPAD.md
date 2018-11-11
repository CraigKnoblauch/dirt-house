# Squirt Notepad
One place for all my notes on using OpenComputers for this project

## OPPM
A crucial part of this project is registering Squirt with the in-game package manager oppm. According to the wiki, there are two ways this can be done. 
- **Locally**, by editing `/etc/oppm.cfg`
- **Globally**, by creating a `programs.cfg` in the root of this project

### Locally
According to the [wiki](https://ocdoc.cil.li/tutorial:program:oppm) I edit the oppm.cfg file in /etc. At the root of this project, this file can be found. To get this into the game, I call
```
wget https://raw.githubusercontent.com/CraigKnoblauch/dirt-house/master/oppm.cfg
```
in /etc.
