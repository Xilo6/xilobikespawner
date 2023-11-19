Config = {
    spawnerloc = {
        {
            location = vec3(-20.2954, -1823.0880, 24.9024),
            spawnloc = vec3(-25.0623, -1828.9750, 25.7191),
            marker = 22, -- Only change these if you have blips enabled
            scale = 0.8, -- Only change these if you have blips enabled
            sprite = 226, -- Only change these if you have blips enabled
            color = 84, -- Only change these if you have blips enabled
        },
    },
    misc = {
        payforbike = false, -- Set True To Make People Pay For Bikes
        price = 10000, -- The Amount People Pay
        enableblips = true, -- Enable Blips
    },
    menu = {
        title = "Xilo BikeSpawner",
        position = "bottom-right"
    },
    cars = {
        {model = "sanchez", label = "Sanchez", icon = "car"},
        {model = "bmx", label = "BMX", icon = "car"},
    },
    alert = function(des, type)
        lib.notify({
            title = "Notification",
            description = des,
            type = type or "info"
        })
    end
}