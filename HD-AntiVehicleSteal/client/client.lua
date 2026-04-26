local protectedSet = {}
for _, model in ipairs(Config.ProtectedVehicles) do
    protectedSet[model:lower()] = true
end

local lastEventTime = 0

CreateThread(function()
    local wasInVehicle = false
    local lastVehicle  = nil

    while true do
        Wait(500)

        local ped     = PlayerPedId()
        local vehicle = GetVehiclePedIsIn(ped, false)

        if vehicle ~= 0 then
            if not wasInVehicle or vehicle ~= lastVehicle then
                wasInVehicle = true
                lastVehicle  = vehicle

                local modelHash = GetEntityModel(vehicle)
                local modelName = string.lower(GetDisplayNameFromVehicleModel(modelHash))

                if modelName == "carnotfound" then
                    for _, name in ipairs(Config.ProtectedVehicles) do
                        if GetHashKey(name) == modelHash then
                            modelName = name:lower()
                            break
                        end
                    end
                end

                if protectedSet[modelName] then
                    local now = GetGameTimer()
                    if (now - lastEventTime) > (Config.EventCooldown * 1000) then
                        lastEventTime = now
                        TriggerServerEvent("vp:playerEnteredProtectedVehicle", modelName)
                    end
                end
            end
        else
            wasInVehicle = false
            lastVehicle  = nil
        end
    end
end)