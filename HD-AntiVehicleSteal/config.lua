Config = {}

-- Discord Webhook
-- Paste your webhook URL here leave blank to disable
Config.WebhookURL  = "https://discord.com/api/webhooks/YOURSERVERSWEBHOOK"
Config.ServerName  = "High DEVELOPMENT"

-- Kick Message
Config.KickReason  = "You tried to steal a protected vehicle and you got kicked from the server!"

-- Protected Vehicles
Config.ProtectedVehicles = {
    "police",
    "police2",
    "police3",
    "police4",
    "policeb",
    "policeold1",
    "policeold2",
    "policet",
    "sheriff",
    "sheriff2",
    "sheriffb",
    "fbi",
    "fbi2",
    "pranger",
    "predator",
    "ambulance",
    "lguard",
    "firetruk",
    "ladder",
    "ladderscfd",
    "riot",
    "riot2",
    "barracks",
    "barracks2",
    "barracks3",
    "crusader",
    "insurgent",
    "insurgent2",
    "rhino",
    "cargobob",

-- you can add custom vehicles that you want to protect
    -- "myaddoncar",
    -- "anothercar",
}

-- allowed jobs and groups
Config.AllowedJobs = {
    "police",
    "sheriff",
    "fbi",
    "swat",
    "ems",
    "ambulance",
    "fire",
    "firefighter",
    "lsfd",
    "army",
    "admin",
}

-- Cooldown between the player
Config.EventCooldown = 5

Config.WebhookColor   = 32768  -- green
-- Red  16711680
-- Green 32768
-- Blue 255
-- Yellow 16776960
-- Orange 16753920

Config.WebhookMessage = "{player} (ID: {id}) was kicked for entering a protected vehicle (`{vehicle}`)." -- The message sent to the webhook
