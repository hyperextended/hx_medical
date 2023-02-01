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
    'NONE',
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
        [-1955384325] = {
        type = "Miscellaneous",
        label = "bleed",
        class = '',
        name = "weapon_bleed",
        statuses = {
                bleed = 1
        }
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
        [453432689] = {
        type = "Pistol",
        label = "Pistol",
        class = 'SMALL_CALIBER',
        name = "weapon_pistol",
        statuses = {
                stagger = 1
        }
    },
        [133987706] = {
        type = "Miscellaneous",
        label = "Rammed - Vehicle",
        class = 'HEAVY_IMPACT',
        name = "weapon_rammed_by_car",
        statuses = {
                unconscious = 1,
stagger = 1,
        }
    },
        [-1768145561] = {
        type = "Assault Rifle",
        label = "Specialcarbine MK2",
        class = 'MEDIUM_CALIBER',
        name = "weapon_specialcarbine_mk2",
        statuses = {
                bleed = 1
        }
    },
        [487013001] = {
        type = "Shotgun",
        label = "Pump Shotgun",
        class = 'SHOTGUN',
        name = "weapon_pumpshotgun",
        statuses = {
                bleed = 1
        }
    },
        [-1075685676] = {
        type = "Pistol",
        label = "Pistol Mk2",
        class = 'SMALL_CALIBER',
        name = "weapon_pistol_mk2",
        statuses = {
                bleed = 1
        }
    },
        [-1834847097] = {
        type = "Melee",
        label = "Dagger",
        class = 'CUTTING',
        name = "weapon_dagger",
        statuses = {
                bleed = 1
        }
    },
        [125959754] = {
        type = "Heavy Weapons",
        label = "Compact Launcher",
        class = 'EXPLOSIVE',
        name = "weapon_compactlauncher",
        statuses = {
                bleed = 1
        }
    },
        [-2067956739] = {
        type = "Melee",
        label = "Crowbar",
        class = 'HEAVY_IMPACT',
        name = "weapon_crowbar",
        statuses = {
                unconscious = 0.1
        }
    },
        [-618237638] = {
        type = "Heavy Weapons",
        label = "EMP Launcher",
        class = 'EXPLOSIVE',
        name = "weapon_emplauncher",
        statuses = {
                
        }
    },
        [-1716589765] = {
        type = "Pistol",
        label = "Pistol .50 Cal",
        class = 'MEDIUM_CALIBER',
        name = "weapon_pistol50",
        statuses = {
                bleed = 1
        }
    },
        [-598887786] = {
        type = "Pistol",
        label = "Marksman Pistol",
        class = 'MEDIUM_CALIBER',
        name = "weapon_marksmanpistol",
        statuses = {
                bleed = 1
        }
    },
        [-1045183535] = {
        type = "Pistol",
        label = "Revolver",
        class = 'MEDIUM_CALIBER',
        name = "weapon_revolver",
        statuses = {
                bleed = 1
        }
    },
        [171789620] = {
        type = "Submachine Gun",
        label = "Combat PDW",
        class = 'SMALL_CALIBER',
        name = "weapon_combatpdw",
        statuses = {
                bleed = 1
        }
    },
        [-1716189206] = {
        type = "Melee",
        label = "Knife",
        class = 'CUTTING',
        name = "weapon_knife",
        statuses = {
                bleed = 1
        }
    },
        [1171102963] = {
        type = "Pistol",
        label = "Taser",
        class = 'NONE',
        name = "weapon_stungun_mp",
        statuses = {
                
        }
    },
        [1672152130] = {
        type = "Heavy Weapons",
        label = "Homing Launcher",
        class = 'EXPLOSIVE',
        name = "weapon_hominglauncher",
        statuses = {
                bleed = 1
        }
    },
        [-1076751822] = {
        type = "Pistol",
        label = "SNS Pistol",
        class = 'SMALL_CALIBER',
        name = "weapon_snspistol",
        statuses = {
                bleed = 1
        }
    },
        [1198879012] = {
        type = "Pistol",
        label = "Flare Gun",
        class = 'FIRE',
        name = "weapon_flaregun",
        statuses = {
                bleed = 1
        }
    },
        [910830060] = {
        type = "Miscellaneous",
        label = "Exhaustion",
        class = 'SUFFOCATING',
        name = "weapon_exhaustion",
        statuses = {
                
        }
    },
        [-1813897027] = {
        type = "Throwable",
        label = "Grenade",
        class = 'EXPLOSIVE',
        name = "weapon_grenade",
        statuses = {
                bleed = 1
        }
    },
        [-1466123874] = {
        type = "Shotgun",
        label = "Musket",
        class = 'HIGH_CALIBER',
        name = "weapon_musket",
        statuses = {
                bleed = 1
        }
    },
        [1936677264] = {
        type = "Miscellaneous",
        label = "Drowning in a Vehicle",
        class = 'SUFFOCATING',
        name = "weapon_drowning_in_vehicle",
        statuses = {
                
        }
    },
        [1432025498] = {
        type = "Shotgun",
        label = "Pump Shotgun MK2",
        class = 'SHOTGUN',
        name = "weapon_pumpshotgun_mk2",
        statuses = {
                bleed = 1
        }
    },
        [-1786099057] = {
        type = "Melee",
        label = "Bat",
        class = 'HEAVY_IMPACT',
        name = "weapon_bat",
        statuses = {
                unconscious = 0.1
        }
    },
        [1593441988] = {
        type = "Pistol",
        label = "Combat Pistol",
        class = 'SMALL_CALIBER',
        name = "weapon_combatpistol",
        statuses = {
                bleed = 1
        }
    },
        [1785463520] = {
        type = "Sniper Rifle",
        label = "Marksman Rifle MK2",
        class = 'HIGH_CALIBER',
        name = "weapon_marksmanrifle_mk2",
        statuses = {
                bleed = 1
        }
    },
        [-1074790547] = {
        type = "Assault Rifle",
        label = "Assault Rifle",
        class = 'HIGH_CALIBER',
        name = "weapon_assaultrifle",
        statuses = {
                bleed = 1
        }
    },
        [984333226] = {
        type = "Shotgun",
        label = "Heavy Shotgun",
        class = 'SHOTGUN',
        name = "weapon_heavyshotgun",
        statuses = {
                bleed = 1
        }
    },
        [-1357824103] = {
        type = "Assault Rifle",
        label = "Advanced Rifle",
        class = 'MEDIUM_CALIBER',
        name = "weapon_advancedrifle",
        statuses = {
                bleed = 1
        }
    },
        [-581044007] = {
        type = "Melee",
        label = "Machete",
        class = 'CUTTING',
        name = "weapon_machete",
        statuses = {
                bleed = 1
        }
    },
        [324215364] = {
        type = "Submachine Gun",
        label = "Micro SMG",
        class = 'SMALL_CALIBER',
        name = "weapon_microsmg",
        statuses = {
                bleed = 1
        }
    },
        [-1063057011] = {
        type = "Assault Rifle",
        label = "Special Carbine",
        class = 'MEDIUM_CALIBER',
        name = "weapon_specialcarbine",
        statuses = {
                bleed = 1
        }
    },
        [-1951375401] = {
        type = "Melee",
        label = "Flashlight",
        class = 'class = "HEAVY_IMPACT"',
        name = "weapon_flashlight",
        statuses = {
                unconscious = 0.1
        }
    },
        [-72657034] = {
        type = "Miscellaneous",
        label = "Parachute",
        class = 'LIGHT_IMPACT',
        name = "gadget_parachute",
        statuses = {
                
        }
    },
        [1119849093] = {
        type = "Heavy Weapons",
        label = "Minigun",
        class = 'HIGH_CALIBER',
        name = "weapon_minigun",
        statuses = {
                bleed = 1
        }
    },
        [-2000187721] = {
        type = "Melee",
        label = "Briefcase",
        class = 'class = "HEAVY_IMPACT"',
        name = "weapon_briefcase",
        statuses = {
                unconscious = 0.1
        }
    },
        [-2066285827] = {
        type = "Assault Rifle",
        label = "Bull Puprifle MK2",
        class = 'MEDIUM_CALIBER',
        name = "weapon_bullpuprifle_mk2",
        statuses = {
                bleed = 1
        }
    },
        [-544306709] = {
        type = "Miscellaneous",
        label = "Fire",
        class = 'FIRE',
        name = "weapon_fire",
        statuses = {
                
        }
    },
        [-1600701090] = {
        type = "Throwable",
        label = "BZ Gas",
        class = 'SUFFOCATING',
        name = "weapon_bzgas",
        statuses = {
                
        }
    },
        [736523883] = {
        type = "Submachine Gun",
        label = "SMG",
        class = 'MEDIUM_CALIBER',
        name = "weapon_smg",
        statuses = {
                bleed = 1
        }
    },
        [-608341376] = {
        type = "Light Machine Gun",
        label = "Combat MG MK2",
        class = 'HIGH_CALIBER',
        name = "weapon_combatmg_mk2",
        statuses = {
                bleed = 1
        }
    },
        [-538741184] = {
        type = "Melee",
        label = "Switchblade",
        class = 'CUTTING',
        name = "weapon_switchblade",
        statuses = {
                bleed = 1
        }
    },
        [2024373456] = {
        type = "Submachine Gun",
        label = "SMG MK2",
        class = 'MEDIUM_CALIBER',
        name = "weapon_smg_mk2",
        statuses = {
                bleed = 1
        }
    },
        [-879347409] = {
        type = "Pistol",
        label = "Revolver MK2",
        class = 'MEDIUM_CALIBER',
        name = "weapon_revolver_mk2",
        statuses = {
                bleed = 1
        }
    },
        [615608432] = {
        type = "Throwable",
        label = "Molotov",
        class = 'FIRE',
        name = "weapon_molotov",
        statuses = {
                
        }
    },
        [2017895192] = {
        type = "Shotgun",
        label = "Sawn-off Shotgun",
        class = 'SHOTGUN',
        name = "weapon_sawnoffshotgun",
        statuses = {
                bleed = 1
        }
    },
        [539292904] = {
        type = "Miscellaneous",
        label = "Explosion",
        class = 'EXPLOSIVE',
        name = "weapon_explosion",
        statuses = {
                bleed = 1
        }
    },
        [-270015777] = {
        type = "Submachine Gun",
        label = "Assault SMG",
        class = 'MEDIUM_CALIBER',
        name = "weapon_assaultsmg",
        statuses = {
                bleed = 1
        }
    },
        [1223143800] = {
        type = "Miscellaneous",
        label = "Barbed Wire",
        class = 'CUTTING',
        name = "weapon_barbed_wire",
        statuses = {
                bleed = 1
        }
    },
        [-37975472] = {
        type = "Throwable",
        label = "Smoke Grenade",
        class = 'SUFFOCATING',
        name = "weapon_smokegrenade",
        statuses = {
                
        }
    },
        [1317494643] = {
        type = "Melee",
        label = "Hammer",
        class = 'HEAVY_IMPACT',
        name = "weapon_hammer",
        statuses = {
                unconscious = 0.1
        }
    },
        [-86904375] = {
        type = "Assault Rifle",
        label = "Carbine Rifle MK2",
        class = 'MEDIUM_CALIBER',
        name = "weapon_carbinerifle_mk2",
        statuses = {
                bleed = 1
        }
    },
        [-275439685] = {
        type = "Shotgun",
        label = "Double-barrel Shotgun",
        class = 'SHOTGUN',
        name = "weapon_dbshotgun",
        statuses = {
                bleed = 1
        }
    },
        [1649403952] = {
        type = "Assault Rifle",
        label = "Compact Rifle",
        class = 'MEDIUM_CALIBER',
        name = "weapon_compactrifle",
        statuses = {
                bleed = 1
        }
    },
        [-1810795771] = {
        type = "Melee",
        label = "Poolcue",
        class = 'HEAVY_IMPACT',
        name = "weapon_poolcue",
        statuses = {
                unconscious = 0.1
        }
    },
        [-1121678507] = {
        type = "Submachine Gun",
        label = "Mini SMG",
        class = 'SMALL_CALIBER',
        name = "weapon_minismg",
        statuses = {
                bleed = 1
        }
    },
        [883325847] = {
        type = "Miscellaneous",
        label = "Petrol Can",
        class = 'HEAVY_IMPACT',
        name = "weapon_petrolcan",
        statuses = {
                
        }
    },
        [341774354] = {
        type = "Miscellaneous",
        label = "Heli Crash",
        class = 'EXPLOSIVE',
        name = "weapon_heli_crash",
        statuses = {
                bleed = 1
        }
    },
        [-952879014] = {
        type = "Sniper Rifle",
        label = "Marksman Rifle",
        class = 'HIGH_CALIBER',
        name = "weapon_marksmanrifle",
        statuses = {
                bleed = 1
        }
    },
        [137902532] = {
        type = "Pistol",
        label = "Vintage Pistol",
        class = 'SMALL_CALIBER',
        name = "weapon_vintagepistol",
        statuses = {
                bleed = 1
        }
    },
        [-1312131151] = {
        type = "Heavy Weapons",
        label = "RPG",
        class = 'EXPLOSIVE',
        name = "weapon_rpg",
        statuses = {
                bleed = 1
        }
    },
        [-947031628] = {
        type = "Assault Rifle",
        label = "Heavy Rifle",
        class = 'HIGH_CALIBER',
        name = "weapon_heavyrifle",
        statuses = {
                bleed = 1
        }
    },
        [-494615257] = {
        type = "Shotgun",
        label = "Assault Shotgun",
        class = 'SHOTGUN',
        name = "weapon_assaultshotgun",
        statuses = {
                bleed = 1
        }
    },
        [-1660422300] = {
        type = "Light Machine Gun",
        label = "Machinegun",
        class = 'HIGH_CALIBER',
        name = "weapon_mg",
        statuses = {
                bleed = 1
        }
    },
        [-1420407917] = {
        type = "Throwable",
        label = "Proxmine Grenade",
        class = 'EXPLOSIVE',
        name = "weapon_proxmine",
        statuses = {
                bleed = 1
        }
    },
        [-100946242] = {
        type = "Animals",
        label = "Animal",
        class = 'WILDLIFE',
        name = "weapon_animal",
        statuses = {
                bleed = 1
        }
    },
        [-1746263880] = {
        type = "Pistol",
        label = "Double Action Revolver",
        class = 'MEDIUM_CALIBER',
        name = "weapon_doubleaction",
        statuses = {
                bleed = 1
        }
    },
        [-1833087301] = {
        type = "Miscellaneous",
        label = "Electric Fence",
        class = 'FIRE',
        name = "weapon_electric_fence",
        statuses = {
                
        }
    },
        [2144741730] = {
        type = "Light Machine Gun",
        label = "Combat MG",
        class = 'HIGH_CALIBER',
        name = "weapon_combatmg",
        statuses = {
                bleed = 1
        }
    },
        [2132975508] = {
        type = "Assault Rifle",
        label = "Bullpup Rifle",
        class = 'MEDIUM_CALIBER',
        name = "weapon_bullpuprifle",
        statuses = {
                bleed = 1
        }
    },
        [-619010992] = {
        type = "Submachine Gun",
        label = "Tec-9",
        class = 'SMALL_CALIBER',
        name = "weapon_machinepistol",
        statuses = {
                bleed = 1
        }
    },
        [1627465347] = {
        type = "Light Machine Gun",
        label = "Thompson SMG",
        class = 'MEDIUM_CALIBER',
        name = "weapon_gusenberg",
        statuses = {
                bleed = 1
        }
    },
        [911657153] = {
        type = "Pistol",
        label = "Taser",
        class = 'NONE',
        name = "weapon_stungun",
        statuses = {
                
        }
    },
        [-10959621] = {
        type = "Miscellaneous",
        label = "Drowning",
        class = 'SUFFOCATING',
        name = "weapon_drowning",
        statuses = {
                
        }
    },
        [419712736] = {
        type = "Melee",
        label = "Wrench",
        class = 'HEAVY_IMPACT',
        name = "weapon_wrench",
        statuses = {
                unconscious = 0.1
        }
    },
        [205991906] = {
        type = "Sniper Rifle",
        label = "Heavy Sniper",
        class = 'HIGH_CALIBER',
        name = "weapon_heavysniper",
        statuses = {
                bleed = 1
        }
    },
        [-771403250] = {
        type = "Pistol",
        label = "Heavy Pistol",
        class = 'MEDIUM_CALIBER',
        name = "weapon_heavypistol",
        statuses = {
                bleed = 1
        }
    },
        [148160082] = {
        type = "Animals",
        label = "Cougar",
        class = 'WILDLIFE',
        name = "weapon_cougar",
        statuses = {
                bleed = 1
        }
    },
        [961495388] = {
        type = "Assault Rifle",
        label = "Assault Rifle MK2",
        class = 'HIGH_CALIBER',
        name = "weapon_assaultrifle_mk2",
        statuses = {
                bleed = 1
        }
    },
        [1233104067] = {
        type = "Throwable",
        label = "Flare pistol",
        class = 'FIRE',
        name = "weapon_flare",
        statuses = {
                
        }
    },
        [177293209] = {
        type = "Sniper Rifle",
        label = "Heavysniper MK2",
        class = 'HIGH_CALIBER',
        name = "weapon_heavysniper_mk2",
        statuses = {
                bleed = 1
        }
    },
        [-2009644972] = {
        type = "Pistol",
        label = "SNS Pistol MK2",
        class = 'SMALL_CALIBER',
        name = "weapon_snspistol_mk2",
        statuses = {
                bleed = 1
        }
    },
        [-102973651] = {
        type = "Melee",
        label = "Hatchet",
        class = 'CUTTING',
        name = "weapon_hatchet",
        statuses = {
                bleed = 1
        }
    },
        [-1169823560] = {
        type = "Throwable",
        label = "Pipe Bomb",
        class = 'EXPLOSIVE',
        name = "weapon_pipebomb",
        statuses = {
                bleed = 1
        }
    },
        [-853065399] = {
        type = "Melee",
        label = "Battle Axe",
        class = 'CUTTING',
        name = "weapon_battleaxe",
        statuses = {
                bleed = 1
        }
    },
        [-868994466] = {
        type = "Miscellaneous",
        label = "Water Cannon",
        class = 'OTHER',
        name = "weapon_hit_by_water_cannon",
        statuses = {
                
        }
    },
        [1834241177] = {
        type = "Heavy Weapons",
        label = "Railgun",
        class = 'HIGH_CALIBER',
        name = "weapon_railgun",
        statuses = {
                
        }
    },
        [-656458692] = {
        type = "Melee",
        label = "Knuckle",
        class = 'LIGHT_IMPACT',
        name = "weapon_knuckle",
        statuses = {
                unconscious = 1
        }
    },
        [-2084633992] = {
        type = "Assault Rifle",
        label = "Carbine Rifle",
        class = 'MEDIUM_CALIBER',
        name = "weapon_carbinerifle",
        statuses = {
                bleed = 1
        }
    },
        [101631238] = {
        type = "Miscellaneous",
        label = "Fire Extinguisher",
        class = 'HEAVY_IMPACT',
        name = "weapon_fireextinguisher",
        statuses = {
                
        }
    },
        [741814745] = {
        type = "Throwable",
        label = "C4",
        class = 'EXPLOSIVE',
        name = "weapon_stickybomb",
        statuses = {
                
        }
    },
        [-102323637] = {
        type = "Melee",
        label = "Broken Bottle",
        class = 'CUTTING',
        name = "weapon_bottle",
        statuses = {
                bleed = 1
        }
    },
        [584646201] = {
        type = "Pistol",
        label = "AP Pistol",
        class = 'SMALL_CALIBER',
        name = "weapon_appistol",
        statuses = {
                bleed = 1
        }
    },
        [-1238556825] = {
        type = "Heavy Weapons",
        label = "Ray Minigun",
        class = '',
        name = "weapon_rayminigun",
        statuses = {
                
        }
    },
        [1141786504] = {
        type = "Melee",
        label = "Golfclub",
        class = '',
        name = "weapon_golfclub",
        statuses = {
                unconscious = 0.1
        }
    },
        [940833800] = {
        type = "Melee",
        label = "Stone Hatchet",
        class = '',
        name = "weapon_stone_hatchet",
        statuses = {
                bleed = 1
        }
    },
        [1470379660] = {
        type = "Pistol",
        label = "Gadget Pistol",
        class = '',
        name = "weapon_gadgetpistol",
        statuses = {
                bleed = 1
        }
    },
        [600439132] = {
        type = "Throwable",
        label = "Ball",
        class = '',
        name = "weapon_ball",
        statuses = {
                unconscious = .01
        }
    },
        [-1355376991] = {
        type = "Pistol",
        label = "Ray Pistol",
        class = '',
        name = "weapon_raypistol",
        statuses = {
                
        }
    },
        [1737195953] = {
        type = "Melee",
        label = "Nightstick",
        class = '',
        name = "weapon_nightstick",
        statuses = {
                unconscious = 0.1
        }
    },
        [100416529] = {
        type = "Sniper Rifle",
        label = "Sniper Rifle",
        class = '',
        name = "weapon_sniperrifle",
        statuses = {
                bleed = 1
        }
    },
        [-499989876] = {
        type = "Melee",
        label = "Garbage Bag",
        class = '',
        name = "weapon_garbagebag",
        statuses = {
                unconscious = 0.1
        }
    },
        [317205821] = {
        type = "Shotgun",
        label = "Auto Shotgun",
        class = '',
        name = "weapon_autoshotgun",
        statuses = {
                bleed = 1
        }
    },
        [2138347493] = {
        type = "Heavy Weapons",
        label = "Firework Launcher",
        class = '',
        name = "weapon_firework",
        statuses = {
                
        }
    },
        [-1853920116] = {
        type = "Pistol",
        label = "Navy Revolver",
        class = '',
        name = "weapon_navyrevolver",
        statuses = {
                bleed = 1
        }
    },
        [28811031] = {
        type = "Melee",
        label = "Briefcase",
        class = '',
        name = "weapon_briefcase_02",
        statuses = {
                unconscious = 0.1
        }
    },
        [-1654528753] = {
        type = "Shotgun",
        label = "Bullpup Shotgun",
        class = '',
        name = "weapon_bullpupshotgun",
        statuses = {
                bleed = 1
        }
    },
        [1305664598] = {
        type = "Heavy Weapons",
        label = "Smoke Grenade Launcher",
        class = '',
        name = "weapon_grenadelauncher_smoke",
        statuses = {
                
        }
    },
        [-1568386805] = {
        type = "Heavy Weapons",
        label = "Grenade Launcher",
        class = '',
        name = "weapon_grenadelauncher",
        statuses = {
                bleed = 1
        }
    },
        [1198256469] = {
        type = "Submachine Gun",
        label = "Raycarbine",
        class = '',
        name = "weapon_raycarbine",
        statuses = {
                
        }
    },
        [-1168940174] = {
        type = "Miscellaneous",
        label = "Hazardcan",
        class = '',
        name = "weapon_hazardcan",
        statuses = {
                
        }
    },
        [-1569615261] = {
        type = "Melee",
        label = "Fists",
        class = '',
        name = "weapon_unarmed",
        statuses = {
            unconscious = 0.1
        }
    },
        [406929569] = {
        type = "Miscellaneous",
        label = "Fertilizer Can",
        class = '',
        name = "weapon_fertilizercan",
        statuses = {
                
        }
    },
        [856002082] = {
        type = "Sniper Rifle",
        label = "Remote Sniper",
        class = '',
        name = "weapon_remotesniper",
        statuses = {
                bleed = 1
        }
    },
        [1309015656] = {
        type = "Melee",
        label = "Baquette",
        class = '',
        name = "weapon_bread",
        statuses = {
                
        }
    },
        [94989220] = {
        type = "Shotgun",
        label = "Combat Shotgun",
        class = '',
        name = "weapon_combatshotgun",
        statuses = {
                bleed = 1
        }
    },
        [-1658906650] = {
        type = "Assault Rifle",
        label = "Military Rifle",
        class = '',
        name = "weapon_militaryrifle",
        statuses = {
                bleed = 1
        }
    },
        [126349499] = {
        type = "Throwable",
        label = "Snowball",
        class = '',
        name = "weapon_snowball",
        statuses = {
                
        }
    },
        [727643628] = {
        type = "Pistol",
        label = "Ceramic Pistol",
        class = '',
        name = "weapon_ceramicpistol",
        statuses = {
                bleed = 1
        }
    },
        [-800287667] = {
        type = "Melee",
        label = "Handcuffs",
        class = '',
        name = "weapon_handcuffs",
        statuses = {
                
        }
    },
}
