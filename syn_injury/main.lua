local hurt = false
local effect = false
local veryhurt = false 
local nothurt = false  
local faded = false   
local weak = false  
--[[ local wobble = false  ]]


local table = {
"weapon_appistol",
"weapon_microsmg",
"weapon_smg",
"weapon_smg_mk2",
"weapon_assaultsmg",
"weapon_combatpdw",
"weapon_machinepistol",
"weapon_minismg",
"weapon_raycarbine",
"weapon_pumpshotgun",
"weapon_pumpshotgun_mk2",
"weapon_sawnoffshotgun",
"weapon_assaultshotgun",
"weapon_bullpupshotgun",
"weapon_musket",
"weapon_heavyshotgun",
"weapon_dbshotgun",
"weapon_autoshotgun",
"weapon_assaultrifle",
"weapon_assaultrifle_mk2",
"weapon_carbinerifle",
"weapon_carbinerifle_mk2",
"weapon_advancedrifle",
"weapon_specialcarbine",
"weapon_specialcarbine_mk2",
"weapon_bullpuprifle",
"weapon_bullpuprifle_mk2",
"weapon_compactrifle",
"weapon_mg",
"weapon_combatmg",
"weapon_combatmg_mk2",
"weapon_gusenberg",
"weapon_sniperrifle",
"weapon_heavysniper",
"weapon_heavysniper_mk2",
"weapon_marksmanrifle",
"weapon_marksmanrifle_mk2",
"weapon_rpg",
"weapon_grenadelauncher",
"weapon_minigun",
"weapon_firework",
"weapon_hominglauncher",
"weapon_compactlauncher",
"weapon_rayminigun"
}

RegisterCommand("lean",function()
	local ped = GetPlayerPed(-1)
	SetEntityHealth(ped,110)

end)

RegisterCommand("veryhurt",function()
	local ped = GetPlayerPed(-1)
	SetEntityHealth(ped,130)

end)

RegisterCommand("faded",function()
	local ped = GetPlayerPed(-1)
	SetEntityHealth(ped,140)

end)

RegisterCommand("wobble",function()
	local ped = GetPlayerPed(-1)
	SetEntityHealth(ped,135)

end)

RegisterCommand("hurt",function()
	local ped = GetPlayerPed(-1)
	SetEntityHealth(ped,160)

end)


Citizen.CreateThread(function()
	while true do
		local ped = GetPlayerPed(-1)
		
		Wait(0)
		SetPedMaxHealth(ped,200)
		
		if Config.UseWeak then
			if GetEntityHealth(ped) >=120 then 
				setNotWeak()
			elseif GetEntityHealth(ped) <=115 then
				setWeak()
			end
		end 

		if Config.UseFaded then
			if GetEntityHealth(ped) <= 140 then
				setFaded()  
			elseif GetEntityHealth(ped) > 145 then
				setNotFaded()  
			end						
		end

		if Config.UseWeak then
			if GetEntityHealth(ped) <= 115 then
				setLimitGuns()  
			elseif GetEntityHealth(ped) > 120 then
				setNotLimitGuns()  
			end						
		end

		if --[[ hurt or veryhurt and ]] GetEntityHealth(ped) >= 175 then
			setNotHurt() 
		elseif GetEntityHealth(ped) <=135 then
			setVeryHurt()
		else
			if --[[ not veryhurt and ]] GetEntityHealth(ped) <=174 then
			setHurt()
			end   
		end
	end
end)

--functions 

function setLimitGuns()
	local ped = GetPlayerPed(-1)
	
	--print("limitedguns")
	for k,v in pairs(table) do 
		SetCanPedSelectWeapon(ped, v, false)
	end 
end 
function setNotLimitGuns()
	local ped = GetPlayerPed(-1)
	
	--print("notlimitedguns")
	for k,v in pairs(table) do 
		SetCanPedSelectWeapon(ped, v, true)
	end 
end 


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
	AnimpostfxStopAll() 
end 


function setNotWeak()
	notweak = true 
	weak = false  
	local ped = GetPlayerPed(-1)
	--print("notweak")
	SetPedConfigFlag(ped, 187, false) 
end 


function setWeak()
	weak = true  
	local ped = GetPlayerPed(-1)
	--print("weak")
	SetPedConfigFlag(ped, 187, true)
	
		if weak and IsPedArmed(ped, 4)  then -- config flag 187 has no reload animations for pistols so this does manually
			local weapon = GetSelectedPedWeapon(ped)
			local chk,ammoClip = GetAmmoInClip(ped,weapon)
			local ped = GetPlayerPed(-1)
			local curcar = GetVehiclePedIsIn(ped, false)
			SetFollowPedCamViewMode(1)
		

			if ammoClip < 1 then

				SetPedConfigFlag(ped, 187, false)

			elseif  ammoClip >= 1 then 

				if IsControlJustReleased(0, 45) then  
					SetPedConfigFlag(ped, 187, false) 
					MakePedReload(ped)
				else
			    SetPedConfigFlag(ped, 187, true) 
				end
			end

			if IsPedInAnyVehicle(ped,true) then 
				
				if IsControlJustReleased(0, 23) then  
					TaskLeaveVehicle(ped,curcar,4160)
				end 
			end 
		
		end   
end 
 

function setVeryHurt()
	local ped = GetPlayerPed(-1)

	veryhurt = true 
	hurt = false
	nothurt = false
	
	--print("VeryHurt")  
	ResetPedMovementClipset(ped)
	--[[ ResetPedWeaponMovementClipset(ped) ]]
	ResetPedStrafeClipset(ped)
	RequestAnimSet("MOVE_M@DRUNK@VERYDRUNK")
	SetPedMovementClipset(GetPlayerPed(-1), "MOVE_M@DRUNK@VERYDRUNK", true)
end
 
function setHurt()

	hurt = true
	veryhurt = false
	nothurt = false 
	local ped = GetPlayerPed(-1)

	--print("Hurt")
	ResetPedMovementClipset(ped)
	--[[ ResetPedWeaponMovementClipset(ped) ]]
	ResetPedStrafeClipset(ped)

	AnimpostfxStopAll()
	SetPedMovementClipset(GetPlayerPed(-1), "MOVE_M@DRUNK@VERYDRUNK", false)
	RequestAnimSet("move_m@injured")
	SetPedMovementClipset(GetPlayerPed(-1), "move_m@injured", true)
end
  
function setNotHurt()
	nothurt = true
	hurt = false
	veryhurt = false
	local ped = GetPlayerPed(-1)

	--print("NotHurt")
	ResetPedMovementClipset(ped) 
	--[[ ResetPedWeaponMovementClipset(ped) ]]
	ResetPedStrafeClipset(ped)  
	StopGameplayCamShaking(true)

end

