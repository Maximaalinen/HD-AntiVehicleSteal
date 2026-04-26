---@param source number
---@return string
local function GetIdentifiers(source)
    local ids = {}
    for i = 0, GetNumPlayerIdentifiers(source) - 1 do
        ids[#ids + 1] = GetPlayerIdentifier(source, i)
    end
    return (#ids > 0) and table.concat(ids, "\n") or "None found"
end

---@param playerName  string
---@param playerId    number
---@param identifiers string
---@param vehicle     string
local function SendDiscordWebhook(playerName, playerId, identifiers, vehicle)
    if not Config.WebhookURL or Config.WebhookURL == ""
       or Config.WebhookURL:find("YOUR_WEBHOOK") then
        return
    end

    local timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ")

    local message = Config.WebhookMessage
        :gsub("{player}",  playerName)
        :gsub("{id}",      tostring(playerId))
        :gsub("{vehicle}", vehicle)

    local payload = {
        username = Config.ServerName,
        embeds = {
            {
                description = message,
                color       = Config.WebhookColor,
                timestamp   = timestamp,
            }
        }
    }

    PerformHttpRequest(
        Config.WebhookURL,
        function() end,
        "POST",
        json.encode(payload),
        { ["Content-Type"] = "application/json" }
    )
end

---@param source number
---@return boolean
local function IsPlayerAllowed(source)
    -- ── Ace permission (no framework needed) ─────────────────────────────────
    -- Uncomment to use FiveM's built-in ace system:
    -- return IsPlayerAceAllowed(source, "vehicle_protection.bypass")

    -- ── ESX ──────────────────────────────────────────────────────────────────
    --[[
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer then
        for _, job in ipairs(Config.AllowedJobs) do
            if xPlayer.job.name == job then return true end
        end
    end
    ]]

    -- ── QBCore ───────────────────────────────────────────────────────────────
    --[[
    local QBCore = exports['qb-core']:GetCoreObject()
    local Player = QBCore.Functions.GetPlayer(source)
    if Player then
        for _, job in ipairs(Config.AllowedJobs) do
            if Player.PlayerData.job.name == job then return true end
        end
    end
    ]]

    return false
end

RegisterNetEvent("vp:playerEnteredProtectedVehicle")
AddEventHandler("vp:playerEnteredProtectedVehicle", function(vehicleModel)
    local source      = source
    local playerName  = GetPlayerName(source) or "Unknown"
    local identifiers = GetIdentifiers(source)

    if IsPlayerAllowed(source) then return end

    print(("[VP] Kicking %s (ID %d) — entered protected vehicle '%s'"):format(
        playerName, source, vehicleModel))

    SendDiscordWebhook(playerName, source, identifiers, vehicleModel)

    SetTimeout(1200, function()
        DropPlayer(source, Config.KickReason)
    end)
end)