Config = Config or {}

-- Peds
Config.ManagerPedSpawn = vector4(1984.26, 3054.75, 47.22, 138.59)
Config.ManagerPedModel = "a_f_y_business_01"

Config.MaxOrders = 50
Config.MinPayout = 500
Config.MaxPayout = 1000

-- Items
Config.Items = {
    -- Examples (Name is what shows in UI)
    {
        name = "Hambuger",
        price = 10.00,
        recipe = {
            bread = 2,
            meat = 1,
            lettuce = 1,
            tomato = 1,
            onion = 1,
            cheese = 1,
        },
    },
    {
        name = "Pizza",
        price = 20.00,
        recipe = {
            bread = 2,
            tomato = 1,
            cheese = 1,
            pepperoni = 1,
        },
    },
    {
        name = "Hotdog",
        price = 5.00,
        recipe = {
            hotdog = 1,
            bread = 1,
        },
    },
}

Config.ItemNames = {
    -- Examples: ['ItemName'] = "SharedItemsName"
    ["Hambuger"] = "hamburger",
    ["Pizza"] = "pizza",
    ["Hotdog"] = "hotdog",
    

    -- Examples: recipeName = "sharedItemsName"
    chicken = "chicken",
    bread = "bread",
    meat = "meat",
    lettuce = "lettuce",
    tomato = "tomato",
    onion = "onion",
    cheese = "cheese",
    pepperoni = "pepperoni",
    hotdog = "hotdog",
}