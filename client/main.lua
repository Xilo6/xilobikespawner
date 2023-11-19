local isUserInZone = false

local function bikemenu()
    local bikes = {}
    for key, value in pairs(Config.cars) do
        table.insert(bikes, {
            label = value.label,
            icon = value.icon,
            args = {
                label = value.label,
                model = value.model
            }
        })
    end
    lib.registerMenu({
        id = "xilo_main_bike_menu",
        title = Config.menu.title,
        position = Config.menu.position,
        options = bikes
    }, function(selected, scrollIndex, args)
        for key, value in pairs(Config.spawnerloc) do
            if ESX.Game.IsSpawnPointClear(value.spawnloc, 3) then
                if Config.misc.payforbike then
                    local spawncallback = lib.callback.await("xilobike:pay", false, Config.misc.price)
                    if spawncallback then
                        Config.alert("Sucessfully purchased "..args.label, "success")
                        ESX.Game.SpawnVehicle(args.model, value.spawnloc, 180)
                    else
                        Config.alert("You cannot afford this vehicle", "error")
                    end
                else
                    Config.alert("Spawned "..args.label, "success")
                    ESX.Game.SpawnVehicle(args.model, value.spawnloc, 180)
                end
            else
                Config.alert("Spawn Point Is Blocked", "error")
            end
        end
    end)
    lib.showMenu("xilo_main_bike_menu")
end

for key, value in pairs(Config.spawnerloc) do
    local point = lib.points.new({
        coords = value.location, 
        distance = 2,
    })

    function point:onEnter()
        lib.showTextUI("[E] - Bike Spawner")
        isUserInZone = true
    end

    function point:onExit()
        lib.hideTextUI()
        isUserInZone = false
    end
    function point:nearby()
        DrawMarker(23, value.location, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 1.0, 1.0, 1.0, 200, 20, 20, 100, false, true, 2, false, nil, nil, false)
        if IsControlJustPressed(0, 38) then
            bikemenu()
            isUserInZone = true
        end
    end
end

if Config.misc.enableblips then
    CreateThread(function()
        for key, blip in pairs(Config.spawnerloc) do
            ShopBlip = AddBlipForCoord(blip.location)
            SetBlipSprite(ShopBlip, blip.sprite)
            SetBlipDisplay(ShopBlip, 4)
            SetBlipScale(ShopBlip, blip.scale)
            SetBlipColour(ShopBlip, blip.color)
            SetBlipAsShortRange(ShopBlip, true)
            BeginTextCommandSetBlipName("STRING")
            EndTextCommandSetBlipName(ShopBlip)
        end
    end)
end