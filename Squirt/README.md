# Squirt's requirements and responsibilities
This page details Squirt's operating responsibilities including movement, navigation, interaction with the environment, and communicating with Crush

## Movement and Navigation (sq-swim)
Squirt must: 
- [x] move forward, backward, up, and down. 
- [x] turn left, right, and around
- [x] know how to navigate to a position
- [x] know how to navigate to a waypoint
- [x] know his orientation
- [x] know his position

## Interaction with the environment (sq-act)
Squirt must:
- [x] Know the type of block in front of him
- [x] Know the type of block behind him
- [x] Know the type of block to the right of him
- [x] Know the type of block to the left of him
- [x] Know the type of block above him
- [x] Know the type of block below him
- [ ] ~~Know the block he's going to pick up~~
- [ ] ~~Choose a block to pick up~~ (<-- Crush is responsible for this)
- [x] Pick up a block in front, to the right, to the left, behind, above, or below him
- [x] Know what block he picked up
- [x] Put picked up blocks in the proper indices (1, 2, 3, 4 for dirt. 5, 6, 7, 8 for cobble) (**This only works for this specialized project**)
- [ ] ~~Know what block he's going to place~~
- [ ] ~~Choose a block to place~~ (<-- Crush is responsible for this)
- [x] Place up a block in front, to the right, to the left, behind, above, or below him
- [x] Know the block he placed

## Communicating with the EAC (sq-comms)
Squirt must:
- [x] Open a connection at 127.0.0.1:65432
- [x] Read a standard amount of bytes (5 bytes)
- [ ] Write a standard message (x, y, z, action, outcome)
