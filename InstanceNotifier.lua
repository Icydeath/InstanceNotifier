_addon.name = 'InstanceNotifier'
_addon.author = 'Icy'
_addon.commands = {'InstanceNotifier'}
_addon.version = '0.0.1'

require('tables')
require('strings')
require('logger')
local enabled = false

msgs = T{
	'Your registration number for entering this nightmare is', --148
	'Nightmare number',
	'Entering '
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
					--if msg:contains('Entering') then
						--windower.send_command('input /p '.. original .. ' <call14>')
					--else
						windower.send_command('input /p '.. original)
					--end
					break
				end
			end
		end
    end
end)

windower.register_event('zone change','login','load', function()
    if windower.ffxi.get_info().zone == 248 then
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
		log('Not in Selbina. enabled =', tostring(enabled))
	end
end)