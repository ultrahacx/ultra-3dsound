local songs = {}

Citizen.CreateThread(function()
	while true do
		local ped = PlayerPedId()
		local pCoord = GetEntityCoords(ped)
		local pRot = GetEntityRotation(ped)
		-- prot = GetGameplayCamRot(0)  -- Uncomment this to use player camera coord
		local count = 0
		for k, v in pairs(songs) do
			if songs[k] ~= nil and songs[k].isSongPlaying and songs[k].audioCoord ~= nil then
				if #(songs[k].audioCoord - pCoord) < 30.0 then
					SendNUIMessage({transactionType = 'unmute',
						uid = k})
				else
					SendNUIMessage({transactionType = 'mute',
						uid = k})
				end
				count = count + 1
			end
		end
		if count > 0 then
			SendNUIMessage({transactionType = 'update',
			pedCoord = pCoord, pedRot = pRot})
		end
		Wait(100)
	end
end)
 
RegisterNetEvent('3dsound:playSound')
AddEventHandler('3dsound:playSound',function(audioSource, audioCoord, audioRotation, uid)
	SendNUIMessage({transactionType = 'start',audioCoord = audioCoord,
		audioRot=audioRotation, audioSource = audioSource, uid = uid})
	songs[uid] = {}
	songs[uid].audioCoord = audioCoord
	songs[uid].isSongPlaying = true
end)


RegisterNetEvent('3dsound:stopSound')
AddEventHandler('3dsound:stopSound',function(uid)
	SendNUIMessage({transactionType = 'stop', uid = uid})
end)

RegisterNUICallback('onStart', function(data)
	songs[data.uid].isSongPlaying = data.isSongPlaying
end)

RegisterNUICallback('onEnd', function(data)
	songs[data.uid].isSongPlaying = data.isSongPlaying
end)

RegisterNUICallback('onError', function(data)
	songs[data.uid].isSongPlaying = data.isSongPlaying
	print("Error occoured while trying to load/play audio with ID: "..data.uid)
end)

AddEventHandler('onResourceStop', function(resourceName)
	if (GetCurrentResourceName() ~= resourceName) then
		return
	end
	for k, v in pairs(songs) do
		if songs[k] ~= nil and songs[k].isSongPlaying and songs[k].audioCoord then
			SendNUIMessage({transactionType = 'stop', uid = k})
		end
	end
end)