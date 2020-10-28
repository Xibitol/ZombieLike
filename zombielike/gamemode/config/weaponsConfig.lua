ZL.weapons = {
    { -- Hand
        name = "Hand",
        entity = "zl_hand",
        price = 0,
        onBuyCharger = 0,

        charger = nil,

        onStart = true,
        onStartCharger = 0
    },
    { -- Machette
        name = "Machette",
        entity = "fas2_machete",
        price = 25,
        onBuyCharger = 0,

        charger = nil,

        onStart = true,
        onStartCharger = 0
    },
    { -- P226
        name = "P226",
        entity = "fas2_p226",
        price = 40,
        onBuyCharger = 4,

        charger = {
            name = ".357 SIG",
            price = 7.5,
            ammo = 13
        },

        onStart = true,
        onStartCharger = 6
    }
}