Script.ReloadScript("scripts/Weather/common.lua");

TornadoPos={
  { x=1292, y=5921, z=0 }, -- Start (north of area 52)
  { x=3342, y=-190, z=0 }, -- End (south of elderstone+bull hollow)
}

-- Trigger spots --------------------------------------------
-- still need to be listed per instance in their patterns (but reused here)
BellPos={
  { x=1950.56, y=2435.93, z=66.14 }, -- Church bell
}

SirenPos={
  { x=3759.46, y=953.82,  z=49.98 }, -- Hospital
}

-- Audio trigger -- 
BellTriggers = createTriggerSpots( "Play_churchbell", "Stop_churchbell", BellPos, { fMinDelay = {30,25}, fMaxDelay = {120,70}, bPlayRandom = {true} } )
WeatherSirenTriggers = createTriggerSpots( "Play_siren_tornado_start", "Stop_siren_tornado", SirenPos )
NukeSirenTriggers = createTriggerSpots( "Play_siren_nuclear_start", "Stop_siren_nuclear", SirenPos )

-- dump(NukeSirenTriggers) -- test output

-- BellTriggers[1]
-- WeatherSirenTriggers[1]
-- NukeSirenTriggers[1]

-- Definition of the weather patterns (can be reloaded with wm_reload)
Weather = 
{
  -- map gps coords for cb radio
  gpsLatitude=38.309562,
  gpsLongitude=-109.804950,

  -- map environment settings
  baseline = { -- values for a normal day at 12:00 AM
    day = {
      -- for canyonlands we aim for ~july
      --          outside, inside, underground, underwater
      humidity=   {0.01,     0.05,   0.2,   1   }, -- [1-0] ratio (1 = wet, 0 = dry)
      rain=       {0,       0,      0,      1   }, -- [1-0] ratio (1 = wet, 0 = no rain)
      light=      {1.0,     0.3,    0.0,    0.2 }, -- [1-0] ratio (1 = bright, 0 = dark)
      temperature={35,      30,     20,     19  }, -- [°C]
      wind=       {12,      1,      0,      0   }, -- [km/h]
      geigercounter=  {1.1,   0.8,    0.0,       0  }, -- sound rtpc
    },
    night = { -- values for a normal night at 12:00 PM
      --          outside, inside, underground, underwater
      humidity=   {0.015,    0.07,   0.21,   1   },
      rain=       {0,       0,      0,      1   },
      light=      {0.04,    0.02,   0.0,    0   },
      temperature={17,      20,     19,      19  },
      wind=       {10,       1,      0,      0   },
      geigercounter=  {1.1,   0.8,    0.0,      0   },
    },
  },

  patterns =
  {
--------------------------------------------------------------------------------------------
    {
      name="ClearSky",
      probability=30, -- probabilities need to be 100 in total, everything over that will never get selected
      danger=-8,
      duration={15, 19},
      audio=
      {
        {
          class="AudioAreaAmbience",
          trigger="Play_wind",
          rtpc="wind_speed",
          rtpcValue=0.3,
        },
      },
    },

--------------------------------------------------------------------------------------------
    {
      name="LightRain",
      probability=1,
      danger=-3,
      duration={5, 15},
      todlimit={7,17}, -- pattern can only spawn between those times (Default: 0, 24 for no limit)
      continue={
        -- Continue pattern starts at fade out of current pattern (so both are active some time)
        ["Rainbow"] = 30,
        ["RainbowHalf"] = 30,
        ["LightFog"] = 10,
      }, 
      modifiers = { -- values added to current baseline (faded in and out)
        --          outside, inside, underground, underwater
        humidity=   {0.25,    0.15,   0.1,  },
        rain=       {0.3,                   },
        light=      {-0.2,    -0.1,         },
        temperature={-4,      -1,           },
        wind=       {5,       1,      1,    },
      },
      entities=
      {
        {
          class="Rain",
          properties=
          {
            -- 						start, 	full(default=start), end(default=start)
            bEnabled=				{1},
            fAmount=				{0,		0.4},
            fDiffuseDarkening=		{0,		0.5},
            fPuddlesAmount=			{0,		2.0},
            fPuddlesMaskAmount=		{0.73},
            fPuddlesRippleAmount=	{0,		1.75},
            fRainDropsAmount=		{0,		0.05},
            fRainDropsLighting=		{1.5},
            fRainDropsSpeed=		{0.8}, -- speed cant be interpolated it, because of how rain entity works
            fSplashesAmount=		{0,		0.6},
          },
        },
      },
      audio=
      {
        {
          class="AudioAreaAmbience",
          trigger="Play_rain",
          rtpc="weather_intensity",
          rtpcValue=1.5,
        },
        {
          class="AudioAreaAmbience",
          trigger="Play_wind",
          rtpc="wind_speed",
          rtpcValue=0.4,
        },
      },
      tod=
      {
        -- method=default lerp, min=totalmin, max=totalmax
        [etod.PARAM_SUN_INTENSITY]=						{0.15, method=emix.MULTIPLY, min=100}, -- lux is logaritmic so decreasing by factor 10
        [etod.PARAM_FOG_RADIAL_COLOR_MULTIPLIER]=		{0.1},

        -- Non-Volumetric Fog
        [etod.PARAM_VOLFOG_GLOBAL_DENSITY]=				{0.15, undergroundFactor=_uff, insideFactor=_iff},
        [etod.PARAM_VOLFOG_RAMP_INFLUENCE]=				{0.5, undergroundFactor=_uff, insideFactor=_iff},

        [etod.PARAM_FOG_COLOR]=            {{ x=140/255, y=157/255, z=176/255 }, constraint=econ.DARKEN, },
        [etod.PARAM_FOG_COLOR_MULTIPLIER] = { 0.15, method=emix.MULTIPLY },
        [etod.PARAM_FOG_COLOR2]=            {{ x=30/255, y=30/255, z=30/255 }, constraint=econ.DARKEN, },
        [etod.PARAM_FOG_COLOR2_MULTIPLIER] = { 0.7, method=emix.MULTIPLY },

        -- Volumetric Fog
        [etod.PARAM_VOLFOG2_GLOBAL_DENSITY]=			{0.25, method=emix.QUART, undergroundFactor=_uff, insideFactor=_iff},
        [etod.PARAM_VOLFOG2_COLOR1]=					{{ x=128/255, y=128/255, z=128/255 }, constraint=econ.NONE,},

        [etod.PARAM_CLOUDSHADING_SUNLIGHT_CUSTOM_COLOR_MULTIPLIER] = {0.5},
        [etod.PARAM_SKYLIGHT_SUN_INTENSITY_MULTIPLIER]=	{100},

        [etod.PARAM_COLORGRADING_DOF_FOCUSRANGE]=		{350, undergroundFactor=_ufd, insideFactor=_ifd},
        [etod.PARAM_COLORGRADING_DOF_BLURAMOUNT]=		{0.2, method=emix.ADDITIVE, undergroundFactor=_ufd, insideFactor=_ifd},
      },
    },

--------------------------------------------------------------------------------------------
    {
      name="HeavyRainThunder",
      probability=1,
      danger=7,
      dangerlimit=40,
      duration={4, 10},
      continue={
        -- Continue pattern starts at fade out of current pattern (so both are active some time)
        ["Rainbow"] = 10,
        ["RainbowHalf"] = 10,
        ["LightRain"] = 1,
        ["StormyDistantThunder"] = 5,
      }, 
      modifiers = { -- values added to current baseline (faded in and out)
        --          outside, inside, underground, underwater
        humidity=   {0.75,    0.25,   0.2,        },
        rain=       {0.8,                         },
        light=      {-0.6,    -0.2,               },
        temperature={-10,      -4,     -1,         },
        wind=       {20,       3,     2,          },
      },
      entities=
      {
        BellTriggers[1],
        {
          class="ParticleEffect",
          properties=
          {
            ParticleEffect= {"weather.fog.fog_rain"}, 
            PulsePeriod= {20}, 
            Strength={1.0}, -- Strength={0.0, 1.0},
          },
        },
        {
          class="Rain",
          properties=
          {
            -- 						start, 	full(default=start), end(default=start)
            bEnabled=				{1},
            fAmount=				{0,		3},
            fDiffuseDarkening=		{0,		1.0},
            fPuddlesAmount=			{0,		2.0},
            fPuddlesMaskAmount=		{0.7},
            fPuddlesRippleAmount=	{0,		2.0},
            fRainDropsAmount=		{0,		0.05},
            fRainDropsLighting=		{3.0},
            fRainDropsSpeed=		{2}, -- speed cant be interpolated it, because of how rain entity works
            fSplashesAmount=		{0,		2.0},
          },
        },
        {
          class="Lightning",
          properties=
          {
            bActive= {1},
            fDistance= {800,100}, -- lightning closes distance to player and then goes away again
            bRelativeToPlayer= {1},
            ["Timing.fDelay"]= {30},
            ["Timing.fDelayVariation"]= {0.75},
            ["Timing.fLightningDuration"]= {0.3},
            ["Effects.LightIntensity"]= {0.4,1.2}, -- increase intensity as it comes closer
            ["Effects.ParticleEffect"]= {"weather.lightning.lightningbolt1"},
            ["Effects.ParticleScale"]= {4,3}, -- have them a bit larger at distance
            ["Effects.SkyHighlightVerticalOffset"]= {400,80},
            ["Effects.SkyHighlightMultiplier"]= {0.3,1},
            ["Audio.audioTriggerPlayTrigger"]= {"Play_thunder"},
          },
        },
        {
          class="Lightning",
          properties=
          {
            bActive= {1},
            fDistance= {900,400}, -- lightning closes distance to player and then goes away again
            bRelativeToPlayer= {1},
            ["Timing.fDelay"]= {33},
            ["Timing.fDelayVariation"]= {0.6},
            ["Timing.fLightningDuration"]= {0.2},
            ["Effects.LightIntensity"]= {0.4,1.2}, -- increase intensity as it comes closer
            ["Effects.ParticleEffect"]= {"weather.lightning.lightningbolt2"},
            ["Effects.ParticleScale"]= {4,3}, -- have them a bit larger at distance
            ["Effects.SkyHighlightVerticalOffset"]= {300,60},
            ["Effects.SkyHighlightMultiplier"]= {0.3,1},
            ["Audio.audioTriggerPlayTrigger"]= {"Play_thunder"},
          },
        },
        {
          class="WindArea", -- cant be interpolated unless physicalized per frame, but not really needed
          properties=
          {
            -- 				start, full(default=start), end(default=start)
            bActive=		{1},
            bEllipsoidal=	{0},
            Speed=			{3},
            Size=			{{ x=200,y=200,z=200 }},
            Dir=			{{ x=1,y=1,z=-0.5 }},
          },
          OnCustomUpdate=windMover,
        },
      },
      audio=
      {
        {
          class="AudioAreaAmbience",
          trigger="Play_rain",
          rtpc="weather_intensity",
          rtpcValue=5,
        },
        {
          class="AudioAreaAmbience",
          trigger="Play_wind",
          rtpc="wind_speed",
          rtpcValue=8.0,
        },
      },
      tod=
      {
        -- method=default lerp, min=totalmin, max=totalmax
        [etod.PARAM_SUN_INTENSITY]=						{0.1, method=emix.MULTIPLY, min=100}, -- lux is logaritmic so decrease by factor 10

        -- Non-Volumetric Fog
        [etod.PARAM_FOG_RADIAL_COLOR_MULTIPLIER]=		{0.1},
        [etod.PARAM_VOLFOG_GLOBAL_DENSITY]=				{0.5, undergroundFactor=_uff, insideFactor=_iff},
        [etod.PARAM_VOLFOG_RAMP_INFLUENCE]=				{0.1, undergroundFactor=_uff, insideFactor=_iff},
        [etod.PARAM_FOG_COLOR_MULTIPLIER]=				{0.3},
        [etod.PARAM_FOG_COLOR2]=						{{ x=150/255, y=175/255, z=190/255 }, constraint=econ.DARKEN, },
        [etod.PARAM_FOG_COLOR2_MULTIPLIER]=				{0.33},
        [etod.PARAM_VOLFOG_HEIGHT2]=					{4000},
        [etod.PARAM_VOLFOG_DENSITY2]=					{0.8, undergroundFactor=_uff, insideFactor=_iff},
        [etod.PARAM_VOLFOG_RADIAL_SIZE]=				{0.5, undergroundFactor=_uff, insideFactor=_iff},

        -- Volumetric Fog
        [etod.PARAM_VOLFOG2_HEIGHT2]=					{10000},
        [etod.PARAM_VOLFOG2_GLOBAL_DENSITY]=			{0.75, method=emix.QUART, undergroundFactor=_uff, insideFactor=_iff},

        [etod.PARAM_CLOUDSHADING_SUNLIGHT_CUSTOM_COLOR_MULTIPLIER] = {0.5},
        [etod.PARAM_SKYLIGHT_SUN_INTENSITY_MULTIPLIER]=	{120},

        [etod.PARAM_COLORGRADING_FILTERS_GRAIN]=		{0.2},
        [etod.PARAM_COLORGRADING_DOF_FOCUSRANGE]=		{200, undergroundFactor=_ufd, insideFactor=_ifd},
        [etod.PARAM_COLORGRADING_DOF_BLURAMOUNT]=		{0.5, method=emix.ADDITIVE, undergroundFactor=_ufd, insideFactor=_ifd},
      },
    },

--------------------------------------------------------------------------------------------
    {
      name="SandStorm",
      probability=2,
      danger=20,
      dangerlimit=25,
      continue={
        ["SandStorm_Tornado"] = 100, -- Continue pattern starts at fade out of this pattern, so blending works
      }, 
      duration={2, 3},
      modifiers = { -- values added to current baseline (faded in and out)
        --          outside, inside, underground, underwater
        light=      {-0.3,    -0.1,               },
        wind=       {20,      10,     2,      1   },
      },
      entities=
      {
        WeatherSirenTriggers[1],
        BellTriggers[1],
        {
          class="WindArea", -- cant be interpolated unless physicalized per frame, but not really needed
          properties=
          {
            --        start, full(default=start), end(default=start)
            bActive=    {1},
            bEllipsoidal= {0},
            Speed=      {4},
            Size=     {{ x=200,y=200,z=200 }},
          },
          OnCustomUpdate=windMover,
        },
      },
      audio=
      {
        {
          class="AudioAreaAmbience",
          trigger="Play_wind",
          rtpc="wind_speed",
          rtpcValue=3.0,
        },
      },
      tod=
      {
        [etod.PARAM_SUN_INTENSITY]=           {0.3, method=emix.MULTIPLY, min=100}, -- lux is logaritmic so half it by decreasing by factor 10
        [etod.PARAM_FOG_RADIAL_COLOR_MULTIPLIER]=   {0.05},

        -- Non-Volumetric Fog
        [etod.PARAM_FOG_COLOR]=            {{ x=222/255, y=202/255, z=134/255 }, constraint=econ.NONE, },
        [etod.PARAM_FOG_COLOR2]=            {{ x=60/255, y=80/255, z=90/255 }, constraint=econ.DARKEN, },
        [etod.PARAM_FOG_COLOR2_MULTIPLIER]=       {0.33},
        [etod.PARAM_VOLFOG_HEIGHT2]=          {2000},
        [etod.PARAM_VOLFOG_DENSITY2]=         {0.8, undergroundFactor=_uff, insideFactor=_iff},
        [etod.PARAM_VOLFOG_RADIAL_SIZE]=        {0.5, undergroundFactor=_uff, insideFactor=_iff},

        -- Volumetric Fog
        [etod.PARAM_VOLFOG2_GLOBAL_DENSITY]=      {0.5, method=emix.QUART, undergroundFactor=_uff, insideFactor=_iff},

        [etod.PARAM_SKYLIGHT_SUN_INTENSITY_MULTIPLIER]= {100},
        [etod.PARAM_CLOUDSHADING_SUNLIGHT_CUSTOM_COLOR_MULTIPLIER] = {0.5},

        [etod.PARAM_COLORGRADING_FILTERS_GRAIN]=    {0.2, undergroundFactor=_ufd, insideFactor=_ifd},
        [etod.PARAM_COLORGRADING_DOF_FOCUSRANGE]=   {300, undergroundFactor=_ufd, insideFactor=_ifd},
        [etod.PARAM_COLORGRADING_DOF_BLURAMOUNT]=   {0.1, undergroundFactor=_ufd, insideFactor=_ifd},
      },
    },

--------------------------------------------------------------------------------------------
    {
      name="SandStorm_Tornado",
      probability=0,
      danger=20,
      duration={7, 10},
      modifiers = { -- values added to current baseline (faded in and out)
        --          outside, inside, underground, underwater
        light=      {-0.5,    -0.2,               },
        wind=       {80,      20,     5,      5   },
        gas_smoke=  {0.04,      0,            },
        physical=    {0.032,      0,            },
      },
      entities=
      {
        BellTriggers[1],
        {
          class="WindArea", -- cant be interpolated unless physicalized per frame, but not really needed
          properties=
          {
            --				start, full(default=start), end(default=start)
            bActive=		{1},
            bEllipsoidal=	{0},
            Speed=			{4},
            Size=			{{ x=200,y=200,z=200 }},
          },
          OnCustomUpdate=windMover,
        },
        {
          class="Tornado",
          networksync=true, -- spawn and handle fully serverside
          properties=
          {
            Radius=					{61}, -- this is the maximum size, after this warnings from entity system occur
            fWanderSpeed=			{0}, -- we want manual control
            fSpinImpulse =			{20.0},
            fAttractionImpulse =	{20.0},
            fUpImpulse =			{30.0},
            fCloudHeight =			{800.0},
          },
          OnCustomUpdate=tornadoMover,
        },
        {
          class="ParticleEffect",
          properties=
          {
            ParticleEffect= {"weather.sandstorm.sandstorm"}, 
            PulsePeriod= {20}, 
            Strength={1.0}, -- Strength={0.0, 1.0, 0.0},
          },
        },
        {
          class="Lightning",
          properties=
          {
            bActive= {1},
            fDistance= {200,75}, -- lightning closes distance to player and then goes away again
            bRelativeToPlayer= {1},
            ["Timing.fDelay"]= {55},
            ["Timing.fDelayVariation"]= {0.6},
            ["Timing.fLightningDuration"]= {0.3},
            ["Effects.LightIntensity"]= {0.4,1.2}, -- increase intensity as it comes closer

            ["Effects.color_SkyHighlightColor"]= {{ x=243/255, y=254/255, z=164/255 }}, -- slightly yellow

            ["Effects.ParticleEffect"]= {"weather.lightning.lightningbolt1"},
            ["Effects.ParticleScale"]= {4,3}, -- have them a bit larger at distance
            ["Effects.SkyHighlightVerticalOffset"]= {75,60},
            ["Effects.SkyHighlightMultiplier"]= {0.3,1},
            ["Audio.audioTriggerPlayTrigger"]= {"Play_thunder"}, 
          },
        },
      },
      audio=
      {
        {
          class="AudioAreaAmbience",
          trigger="Play_wind",
          rtpc="wind_speed",
          rtpcValue=10.0,
          rtpcFunc=function(weather, rtpcVal, ramp, down, progress) return tornadoSoundMoverMinScale(weather, rtpcVal, ramp, down, progress, 0.9) end,
        },
      },
      tod=
      {
        [etod.PARAM_SUN_INTENSITY]=						{0.2, method=emix.MULTIPLY, min=100}, -- lux is logaritmic so decreasing by factor 1000
        [etod.PARAM_FOG_RADIAL_COLOR_MULTIPLIER]=       {0.1},
        [etod.PARAM_SUN_SPECULAR_MULTIPLIER]=           {0.05},

        -- Non-Volumetric Fog
        [etod.PARAM_FOG_COLOR]=                         {{ x=134/255, y=92/255, z=60/255 }, constraint=econ.NONE, },
        [etod.PARAM_FOG_COLOR2]=						{{ x=134/255, y=92/255, z=60/255 }, constraint=econ.NONE, },
        [etod.PARAM_FOG_COLOR2_MULTIPLIER]=				{3.0},
		[etod.PARAM_FOG_COLOR_MULTIPLIER]=				{3.0},
		[etod.PARAM_VOLFOG_HEIGHT]=                     {300},
        [etod.PARAM_VOLFOG_HEIGHT2]=                    {10000},
        [etod.PARAM_VOLFOG_DENSITY2]=					{1.0, undergroundFactor=_uff, insideFactor=_iff},
		[etod.PARAM_VOLFOG_DENSITY]=					{0.5, undergroundFactor=_uff, insideFactor=_iff},
        [etod.PARAM_VOLFOG_RADIAL_SIZE]=				{0.5, undergroundFactor=_uff, insideFactor=_iff},

        -- Volumetric Fog
        [etod.PARAM_VOLFOG2_GLOBAL_DENSITY]=			{0.5, method=emix.QUART, undergroundFactor=_uff, insideFactor=_iff},

        [etod.PARAM_CLOUDSHADING_SUNLIGHT_CUSTOM_COLOR_MULTIPLIER] = {0.5},

        [etod.PARAM_COLORGRADING_FILTERS_GRAIN]=		{1.0, undergroundFactor=_ufd, insideFactor=_ifd},
        [etod.PARAM_COLORGRADING_DOF_FOCUSRANGE]=		{250, undergroundFactor=_ufd, insideFactor=_ifd},
        [etod.PARAM_COLORGRADING_DOF_BLURAMOUNT]=		{0.5, method=emix.ADDITIVE, undergroundFactor=_ufd, insideFactor=_ifd},

        -- color grading
        [etod.PARAM_COLORGRADING_FILTERS_PHOTOFILTER_COLOR]=    {{ x=164/255, y=103/255, z=35/255 }, constraint=econ.NONE, },
        [etod.PARAM_COLORGRADING_FILTERS_PHOTOFILTER_DENSITY]=  {0.278, undergroundFactor=_ufc, insideFactor=_ifc},
      },
    },

--------------------------------------------------------------------------------------------
    {
      name="LightFog",
      probability=1.5,
      danger=10,
      dangerlimit=40,
      todlimit={3,11}, -- pattern can only spawn between those times
      duration={8, 10},
      ramp={0.2, 0.4}, -- use 20% fade-in and 40% fade-out for fog
      modifiers = { -- values added to current baseline (faded in and out)
        --          outside, inside, underground, underwater
        humidity=   {0.15,    0.1,    0.1,        },
        light=      {-0.2,    -0.1,               },
        temperature={-4,      -1,                 },
      },
      entities={
        {
          class="ParticleEffect",
          properties=
          {
            ParticleEffect= {"weather.fog.fog_light"}, 
            PulsePeriod= {20}, 
            Strength={1.0}, -- Strength={0.0, 1.0},
          },
        },
      },
      audio={
        {
          class="AudioAreaAmbience",
          trigger="Play_wind",
          rtpc="wind_speed",
          rtpcValue=0.3,
        },
      },
      tod=
      {
        [etod.PARAM_SUN_INTENSITY]=						{0.2, method=emix.MULTIPLY, min=100}, -- lux is logaritmic so half it by decreasing by factor 10
        [etod.PARAM_FOG_RADIAL_COLOR_MULTIPLIER]=		{0.1},

        -- Non-Volumetric Fog
        [etod.PARAM_VOLFOG_GLOBAL_DENSITY]=				{0.5, undergroundFactor=_uff, insideFactor=_iff},
        [etod.PARAM_VOLFOG_RAMP_INFLUENCE]=				{0.5, undergroundFactor=_uff, insideFactor=_iff},
        [etod.PARAM_VOLFOG_HEIGHT_OFFSET]=				{1.0, undergroundFactor=_uff},

        -- Volumetric Fog
        [etod.PARAM_VOLFOG2_GLOBAL_DENSITY]=			{0.25, method=emix.QUART, undergroundFactor=_uff, insideFactor=_iff},

        [etod.PARAM_SKYLIGHT_SUN_INTENSITY_MULTIPLIER]=	{10},

        [etod.PARAM_COLORGRADING_FILTERS_GRAIN]=		{0.3},
        [etod.PARAM_COLORGRADING_DOF_FOCUSRANGE]=		{350, undergroundFactor=_ufd, insideFactor=_ifd},
        [etod.PARAM_COLORGRADING_DOF_BLURAMOUNT]=		{0.15, method=emix.ADDITIVE, undergroundFactor=_ufd, insideFactor=_ifd},
      },
    },

--------------------------------------------------------------------------------------------
    {
      name="HeatWave",
      probability=3.5,
      danger=25,
      dangerlimit=26,
      todlimit={6,18}, -- pattern can only spawn between those times
      duration={12, 22},
      ramp={0.2, 0.4}, -- use 20% fade-in and 40% fade-out for fog
      modifiers = { -- values added to current baseline (faded in and out)
        --          outside, inside, underground, underwater
        humidity=   {-0.15,    -0.1,    0.1,        },
        light=      {0.5,    0.1,               },
        temperature={13,      2,                 },
      },
      entities={},
      audio={
        {
          class="AudioAreaAmbience",
          trigger="Play_wind",
          rtpc="wind_speed",
          rtpcValue=0.2,
        },
      },
      tod=
      {
        [etod.PARAM_SUN_INTENSITY]=           {5, method=emix.MULTIPLY}, -- lux is logaritmic 
        [etod.PARAM_SKYLIGHT_SUN_INTENSITY_MULTIPLIER]= {2, method=emix.MULTIPLY},
        [etod.PARAM_CLOUDSHADING_SUNLIGHT_CUSTOM_COLOR_MULTIPLIER] = {1}, -- less cloudcover
      },
    },
   
--------------------------------------------------------------------------------------------
    {
      name="Rainbow",
      probability=0, -- this pattern is exclusively triggered as followup pattern
      danger=-2,
      duration={5, 8},
      todlimit={7,18}, -- pattern can only spawn between those times (Default: 0, 24 for no limit)
      modifiers = { -- values added to current baseline (faded in and out)
        --          outside, inside, underground, underwater
        humidity=   {0.15,    0.1,                },
        rain=       {0.05,                        },
        temperature={-1,      -1,                 },
      },
      entities=
      {
        {
          class="ParticleEffect",
          pos={ x=2000, y=2000, z=350 }, -- override normal spawn pos which is somewhere in center of map
          properties=
          {
            ParticleEffect= {"weather.rainbow.quarter_normal"},
          },
        },
      },
      audio={
        {
          class="AudioAreaAmbience",
          trigger="Play_wind",
          rtpc="wind_speed",
          rtpcValue=0.3,
        },
      },
    },

--------------------------------------------------------------------------------------------
    {
      name="RainbowHalf",
      probability=0, -- this pattern is exclusively triggered as followup pattern
      danger=-2,
      duration={5, 8},
      todlimit={7,18}, -- pattern can only spawn between those times (Default: 0, 24 for no limit)
      modifiers = { -- values added to current baseline (faded in and out)
        --          outside, inside, underground, underwater
        humidity=   {0.15,    0.1,                },
        rain=       {0.05,                        },
        temperature={-1,      -1,                 },
      },
      entities=
      {
        {
          class="ParticleEffect",
          pos={ x=2000, y=2000, z=350 }, -- override normal spawn pos which is somewhere in center of map
          properties=
          {
            ParticleEffect= {"weather.rainbow.half_normal"},
          },
        },
      },
      audio={
        {
          class="AudioAreaAmbience",
          trigger="Play_wind",
          rtpc="wind_speed",
          rtpcValue=0.3,
        },
      },
    },

--------------------------------------------------------------------------------------------
    {
      name="RadStorm", -- Intro pattern
      probability=1,
      danger=45,
      dangerlimit=40,
      duration={2.5, 4},
      continue={
        ["RadStorm_Peak"] = 100, -- Continue pattern starts at fade out of this pattern, so blending works
      }, 
      ramp={0.5, 0.1}, -- use 50% fade-in and 10% fade-out (mix into new effect)
      modifiers = { -- values added to current baseline (faded in and out)
        --               outside, inside, underground, underwater
        humidity=       {0.1,     0.1,    0.1,        },
        light=          {-0.2,    -0.1,               },
        temperature=    {2,       2,                  },
        gas_radiation=  {0.032,      0.02,            },
        rain_radiation= {0.01,      0.0,              },
        ray_radiation= {0.002,       0.004,           },
        geigercounter=  {2,        1.75,    0.0,    1  },
      },
      entities=
      {
        NukeSirenTriggers[1],
        {
          class="Lightning",
          properties=
          {
            bActive= {1},
            fDistance= {1000,300,300}, -- lightning closes distance to player and then stays
            bRelativeToPlayer= {1},
            ["Timing.fDelay"]= {50},
            ["Timing.fDelayVariation"]= {0.75},
            ["Timing.fLightningDuration"]= {0.4},
            ["Effects.LightIntensity"]= {0.2,0.4,0.4}, -- increase intensity as it comes closer leave it

            ["Effects.color_SkyHighlightColor"]= {{ x=218/255, y=248/255, z=165/255 }}, -- slightly green

            ["Effects.ParticleEffect"]= {"weather.lightning.lightningbolt1"},
            ["Effects.ParticleScale"]= {4,3}, -- have them a bit larger at distance
            ["Effects.SkyHighlightVerticalOffset"]= {400,80,80},
            ["Effects.SkyHighlightMultiplier"]= {0.2,0.3,0.3},
            ["Audio.audioTriggerPlayTrigger"]= {"Play_nuclear_thunder"},
          },
        },
        {
          class="Lightning",
          properties=
          {
            bActive= {1},
            fDistance= {1000,200,200}, -- lightning closes distance to player and then stays
            bRelativeToPlayer= {1},
            ["Timing.fDelay"]= {30},
            ["Timing.fDelayVariation"]= {0.6},
            ["Timing.fLightningDuration"]= {0.3},
            ["Effects.LightIntensity"]= {0.2,0.4,0.4}, -- increase intensity as it comes closer leave it

            ["Effects.color_SkyHighlightColor"]= {{ x=243/255, y=254/255, z=164/255 }}, -- slightly yellow

            ["Effects.ParticleEffect"]= {"weather.lightning.lightningbolt2"},
            ["Effects.ParticleScale"]= {4,3}, -- have them a bit larger at distance
            ["Effects.SkyHighlightVerticalOffset"]= {300,75,75},
            ["Effects.SkyHighlightMultiplier"]= {0.2,0.3,0.3},
            ["Audio.audioTriggerPlayTrigger"]= {"Play_thunder"},
          },
        },
        {
          class="WindArea", -- cant be interpolated unless physicalized per frame, but not really needed
          properties=
          {
            --        start,  full(default=start), end(default=start)
            bActive=    {1},
            bEllipsoidal= {0},
            Speed=      {3},
            Size=     {{ x=200,y=200,z=200 }},
          },
          OnCustomUpdate=windMover,
        },
      },
      audio={
        {
          class="AudioAreaAmbience",
          trigger="Play_wind",
          rtpc="wind_speed",
          rtpcValue=6.0,
        },
      },
      tod=
      {
        [etod.PARAM_SUN_INTENSITY]=                 {0.6, method=emix.MULTIPLY, min=100}, -- lux is logaritmic so half it by decreasing by factor 10, for intro have it only slightly lower

        [etod.PARAM_CLOUDSHADING_SUNLIGHT_CUSTOM_COLOR_MULTIPLIER] = {0.5},

        -- Non-Volumetric Fog
        [etod.PARAM_VOLFOG_GLOBAL_DENSITY]=         {2.0, undergroundFactor=_uff, insideFactor=_iff},
        [etod.PARAM_VOLFOG_DENSITY]=                {0.6, undergroundFactor=_uff, insideFactor=_iff},
        [etod.PARAM_FOG_COLOR_MULTIPLIER]=          {0.3},
        [etod.PARAM_FOG_COLOR2_MULTIPLIER]=         {0.3},

        [etod.PARAM_FOG_COLOR]=                     {{ x=61/255, y=68/255, z=26/255 }, constraint=econ.DARKEN }, -- bottom
        [etod.PARAM_FOG_COLOR2]=                    {{ x=119/255, y=126/255, z=54/255 }, constraint=econ.DARKEN }, -- top
        [etod.PARAM_VOLFOG_RAMP_INFLUENCE]=         {0.01, undergroundFactor=_uff, insideFactor=_iff},
        [etod.PARAM_VOLFOG_HEIGHT_OFFSET]=          {0.1, undergroundFactor=_uff},
        [etod.PARAM_VOLFOG_FINAL_DENSITY_CLAMP]=        {0.9, undergroundFactor=_ufd, insideFactor=_ifd}, -- allow look through
		[etod.PARAM_SKYLIGHT_SUN_INTENSITY_MULTIPLIER]= {1000},

        -- color grading
        [etod.PARAM_COLORGRADING_FILTERS_PHOTOFILTER_COLOR]=    {{ x=199/255, y=247/255, z=79/255 }, constraint=econ.BRIGTHEN, },
        [etod.PARAM_COLORGRADING_FILTERS_PHOTOFILTER_DENSITY]=  {0.1, undergroundFactor=_ufc, insideFactor=_ifc},
      },
    },

--------------------------------------------------------------------------------------------
    {
      name="RadStorm_Peak",
      probability=0,
      danger=40,
      duration={1.5, 3},
      continue={
        ["RadStorm_Outro"] = 100, -- Continue pattern starts at fade out of this pattern, so blending works
      }, 
      ramp={0.15, 0.2}, -- use 15% fade-in and 20% fade-out for fog
      modifiers = { -- values added to current baseline (faded in and out)
        --          outside, inside, underground, underwater
        humidity=       {0.3,     0.2,    0.15,       },
        light=          {-0.4,    -0.25,              },
        temperature=    {10,      5,                  },
        physical=       {0.1,       0.025,              },
        gas_radiation=  {0.56,       0.15,              },
        rain_radiation= {0.19,       0.0,              },
        ray_radiation= {0.05,       0.02,              },
        geigercounter=  {3,        2.75,    0.0,    1  },
      },
      entities=
      {
        BellTriggers[1],
        {
          class="ParticleEffect",
          properties=
          {
            ParticleEffect= {"weather.radstorm.radstorm"}, 
            PulsePeriod= {20}, 
            Strength={1.0}, -- Strength={0.0, 1.0, 0.0},
          },
        },
        {
          class="Lightning",
          properties=
          {
            bActive= {1},
            fDistance= {300,100}, -- lightning closes distance to player and then goes away again
            bRelativeToPlayer= {1},
            ["Timing.fDelay"]= {10},
            ["Timing.fDelayVariation"]= {0.75},
            ["Timing.fLightningDuration"]= {0.4},
            ["Effects.LightIntensity"]= {0.4,1.2}, -- increase intensity as it comes closer

            ["Effects.color_SkyHighlightColor"]= {{ x=218/255, y=248/255, z=165/255 }}, -- slightly green

            ["Effects.ParticleEffect"]= {"weather.lightning.lightningbolt1"},
            ["Effects.ParticleScale"]= {4,3}, -- have them a bit larger at distance
            ["Effects.SkyHighlightVerticalOffset"]= {100,80},
            ["Effects.SkyHighlightMultiplier"]= {0.3,1},
            ["Audio.audioTriggerPlayTrigger"]= {"Play_nuclear_thunder"},
          },
        },
        {
          class="Lightning",
          properties=
          {
            bActive= {1},
            fDistance= {200,75}, -- lightning closes distance to player and then goes away again
            bRelativeToPlayer= {1},
            ["Timing.fDelay"]= {7},
            ["Timing.fDelayVariation"]= {0.6},
            ["Timing.fLightningDuration"]= {0.3},
            ["Effects.LightIntensity"]= {0.4,1.2}, -- increase intensity as it comes closer

            ["Effects.color_SkyHighlightColor"]= {{ x=243/255, y=254/255, z=164/255 }}, -- slightly yellow

            ["Effects.ParticleEffect"]= {"weather.lightning.lightningbolt2"},
            ["Effects.ParticleScale"]= {4,3}, -- have them a bit larger at distance
            ["Effects.SkyHighlightVerticalOffset"]= {75,60},
            ["Effects.SkyHighlightMultiplier"]= {0.3,1},
            ["Audio.audioTriggerPlayTrigger"]= {"Play_thunder"}, 
          },
        },
        {
          class="Lightning",
          properties=
          {
            bActive= {1},
            fDistance= {100,30}, -- lightning closes distance to player and then goes away again
            bRelativeToPlayer= {1},
            ["Timing.fDelay"]= {7},
            ["Timing.fDelayVariation"]= {0.6},
            ["Timing.fLightningDuration"]= {0.2},
            ["Effects.LightIntensity"]= {0.4,1.2}, -- increase intensity as it comes closer

            ["Effects.color_SkyHighlightColor"]= {{ x=243/255, y=254/255, z=164/255 }}, -- slightly yellow

            ["Effects.ParticleEffect"]= {"weather.lightning.lightningbolt1"},
            ["Effects.ParticleScale"]= {4,3}, -- have them a bit larger at distance
            ["Effects.SkyHighlightVerticalOffset"]= {40,30},
            ["Effects.SkyHighlightMultiplier"]= {0.3,1},
            ["Audio.audioTriggerPlayTrigger"]= {"Play_nuclear_thunder"},
          },
        },
        {
          class="WindArea", -- cant be interpolated unless physicalized per frame, but not really needed
          properties=
          {
            --        start,  full(default=start), end(default=start)
            bActive=    {1},
            bEllipsoidal= {0},
            Speed=      {4},
            Size=     {{ x=200,y=200,z=200 }},
          },
          OnCustomUpdate=windMover,
        },
      },
      audio={
        {
          class="AudioAreaAmbience",
          trigger="Play_wind",
          rtpc="wind_speed",
          rtpcValue=20.0,
        },
      },
      tod=
      {
        [etod.PARAM_SUN_INTENSITY]=                 {0.1, method=emix.MULTIPLY, min=100}, -- lux is logaritmic so half it by decreasing by factor 10
        [etod.PARAM_FOG_RADIAL_COLOR_MULTIPLIER]=   {0.1},
        [etod.PARAM_SUN_SPECULAR_MULTIPLIER]=       {0.05},
        [etod.PARAM_SUN_COLOR]=                     {{ x=208/255, y=255/255, z=144/255 }, constraint=econ.DARKEN, }, -- slightly greenish light
        [etod.PARAM_NIGHSKY_MOON_COLOR]=            {{ x=208/255, y=255/255, z=144/255 }, constraint=econ.DARKEN, }, -- slightly greenish light

        [etod.PARAM_CLOUDSHADING_SUNLIGHT_CUSTOM_COLOR_MULTIPLIER] = {0.5},

        -- Non-Volumetric Fog
        [etod.PARAM_VOLFOG_GLOBAL_DENSITY]=         {7.0, undergroundFactor=_uff, insideFactor=_iff},
        [etod.PARAM_VOLFOG_DENSITY]=                {0.9, undergroundFactor=_uff, insideFactor=_iff},
        [etod.PARAM_FOG_COLOR_MULTIPLIER]=          {0.9},
        [etod.PARAM_FOG_COLOR2_MULTIPLIER]=         {0.9},
		[etod.PARAM_VOLFOG_HEIGHT2]=                {20000},

        [etod.PARAM_FOG_COLOR]=                     {{ x=61/255, y=68/255, z=10/255 }, constraint=econ.DARKEN }, -- bottom
        [etod.PARAM_FOG_COLOR2]=                    {{ x=61/255, y=68/255, z=10/255 }, constraint=econ.DARKEN }, -- top
        [etod.PARAM_VOLFOG_RAMP_INFLUENCE]=         {0.01, undergroundFactor=_uff, insideFactor=_iff},
        [etod.PARAM_VOLFOG_HEIGHT_OFFSET]=          {0.1, undergroundFactor=_uff},
        [etod.PARAM_VOLFOG_FINAL_DENSITY_CLAMP]=        {0.997, undergroundFactor=_uff, insideFactor=_iff}, -- allow look through at least a bit always

        -- Volumetric Fog
        --[etod.PARAM_VOLFOG2_GLOBAL_DENSITY]=      {2.0, method=emix.QUART},

        [etod.PARAM_COLORGRADING_FILTERS_PHOTOFILTER_COLOR]=    {{ x=199/255, y=247/255, z=79/255 }, constraint=econ.BRIGTHEN, },
        [etod.PARAM_COLORGRADING_FILTERS_PHOTOFILTER_DENSITY]=  {1.0, undergroundFactor=_ufc, insideFactor=_ifc},

        [etod.PARAM_COLORGRADING_FILTERS_GRAIN]=    {1.0},
        [etod.PARAM_COLORGRADING_DOF_FOCUSRANGE]=   {10, undergroundFactor=_ufd, insideFactor=_ifd},
        [etod.PARAM_COLORGRADING_DOF_BLURAMOUNT]=   {1.0, method=emix.ADDITIVE, undergroundFactor=_ufd, insideFactor=_ifd},

        [etod.PARAM_SUN_RAYS_VISIBILITY]=       {0.4},
      },
    },

--------------------------------------------------------------------------------------------
    {
      name="RadStorm_Outro",
      probability=0,
      danger=10,
      duration={2,3},
      continue={
        -- Continue pattern starts at fade out of current pattern (so both are active some time)
        ["LightRain"] = 5,
      }, 
      ramp={0.05, 0.6}, -- use 5% fade-in and 60% fade-out for fog
      modifiers = { -- values added to current baseline (faded in and out)
        --          outside, inside, underground, underwater
        humidity=       {0.1,       0.1,    0.1,        },
        light=          {-0.2,      -0.1,               },
        temperature=    {2,             2,              },
        gas_radiation=  {0.08,       0.02,              },
        rain_radiation= {0.02,       0.0,              },
        ray_radiation=  {0.01,       0.005,              },
        geigercounter=  {1,        0.75,    0.0,    0.5  },
      },
      entities={
        {
          class="ParticleEffect",
          properties=
          {
            ParticleEffect= {"weather.ash.slow_ash"},
            PulsePeriod= {0},
            Strength={1.0}, -- Strength={1.0, 1.0, 0.0},
          },
        },
        {
          class="Lightning",
          properties=
          {
            bActive= {1},
            fDistance= {300,1000,1000}, -- lightning closes distance to player and then stays
            bRelativeToPlayer= {1},
            ["Timing.fDelay"]= {50},
            ["Timing.fDelayVariation"]= {0.75},
            ["Timing.fLightningDuration"]= {0.4},
            ["Effects.LightIntensity"]= {0.4,0.2}, -- increase intensity as it comes closer leave it

            ["Effects.color_SkyHighlightColor"]= {{ x=218/255, y=248/255, z=165/255 }}, -- slightly green

            ["Effects.ParticleEffect"]= {"weather.lightning.lightningbolt1"},
            ["Effects.ParticleScale"]= {3,4}, -- have them a bit larger at distance
            ["Effects.SkyHighlightVerticalOffset"]= {80,400},
            ["Effects.SkyHighlightMultiplier"]= {0.3,0.2},
            ["Audio.audioTriggerPlayTrigger"]= {"Play_thunder"},
          },
        },
        {
          class="Lightning",
          properties=
          {
            bActive= {1},
            fDistance= {200,1000,1000}, -- lightning closes distance to player and then stays
            bRelativeToPlayer= {1},
            ["Timing.fDelay"]= {30},
            ["Timing.fDelayVariation"]= {0.6},
            ["Timing.fLightningDuration"]= {0.3},
            ["Effects.LightIntensity"]= {0.4,0.2}, -- increase intensity as it comes closer leave it

            ["Effects.color_SkyHighlightColor"]= {{ x=243/255, y=254/255, z=164/255 }}, -- slightly yellow

            ["Effects.ParticleEffect"]= {"weather.lightning.lightningbolt2"},
            ["Effects.ParticleScale"]= {3,4}, -- have them a bit larger at distance
            ["Effects.SkyHighlightVerticalOffset"]= {75,300},
            ["Effects.SkyHighlightMultiplier"]= {0.3,0.2},
            ["Audio.audioTriggerPlayTrigger"]= {"Play_nuclear_thunder"}, 
          },
        },
        {
          class="WindArea", -- cant be interpolated unless physicalized per frame, but not really needed
          properties=
          {
            --        start,  full(default=start), end(default=start)
            bActive=    {1},
            bEllipsoidal= {0},
            Speed=      {2},
            Size=     {{ x=200,y=200,z=200 }},
          },
          OnCustomUpdate=windMover,
        },
      },
      audio={
        {
          class="AudioAreaAmbience",
          trigger="Play_wind",
          rtpc="wind_speed",
          rtpcValue=3.0,
        },
      },
      tod=
      {
        [etod.PARAM_SUN_INTENSITY]=                 {0.8, method=emix.MULTIPLY, min=100}, -- lux is logaritmic so half it by decreasing by factor 10, for intro have it only slightly lower

        -- Non-Volumetric Fog
        [etod.PARAM_VOLFOG_GLOBAL_DENSITY]=         {1.5, undergroundFactor=_uff, insideFactor=_iff},
        [etod.PARAM_VOLFOG_DENSITY]=                {0.5, undergroundFactor=_uff, insideFactor=_iff},
        [etod.PARAM_FOG_COLOR_MULTIPLIER]=          {0.3},
        [etod.PARAM_FOG_COLOR2_MULTIPLIER]=         {0.3},

        [etod.PARAM_FOG_COLOR]=                     {{ x=61/255, y=68/255, z=26/255 }, constraint=econ.DARKEN }, -- bottom
        [etod.PARAM_FOG_COLOR2]=                    {{ x=119/255, y=126/255, z=54/255 }, constraint=econ.DARKEN }, -- top
        [etod.PARAM_VOLFOG_RAMP_INFLUENCE]=         {0.01, undergroundFactor=_uff, insideFactor=_iff},
        [etod.PARAM_VOLFOG_HEIGHT_OFFSET]=          {0.1, undergroundFactor=_uff},
        [etod.PARAM_VOLFOG_FINAL_DENSITY_CLAMP]=        {0.9, undergroundFactor=_uff, insideFactor=_iff}, -- allow look through
		[etod.PARAM_SKYLIGHT_SUN_INTENSITY_MULTIPLIER]= {1000},

        -- color grading
        [etod.PARAM_COLORGRADING_FILTERS_PHOTOFILTER_COLOR]=    {{ x=199/255, y=247/255, z=79/255 }, constraint=econ.BRIGTHEN, },
        [etod.PARAM_COLORGRADING_FILTERS_PHOTOFILTER_DENSITY]=  {0.15, undergroundFactor=_ufc, insideFactor=_ifc},
      },
    },

--------------------------------------------------------------------------------------------
    {
      name="NuclearFlashFreeze",
      probability=2,
      danger=45,
      dangerlimit=40,
      duration={3, 4},
      continue={
        ["NuclearFlashFreeze_Peak"] = 100, -- Continue pattern starts at fade out of this pattern, so blending works
      }, 
      ramp={0.3, 0.05}, -- use 30% fade-in and 5% fade-out
      modifiers = { -- values added to current baseline (faded in and out)
        --              outside, inside, underground, underwater
        humidity=       {0.3,       0.2,    0.15,         },
        light=          {-0.4,      -0.25,                },
        temperature=    {-30,       -25,       -13,    -16   },
        gas_radiation=  {0.0075,     0.002,                },
        rain_radiation= {0.015,      0.01,                },
        geigercounter=  {1,          0.75,    0.0,    1  },
      },
      entities={
        {
          class="Snow",
          pos={ x=4096, y=4096, z=450 }, -- center of map
          properties=
          {
            bEnabled= {1},
            fRadius= {8000}, -- whole map
            ["SnowFall.nSnowFlakeCount"]= {0},
            ["Surface.fSnowAmount"]= {0.0},
            ["Surface.fFrostAmount"]= {0.0,0.8,0.8},
            ["Surface.fSurfaceFreezing"]= {0.0,0.05,0.05},
          },
        },
        {
          class="WindArea", -- cant be interpolated unless physicalized per frame, but not really needed
          properties=
          {
            --        start,  full(default=start), end(default=start)
            bActive=    {1},
            bEllipsoidal= {0},
            Speed=      {1.5},
            Size=     {{ x=200,y=200,z=200 }},
          },
          OnCustomUpdate=windMover,
        },
      },
      audio={
        {
          class="AudioAreaAmbience",
          trigger="Play_wind",
          rtpc="wind_speed",
          rtpcValue=2.0,
        },
        {
          class="AudioAreaAmbience",
          trigger="Play_nuclear_winter",
          rtpc="freeze_strength",
          rtpcValue=1.0,
        },
      },
      tod=
      {
        -- Sun
        [etod.PARAM_SUN_INTENSITY]=                 {0.1, method=emix.MULTIPLY, min=100}, -- lux is logaritmic so half it by decreasing by factor 10, for intro have it only slightly lower
        [etod.PARAM_FOG_RADIAL_COLOR]=              {{ x=48/255, y=67/255, z=110/255 } }, -- saturated grey blue
        [etod.PARAM_FOG_RADIAL_COLOR_MULTIPLIER]=   {0.734},

        -- Colorgrading
        [etod.PARAM_COLORGRADING_FILTERS_PHOTOFILTER_COLOR]=    {{ x=4/255, y=2/255, z=62/255 }, }, -- dark blue
        [etod.PARAM_COLORGRADING_FILTERS_PHOTOFILTER_DENSITY]=  {0.25},

        -- Filters
        [etod.PARAM_COLORGRADING_DOF_BLURAMOUNT]=   {0.2, method=emix.ADDITIVE},
      },
    },

--------------------------------------------------------------------------------------------
    {
      name="NuclearFlashFreeze_Peak",
      probability=0,
      danger=20,
      duration={3, 5},
      continue={
        ["NuclearFlashFreeze_Outro"] = 100, -- Continue pattern starts at fade out of this pattern, so blending works
      }, 
      ramp={0.1, 0.1}, -- use 10% fade-in and 10% fade-out for fog
      modifiers = { -- values added to current baseline (faded in and out)
        --          outside, inside, underground, underwater
        humidity=       {0.3,     0.2,    0.15,       },
        light=          {-0.4,    -0.25,              },
        temperature=    {-45,     -35,    -18,    -31  },
        gas_radiation=  {0.05,     0.02,              },
        rain_radiation= {0.15,     0.04,              },
        ray_radiation=  {0.01,     0.005,              },
        geigercounter=  {1.5,      0.75,    0.0,    1  },
      },
      entities={
        {
          class="ParticleEffect",
          properties=
          {
            ParticleEffect= {"weather.ash.slow_ash"},
            PulsePeriod= {0},
            Strength={1.0}, -- Strength={0.0, 1.0, 1.0},
          },
        },
        {
          class="Lightning",
          properties=
          {
            bActive= {1},
            fDistance= {600,500}, -- lightning closes distance to player and then goes away again
            bRelativeToPlayer= {1},
            ["Timing.fDelay"]= {45},
            ["Timing.fDelayVariation"]= {0.75},
            ["Timing.fLightningDuration"]= {0.2},
            ["Effects.LightIntensity"]= {0.4,1.0}, -- increase intensity as it comes closer

            ["Effects.color_SkyHighlightColor"]= {{ x=253/255, y=56/255, z=6/255 }}, -- orange/red

            ["Effects.ParticleEffect"]= {"weather.lightning.lightningbolt1"},
            ["Effects.ParticleScale"]= {4,3}, -- have them a bit larger at distance
            ["Effects.SkyHighlightVerticalOffset"]= {300,250},
            ["Effects.SkyHighlightMultiplier"]= {1},
            ["Audio.audioTriggerPlayTrigger"]= {"Play_nuclear_thunder"},
          },
        },
        {
          class="Snow",
          pos={ x=4096, y=4096, z=450 }, -- center of map
          properties=
          {
            bEnabled= {1},
            fRadius= {8000}, -- whole map
            ["SnowFall.nSnowFlakeCount"]= {50,0,0},
            --["Surface.fSnowAmount"]= {0.0,0.5},
            --["Surface.fFrostAmount"]= {0.0,0.8},
            --["Surface.fSurfaceFreezing"]= {0.0,0.05},
            ["Surface.fSnowAmount"]= {0.0,0.7},
            ["Surface.fFrostAmount"]= {0.8,1.0},
            ["Surface.fSurfaceFreezing"]= {0.05,0.1},
          },
        },
        {
          class="WindArea", -- cant be interpolated unless physicalized per frame, but not really needed
          properties=
          {
            --        start,  full(default=start), end(default=start)
            bActive=    {1},
            bEllipsoidal= {0},
            Speed=      {2},
            Size=     {{ x=200,y=200,z=200 }},
          },
          OnCustomUpdate=windMover,
        },
      },
      audio={
        {
          class="AudioAreaAmbience",
          trigger="Play_wind",
          rtpc="wind_speed",
          rtpcValue=3.0,
        },
        {
          class="AudioAreaAmbience",
          trigger="Play_nuclear_winter",
          rtpc="freeze_strength",
          rtpcValue=2.0,
        },
      },
      tod=
      {
        -- Sun
        [etod.PARAM_SUN_INTENSITY]=                 {2500, method=emix.QUART}, -- lux is logaritmic so half it by decreasing by factor 10
        [etod.PARAM_FOG_RADIAL_COLOR]=              {{ x=48/255, y=67/255, z=110/255 } }, -- saturated grey blue
        [etod.PARAM_FOG_RADIAL_COLOR_MULTIPLIER]=   {0.734},
        [etod.PARAM_SUN_SPECULAR_MULTIPLIER]=       {0.1},
        [etod.PARAM_SUN_COLOR]=                     {{ x=7/255, y=7/255, z=11/255 }, method=emix.QUART}, -- dark blue

        -- Moon
        [etod.PARAM_NIGHSKY_MOON_COLOR]=                {{ x=179/255, y=183/255, z=255/255 }, }, -- brigth blue/white
        [etod.PARAM_NIGHSKY_MOON_INNERCORONA_COLOR]=    {{ x=109/255, y=99/255, z=252/255 }, }, -- bright purple/white
        [etod.PARAM_NIGHSKY_MOON_OUTERCORONA_COLOR]=    {{ x=10/255, y=150/255, z=190/255 }, }, -- cyan

        -- Skylight
        [etod.PARAM_SKYLIGHT_SUN_INTENSITY]=            {{ x=1/255, y=1/255, z=1/255 }, method=emix.QUART }, -- black

        -- Non-Volumetric Fog
        [etod.PARAM_VOLFOG_GLOBAL_DENSITY]=         {0.25, undergroundFactor=_uff, insideFactor=_iff},
        [etod.PARAM_VOLFOG_DENSITY]=                {0.9, undergroundFactor=_uff, insideFactor=_iff},
        [etod.PARAM_FOG_COLOR_MULTIPLIER]=          {0.9},
        [etod.PARAM_FOG_COLOR2_MULTIPLIER]=         {0.9},

        [etod.PARAM_FOG_COLOR]=                     {{ x=29/255, y=55/255, z=117/255 } }, -- bottom
        [etod.PARAM_FOG_COLOR2]=                    {{ x=0/255, y=0/255, z=0/255 } }, -- top
        [etod.PARAM_VOLFOG_RAMP_INFLUENCE]=         {0, undergroundFactor=_uff, insideFactor=_iff},
        [etod.PARAM_VOLFOG_HEIGHT_OFFSET]=          {0, undergroundFactor=_uff},
        [etod.PARAM_VOLFOG_FINAL_DENSITY_CLAMP]=    {0.09, undergroundFactor=_uff, insideFactor=_iff},

        -- Volumetric Fog
        --[etod.PARAM_VOLFOG2_GLOBAL_DENSITY]=      {2.0, method=emix.QUART},

        -- Skybox
        [etod.PARAM_CLOUDSHADING_SUNLIGHT_MULTIPLIER]=                {1.0},
        [etod.PARAM_CLOUDSHADING_SUNLIGHT_CUSTOM_COLOR]=              {{ x=23/255, y=37/255, z=94/255 }, }, -- dark blue
        [etod.PARAM_CLOUDSHADING_SUNLIGHT_CUSTOM_COLOR_MULTIPLIER]=   {1.0},
        [etod.PARAM_CLOUDSHADING_SUNLIGHT_CUSTOM_COLOR_INFLUENCE]=    {0.194},

        -- Colorgrading
        [etod.PARAM_COLORGRADING_FILTERS_PHOTOFILTER_COLOR]=    {{ x=4/255, y=2/255, z=62/255 }, }, -- dark blue
        [etod.PARAM_COLORGRADING_FILTERS_PHOTOFILTER_DENSITY]=  {0.8, undergroundFactor=_ufc, insideFactor=_ifc},

        -- Filters
        [etod.PARAM_COLORGRADING_FILTERS_GRAIN]=    {0.8},
        [etod.PARAM_COLORGRADING_DOF_FOCUSRANGE]=   {50, undergroundFactor=_ufd, insideFactor=_ifd},
        [etod.PARAM_COLORGRADING_DOF_BLURAMOUNT]=   {0.2, method=emix.ADDITIVE, undergroundFactor=_ufd, insideFactor=_ifd},
      },
    },

--------------------------------------------------------------------------------------------
    {
      name="NuclearFlashFreeze_Outro",
      probability=0,
      danger=5,
      duration={1, 2},
      continue={}, 
      ramp={0.05, 0.3}, -- use 5% fade-in and 30%  fade-out
      modifiers = { -- values added to current baseline (faded in and out)
        --              outside, inside, underground, underwater
        humidity=       {0.3,     0.2,    0.15,           },
        light=          {-0.4,    -0.25,                  },
        temperature=    {-20,     -5,    -3,    -17       },
        gas_radiation=  {0.01,       0.01,                },
        rain_radiation= {0.02,       0.02,                },
        ray_radiation=  {0.02,       0.02,                },
        geigercounter=  {0.75,       0.75,    0.0,    1  },
      },
      entities={
        {
          class="ParticleEffect",
          properties=
          {
            ParticleEffect= {"weather.ash.slow_ash"},
            PulsePeriod= {0},
            Strength={1.0}, -- Strength={1.0, 1.0, 0.0},
          },
        },
        {
          class="Snow",
          pos={ x=4096, y=4096, z=450 }, -- center of map
          properties=
          {
            bEnabled= {1},
            fRadius= {8000}, -- whole map
            ["SnowFall.nSnowFlakeCount"]= {0},
            ["Surface.fSnowAmount"]= {0.7,0.1,0.0},
            ["Surface.fFrostAmount"]= {1.0,0.9,0.0},
            ["Surface.fSurfaceFreezing"]= {0.1,0.05,0.0},
          },
        },
        {
          class="WindArea", -- cant be interpolated unless physicalized per frame, but not really needed
          properties=
          {
            --        start,  full(default=start), end(default=start)
            bActive=    {1},
            bEllipsoidal= {0},
            Speed=      {1.5},
            Size=     {{ x=200,y=200,z=200 }},
          },
          OnCustomUpdate=windMover,
        },
      },
      audio={
        {
          class="AudioAreaAmbience",
          trigger="Play_wind",
          rtpc="wind_speed",
          rtpcValue=1.0,
        },
        {
          class="AudioAreaAmbience",
          trigger="Play_nuclear_winter",
          rtpc="freeze_strength",
          rtpcValue=-0.5,
        },
      },
      tod=
      {
        -- Sun
        [etod.PARAM_SUN_INTENSITY]=                 {0.8, method=emix.MULTIPLY, min=100}, -- lux is logaritmic so half it by decreasing by factor 10, for intro have it only slightly lower
        [etod.PARAM_FOG_RADIAL_COLOR]=              {{ x=48/255, y=67/255, z=110/255 } }, -- saturated grey blue
        [etod.PARAM_FOG_RADIAL_COLOR_MULTIPLIER]=   {0.5},

        -- Colorgrading
        [etod.PARAM_COLORGRADING_FILTERS_PHOTOFILTER_COLOR]=    {{ x=4/255, y=2/255, z=62/255 }, }, -- dark blue
        [etod.PARAM_COLORGRADING_FILTERS_PHOTOFILTER_DENSITY]=  {0.6},

        -- Filters
        [etod.PARAM_COLORGRADING_DOF_BLURAMOUNT]=   {0.1},
      },
    },

--------------------------------------------------------------------------------------------
    {
      name="ClearSkyWindy",
      probability=53, 
      danger=-7,
      duration={5, 19},
      continue={
        ["SandStorm"] = 1,
      }, 
      modifiers = { -- values added to current baseline (faded in and out)
        --          outside, inside, underground, underwater
        temperature={-1,      -1,                 },
        wind=       {10,      2,     1,         },
      },
      entities=
      {
        {
          class="WindArea", -- cant be interpolated unless physicalized per frame, but not really needed
          properties=
          {
            --        start, full(default=start), end(default=start)
            bActive=    {1},
            bEllipsoidal= {0},
            Speed=      {1},
            Size=     {{ x=200,y=200,z=200 }},
            Dir=      {{ x=1,y=1,z=-0.5 }},
          },
          OnCustomUpdate=windMover,
        },
      },
      audio=
      {
        {
          class="AudioAreaAmbience",
          trigger="Play_wind",
          rtpc="wind_speed",
          rtpcValue=0.75,
        },
      },
      tod=
      {
        -- method=default lerp, min=totalmin, max=totalmax
        [etod.PARAM_SUN_INTENSITY]=           {0.98, method=emix.MULTIPLY, min=100}, -- lux is logaritmic so halve it by decreasing by factor 10

        [etod.PARAM_COLORGRADING_DOF_FOCUSRANGE]=   {700},
        [etod.PARAM_COLORGRADING_DOF_BLURAMOUNT]=   {0.12, method=emix.ADDITIVE},
      },
    },

--------------------------------------------------------------------------------------------
    {
      name="StormyDistantThunder",
      probability=3, 
      danger=2,
      dangerlimit=20,
      duration={7, 13},
      continue={
        ["HeavyRainThunder"] = 2,
        ["SandStorm"] = 2,
        ["HeatWave"] = 2,
      }, 
      modifiers = { -- values added to current baseline (faded in and out)
        --          outside, inside, underground, underwater
        light=      {-0.1,    -0.1,               },
        humidity=   {0.04,    0.01,               },
        temperature={-5,      -2,                 },
        wind=       {15,      4,     1,         },
      },
      entities=
      {
        {
          class="WindArea", -- cant be interpolated unless physicalized per frame, but not really needed
          properties=
          {
            --        start, full(default=start), end(default=start)
            bActive=    {1},
            bEllipsoidal= {0},
            Speed=      {3.0},
            Size=     {{ x=200,y=200,z=200 }},
            Dir=      {{ x=1,y=1,z=-0.5 }},
          },
          OnCustomUpdate=windMover,
        },
        {
          class="Lightning",
          properties=
          {
            bActive= {1},
            fDistance= {800,760}, 
            bRelativeToPlayer= {1},
            ["Timing.fDelay"]= {25},
            ["Timing.fDelayVariation"]= {0.75},
            ["Timing.fLightningDuration"]= {0.1},
            ["Effects.LightIntensity"]= {0.025},
            ["Effects.ParticleEffect"]= {"weather.lightning.lightningbolt1"},
            ["Effects.ParticleScale"]= {0.3, 0.2},
            ["Effects.SkyHighlightVerticalOffset"]= {300,250},
            ["Effects.SkyHighlightMultiplier"]= {0.015,0.01},
            ["Audio.audioTriggerPlayTrigger"]= {"Play_thunder"},
          },
        },
        {
          class="Lightning",
          properties=
          {
            bActive= {1},
            fDistance= {750,800},
            bRelativeToPlayer= {1},
            ["Timing.fDelay"]= {20},
            ["Timing.fDelayVariation"]= {0.6},
            ["Timing.fLightningDuration"]= {0.1},
            ["Effects.LightIntensity"]= {0.01}, 
            ["Effects.ParticleEffect"]= {"weather.lightning.lightningbolt1"},
            ["Effects.ParticleScale"]= {0.5}, 
            ["Effects.SkyHighlightVerticalOffset"]= {250,400},
            ["Effects.SkyHighlightMultiplier"]= {0.01,0.015},
            ["Audio.audioTriggerPlayTrigger"]= {"Play_thunder"},
          },
        },
      },
      audio=
      {
        {
          class="AudioAreaAmbience",
          trigger="Play_wind",
          rtpc="wind_speed",
          rtpcValue=1.2,
        },
      },

      tod=
      {
        -- method=default lerp, min=totalmin, max=totalmax
        [etod.PARAM_SUN_INTENSITY]=           {0.7, method=emix.MULTIPLY, min=100}, -- lux is logaritmic so halve it by decreasing by factor 10

        [etod.PARAM_SKYLIGHT_SUN_INTENSITY_MULTIPLIER]= {20},

        [etod.PARAM_COLORGRADING_DOF_FOCUSRANGE]=   {700},
        [etod.PARAM_COLORGRADING_DOF_BLURAMOUNT]=   {0.19, method=emix.ADDITIVE},
      },
    },

--------------------------------------------------------------------------------------------
    {
      name="AcidRain",
      probability=2,
      danger=22,
      dangerlimit=40,
      continue={
        ["AcidRain_Peak"] = 100,
      }, 
      duration={2, 3},
      modifiers = { -- values added to current baseline (faded in and out)
        --          outside, inside, underground, underwater
        humidity=   {0.1,     0.1,                },
        light=      {-0.2,    -0.1,               },
        temperature={-4,      -2,                 },
        wind=       {6,      2,     2,      1   },
      },
      entities=
      {
        WeatherSirenTriggers[1],
      },
      audio=
      {
        {
          class="AudioAreaAmbience",
          trigger="Play_wind",
          rtpc="wind_speed",
          rtpcValue=1.0,
        },
      },
      tod=
      {
        -- method=default lerp, min=totalmin, max=totalmax
        [etod.PARAM_SUN_INTENSITY]=           {0.8, method=emix.MULTIPLY, min=100}, -- lux is logaritmic so half it by decreasing by factor 10

        [etod.PARAM_FOG_COLOR2]=            {{ x=122/255, y=120/255, z=10/255 }, constraint=econ.DARKEN, },

        [etod.PARAM_SKYLIGHT_SUN_INTENSITY_MULTIPLIER]= {15},
        [etod.PARAM_CLOUDSHADING_SUNLIGHT_CUSTOM_COLOR_MULTIPLIER] = {0.25, method=emix.MULTIPLY},

        [etod.PARAM_COLORGRADING_FILTERS_PHOTOFILTER_COLOR]=    {{ x=244/255, y=223/255, z=66/255 }, constraint=econ.BRIGTHEN, },
        [etod.PARAM_COLORGRADING_FILTERS_PHOTOFILTER_DENSITY]=  {0.25},
        [etod.PARAM_COLORGRADING_FILTERS_GRAIN]=    {0.1},
        [etod.PARAM_COLORGRADING_DOF_FOCUSRANGE]=   {500},
        [etod.PARAM_COLORGRADING_DOF_BLURAMOUNT]=   {0.2, method=emix.ADDITIVE},
		[etod.PARAM_SKYLIGHT_SUN_INTENSITY_MULTIPLIER]= {150},
      },
    },

--------------------------------------------------------------------------------------------
    {
      name="AcidRain_Peak",
      probability=0,
      danger=5,
      duration={4, 5},
      continue={
        -- Continue pattern starts at fade out of current pattern (so both are active some time)
        ["Rainbow"] = 10,
        ["RainbowHalf"] = 10,
        ["StormyDistantThunder"] = 3,
      }, 
      modifiers = { -- values added to current baseline (faded in and out)
        --          outside, inside, underground, underwater
        humidity=   {0.4,    0.13,   0.1,        },
        rain=       {0.5,                         },
        rain_acid=  {0.12,     0.0,    0.0,  0.08    },
        light=      {-0.4,    -0.1,               },
        temperature={-4,      -1,                },
        wind=       {8,       3,     2,          },
      },
      entities=
      {
        {
          class="Rain",
          properties=
          {
            --            start,  full(default=start), end(default=start)
            bEnabled=       {1},
            fAmount=        {0,   2},
            fDiffuseDarkening=    {0,   0.75},
            fPuddlesAmount=     {0,   2.0},
            fPuddlesMaskAmount=   {0.715},
            fPuddlesRippleAmount= {0,   2.0},
            fRainDropsAmount=   {0,   0.05},
            fRainDropsLighting=   {3.5},
            fRainDropsSpeed=    {1.33}, -- speed cant be interpolated it, because of how rain entity works
            fSplashesAmount=    {0,   1.5},
          },
        },
        {
          class="WindArea", -- cant be interpolated unless physicalized per frame, but not really needed
          properties=
          {
            --        start, full(default=start), end(default=start)
            bActive=    {1},
            bEllipsoidal= {0},
            Speed=      {1.9},
            Size=     {{ x=200,y=200,z=200 }},
            Dir=      {{ x=1,y=1,z=-0.5 }},
          },
          OnCustomUpdate=windMover,
        },
        {
          class="ParticleEffect",
          properties=
          {
            ParticleEffect= {"weather.fog.acid_rain"}, 
            PulsePeriod= {20}, 
            Strength={1.0}, -- Strength={0.0, 1.0},
          },
        },
      },
      audio=
      {
        {
          class="AudioAreaAmbience",
          trigger="Play_rain",
          rtpc="weather_intensity",
          rtpcValue=2.4,
        },
        {
          class="AudioAreaAmbience",
          trigger="Play_wind",
          rtpc="wind_speed",
          rtpcValue=3.0,
        },
      },
      tod=
      {
        -- method=default lerp, min=totalmin, max=totalmax
        [etod.PARAM_SUN_INTENSITY]=           {0.33, method=emix.MULTIPLY, min=100}, -- lux is logaritmic so half it by decreasing by factor 10

        -- Non-Volumetric Fog
        [etod.PARAM_FOG_RADIAL_COLOR_MULTIPLIER]=   {0.2},
        [etod.PARAM_VOLFOG_GLOBAL_DENSITY]=       {0.6, undergroundFactor=_uff, insideFactor=_iff},
        [etod.PARAM_VOLFOG_RAMP_INFLUENCE]=       {0.1, undergroundFactor=_uff, insideFactor=_iff},
        [etod.PARAM_FOG_COLOR_MULTIPLIER]=        {0.15},
        [etod.PARAM_FOG_COLOR2]=            {{ x=122/255, y=120/255, z=10/255 }, constraint=econ.DARKEN, },
        [etod.PARAM_FOG_COLOR2_MULTIPLIER]=       {0.15},
        [etod.PARAM_VOLFOG_HEIGHT2]=          {4000},
        [etod.PARAM_VOLFOG_DENSITY2]=         {0.4, undergroundFactor=_uff, insideFactor=_iff},
        [etod.PARAM_VOLFOG_RADIAL_SIZE]=        {0.5, undergroundFactor=_uff, insideFactor=_iff},

        -- Volumetric Fog
        [etod.PARAM_VOLFOG2_HEIGHT2]=         {10000},
        [etod.PARAM_VOLFOG2_GLOBAL_DENSITY]=      {0.5, method=emix.QUART, undergroundFactor=_uff, insideFactor=_iff},

        [etod.PARAM_SKYLIGHT_SUN_INTENSITY_MULTIPLIER]= {15},
        [etod.PARAM_CLOUDSHADING_SUNLIGHT_CUSTOM_COLOR_MULTIPLIER] = {0.5},

        [etod.PARAM_COLORGRADING_FILTERS_PHOTOFILTER_COLOR]=    {{ x=244/255, y=223/255, z=66/255 }, constraint=econ.BRIGTHEN, },
        [etod.PARAM_COLORGRADING_FILTERS_PHOTOFILTER_DENSITY]=  {0.3, undergroundFactor=_ufc, insideFactor=_ifc},
        [etod.PARAM_COLORGRADING_FILTERS_GRAIN]=    {0.24},
        [etod.PARAM_COLORGRADING_DOF_FOCUSRANGE]=   {250, undergroundFactor=_ufd, insideFactor=_ifd},
        [etod.PARAM_COLORGRADING_DOF_BLURAMOUNT]=   {0.4, method=emix.ADDITIVE, undergroundFactor=_ufd, insideFactor=_ifd},
		[etod.PARAM_SKYLIGHT_SUN_INTENSITY_MULTIPLIER]= {200},
      },
    },

  }
}


--------------------------------------------------------------------------------------------
-- FUNCTIONS
--------------------------------------------------------------------------------------------

-- OnPropertyChange called only by the editor.
function Weather:OnPropertyChange()
  self:Reset();
end

-- OnReset called only by the editor.
function Weather:OnReset()
  --Log("Weather:OnReset");
  self:Reset();
end

-- OnSpawn called Editor/Game.
function Weather:OnSpawn()
  self:Reset();
end

function Weather:Reset()

end

-- Load weather mods
Script.LoadScriptFolder("scripts/weather/mods", true, true)