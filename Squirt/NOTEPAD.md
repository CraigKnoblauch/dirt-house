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

Now I can call `oppm install <package-name>` and the files will be installed in `/usr`. My last question is how do I access this functionality in my own scripts? Specifically, there's a file in my package called `nav.lua` that contains a function `sqForward`. __How do I call this function insdie another lua script__?

### Globally
The top key of `programs.cfg`
