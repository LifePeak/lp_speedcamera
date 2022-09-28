local Keys = {
    ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57, 
    ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177, 
    ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
    ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
    ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
    ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70, 
    ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
    ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
    ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}
--Chat
TriggerEvent('chat:addSuggestion', "/"..Config.CreateSpeedCamera, "CameraName, MaxKmH", {
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

Citizen.CreateThread(function()
    while true do 
        PlayerData = ESX.GetPlayerData()
        job = PlayerData.job.name
        if job == Config.Society then
            if IsControlJustPressed(0, Keys[Config.Key]) then
                print("OPENMENU")
                openMenu()
            end
        end
        Citizen.Wait(0)
    end
end)




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
            
            local blipRadius = AddBlipForRadius(v.Position, 10)
            SetBlipColour(blipRadius, Config.Blips.BlipColour)
            local coords = v.Position

            local blip = AddBlipForRadius(coords, Config.Radius)
            SetBlipColour(blip, 1)
            SetBlipAlpha(blip, 128)
        
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
            local shootspeed = speed - v.MaxKmH
            if Config.PolicePay == true then
                if distanceCheck(pedcoord,v.Position) <= Config.Radius then
                    if speed > v.MaxKmH and canReceiveBill() then
                        if isShoot == false then
                            isShoot = true
                            ESX.ShowNotification(_U("SpeedShoot",v.SpeedCameraName,math.floor(shootspeed)))
                            AnimpostfxPlay('PPOrange', 200, false)
                            SendBill(camname, shootspeed)
                            Citizen.SetTimeout(10000, function()
                                isShoot = false
                            end)
                        end
                    end
                    letSleep = false
                end
            elseif Config.PolicePay == false then
                if job ~= Config.Society then
                    if distanceCheck(pedcoord,v.Position) <= Config.Radius then
                        if speed > v.MaxKmH and canReceiveBill() then
                            if isShoot == false then
                                isShoot = true
                                ESX.ShowNotification(_U("SpeedShoot",v.SpeedCameraName,math.floor(shootspeed)))
                                AnimpostfxPlay('PPOrange', 200, false)
                                SendBill(camname, shootspeed)
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
            local shootspeed = speed - v.MaxKmH
            local campos = v.CameraPosition
            local camname = v.SpeedCameraName
            
            if Config.PolicePay == true then
                if distanceCheck(pedcoord,campos) <= Config.Radius then
                    if speed > v.MaxKmH and canReceiveBill() then
                        if isShoot == false then
                            isShoot = true
                            ESX.ShowNotification(_U("SpeedShoot",v.SpeedCameraName,math.floor(shootspeed)))
                            AnimpostfxPlay('PPOrange', 200, false)
                            SendBill(camname, shootspeed)
                            Citizen.SetTimeout(10000, function()
                                isShoot = false
                            end)
                        end
                    end
                    letSleep = false
                end
            elseif Config.PolicePay == false then
                if job ~= Config.Society then
                    if distanceCheck(pedcoord,campos) <= Config.Radius then
                        if speed > v.MaxKmH and canReceiveBill() then
                            if isShoot == false then
                                isShoot = true
                                ESX.ShowNotification(_U("SpeedShoot",v.SpeedCameraName,math.floor(shootspeed)))
                                AnimpostfxPlay('PPOrange', 200, false)
                                SendBill(camname, shootspeed)
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


        local blipRadius = AddBlipForRadius(blipLocation, Config.Radius)
        SetBlipColour(blipRadius, 1)
        SetBlipAlpha(blipRadius, 128)
        SpeedCamera.RadiusBlip = blipRadius

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
                RemoveBlip(v.RadiusBlip)
                table.remove(SpeedCameras, index)
                ESX.ShowNotification(_U("RemoveCam"))
            end
        end
    else
        ESX.ShowNotification(_U("IsntPolice"))
    end
end)

--Billing System 
function SendBill(camname, shootspeed)
    if Config.Billing == "esx_billing" then
        for k,v in pairs(SpeedCameras) do
            local amount = Config.BillingAmount
            if camname == v.SpeedCameraName then
                local Bill = shootspeed * amount
                TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(PlayerId()), 'society_police', _U('BillingName'), Bill, true)
                ESX.ShowNotification(_U("SpeedFine", math.floor(Bill)))
            end
        end
    elseif Config.Billing == "okokBilling" then
        for k,v in pairs(SpeedCameras) do
            local amount = Config.BillingAmount
            if camname == v.SpeedCameraName then
                local Bill = shootspeed * amount
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
                local Bill = shootspeed * amount
               TriggerServerEvent("lp_speedcamera:SendBilling", Bill)
               ESX.ShowNotification(_U("SpeedFine", math.floor(Bill)))
            end
        end
    elseif Config.Billing == "okokBillingV2" then
        for k,v in pairs(SpeedCameras) do
            if camname == v.SpeedCameraName then
                local target = GetPlayerServerId(PlayerId())
                local society = Config.Society
                local price = Config.BillingAmount * shootspeed
                local invoiceSource = v.SpeedCameraName
                TriggerServerEvent("okokBilling:CreateCustomInvoice", target, price, _U("BillingReason"), invoiceSource, society, _U("SocietyName"))
            end
        end
    end
end


--Contex Menu

function openMenu()

    local elements = {
        {
            icon="fas fa-check",
            title=_U("BuildCamera"),
        },
        {
            icon="fas fa-check",
            title=_U("RemoveCamera"),
        },
    }

    ESX.OpenContext("right" , elements, 
    function(menu,element) 

    if element.title == _U("BuildCamera") then
        CreateCameraObject()
      ESX.CloseContext()
    end

    if element.title == _U("RemoveCamera") then
        RemoveCameraObject()
        ESX.CloseContext()
      end
  
    ESX.CloseContext()
  end, function(menu) 
  end)
end


function CreateCameraObject()
    local pedcoord = GetEntityCoords(PlayerPedId())
    local heading = GetEntityHeading(PlayerPedId()) + 180
    local object = CreateObject("prop_tv_cam_02", pedcoord.x+1, pedcoord.y+1, pedcoord.z -1.5, true, true, false)
    SetEntityHeading(object, heading)
end

function RemoveCameraObject()
    local pedcoord = GetEntityCoords(PlayerPedId())
    local objectId = GetClosestObjectOfType(pedcoord, 5.0, GetHashKey("prop_tv_cam_02"), false)
    DeleteObject(objectId)
end