ESX.RegisterServerCallback('tattoo:requestTattoo', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	MySQL.Async.fetchAll('SELECT tattoos FROM users WHERE identifier = @identifier', {
		['@identifier'] = xPlayer.identifier
	}, function(result)
		if result[1].tattoos then
			cb(json.decode(result[1].tattoos))
		end
	end)
end)

RegisterServerEvent('tattoo:registerTattoo')
AddEventHandler('tattoo:registerTattoo', function(Tattoo)
    local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getAccount("money").money >= TattooSettings.TattooPrice then
        MySQL.Async.execute('UPDATE users SET tattoos = @tattoos WHERE identifier = @identifier', {
            ['@identifier'] = xPlayer.identifier,
            ['@tattoos'] = json.encode(Tattoo)
        })
        TriggerClientEvent("esx:showNotification", source, "Vous avez payé ~g~"..TattooSettings.TattooPrice.."$")
        xPlayer.removeMoney(TattooSettings.TattooPrice)
        TattooDiscordLog("Achat de tatouage", "**Joueur:** " .. xPlayer.getName() .. "\n**ID:** " .. source .. "\n**Montant payé:** " .. TattooSettings.TattooPrice .. "$" .. "\n**Tatouage acheté:** " .. json.encode(Tattoo), 16034613)
    else
        TriggerClientEvent("esx:showNotification", source, "~o~Vous n'avez pas assez d'argent...")
    end
end)

RegisterServerEvent('tattoo:deleteTattoo')
AddEventHandler('tattoo:deleteTattoo', function(Type)
    local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getAccount("money").money >= TattooSettings.DeleteTattooPrice then
        MySQL.Async.execute('UPDATE users SET tattoos = @tattoos WHERE identifier = @identifier', {
            ['@identifier'] = xPlayer.identifier,
            ['@tattoos'] = nil
        })
        TriggerClientEvent("esx:showNotification", source, "Vous avez payé ~g~"..TattooSettings.DeleteTattooPrice.."$")
        xPlayer.removeMoney(TattooSettings.DeleteTattooPrice)
        TattooDiscordLog("Suppression de tatouage", "**Joueur:** " .. xPlayer.getName() .. "\n**ID:** " .. source .. "\n**Montant payé:** " .. TattooSettings.DeleteTattooPrice .. "$" .. "\n**Tatouage supprimé:** " .. Type, 16034613)
    else
        TriggerClientEvent("esx:showNotification", source, "~o~Vous n'avez pas assez d'argent...")
    end
end)