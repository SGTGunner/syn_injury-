







Citizen.CreateThread(function()
	while true do
		local ped = GetPlayerPed(-1)
		
		Wait(0)

        if Config.UseWobble then
			if GetEntityHealth(ped) <= 135 then
				setWobble()  
			elseif GetEntityHealth(ped) > 140 then
				setNotWobble()  
			end						
        end
        
        if Config.UseBleed then
			if GetEntityHealth(ped) <= 130 then
				setBleedingOn(ped)
			elseif GetEntityHealth(ped) > 135 then
				setBleedingOff(ped)
			end						
		end


    end
end)




function setWobble()
    local ped = GetPlayerPed(-1)  
    --print("wobble")
    ShakeGameplayCam('DRUNK_SHAKE', 3.11 ) 
    Wait(15000) 
   
end 
function setNotWobble()
    local ped = GetPlayerPed(-1)
    --print("notWobble")
    StopGameplayCamShaking(true)  
end 




    
function setBleedingOn(ped)
    local ped = GetPlayerPed(-1) 
	SetEntityHealth(ped,GetEntityHealth(ped) - 1 )
    ShakeGameplayCam("SMALL_EXPLOSION_SHAKE", 0.1)
    TriggerScreenblurFadeIn(250)
    Wait(600) 
    TriggerScreenblurFadeOut(300)
	--[[ exports['mythic_notify']:DoHudText('error', 'You are bleeding seek help') ]]
	SetPlayerHealthRechargeMultiplier(PlayerId(), 0.0)
	--[[ Wait(8000) ]]
end
 
function setBleedingOff(ped)
	SetPlayerHealthRechargeMultiplier(PlayerId(), 0.0)
end