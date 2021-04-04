local faded = false 




Citizen.CreateThread(function() -- this functin tics every frame, waits will cause audio to bug
	while true do
		local ped = GetPlayerPed(-1)
		
		Wait(0)
		SetPlayerHealthRechargeLimit(ped, 0) -- stops players health from auto refilling 

		if Config.UseFaded then
			if GetEntityHealth(ped) <= 140 then
				setFaded()  
			elseif GetEntityHealth(ped) > 145 then
				setNotFaded()  
			end						
		end

	end
end)




function setFaded()
	faded = true 
	local ped = GetPlayerPed(-1)
	
	--print("faded")
	AnimpostfxPlay("RaceTurbo",0, true )   
	--[[ AnimpostfxPlay("MP_Celeb_Win",0, true )   ]]
	--[[ AnimpostfxPlay("ChopVision",0, true )  ]]
	--[[ AnimpostfxPlay("DeathFailOut",0, true ) ]]
	RegisterNoirScreenEffectThisFrame() 
	SetAudioSpecialEffectMode(2)  
end 
function setNotFaded()
	local ped = GetPlayerPed(-1)
	--print("notfaded")
	AnimpostfxStop("RaceTurbo")
end 