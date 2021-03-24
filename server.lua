function playSound(toBePlayedOn, audioSource, audioCoord, audioRotation)
	TriggerClientEvent('3dsound:playSound', toBePlayedOn, audioSource, audioCoord, audioRotation)	
end


function stopSound(toBeStoppedOn, uniqueID)
	TriggerClientEvent('3dsound:stopSound', toBeStoppedOn)	
end
