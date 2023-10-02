<!-- add configurable functionality to drop some random invent items, ability to add exclusions -->

## TODO Features


- [ ] Add configurable functionality to drop some random invent items, ability to add exclusions
- [ ] Add List of all setr values and how to use them
- [x] Package up hospital_map or another free pillbox and use that instead of the current one
- [x] Document states used in the script
- [ ] Add targeting functionality to bandage other players and stop bleeding

## TODO Fixes
- [x] Update any outdated ox_core functions/exports/calls
- [x] Fix Heal command
- [x] Fix Revive command
- [ ] Add export to revive other players
- [ ] Add export to heal other players

## setr values

```cfg
setr medical:deathTimer 10 # how long must the player be down before respawning (in seconds), 180 by default
setr medical:debug 1 # 0 to disable 1 to enable, 0 by default
setr medical:dropInventory 0 # 0 to disable 1 to enable 2 for weapons only, 0 by default
setr medical:smellingsalt 1 # 0 to disable 1 to enable, 0 by default
```

## States used

```lua
Player.state.dead
```