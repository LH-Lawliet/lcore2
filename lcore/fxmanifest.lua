fx_version 'cerulean'
games { 'gta5' }

author "Hugo 'LH_Lawliet' Rustenholz"
description 'A ressource that make everything that I need'
version '0.0.2'

lua54 'yes'

loadscreen 'client/loadscreen/build/index.html'
loadscreen_manual_shutdown 'yes'
loadscreen_cursor 'yes'

files {
    'client/loadscreen/build/**.js',
    'client/loadscreen/build/**.css',
    'client/loadscreen/build/**.json',
    'client/loadscreen/build/index.html',
    'client/loadscreen/build/color.css',
}

shared_scripts {
    'shared/config.lua',
    'shared/labels.lua',
    'shared/debug/debug.lua',
}

client_scripts {
    'client/model/model.lua',
    'client/player/player.lua',
    'client/player/creator.lua',
    'client/spawn/spawn.lua',
    'client/loadscreen/client.lua',
    'client/vehicle/vehicle.lua',
    'client/command/debug.lua'
}

server_scripts {
    'server/socket/socket.js',
    'server/config.lua',
    'server/labels.lua',
    'server/database/database.js',
    'server/database/initDB.js',

    'server/players/players.lua',
    'server/database/connector.lua',
    'server/players/connection.lua',
}


