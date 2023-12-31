Config = {}

Config.UseOldESX = false -- Set this to true if you use and older version of ESX
Config.SharedObject = 'esx:getSharedObject'

Config.Locale = "en"
Config.Billing = "none"                     -- Change your Billing System -> "esx_billing" / "okokBilling" / "okokBillingV2" / "none"
Config.BillingAmount = 5                    -- Amount per Km/H
Config.Society = "police"                   -- Billing Society / Create Speedcamera - Policejob
Config.PolicePay = true                     -- Can police officers be fined true/false
Config.CreateSpeedCamera = "spccreate"      -- Command to create a SpeedCamera
Config.DeleteSpeedCamera = "spcdelete"      -- Command to delete a SpeedCamera
Config.Radius = 10.0                        -- Set the range of the SpeedCamera
Config.Key = "X"                            -- Key for the Menu


-- Blips
Config.Blips = {
    ShowBlip = true,                        -- Speedcamera Blips on Map
    BlipName = "Speedcamera",               -- Name for Blip
    BlipScale = 0.5,
    BlipColour = 2,
    BlipSprite = 184
}


-- Speedcameras
Config.Locations = {
    [1] = {
        SpeedCameraName = "Highway Point",
        MaxKmH  = 130,
        Position = vector3(1437.810546875,752.94683837891,77.623649597168)
    },
    [2] = {
        SpeedCameraName = "Highway 23 South",
        MaxKmH  = 130,
        Position = vector3(-2485.4990234375,-218.81741333008,17.860759735107)
    }
}

-- Blacklist

Config.BlacklistVehicle = {
    "police",
    "police2",
    "ambulance"
}

Config.BlacklistJob = {
    "police",
    "ambulance"
}
