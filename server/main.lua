-- Billing

RegisterNetEvent("lp_speedcamera:SendBilling")
AddEventHandler("lp_speedcamera:SendBilling", function(Bill)
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.removeAccountMoney("bank", Bill)
end)


