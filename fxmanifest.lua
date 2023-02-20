author "helmimarif"
description "Car Customs for Ayseframework"
version "1.0"

fx_version "cerulean"
game "gta5"
lua54 "yes"

shared_scripts {
    "config.lua",
    "config_locations.lua",
    "@ox_lib/init.lua"
}

client_scripts {
    "@PolyZone/client.lua",
    "@PolyZone/BoxZone.lua",
    "source/client/ui.lua",
    "source/client/main.lua"
}

server_script "source/server/main.lua"

ui_page "source/html/index.html"

files {
    "source/html/index.html",
    "source/html/css/menu.css",
    "source/html/js/ui.js",
    "source/html/sounds/wrench.ogg",
    "source/html/sounds/respray.ogg"
}
