local function uuid()
	local random = math.random
    local template ='xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'
    return string.gsub(template, '[xy]', function (c)
        local v = (c == 'x') and random(0, 0xf) or random(8, 0xb)
        return string.format('%x', v)
    end)
end

function playSound(toBePlayedOn, audioSource, audioCoord, audioRotation)
	local uid = uuid()
	TriggerClientEvent('3dsound:playSound', toBePlayedOn, audioSource, audioCoord, audioRotation, uid)	
	return uid
end

function stopSound(toBeStoppedOn, uniqueID)
	if uniqueID == nil then return end
	TriggerClientEvent('3dsound:stopSound', toBeStoppedOn, uniqueId)	
end
