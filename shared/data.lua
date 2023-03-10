Data = {}

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

Data.locations = {
    beds = {
        [1] = { coords = vec4(353.1, -584.6, 43.11, 152.08), taken = false, model = 1631638868 },
        [2] = { coords = vec4(356.79, -585.86, 43.11, 152.08), taken = false, model = 1631638868 },
        [3] = { coords = vec4(354.12, -593.12, 43.1, 336.32), taken = false, model = 2117668672 },
        [4] = { coords = vec4(350.79, -591.8, 43.1, 336.32), taken = false, model = 2117668672 },
        [5] = { coords = vec4(346.99, -590.48, 43.1, 336.32), taken = false, model = 2117668672 },
        [6] = { coords = vec4(360.32, -587.19, 43.02, 152.08), taken = false, model = -1091386327 },
        [7] = { coords = vec4(349.82, -583.33, 43.02, 152.08), taken = false, model = -1091386327 },
        [8] = { coords = vec4(326.98, -576.17, 43.02, 152.08), taken = false, model = -1091386327 },
    },
    jailbeds = {
        [1] = { coords = vec4(1761.96, 2597.74, 45.66, 270.14), taken = false, model = 2117668672 },
        [2] = { coords = vec4(1761.96, 2591.51, 45.66, 269.8), taken = false, model = 2117668672 },
        [3] = { coords = vec4(1771.8, 2598.02, 45.66, 89.05), taken = false, model = 2117668672 },
        [4] = { coords = vec4(1771.85, 2591.85, 45.66, 91.51), taken = false, model = 2117668672 },
    }
}