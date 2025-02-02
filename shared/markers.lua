CreateThread(function()
    for _,v in pairs(TattooSettings.Positions) do
		TattooBlips = AddBlipForCoord(v.pos)
		SetBlipSprite(TattooBlips, 75)
		SetBlipScale(TattooBlips, 0.8)
		SetBlipDisplay(TattooBlips, 4)
		SetBlipColour(TattooBlips, 1)
		SetBlipAsShortRange(TattooBlips, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Salon de tatouage")
		EndTextCommandSetBlipName(TattooBlips)
	end
    while true do
        local pCoords = GetEntityCoords(PlayerPedId())
        local OnMarker = false
        for _,v in pairs(TattooSettings.Positions) do
            if #(pCoords - v.pos) < 15.0 then
                OnMarker = true
                DrawMarker(1, v.pos, 0, 0, 0, 0, 0, 0, 0.75, 0.75, 0.25, 244, 171, 53, 1.0, 0, 0, 0, 0)                              
            end
            if #(pCoords - v.pos) < 1.2 then
                if not IsOpen then 
                    ESX.ShowHelpNotification("Appuyer sur ~INPUT_PICKUP~ pour accéder au salon de tatouage")
                    if IsControlJustPressed(1, 51) then
                        OpenTattooShopMenu()
                        TattooCam()
                    end 
                end
            end
        end
        if OnMarker then
            Wait(1)
        else
            Wait(500)
        end
    end
end)