# RP Medical - WIP

Simple medical system for [ox_core]() that leverages StateBags, statuses and the [CEventNetworkEntityDamage](https://github.com/logan-mcgee/FiveM-Documentation/blob/master/GameEvents/EventList.md#182---ceventnetworkentitydamage) game event.

Our goal was to decouple the EMS job from the medical system to allow more flexibility. This system will not include EMS but we do plan on writing that as a separate resource.

This script handles:

1. Wounding statuses using ox_core's status system.
   - bleed
   - stagger
   - unconscious
2. Player death and respawning using player state.
3. Usage of Pillbox (default configured to [AshiroDev's hospital map](https://forum.cfx.re/t/interior-map-pillbox-medical-center-top-floor/949788)) for self-serve care.

## Contributions

Please open an issue prior to spending time coding any major changes to avoid wasting your time.

## Exports

Revive player:

```lua
exports.rp_medical:Revive(target)
```

## Dependecies

- [ox_core](https://github.com/overextended/ox_core)
- [ox_lib](https://github.com/overextended/ox_lib)
- [scully_emotemenu](https://github.com/Scullyy/scully_emotemenu)
- OneSync Infinity
- FXServer >= `5484`

### Optional

- [ox_target](https://github.com/overextended/ox_target)
- [xSound](https://github.com/Xogy/xsound/releases/latest/)

## Installation

Drop script into resources folder

Create config file: `medical.cfg` to adjust default settings

### Convars:

```cfg
## respawn countdown (in seconds) | 180 by default
 setr medical:deathTimer 60

## 0 to disable 1 to enable | 0 by default
 setr medical:debug 1
```

### Database:

Update required to run this script properly.

Run statuses.sql to update your database for compatibility or manually update the ox_statuses table.

```sql
INSERT INTO `ox_statuses` (`name`, `ontick`) VALUES ('unconscious', -0.1);
INSERT INTO `ox_statuses` (`name`, `ontick`) VALUES ('stagger', -0.1);
INSERT INTO `ox_statuses` (`name`, `ontick`) VALUES ('bleed', 0);
```

## License

[![GPLv3 License](https://img.shields.io/badge/License-GPL%20v3-yellow.svg)](https://opensource.org/licenses/)

## Authors

- [@tclrd](https://www.github.com/tclrd)
- [@sumndaiy](https://github.com/sumndaiy)
