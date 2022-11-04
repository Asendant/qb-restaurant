fx_version 'cerulean'
game 'gta5'

description 'QB Restaurant Civilian Job'
version '1.0.0'

client_scripts {
    'cl_restaurant.lua'
}

server_scripts {
    'sv_restaurant.lua'
}

shared_scripts {
    'config.lua'
}

ui_page 'html/index.html'

files {
    'html/app.js',
    'html/styles.css',
    'html/index.html',
}

lua54 'yes'