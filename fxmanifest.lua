fx_version 'adamant'
game {'gta5'}

author 'ultrahacx'

client_script "client.lua"

server_script "server.lua"

ui_page "html/index.html"

files {
    'html/sound.js',
    'html/index.html',
	'html/*.mp3'
}

server_export 'playSound'
server_export 'stopSound'


