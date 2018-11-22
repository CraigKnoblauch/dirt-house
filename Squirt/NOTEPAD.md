# Squirt Notepad
One place for all my notes on using OpenComputers for this project

## robot
The functions in this module are very straightforward. I'll use this section to detail weird behavior and make plans to work around it. 
1. `robot` has no orientation. In the API I design, we'll need to design some way to track that.
2. The move functions are non-blocking relative to `debug`. In the API, I'll have to make wrapper functions for the move functions that allow Squirt to move, but do not allow a calling program to progress until Squirt has finished moving.
3. The turn functions **are** blocking.
4. Calling up in an infinite loop causes Squirt to stop going up after 8 blocks. At that point, Squirt starts spitting out particle effects.

## debug
Like the previous section, I'll be using this to detail weird behavior and plans to work around it.
1. Unlike other components, the only way I've been able to successfully include this in a lua script is like so: `require("component").debug`. 
2. I've found that the world I'm in, for the `getWorld` function, is 0. I don't know if this is true for all instances.
3. The X coordinate from the `getX` function is off by one. To mitigate this, use a wrapper function that subtracts 1 from the return of this function. If we make a wrapper function, if the mod is updated and this behavior is fixed, only our wrapper has to be changed. 

## oppm
A crucial part of this project is registering Squirt with the in-game package manager oppm. After a lot of help from @Vexatos on OpenComputer's discord server, I nailed down the following notes about creating a package compatible with OPPM on github.
1. The repository where the package exists must have a config file by the name of `programs.cfg` in the root directory.
2. To register the repository with oppm, call `oppm register <github-username>/<repository-name>`. In my case, this is `oppm register CraigKnoblauch/dirt-house`.
3. The top key of `programs.cfg` is the name of the package. So, you can have multiple packages in the same repository. To install a package from the registered repository, call `oppm install <package-name>`. In Squirt's case, it was `oppm install squirt`.
4. According to `/etc/oppm.cfg`, the files will be installed in `/usr/lib`. Now we can include the files from the package we want, and their functions along with it. As a small note, the files that we include are executed when we call `require`. So, to get access to the functions made in those files, the file must return a table of those functions. At the time of writing this section, I had a file called `nav.lua` with a wrapper function `sqForward`. After installing my package, I could do the following
```
lua
> n = require("nav")
> n
{sqForward=function: 0x7fb3282c5d70}
```
5. Now that the package is installed, if I update the github, all I have to do to update the code is `oppm update <package-name>`. An important note: required files are cached. To reset the file before calling `require` you can do either of the following:
- reboot
- In a lua console: `package.loaded.nav = nil`

## navigation
The navigation upgrade is needed to access these functions. After that is included, we can call `require("component").navigation`.
1. Waypoints are a useful tool. Especially since their position is read by Squirt relative to Squirt's location.
2. To find lead Squirt to a position, whether it's a world coordinate or a waypoint, directions matter. 
 - East/West is +x/-x
 - North/South is -z/+z 

## action
1. Squirt must be equipped with a tool to pick up blocks that require a tool.
2. Tool decay can be turned off by setting `itemDamageRate` in the settings config to 0.
