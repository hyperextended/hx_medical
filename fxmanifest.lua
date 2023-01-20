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
    -- "ox_inventory",
}

shared_scripts {
    '@ox_lib/init.lua',
    'locales/en.lua',
    'locales/*.lua',
}

client_scripts {
    '@ox_core/imports/client.lua',
    'client/main.lua',
    'client/death.lua',
    'client/wounding.lua',
    'client/statuses/unconscious.lua',
    'client/statuses/limping.lua',
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    '@ox_core/imports/server.lua',
    'server/main.lua',
}
