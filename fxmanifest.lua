fx_version 'cerulean'
game 'gta5'

name "lp_speedcamera"
description "A simple Speedcamera Script"
author "LifePeak"
version "1.0.0"

shared_script {
	'@es_extended/imports.lua',
	'@es_extended/locale.lua',
    'locales/*.lua',
	'config.lua'
}

client_scripts {
	'client/*.lua',
}

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'server/*.lua'
}
