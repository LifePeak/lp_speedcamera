
--Chat
TriggerEvent('chat:addSuggestion', "/"..Config.CreateSpeedCamera, 'CameraName", MaxKmH', {
    { name="CameraName", help="Test Blitzer" },
    { name="MaxKmH", help="100" }
})
TriggerEvent('chat:addSuggestion', '/'..Config.DeleteSpeedCamera, "CameraName", {
    { name="CameraName", help="Test Blitzer" }
})

if Config.UseOldESX then
    ESX = nil

    Citizen.CreateThread(function()
        while ESX == nil do
            TriggerEvent(Config.SharedObject, function(obj) ESX = obj end)
            Citizen.Wait(0)
        end
    end)
end


local PlayerData
local job

local SpeedCameras = {}

--DistanceCheck
function distanceCheck(vec1, vec2)

    local distance = GetDistanceBetweenCoords(vec1.x, vec1.y, vec1.z, vec2.x, vec2.y, vec2.z, true)

    return distance
end

function canReceiveBill()
    if GetVehiclePedIsIn(PlayerPedId(), false) ~= 0 then
        if GetPedInVehicleSeat(GetVehiclePedIsIn(PlayerPedId()), -1) == PlayerPedId() then
            return true
        end
    else
        return false
    end
end


--Script Start / Locations
Citizen.CreateThread(function()

    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(100)
    end

    local isShoot = false
    if Config.Blips.ShowBlip == true then
        for k,v in pairs(Config.Locations) do
            local blip = AddBlipForCoord(v.Position)
            SetBlipSprite(blip, Config.Blips.BlipSprite)
            SetBlipColour(blip, Config.Blips.BlipColour)
            SetBlipScale(blip, Config.Blips.BlipScale)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentSubstringPlayerName(Config.Blips.BlipName)
            EndTextCommandSetBlipName(blip)
        end
    end

    for k,v in pairs(Config.Locations) do
        local ConfigCameras = {}
        ConfigCameras.SpeedCameraName = v.SpeedCameraName
        ConfigCameras.MaxKmH = v.MaxKmH
        ConfigCameras.CameraPosition = v.Position
        table.insert(SpeedCameras,ConfigCameras)
    end
    
    while true do
        Citizen.Wait(0)
        -- Refreshing Playerjob
        PlayerData = ESX.GetPlayerData()
        job = PlayerData.job.name

        local pedcoord = GetEntityCoords(PlayerPedId())
        -- Calculating Vehicle Speed
        local speed = GetEntitySpeed(PlayerPedId()) * 3.6 -- https://docs.fivem.net/natives/?_0xD5037BA82E12416F -> GetEntitySpeed * 3.6 = kmh
        local letSleep = true
        for k,v in pairs(Config.Locations) do
            local camname = v.SpeedCameraName
            local shootspeed = speed -v.MaxKmH
            if Config.PolicePay == true then
                if distanceCheck(pedcoord,v.Position) <= 10 then
                    if speed > v.MaxKmH and canReceiveBill() then
                        if isShoot == false then
                            isShoot = true
                            ESX.ShowNotification(_U("SpeedShoot",v.SpeedCameraName,math.floor(shootspeed)))
                            AnimpostfxPlay('PPOrange', 200, false)
                            SendBill(camname, speed)
                            Citizen.SetTimeout(10000, function()
                                isShoot = false
                            end)
                        end
                    end
                    letSleep = false
                end
            elseif Config.PolicePay == false then
                if job ~= Config.Society then
                    if distanceCheck(pedcoord,v.Position) <= 10 then
                        if speed > v.MaxKmH and canReceiveBill() then
                            if isShoot == false then
                                isShoot = true
                                ESX.ShowNotification(_U("SpeedShoot",v.SpeedCameraName,math.floor(shootspeed)))
                                AnimpostfxPlay('PPOrange', 200, false)
                                SendBill(camname, speed)
                                Citizen.SetTimeout(10000, function()
                                    isShoot = false
                                end)
                            end
                        end
                        letSleep = false
                    end
                end
            end
        end
        for k,v in pairs(SpeedCameras) do
            local shootspeed = speed -v.MaxKmH
            local campos = v.CameraPosition
            local camname = v.SpeedCameraName
            if Config.PolicePay == true then
                if distanceCheck(pedcoord,campos) <= 10 then
                    if speed > v.MaxKmH and canReceiveBill() then
                        if isShoot == false then
                            isShoot = true
                            ESX.ShowNotification(_U("SpeedShoot",v.SpeedCameraName,math.floor(shootspeed)))
                            AnimpostfxPlay('PPOrange', 200, false)
                            SendBill(camname, speed)
                            Citizen.SetTimeout(10000, function()
                                isShoot = false
                            end)
                        end
                    end
                    letSleep = false
                end
            elseif Config.PolicePay == false then
                if job ~= Config.Society then
                    if distanceCheck(pedcoord,campos) <= 10 then
                        if speed > v.MaxKmH and canReceiveBill() then
                            if isShoot == false then
                                isShoot = true
                                ESX.ShowNotification(_U("SpeedShoot",v.SpeedCameraName,math.floor(shootspeed)))
                                AnimpostfxPlay('PPOrange', 200, false)
                                SendBill(camname, speed)
                                Citizen.SetTimeout(10000, function()
                                    isShoot = false
                                end)
                            end
                        end
                        letSleep = false
                    end
                end
            end
        end

        if letSleep then
            Wait(500)
        end
    end
    
end)


--Commands
RegisterCommand(Config.CreateSpeedCamera, function(source, args, rawCommand)
    if job == Config.Society then
        local SpeedCamera = {}
        SpeedCamera.SpeedCameraName = args[1]
        SpeedCamera.MaxKmH = tonumber(args[2])
        SpeedCamera.CameraPosition = GetEntityCoords(PlayerPedId())

        local blipLocation = GetEntityCoords(PlayerPedId())
        local blip = AddBlipForCoord(blipLocation)
        SetBlipSprite(blip, Config.Blips.BlipSprite)
        SetBlipColour(blip, Config.Blips.BlipColour)
        SetBlipScale(blip, Config.Blips.BlipScale)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentSubstringPlayerName(Config.Blips.BlipName)
        EndTextCommandSetBlipName(blip)
        SpeedCamera.Blip = blip
        table.insert(SpeedCameras, SpeedCamera)
        ESX.ShowNotification(_U("CreateCam"))
    else
        ESX.ShowNotification(_U("IsntPolice"))
    end
end, false)

RegisterCommand(Config.DeleteSpeedCamera, function(source, args, rawCommand)
    local camname = args[1]
    if job == Config.Society then
        for index,v in ipairs(SpeedCameras) do
            if camname == v.SpeedCameraName then
                RemoveBlip(v.Blip)
                table.remove(SpeedCameras, index)
                ESX.ShowNotification(_U("RemoveCam"))
            end
        end
    else
        ESX.ShowNotification(_U("IsntPolice"))
    end
end)

--Billing System 
function SendBill(camname, speed)
    if Config.Billing == "esx_billing" then
        for k,v in pairs(SpeedCameras) do
            local amount = Config.BillingAmount
            if camname == v.SpeedCameraName then
                local Bill = speed * amount
                TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(PlayerId()), 'society_police', _U('BillingName'), Bill, true)
                ESX.ShowNotification(_U("SpeedFine", math.floor(Bill)))
            end
        end
    elseif Config.Billing == "okokBilling" then
        for k,v in pairs(SpeedCameras) do
            local amount = Config.BillingAmount
            if camname == v.SpeedCameraName then
                local Bill = speed * amount
                local data = {}
                data.target = GetPlayerServerId(PlayerId())
                data.society = Config.Society
                data.society_name = _U("SocietyName")
                data.invoice_item = _U("BillingReason")
                data.invoice_value = Bill
                data.invoice_notes = _U("BillingNote")
                TriggerServerEvent("okokBilling:CreateInvoice", data)
                ESX.ShowNotification(_U("SpeedFine", math.floor(Bill)))
            end
        end
    elseif Config.Billing == "none" then
        for k,v in pairs(SpeedCameras) do
            local amount = Config.BillingAmount
            if camname == v.SpeedCameraName then
                local Bill = speed * amount
               TriggerServerEvent("lp_speedcamera:SendBilling", Bill)
               ESX.ShowNotification(_U("SpeedFine", math.floor(Bill)))
            end
        end
    end
end


