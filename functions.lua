local walk = false 







Citizen.CreateThread(function()
	while true do
		local ped = GetPlayerPed(-1)
		
		Wait(0)


        	if Config.UseWobble then
				if not (GetEntityHealth(ped) <= 1) then
					if GetEntityHealth(ped) <= 135 then
						setWobble()  
					elseif GetEntityHealth(ped) > 140 then
						setNotWobble()  
					end	
				end 					
        	end
        
        	if Config.UseBleed then
				if not (GetEntityHealth(ped) <= 1) then
					if GetEntityHealth(ped) <= 135 then
					setBleedingOn(ped)
					elseif GetEntityHealth(ped) > 140 then
					setBleedingOff(ped)
					end	
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
	--[[ print("bleed") ]]
	--[[ exports['mythic_notify']:DoHudText('error', 'You are bleeding seek help') ]]
	SetPlayerHealthRechargeMultiplier(PlayerId(), 0.0) 
	if not Config.UseWobble then 
		Wait(15000) -- if you disable wobble un bracket this wait for bleed to work properly
	end  
end
 
function setBleedingOff(ped)
	SetPlayerHealthRechargeMultiplier(PlayerId(), 0.0)
end