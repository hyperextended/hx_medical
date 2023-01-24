Data = {}

Data.WeaponClasses = { -- Define gta weapon classe numbers
    ['SMALL_CALIBER'] = 1,
    ['MEDIUM_CALIBER'] = 2,
    ['HIGH_CALIBER'] = 3,
    ['SHOTGUN'] = 4,
    ['CUTTING'] = 5,
    ['LIGHT_IMPACT'] = 6,
    ['HEAVY_IMPACT'] = 7,
    ['EXPLOSIVE'] = 8,
    ['FIRE'] = 9,
    ['SUFFOCATING'] = 10,
    ['OTHER'] = 11,
    ['WILDLIFE'] = 12,
    ['NOTHING'] = 13
}

Data.ArmoredBones = {
    ['SPINE'] = true,
    ['UPPER_BODY'] = true,
    ['LOWER_BODY'] = true
}

Data.StaggerAreas = {
    'SPINE',
    'LLEG',
    'RLEG',
    'LFOOT',
    'RFOOT',
}

Data.Bones = { -- Correspond bone hash numbers to their label
    [0]     = 'NONE',
    [31085] = 'HEAD',
    [31086] = 'HEAD',
    [39317] = 'NECK',
    [57597] = 'SPINE',
    [23553] = 'SPINE',
    [24816] = 'SPINE',
    [24817] = 'SPINE',
    [24818] = 'SPINE',
    [10706] = 'UPPER_BODY',
    [64729] = 'UPPER_BODY',
    [11816] = 'LOWER_BODY',
    [45509] = 'LARM',
    [61163] = 'LARM',
    [18905] = 'LHAND',
    [4089]  = 'LFINGER',
    [4090]  = 'LFINGER',
    [4137]  = 'LFINGER',
    [4138]  = 'LFINGER',
    [4153]  = 'LFINGER',
    [4154]  = 'LFINGER',
    [4169]  = 'LFINGER',
    [4170]  = 'LFINGER',
    [4185]  = 'LFINGER',
    [4186]  = 'LFINGER',
    [26610] = 'LFINGER',
    [26611] = 'LFINGER',
    [26612] = 'LFINGER',
    [26613] = 'LFINGER',
    [26614] = 'LFINGER',
    [58271] = 'LLEG',
    [63931] = 'LLEG',
    [2108]  = 'LFOOT',
    [14201] = 'LFOOT',
    [40269] = 'RARM',
    [28252] = 'RARM',
    [57005] = 'RHAND',
    [58866] = 'RFINGER',
    [58867] = 'RFINGER',
    [58868] = 'RFINGER',
    [58869] = 'RFINGER',
    [58870] = 'RFINGER',
    [64016] = 'RFINGER',
    [64017] = 'RFINGER',
    [64064] = 'RFINGER',
    [64065] = 'RFINGER',
    [64080] = 'RFINGER',
    [64081] = 'RFINGER',
    [64096] = 'RFINGER',
    [64097] = 'RFINGER',
    [64112] = 'RFINGER',
    [64113] = 'RFINGER',
    [36864] = 'RLEG',
    [51826] = 'RLEG',
    [20781] = 'RFOOT',
    [52301] = 'RFOOT',
}

---@alias Bone 'NONE'|'HEAD'|'NECK'|'SPINE'|'UPPER_BODY'|'LOWER_BODY'|'LARM'|'LHAND'|'LFINGER'|'LLEG'|'LFOOT'|'RARM'|'RHAND'|'RFINGER'|'RLEG'|'RFOOT'
Data.BoneIndexes = { -- Correspond bone labels to their hash number
    ['NONE'] = 0,
    -- ['HEAD'] = 31085,
    ['HEAD'] = 31086,
    ['NECK'] = 39317,
    -- ['SPINE'] = 57597,
    -- ['SPINE'] = 23553,
    -- ['SPINE'] = 24816,
    -- ['SPINE'] = 24817,
    ['SPINE'] = 24818,
    -- ['UPPER_BODY'] = 10706,
    ['UPPER_BODY'] = 64729,
    ['LOWER_BODY'] = 11816,
    -- ['LARM'] = 45509,
    ['LARM'] = 61163,
    ['LHAND'] = 18905,
    -- ['LFINGER'] = 4089,
    -- ['LFINGER'] = 4090,
    -- ['LFINGER'] = 4137,
    -- ['LFINGER'] = 4138,
    -- ['LFINGER'] = 4153,
    -- ['LFINGER'] = 4154,
    -- ['LFINGER'] = 4169,
    -- ['LFINGER'] = 4170,
    -- ['LFINGER'] = 4185,
    -- ['LFINGER'] = 4186,
    -- ['LFINGER'] = 26610,
    -- ['LFINGER'] = 26611,
    -- ['LFINGER'] = 26612,
    -- ['LFINGER'] = 26613,
    ['LFINGER'] = 26614,
    -- ['LLEG'] = 58271,
    ['LLEG'] = 63931,
    -- ['LFOOT'] = 2108,
    ['LFOOT'] = 14201,
    -- ['RARM'] = 40269,
    ['RARM'] = 28252,
    ['RHAND'] = 57005,
    -- ['RFINGER'] = 58866,
    -- ['RFINGER'] = 58867,
    -- ['RFINGER'] = 58868,
    -- ['RFINGER'] = 58869,
    -- ['RFINGER'] = 58870,
    -- ['RFINGER'] = 64016,
    -- ['RFINGER'] = 64017,
    -- ['RFINGER'] = 64064,
    -- ['RFINGER'] = 64065,
    -- ['RFINGER'] = 64080,
    -- ['RFINGER'] = 64081,
    -- ['RFINGER'] = 64096,
    -- ['RFINGER'] = 64097,
    -- ['RFINGER'] = 64112,
    ['RFINGER'] = 64113,
    -- ['RLEG'] = 36864,
    ['RLEG'] = 51826,
    -- ['RFOOT'] = 20781,
    ['RFOOT'] = 52301,
}

Data.WeaponsTable = {
    [-1768145561] = {
        type = "Assault Rifle",
        label = "Specialcarbine MK2",
        class = 'MEDIUM_CALIBER',
        name = "weapon_specialcarbine_mk2"
    },
    [487013001] = {
        type = "Shotgun",
        label = "Pump Shotgun",
        class = 'SHOTGUN',
        name = "weapon_pumpshotgun"
    },
    [-1955384325] = {
        label = "Bleeding",
        bleeding = 1,
        type = "Miscellaneous",
        name = "weapon_bleeding"
    },
    [-1075685676] = {
        type = "Pistol",
        label = "Pistol Mk2",
        class = 'SMALL_CALIBER',
        name = "weapon_pistol_mk2"
    },
    [-1238556825] = {
        label = "Ray Minigun",
        type = "Heavy Weapons",
        name = "weapon_rayminigun"
    },
    [-1834847097] = {
        type = "Melee",
        label = "Dagger",
        class = 'CUTTING',
        name = "weapon_dagger"
    },
    [125959754] = {
        type = "Heavy Weapons",
        label = "Compact Launcher",
        class = 'EXPLOSIVE',
        name = "weapon_compactlauncher"
    },
    [-842959696] = {
        type = "Miscellaneous",
        label = "Fall",
        class = 'HEAVY_IMPACT',
        name = "weapon_fall",
        statuses = {
            unconscious = 3
        }
    },
    [-1553120962] = {
        type = "Miscellaneous",
        label = "Run Over - Vehicle",
        class = 'HEAVY_IMPACT',
        name = "weapon_run_over_by_car",
        statuses = {
            unconscious = 1
        }
    },
    [-2067956739] = {
        type = "Melee",
        label = "Crowbar",
        class = 'HEAVY_IMPACT',
        name = "weapon_crowbar"
    },
    [-618237638] = {
        type = "Heavy Weapons",
        label = "EMP Launcher",
        class = 'EXPLOSIVE',
        name = "weapon_emplauncher"
    },
    [1141786504] = {
        label = "Golfclub",
        type = "Melee",
        name = "weapon_golfclub"
    },
    [453432689] = {
        type = "Pistol",
        label = "Pistol",
        class = 'SMALL_CALIBER',
        name = "weapon_pistol",
        statuses = {
            stagger = 1
        }
    },
    [-1716589765] = {
        type = "Pistol",
        label = "Pistol .50 Cal",
        class = 'MEDIUM_CALIBER',
        name = "weapon_pistol50"
    },
    [-598887786] = {
        type = "Pistol",
        label = "Marksman Pistol",
        class = 'MEDIUM_CALIBER',
        name = "weapon_marksmanpistol"
    },
    [940833800] = {
        label = "Stone Hatchet",
        type = "Melee",
        name = "weapon_stone_hatchet"
    },
    [-1045183535] = {
        type = "Pistol",
        label = "Revolver",
        class = 'MEDIUM_CALIBER',
        name = "weapon_revolver"
    },
    [171789620] = {
        type = "Submachine Gun",
        label = "Combat PDW",
        class = 'SMALL_CALIBER',
        name = "weapon_combatpdw"
    },
    [-1716189206] = {
        type = "Melee",
        label = "Knife",
        class = 'CUTTING',
        name = "weapon_knife"
    },
    [1470379660] = {
        label = "Gadget Pistol",
        type = "Pistol",
        name = "weapon_gadgetpistol"
    },
    [1171102963] = {
        type = "Pistol",
        label = "Taser",
        class = 'NONE',
        name = "weapon_stungun_mp"
    },
    [1672152130] = {
        type = "Heavy Weapons",
        label = "Homing Launcher",
        class = 'EXPLOSIVE',
        name = "weapon_hominglauncher"
    },
    [-1076751822] = {
        type = "Pistol",
        label = "SNS Pistol",
        class = 'SMALL_CALIBER',
        name = "weapon_snspistol"
    },
    [1198879012] = {
        type = "Pistol",
        label = "Flare Gun",
        class = 'FIRE',
        name = "weapon_flaregun"
    },
    [600439132] = {
        label = "Ball",
        type = "Throwable",
        name = "weapon_ball"
    },
    [910830060] = {
        type = "Miscellaneous",
        label = "Exhaustion",
        class = 'SUFFOCATING',
        name = "weapon_exhaustion"
    },
    [-1355376991] = {
        label = "Ray Pistol",
        type = "Pistol",
        name = "weapon_raypistol"
    },
    [133987706] = {
        type = "Miscellaneous",
        label = "Rammed - Vehicle",
        class = 'HEAVY_IMPACT',
        name = "weapon_rammed_by_car"
    },
    [-1813897027] = {
        type = "Throwable",
        label = "Grenade",
        class = 'EXPLOSIVE',
        name = "weapon_grenade"
    },
    [-1466123874] = {
        type = "Shotgun",
        label = "Musket",
        class = 'HIGH_CALIBER',
        name = "weapon_musket"
    },
    [1936677264] = {
        type = "Miscellaneous",
        label = "Drowning in a Vehicle",
        class = 'SUFFOCATING',
        name = "weapon_drowning_in_vehicle"
    },
    [1432025498] = {
        type = "Shotgun",
        label = "Pump Shotgun MK2",
        class = 'SHOTGUN',
        name = "weapon_pumpshotgun_mk2"
    },
    [1737195953] = {
        label = "Nightstick",
        type = "Melee",
        name = "weapon_nightstick"
    },
    [-1786099057] = {
        type = "Melee",
        label = "Bat",
        class = 'HEAVY_IMPACT',
        name = "weapon_bat"
    },
    [1593441988] = {
        type = "Pistol",
        label = "Combat Pistol",
        class = 'SMALL_CALIBER',
        name = "weapon_combatpistol"
    },
    [1785463520] = {
        type = "Sniper Rifle",
        label = "Marksman Rifle MK2",
        class = 'HIGH_CALIBER',
        name = "weapon_marksmanrifle_mk2"
    },
    [-1074790547] = {
        type = "Assault Rifle",
        label = "Assault Rifle",
        class = 'HIGH_CALIBER',
        name = "weapon_assaultrifle"
    },
    [100416529] = {
        label = "Sniper Rifle",
        type = "Sniper Rifle",
        name = "weapon_sniperrifle"
    },
    [984333226] = {
        type = "Shotgun",
        label = "Heavy Shotgun",
        class = 'SHOTGUN',
        name = "weapon_heavyshotgun"
    },
    [-1357824103] = {
        type = "Assault Rifle",
        label = "Advanced Rifle",
        class = 'MEDIUM_CALIBER',
        name = "weapon_advancedrifle"
    },
    [-581044007] = {
        type = "Melee",
        label = "Machete",
        class = 'CUTTING',
        name = "weapon_machete"
    },
    [324215364] = {
        type = "Submachine Gun",
        label = "Micro SMG",
        class = 'SMALL_CALIBER',
        name = "weapon_microsmg"
    },
    [-1063057011] = {
        type = "Assault Rifle",
        label = "Special Carbine",
        class = 'MEDIUM_CALIBER',
        name = "weapon_specialcarbine"
    },
    [-1951375401] = {
        label = "Flashlight",
        type = "Melee",
        name = "weapon_flashlight",
        class = "HEAVY_IMPACT"
    },
    [-72657034] = {
        label = "Parachute",
        type = "Miscellaneous",
        class = 'LIGHT_IMPACT',
        name = "gadget_parachute"
    },
    [1119849093] = {
        type = "Heavy Weapons",
        label = "Minigun",
        class = 'HIGH_CALIBER',
        name = "weapon_minigun"
    },
    [-2000187721] = {
        label = "Briefcase",
        type = "Melee",
        name = "weapon_briefcase",
        class = "HEAVY_IMPACT"
    },
    [-2066285827] = {
        type = "Assault Rifle",
        label = "Bull Puprifle MK2",
        class = 'MEDIUM_CALIBER',
        name = "weapon_bullpuprifle_mk2"
    },
    [-544306709] = {
        type = "Miscellaneous",
        label = "Fire",
        class = 'FIRE',
        name = "weapon_fire"
    },
    [-1600701090] = {
        type = "Throwable",
        label = "BZ Gas",
        class = 'SUFFOCATING',
        name = "weapon_bzgas"
    },
    [736523883] = {
        type = "Submachine Gun",
        label = "SMG",
        class = 'MEDIUM_CALIBER',
        name = "weapon_smg"
    },
    [-608341376] = {
        type = "Light Machine Gun",
        label = "Combat MG MK2",
        class = 'HIGH_CALIBER',
        name = "weapon_combatmg_mk2"
    },
    [-538741184] = {
        type = "Melee",
        label = "Switchblade",
        class = 'CUTTING',
        name = "weapon_switchblade"
    },
    [-499989876] = {
        label = "Garbage Bag",
        type = "Melee",
        name = "weapon_garbagebag"
    },
    [317205821] = {
        label = "Auto Shotgun",
        type = "Shotgun",
        name = "weapon_autoshotgun"
    },
    [2024373456] = {
        type = "Submachine Gun",
        label = "SMG MK2",
        class = 'MEDIUM_CALIBER',
        name = "weapon_smg_mk2"
    },
    [-879347409] = {
        type = "Pistol",
        label = "Revolver MK2",
        class = 'MEDIUM_CALIBER',
        name = "weapon_revolver_mk2"
    },
    [615608432] = {
        type = "Throwable",
        label = "Molotov",
        class = 'FIRE',
        name = "weapon_molotov"
    },
    [2138347493] = {
        label = "Firework Launcher",
        type = "Heavy Weapons",
        name = "weapon_firework"
    },
    [-1853920116] = {
        label = "Navy Revolver",
        type = "Pistol",
        name = "weapon_navyrevolver"
    },
    [28811031] = {
        label = "Briefcase",
        type = "Melee",
        name = "weapon_briefcase_02"
    },
    [2017895192] = {
        type = "Shotgun",
        label = "Sawn-off Shotgun",
        class = 'SHOTGUN',
        name = "weapon_sawnoffshotgun"
    },
    [539292904] = {
        type = "Miscellaneous",
        label = "Explosion",
        class = 'EXPLOSIVE',
        name = "weapon_explosion"
    },
    [-270015777] = {
        type = "Submachine Gun",
        label = "Assault SMG",
        class = 'MEDIUM_CALIBER',
        name = "weapon_assaultsmg"
    },
    [1223143800] = {
        type = "Miscellaneous",
        label = "Barbed Wire",
        class = 'CUTTING',
        name = "weapon_barbed_wire"
    },
    [-37975472] = {
        type = "Throwable",
        label = "Smoke Grenade",
        class = 'SUFFOCATING',
        name = "weapon_smokegrenade"
    },
    [-1654528753] = {
        label = "Bullpup Shotgun",
        type = "Shotgun",
        name = "weapon_bullpupshotgun"
    },
    [1317494643] = {
        type = "Melee",
        label = "Hammer",
        class = 'HEAVY_IMPACT',
        name = "weapon_hammer"
    },
    [-86904375] = {
        type = "Assault Rifle",
        label = "Carbine Rifle MK2",
        class = 'MEDIUM_CALIBER',
        name = "weapon_carbinerifle_mk2"
    },
    [-275439685] = {
        type = "Shotgun",
        label = "Double-barrel Shotgun",
        class = 'SHOTGUN',
        name = "weapon_dbshotgun"
    },
    [1649403952] = {
        type = "Assault Rifle",
        label = "Compact Rifle",
        class = 'MEDIUM_CALIBER',
        name = "weapon_compactrifle"
    },
    [-1810795771] = {
        type = "Melee",
        label = "Poolcue",
        class = 'HEAVY_IMPACT',
        name = "weapon_poolcue"
    },
    [1305664598] = {
        label = "Smoke Grenade Launcher",
        type = "Heavy Weapons",
        name = "weapon_grenadelauncher_smoke"
    },
    [-1568386805] = {
        label = "Grenade Launcher",
        type = "Heavy Weapons",
        name = "weapon_grenadelauncher"
    },
    [-1121678507] = {
        type = "Submachine Gun",
        label = "Mini SMG",
        class = 'SMALL_CALIBER',
        name = "weapon_minismg"
    },
    [883325847] = {
        type = "Miscellaneous",
        label = "Petrol Can",
        class = 'HEAVY_IMPACT',
        name = "weapon_petrolcan"
    },
    [1198256469] = {
        label = "Raycarbine",
        type = "Submachine Gun",
        name = "weapon_raycarbine"
    },
    [341774354] = {
        type = "Miscellaneous",
        label = "Heli Crash",
        class = 'EXPLOSIVE',
        name = "weapon_heli_crash"
    },
    [-952879014] = {
        type = "Sniper Rifle",
        label = "Marksman Rifle",
        class = 'HIGH_CALIBER',
        name = "weapon_marksmanrifle"
    },
    [137902532] = {
        type = "Pistol",
        label = "Vintage Pistol",
        class = 'SMALL_CALIBER',
        name = "weapon_vintagepistol"
    },
    [-1312131151] = {
        type = "Heavy Weapons",
        label = "RPG",
        class = 'EXPLOSIVE',
        name = "weapon_rpg"
    },
    [-1168940174] = {
        label = "Hazardcan",
        type = "Miscellaneous",
        name = "weapon_hazardcan"
    },
    [-947031628] = {
        type = "Assault Rifle",
        label = "Heavy Rifle",
        class = 'HIGH_CALIBER',
        name = "weapon_heavyrifle"
    },
    [-494615257] = {
        type = "Shotgun",
        label = "Assault Shotgun",
        class = 'SHOTGUN',
        name = "weapon_assaultshotgun"
    },
    [-1660422300] = {
        type = "Light Machine Gun",
        label = "Machinegun",
        class = 'HIGH_CALIBER',
        name = "weapon_mg"
    },
    [-1420407917] = {
        type = "Throwable",
        label = "Proxmine Grenade",
        class = 'EXPLOSIVE',
        name = "weapon_proxmine"
    },
    [-100946242] = {
        type = "Animals",
        label = "Animal",
        class = 'WILDLIFE',
        name = "weapon_animal"
    },
    [-1746263880] = {
        type = "Pistol",
        label = "Double Action Revolver",
        class = 'MEDIUM_CALIBER',
        name = "weapon_doubleaction"
    },
    [-1569615261] = {
        label = "Fists",
        type = "Melee",
        name = "weapon_unarmed"
    },
    [-1833087301] = {
        type = "Miscellaneous",
        label = "Electric Fence",
        class = 'FIRE',
        name = "weapon_electric_fence"
    },
    [2144741730] = {
        type = "Light Machine Gun",
        label = "Combat MG",
        class = 'HIGH_CALIBER',
        name = "weapon_combatmg"
    },
    [2132975508] = {
        type = "Assault Rifle",
        label = "Bullpup Rifle",
        class = 'MEDIUM_CALIBER',
        name = "weapon_bullpuprifle"
    },
    [-619010992] = {
        type = "Submachine Gun",
        label = "Tec-9",
        class = 'SMALL_CALIBER',
        name = "weapon_machinepistol"
    },
    [1627465347] = {
        type = "Light Machine Gun",
        label = "Thompson SMG",
        class = 'MEDIUM_CALIBER',
        name = "weapon_gusenberg"
    },
    [911657153] = {
        type = "Pistol",
        label = "Taser",
        class = 'NONE',
        name = "weapon_stungun"
    },
    [-10959621] = {
        type = "Miscellaneous",
        label = "Drowning",
        class = 'SUFFOCATING',
        name = "weapon_drowning"
    },
    [419712736] = {
        type = "Melee",
        label = "Wrench",
        class = 'HEAVY_IMPACT',
        name = "weapon_wrench"
    },
    [205991906] = {
        type = "Sniper Rifle",
        label = "Heavy Sniper",
        class = 'HIGH_CALIBER',
        name = "weapon_heavysniper"
    },
    [-771403250] = {
        type = "Pistol",
        label = "Heavy Pistol",
        class = 'MEDIUM_CALIBER',
        name = "weapon_heavypistol"
    },
    [148160082] = {
        type = "Animals",
        label = "Cougar",
        class = 'WILDLIFE',
        name = "weapon_cougar"
    },
    [961495388] = {
        type = "Assault Rifle",
        label = "Assault Rifle MK2",
        class = 'HIGH_CALIBER',
        name = "weapon_assaultrifle_mk2"
    },
    [406929569] = {
        label = "Fertilizer Can",
        type = "Miscellaneous",
        name = "weapon_fertilizercan"
    },
    [1233104067] = {
        type = "Throwable",
        label = "Flare pistol",
        class = 'FIRE',
        name = "weapon_flare"
    },
    [177293209] = {
        type = "Sniper Rifle",
        label = "Heavysniper MK2",
        class = 'HIGH_CALIBER',
        name = "weapon_heavysniper_mk2"
    },
    [-2009644972] = {
        type = "Pistol",
        label = "SNS Pistol MK2",
        class = 'SMALL_CALIBER',
        name = "weapon_snspistol_mk2"
    },
    [-102973651] = {
        type = "Melee",
        label = "Hatchet",
        class = 'CUTTING',
        name = "weapon_hatchet"
    },
    [856002082] = {
        label = "Remote Sniper",
        type = "Sniper Rifle",
        name = "weapon_remotesniper"
    },
    [-1169823560] = {
        type = "Throwable",
        label = "Pipe Bomb",
        class = 'EXPLOSIVE',
        name = "weapon_pipebomb"
    },
    [1309015656] = {
        label = "Baquette",
        type = "Melee",
        name = "weapon_bread"
    },
    [-853065399] = {
        type = "Melee",
        label = "Battle Axe",
        class = 'CUTTING',
        name = "weapon_battleaxe"
    },
    [-868994466] = {
        type = "Miscellaneous",
        label = "Water Cannon",
        class = 'OTHER',
        name = "weapon_hit_by_water_cannon"
    },
    [1834241177] = {
        type = "Heavy Weapons",
        label = "Railgun",
        class = 'HIGH_CALIBER',
        name = "weapon_railgun"
    },
    [94989220] = {
        label = "Combat Shotgun",
        type = "Shotgun",
        name = "weapon_combatshotgun"
    },
    [-1658906650] = {
        label = "Military Rifle",
        type = "Assault Rifle",
        name = "weapon_militaryrifle"
    },
    [-656458692] = {
        type = "Melee",
        label = "Knuckle",
        class = 'LIGHT_IMPACT',
        name = "weapon_knuckle"
    },
    [126349499] = {
        label = "Snowball",
        type = "Throwable",
        name = "weapon_snowball"
    },
    [727643628] = {
        label = "Ceramic Pistol",
        type = "Pistol",
        name = "weapon_ceramicpistol"
    },
    [-2084633992] = {
        type = "Assault Rifle",
        label = "Carbine Rifle",
        class = 'MEDIUM_CALIBER',
        name = "weapon_carbinerifle"
    },
    [101631238] = {
        type = "Miscellaneous",
        label = "Fire Extinguisher",
        class = 'HEAVY_IMPACT',
        name = "weapon_fireextinguisher"
    },
    [-800287667] = {
        label = "Handcuffs",
        type = "Melee",
        name = "weapon_handcuffs"
    },
    [741814745] = {
        type = "Throwable",
        label = "C4",
        class = 'EXPLOSIVE',
        name = "weapon_stickybomb"
    },
    [-102323637] = {
        type = "Melee",
        label = "Broken Bottle",
        class = 'CUTTING',
        name = "weapon_bottle"
    },
    [584646201] = {
        type = "Pistol",
        label = "AP Pistol",
        class = 'SMALL_CALIBER',
        name = "weapon_appistol"
    }
}
