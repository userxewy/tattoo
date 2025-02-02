RegisterTattoo = {}

function LoadTattoo()
	ESX.TriggerServerCallback('tattoo:requestTattoo', function(TattooList)
		if TattooList then
			for _, v in pairs(TattooList) do
				SetPedDecoration(PlayerPedId(), v.lib, v.texture)
				table.insert(RegisterTattoo, {
					lib = v.lib, 
					texture = v.texture
				})
			end
		end
	end)
end

AddEventHandler('skinchanger:modelLoaded', function()
	LoadTattoo()
end)

function TattooCam()
    Cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)
    SetCamRot(Cam, 0.0, 0.0, 270.0, true)
    local pCoords = GetEntityCoords(PlayerPedId())
	local pHeading = GetEntityHeading(PlayerPedId())
    local CalcCoords = pHeading * math.pi / 180.0
    SetCamCoord(Cam, pCoords.x - 1.5 * math.sin(CalcCoords), pCoords.y + 1.5 * math.cos(CalcCoords), pCoords.z + .5)
    SetCamRot(Cam, .0, .0, 120.0, 2)
    PointCamAtEntity(Cam, PlayerPedId(), .0, .0, .0, true)
    SetCamActive(Cam, true)
    RenderScriptCams(1, 0, 500, 1, 0)
end

function turnPlayer()
    local Control1, Control2 = IsDisabledControlPressed(1, 108), IsDisabledControlPressed(1, 109)
    if Control1 or Control2 then
        SetEntityHeading(PlayerPedId(), Control1 and GetEntityHeading(PlayerPedId()) - 2.0 or Control2 and GetEntityHeading(PlayerPedId()) + 2.0)
	end
end

function SetOutfit(Type)
	if Type == 1 then
		TriggerEvent('skinchanger:getSkin', function(skin)
			ESX.Streaming.RequestAnimDict("clothingtie", function()
				TaskPlayAnim(PlayerPedId(), "clothingtie", "try_tie_negative_a", 2.0, 2.0, -1, 51, 0, false, false, false)
			end)
			Wait(1000)
			ClearPedTasks(PlayerPedId())
			if skin.sex == 0 then
				TriggerEvent('skinchanger:loadClothes', skin, TattooSettings.OutfitTatoo.male)
			elseif skin.sex == 1 then
				TriggerEvent('skinchanger:loadClothes', skin, TattooSettings.OutfitTatoo.female)
			end
		end)
	elseif Type == 2 then
		ESX.Streaming.RequestAnimDict("clothingtie", function()
			TaskPlayAnim(PlayerPedId(), "clothingtie", "try_tie_negative_a", 2.0, 2.0, -1, 51, 0, false, false, false)
		end)
		Wait(1000)
		ClearPedTasks(PlayerPedId())
		ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
			TriggerEvent('skinchanger:loadSkin', skin)
		end)
	end
end