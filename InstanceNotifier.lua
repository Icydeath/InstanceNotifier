_addon.name = 'InstanceNotifier'
_addon.author = 'Icy'
_addon.commands = {'InstanceNotifier'}
_addon.version = '0.0.3'
-- bug fix with valid zones
-- added Mhaura's Ambuscade messages.

require('tables')
require('strings')
require('logger')
local enabled = false

valid_zones = T{
	[248] = 'Selbina',
	[249] = 'Mhaura', 
}

msgs = T{
	'Your registration number for entering this nightmare is', --148
	'Nightmare number',
	'Entering ',
	' while the battle is being prepared',
}

windower.register_event('addon command', function(...)
    local command = {...}
	
end)

windower.register_event("incoming text", function(original,modified,original_mode,modified_mode, blocked)
	if enabled then
		if original_mode == 151 or original_mode == 161 or original_mode == 190 or original_mode == 148 then
			--windower.add_to_chat(8, '  ID = '..original_mode)
			for i,msg in pairs(msgs) do
				if windower.wc_match(original, "*"..msg.."*") then
					windower.send_command('input /p '.. original)
					break
				end
			end
		end
    end
end)

windower.register_event('zone change','login','load', function()
	local zone = windower.ffxi.get_info().zone
	if valid_zones[zone] then
		local player = windower.ffxi.get_player()
		local party = windower.ffxi.get_party()
		if player.id == party.party1_leader then
			enabled = true
			log('enabled =', tostring(enabled))
		else
			enabled = false
			log('You are not the party leader. enabled =', tostring(enabled))
		end
	else
		enabled = false
		log('Not in a valid zone. enabled =', tostring(enabled))
	end
end)
