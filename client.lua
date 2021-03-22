local isSongPlaying = false
 
RegisterNetEvent('3dsound:playSound')
AddEventHandler('3dsound:playSound',function(audioSource, audioCoord, audioRotation)
	local ped = PlayerPedId()
	
	-- Send NUI message to start the audio
	SendNUIMessage({transactionType = 'start',audioCoord = audioCoord,
		audioRot=audioRotation, audioSource = audioSource})
	
	isSongPlaying = true  -- Set song playing to true 
	

	Citizen.CreateThread(function()
		while isSongPlaying do
			Wait(100)
			pCoord = GetEntityCoords(ped)
			-- prot = GetGameplayCamRot(0)  -- Uncomment this to use player camera coord
			pRot = GetEntityRotation(ped)
			if #(audioCoord-pCoord) < 30 then
				SendNUIMessage({transactionType = 'update',
					pedCoord = pCoord, pedRot = pRot, mute = false})
			else
				SendNUIMessage({transactionType = 'update',
					pedCoord = pCoord, pedRot = pRot, mute = true})
			end
		end
	end)
end)


RegisterNetEvent('3dsound:stopSound')
AddEventHandler('3dsound:stopSound',function(sid)
	SendNUIMessage({transactionType = 'stop'})
end)


RegisterNUICallback('onStart', function(data)
	isSongPlaying = data.isSongPlaying
end)

RegisterNUICallback('onEnd', function(data)
	isSongPlaying = data.isSongPlaying
end)

RegisterNUICallback('onError', function(data)
	isSongPlaying = data.isSongPlaying
	print("Error occoured while trying to load/play audio")
end)

AddEventHandler('onResourceStop', function(resourceName)
  if (GetCurrentResourceName() ~= resourceName) then
    return
  end
  SendNUIMessage({transactionType = 'stop'})
  isSongPlaying = false
  
end)