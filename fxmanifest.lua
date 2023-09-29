fx_version 'cerulean'
game 'gta5'

use_experimental_fxv2_oal 'yes'
lua54 'yes'

description 'medical system for ox_core'
version '0.0.1'

dependencies {
    "/onesync",
    "ox_core",
    "ox_lib",
    "ox_inventory",
    "scully_emotemenu",
}

shared_scripts {
    '@ox_lib/init.lua',
    'shared/data.lua',
    'shared/weapons.lua',
}

client_scripts {
    '@ox_core/imports/client.lua',
    'client/main.lua',
    'client/hospital.lua',
    'client/death.lua',
    'client/wounding.lua',
    'client/statuses/*.lua',
    'client/target/target.lua',
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    '@ox_core/imports/server.lua',
    'server/main.lua',
    'server/death.lua',
    'server/hospital.lua',
    'server/target/target.lua'
}

server_exports {
    'heal',
    'revive'
}
