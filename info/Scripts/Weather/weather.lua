Script.ReloadScript("scripts/Weather/common.lua");

--[[ 
--------------------- HELP --------------------

Seperate maps can use alternative weather_<mapname>.lua setups.

Available weather patterns (must total 100%):

 HELP:
      Enter wm_startPattern (without parameters)
       -> get all weather numbers/names and chances
        -> also checks if they total up to 100%

- TODO: Possible Additions
Seasons: (Layer 0)
- Filter out some patterns
- Effect vegetation shader (No leaves in winter/green=alpha,green=reddish/yellow,green=lusher)
- Winter always snow or ground ice

Weather/Event: (Layer 1)
- Hail/IceRain
- Smog? 
- MagneticStorm (Aurora Borealis)
- Wildfire (firenado? :P)
- Nuke (Warning: Overshooting ICBM's in the sky, siren -> then explosion near death valley)
- Other rainbows (e.g. Moonbow)
- Flood (careful ocean invisible shortly when raising water)
- Earthquake/Aftershocks
- Asteroids (warnings shooting stars+siren)

Moods: (Layer 2)
- Shooting Star
- Fireflies
- Minor color variances
- Violet evening/morning
- Red evening etc
 
wm_startPattern <# or name>
 Can be used to immediately start a weather pattern by name or number. The number 0 will automatically select one.

wm_pattern <x> (not working atm)
 Can be used for constantly force a weather pattern.
  0  | Means no pattern at all
  -1 | Means random pattern selection cycle (Default)
  x  | See weather pattern list (needs to be a number)

wm_disable <1/0>
 Can be used to disable weather/time manager
  0 | Weather manager active (Default)
  1 | Weather/Time deactivated
  
wm_forceTime <hours>
 Can be used to freeze time to a specific hour
  -1 | Time not frozen
  0  | Midnight
  6  | Sunrise
  12 | Noon
  18 | Sunset
  
wm_timeOffset <hours>
 Can be used to offset time from system time on server start up
 -1 | random offset
 0 | no offset
 1 | +1 hour offset
 use 24-x for real negative offsets (as positive numbers)
 
wm_timeScale <speedscale>
 Scale time of day speed
  0.5 | Half of real time
  1   | Real time
  4   | 4x as fast as real time
  512 | 512x as fast as real time

wm_timeScaleNight <speedscale>
 Scale of night speed (relative to day)
 
wm_timeScaleWeather <speedscale>
 Scale of weather speed (The weather speed is independent of day/night speed)

-- Only editor:
wm_reload
 Reloads the weather scripts (testing weather changes)

wm_dumpgps 
 Outputs 8x8km coordinate grid for current gps base

--------------------- HELP --------------------
]]--

TornadoPos={
  { x=3473, y=-313, z=-102 }, -- Start (Ocean next to airport)
  { x=1951, y=8230, z=-102 }, -- End (Ocean Northwest of Hayward)
}

-- Trigger spots --------------------------------------------
-- still need to be listed per instance in their patterns (but reused here)
BellPos={
  { x=3969.34, y=6672.02, z=37.72 }, -- Hayward Church
  { x=2394.19, y=2226.62, z=52.13 }, -- Sultan Church
  { x=7065.78, y=4973.47, z=63.17 }, -- Cape bay Church
}

SirenPos={
  { x=1595.19, y=7050.7,  z=45.31 }, -- Hospital
  { x=1633.72, y=5356.25, z=419.6 }, -- Woodhaven Bunker
  { x=5141.56, y=3313.01, z=46.02 }, -- Brightmoor Bunker
  { x=3987.63, y=1591.37, z=32.85  }, -- Pinecrest Fire Dept
  { x=1708.95, y=3407.54, z=40.67  }, -- Woodhaven Fire Dept
  { x=3748.93, y=6415.58, z=28.99  }, -- Hayward Police Dept
  { x=7384.95, y=4927.82, z=49.05  }, -- Cape bay Fire Dept
  { x=5847.92, y=4610.79, z=195.71 }, -- Orca Dam
  { x=2497.54, y=643.35,  z=52.10  }, -- Amalgamated Airfield
  { x=788.16, y=4148.64, z=256.56  }, -- Turtle bay radio tower
  { x=2920.04, y=3203.42, z=284.54  }, -- Middle of map radio tower
}

-- Audio trigger -- 
BellTriggers = createTriggerSpots( "Play_churchbell", "Stop_churchbell", BellPos, { fMinDelay = {30,25}, fMaxDelay = {120,70}, bPlayRandom = {true} } )
WeatherSirenTriggers = createTriggerSpots( "Play_siren_tornado_start", "Stop_siren_tornado", SirenPos )
NukeSirenTriggers = createTriggerSpots( "Play_siren_nuclear_start", "Stop_siren_nuclear", SirenPos )

-- dump(NukeSirenTriggers) -- test output

-- BellTriggers[1-3]
-- WeatherSirenTriggers[1-11]
-- NukeSirenTriggers[1-11]

-- Definition of the weather patterns (can be reloaded with wm_reload)
Weather = 
{
  -- map gps coords for cb radio
  gpsLatitude=48.578424,
  gpsLongitude=-123.050995,

  -- map environment settings
  baseline = { -- values for a normal day at 12:00 AM
    day = {
      --          outside, inside, underground, underwater
      humidity=   {0.1,     0.05,   0.25,   1   }, -- [1-0] ratio (1 = wet, 0 = dry)
      rain=       {0,       0,      0,      1   }, -- [1-0] ratio (1 = wet, 0 = no rain)
      light=      {1.0,     0.2,    0.0,    0.2 }, -- [1-0] ratio (1 = bright, 0 = dark)
      temperature={23,      24,     9,     8  }, -- [°C]
      wind=       {11,      1,      0,      0   }, -- [km/h]
      geigercounter=  {1,   0.75,    0.0,       0  }, -- sound rtpc
    },
    night = { -- values for a normal night at 12:00 PM
      --          outside, inside, underground, underwater
      humidity=   {0.15,    0.10,   0.27,   1   },
      rain=       {0,       0,      0,      1   },
      light=      {0.02,    0.01,   0.0,    0   },
      temperature={10,      15,     8,      7  },
      wind=       {5,       1,      0,      0   },
      geigercounter=  {1,   0.75,    0.0,      0   },
    },
  },

  patterns =
  {
--------------------------------------------------------------------------------------------
    {
      name="ClearSky",
      probability=15, -- probabilities need to be 100 in total, everything over that will never get selected
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
      probability=3,
      danger=-3,
      duration={5, 15},
      todlimit={7,17}, -- pattern can only spawn between those times (Default: 0, 24 for no limit)
      continue={
        -- Continue pattern starts at fade out of current pattern (so both are active some time)
        ["Rainbow"] = 30,
        ["RainbowHalf"] = 30,
        ["LightFog"] = 10,
        ["MediumRain"] = 3,
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
        [etod.PARAM_SUN_INTENSITY]=						{0.5, method=emix.MULTIPLY, min=100}, -- lux is logaritmic so halve it by decreasing by factor 10
        [etod.PARAM_FOG_RADIAL_COLOR_MULTIPLIER]=		{0.1},

        -- Non-Volumetric Fog
        [etod.PARAM_VOLFOG_GLOBAL_DENSITY]=				{0.15, undergroundFactor=_uff, insideFactor=_iff},
        [etod.PARAM_VOLFOG_RAMP_INFLUENCE]=				{0.5, undergroundFactor=_uff, insideFactor=_iff},

        -- Volumetric Fog
        [etod.PARAM_VOLFOG2_GLOBAL_DENSITY]=			{0.25, method=emix.QUART, undergroundFactor=_uff, insideFactor=_iff},
        [etod.PARAM_VOLFOG2_COLOR1]=					{{ x=187/255, y=255/255, z=255/255 }, constraint=econ.NONE,},

        [etod.PARAM_SKYLIGHT_SUN_INTENSITY_MULTIPLIER]=	{10},

        [etod.PARAM_COLORGRADING_DOF_FOCUSRANGE]=		{350, undergroundFactor=_ufd, insideFactor=_ifd},
        [etod.PARAM_COLORGRADING_DOF_BLURAMOUNT]=		{0.2, method=emix.ADDITIVE, undergroundFactor=_ufd, insideFactor=_ifd},
      },
    },

--------------------------------------------------------------------------------------------
    {
      name="HeavyRainThunder",
      probability=2,
      danger=7,
      dangerlimit=40,
      duration={5, 30},
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
        BellTriggers[1],BellTriggers[2],BellTriggers[3],
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
        [etod.PARAM_SUN_INTENSITY]=						{0.1, method=emix.MULTIPLY, min=100}, -- lux is logaritmic so half it by decreasing by factor 10

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

        [etod.PARAM_SKYLIGHT_SUN_INTENSITY_MULTIPLIER]=	{50},

        [etod.PARAM_COLORGRADING_FILTERS_GRAIN]=		{0.2},
        [etod.PARAM_COLORGRADING_DOF_FOCUSRANGE]=		{200, undergroundFactor=_ufd, insideFactor=_ifd},
        [etod.PARAM_COLORGRADING_DOF_BLURAMOUNT]=		{0.5, method=emix.ADDITIVE, undergroundFactor=_ufd, insideFactor=_ifd},
      },
    },

--------------------------------------------------------------------------------------------
    {
      name="HeavyStorm",
      probability=1,
      danger=4,
      dangerlimit=40,
      duration={5, 8},
      modifiers = { -- values added to current baseline (faded in and out)
        --          outside, inside, underground, underwater
        humidity=   {0.1,     0.1,                },
        light=      {-0.3,    -0.1,               },
        temperature={-8,      -2,                 },
        wind=       {80,      20,     5,      5   },
      },
      entities=
      {
        BellTriggers[1],BellTriggers[2],BellTriggers[3],
        {
          class="WindArea", -- cant be interpolated unless physicalized per frame, but not really needed
          properties=
          {
            -- 				start, full(default=start), end(default=start)
            bActive=		{1},
            bEllipsoidal=	{0},
            Speed=			{4.5},
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
          trigger="Play_wind",
          rtpc="wind_speed",
          rtpcValue=9.0,
        },
      },
      tod=
      {
        -- method=default lerp, min=totalmin, max=totalmax
        [etod.PARAM_SUN_INTENSITY]=           {0.6, method=emix.MULTIPLY, min=100}, -- lux is logaritmic so halve it by decreasing by factor 10

        [etod.PARAM_SKYLIGHT_SUN_INTENSITY_MULTIPLIER]= {30},

        [etod.PARAM_COLORGRADING_DOF_FOCUSRANGE]=   {700},
        [etod.PARAM_COLORGRADING_DOF_BLURAMOUNT]=   {0.19, method=emix.ADDITIVE},
      },
    },

--------------------------------------------------------------------------------------------
    {
      name="TornadoStorm",
      probability=0, -- deprecated looks not good enough
      danger=60,
      dangerlimit=40,
      continue={
        ["TornadoStorm_Tornado"] = 100, -- Continue pattern starts at fade out of this pattern, so blending works
      }, 
      duration={2, 3},
      modifiers = { -- values added to current baseline (faded in and out)
        --          outside, inside, underground, underwater
        humidity=   {0.1,     0.1,                },
        light=      {-0.3,    -0.1,               },
        temperature={-4,      -2,                 },
        wind=       {20,      10,     2,      1   },
      },
      entities=
      {
        WeatherSirenTriggers[1],WeatherSirenTriggers[2],WeatherSirenTriggers[3],WeatherSirenTriggers[4],WeatherSirenTriggers[5],WeatherSirenTriggers[6],WeatherSirenTriggers[7],WeatherSirenTriggers[8],WeatherSirenTriggers[9],WeatherSirenTriggers[10],WeatherSirenTriggers[11],
        BellTriggers[1],BellTriggers[2],BellTriggers[3],
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
        [etod.PARAM_FOG_COLOR2]=            {{ x=60/255, y=80/255, z=90/255 }, constraint=econ.DARKEN, },
        [etod.PARAM_FOG_COLOR2_MULTIPLIER]=       {0.33},
        [etod.PARAM_VOLFOG_HEIGHT2]=          {2000},
        [etod.PARAM_VOLFOG_DENSITY2]=         {0.8, undergroundFactor=_uff, insideFactor=_iff},
        [etod.PARAM_VOLFOG_RADIAL_SIZE]=        {0.5, undergroundFactor=_uff, insideFactor=_iff},

        -- Volumetric Fog
        [etod.PARAM_VOLFOG2_GLOBAL_DENSITY]=      {0.5, method=emix.QUART, undergroundFactor=_uff, insideFactor=_iff},

        [etod.PARAM_SKYLIGHT_SUN_INTENSITY_MULTIPLIER]= {10},

        [etod.PARAM_COLORGRADING_FILTERS_GRAIN]=    {0.2},
        [etod.PARAM_COLORGRADING_DOF_FOCUSRANGE]=   {300, undergroundFactor=_ufd, insideFactor=_ifd},
        [etod.PARAM_COLORGRADING_DOF_BLURAMOUNT]=   {0.1, undergroundFactor=_ufd, insideFactor=_ifd},
      },
    },

--------------------------------------------------------------------------------------------
    {
      name="TornadoStorm_Tornado",
      probability=0,
      danger=20,
      duration={20, 30},
      modifiers = { -- values added to current baseline (faded in and out)
        --          outside, inside, underground, underwater
        humidity=   {0.1,     0.1,                },
        light=      {-0.3,    -0.1,               },
        temperature={-8,      -2,                 },
        wind=       {80,      20,     5,      5   },
      },
      entities=
      {
        BellTriggers[1],BellTriggers[2],BellTriggers[3],
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
      },
      audio=
      {
        {
          class="AudioAreaAmbience",
          trigger="Play_wind",
          rtpc="wind_speed",
          rtpcValue=9.0,
          rtpcFunc=tornadoSoundMover,
        },
      },
      tod=
      {
        [etod.PARAM_SUN_INTENSITY]=						{0.2, method=emix.MULTIPLY, min=100}, -- lux is logaritmic so half it by decreasing by factor 10
        [etod.PARAM_FOG_RADIAL_COLOR_MULTIPLIER]=		{0.05},

        -- Non-Volumetric Fog
        [etod.PARAM_FOG_COLOR2]=						{{ x=60/255, y=80/255, z=90/255 }, constraint=econ.DARKEN, },
        [etod.PARAM_FOG_COLOR2_MULTIPLIER]=				{0.33},
        [etod.PARAM_VOLFOG_HEIGHT2]=					{2000},
        [etod.PARAM_VOLFOG_DENSITY2]=					{0.8, undergroundFactor=_uff, insideFactor=_iff},
        [etod.PARAM_VOLFOG_RADIAL_SIZE]=				{0.5, undergroundFactor=_uff, insideFactor=_iff},

        -- Volumetric Fog
        [etod.PARAM_VOLFOG2_GLOBAL_DENSITY]=			{0.5, method=emix.QUART, undergroundFactor=_uff, insideFactor=_iff},

        [etod.PARAM_SKYLIGHT_SUN_INTENSITY_MULTIPLIER]=	{10},

        [etod.PARAM_COLORGRADING_FILTERS_GRAIN]=		{0.2},
        [etod.PARAM_COLORGRADING_DOF_FOCUSRANGE]=		{300, undergroundFactor=_ufd, insideFactor=_ifd},
        [etod.PARAM_COLORGRADING_DOF_BLURAMOUNT]=		{0.1, method=emix.ADDITIVE, undergroundFactor=_ufd, insideFactor=_ifd},
      },
    },

--------------------------------------------------------------------------------------------
    {
      name="TornadoRainThunder",
      probability=2,
      danger=60,
      dangerlimit=40,
      continue={
        ["TornadoRainThunder_Tornado"] = 100, -- Continue pattern starts at fade out of this pattern, so blending works
      }, 
      duration={2, 3},
      modifiers = { -- values added to current baseline (faded in and out)
        --          outside, inside, underground, underwater
        humidity=   {0.1,     0.1,                },
        light=      {-0.3,    -0.1,               },
        temperature={-4,      -2,                 },
        wind=       {20,      10,     2,      1   },
      },
      entities=
      {
        WeatherSirenTriggers[1],WeatherSirenTriggers[2],WeatherSirenTriggers[3],WeatherSirenTriggers[4],WeatherSirenTriggers[5],WeatherSirenTriggers[6],WeatherSirenTriggers[7],WeatherSirenTriggers[8],WeatherSirenTriggers[9],WeatherSirenTriggers[10],WeatherSirenTriggers[11],
        BellTriggers[1],BellTriggers[2],BellTriggers[3],
        {
          class="Lightning",
          properties=
          {
            bActive= {1},
            fDistance= {1000,800}, -- lightning closes distance to player and then goes away again
            bRelativeToPlayer= {1},
            ["Timing.fDelay"]= {30},
            ["Timing.fDelayVariation"]= {0.75},
            ["Timing.fLightningDuration"]= {0.3},
            ["Effects.LightIntensity"]= {0.4}, -- increase intensity as it comes closer
            ["Effects.ParticleEffect"]= {"weather.lightning.lightningbolt1"},
            ["Effects.ParticleScale"]= {4}, -- have them a bit larger at distance
            ["Effects.SkyHighlightVerticalOffset"]= {400},
            ["Effects.SkyHighlightMultiplier"]= {0.3},
            ["Audio.audioTriggerPlayTrigger"]= {"Play_thunder"},
          },
        },
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
        [etod.PARAM_FOG_COLOR2]=            {{ x=60/255, y=80/255, z=90/255 }, constraint=econ.DARKEN, },
        [etod.PARAM_FOG_COLOR2_MULTIPLIER]=       {0.33},
        [etod.PARAM_VOLFOG_HEIGHT2]=          {2000},
        [etod.PARAM_VOLFOG_DENSITY2]=         {0.8, undergroundFactor=_uff, insideFactor=_iff},
        [etod.PARAM_VOLFOG_RADIAL_SIZE]=        {0.5, undergroundFactor=_uff, insideFactor=_iff},

        -- Volumetric Fog
        [etod.PARAM_VOLFOG2_GLOBAL_DENSITY]=      {0.5, method=emix.QUART, undergroundFactor=_uff, insideFactor=_iff},

        [etod.PARAM_SKYLIGHT_SUN_INTENSITY_MULTIPLIER]= {10},

        [etod.PARAM_COLORGRADING_FILTERS_GRAIN]=    {0.2},
        [etod.PARAM_COLORGRADING_DOF_FOCUSRANGE]=   {300, undergroundFactor=_ufd, insideFactor=_ifd},
        [etod.PARAM_COLORGRADING_DOF_BLURAMOUNT]=   {0.1, method=emix.ADDITIVE, undergroundFactor=_ufd, insideFactor=_ifd},
      },
    },

--------------------------------------------------------------------------------------------
    {
      name="TornadoRainThunder_Tornado",
      probability=0,
      danger=20,
      duration={20, 30},
      continue={
        -- Continue pattern starts at fade out of current pattern (so both are active some time)
        ["LightRain"] = 5,
        ["HeavyRainThunder"] = 10,
        ["Rainbow"] = 10,
        ["RainbowHalf"] = 10,
      },  
      modifiers = { -- values added to current baseline (faded in and out)
        --          outside, inside, underground, underwater
        humidity=   {0.75,    0.25,   0.2,        },
        rain=       {0.8,                         },
        light=      {-0.7,    -0.3,               },
        temperature={-10,     -4,     -1,         },
        wind=       {80,      6,      4,          },
      },
      entities=
      {
        BellTriggers[1],BellTriggers[2],BellTriggers[3],
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
            fAmount=				{0,		3.0},
            fDiffuseDarkening=		{0,		1.0},
            fPuddlesAmount=			{0,		2.0},
            fPuddlesMaskAmount=		{0.7},
            fPuddlesRippleAmount=	{0,		2.0},
            fRainDropsAmount=		{0,		0.05},
            fRainDropsLighting=		{3.0},
            fRainDropsSpeed=		{3}, -- speed cant be interpolated it, because of how rain entity works
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
            ["Audio.audioTriggerPlayTrigger"]= {"Play_thunder"}, --TODO needs a better sound
          },
        },
        {
          class="WindArea", -- cant be interpolated unless physicalized per frame, but not really needed
          properties=
          {
            -- 				start, 	full(default=start), end(default=start)
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
            fCloudHeight = 			{800.0},
          },
          OnCustomUpdate=tornadoMover,
        },
      },
      audio=
      {
        {
          class="AudioAreaAmbience",
          trigger="Play_rain",
          rtpc="weather_intensity",
          rtpcValue=5.0,
        },
        {
          class="AudioAreaAmbience",
          trigger="Play_wind",
          rtpc="wind_speed",
          rtpcValue=10.0,
          rtpcFunc=tornadoSoundMover,
        },
      },
      tod=
      {
        [etod.PARAM_SUN_INTENSITY]=						{0.1, method=emix.MULTIPLY, min=100}, -- lux is logaritmic so half it by decreasing by factor 10

        -- Non-Volumetric Fog
        [etod.PARAM_FOG_COLOR_MULTIPLIER]=				{0.1},
        [etod.PARAM_FOG_RADIAL_COLOR_MULTIPLIER]=		{0.1},
        [etod.PARAM_VOLFOG_GLOBAL_DENSITY]=				{1.0, undergroundFactor=_uff, insideFactor=_iff},
        [etod.PARAM_VOLFOG_RAMP_INFLUENCE]=				{0.5, undergroundFactor=_uff, insideFactor=_iff},
        [etod.PARAM_FOG_COLOR2]=						{{ x=60/255, y=80/255, z=90/255 }, constraint=econ.DARKEN, },
        [etod.PARAM_FOG_COLOR2_MULTIPLIER]=				{0.33},
        [etod.PARAM_VOLFOG_HEIGHT2]=					{2000},
        [etod.PARAM_VOLFOG_DENSITY2]=					{0.8, undergroundFactor=_uff, insideFactor=_iff},
        [etod.PARAM_VOLFOG_RADIAL_SIZE]=				{0.5, undergroundFactor=_uff, insideFactor=_iff},

        -- Volumetric Fog
        [etod.PARAM_VOLFOG2_HEIGHT2]=					{10000},
        [etod.PARAM_VOLFOG2_GLOBAL_DENSITY]=			{0.75, method=emix.QUART, undergroundFactor=_uff, insideFactor=_iff},

        [etod.PARAM_SKYLIGHT_SUN_INTENSITY_MULTIPLIER]=	{10},

        [etod.PARAM_COLORGRADING_FILTERS_GRAIN]=		{0.2},
        [etod.PARAM_COLORGRADING_DOF_FOCUSRANGE]=		{100, undergroundFactor=_ufd, insideFactor=_ifd},
        [etod.PARAM_COLORGRADING_DOF_BLURAMOUNT]=		{0.75, method=emix.ADDITIVE, undergroundFactor=_ufd, insideFactor=_ifd},

        -- Decrease sunshafts/rays visibilty
        [etod.PARAM_SUN_RAYS_VISIBILITY]=				{0.1, undergroundFactor=_uff, insideFactor=_iff},
        [etod.PARAM_VOLFOG_SHADOW_DARKENING]=			{0.5, undergroundFactor=_uff, insideFactor=_iff},
      },
    },

--------------------------------------------------------------------------------------------
    {
      name="LightFog",
      probability=2,
      danger=10,
      dangerlimit=40,
      duration={8, 10},
      ramp={0.2, 0.4}, -- use 20% fade-in and 40% fade-out for fog
      modifiers = { -- values added to current baseline (faded in and out)
        --          outside, inside, underground, underwater
        humidity=   {0.15,    0.1,    0.1,        },
        light=      {-0.2,    -0.1,               },
        temperature={-4,      -1,                 },
        fog=        {0.3,     0,      0,          },
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
      name="MediumFog",
      probability=1,
      danger=12,
      dangerlimit=40,
      duration={10, 15},
      continue={
        -- Continue pattern starts at fade out of current pattern (so both are active some time)
        ["LightFog"] = 1, -- Light fog 1% chance
      }, 
      ramp={0.2, 0.4}, -- use 20% fade-in and 40% fade-out for fog
      modifiers = { -- values added to current baseline (faded in and out)
        --          outside, inside, underground, underwater
        humidity=   {0.2,     0.15,   0.1,        },
        light=      {-0.3,    -0.2,               },
        temperature={-4,      -1,                 },
        fog=        {0.6,     0,      0,          },
      },
      entities={
        {
          class="ParticleEffect",
          properties=
          {
            ParticleEffect= {"weather.fog.fog_medium"}, 
            PulsePeriod= {20}, 
            Strength={1.0}, -- Strength={0.0, 1.0},
          },
        },
      },
      audio=
      {
        {
          class="AudioAreaAmbience",
          trigger="Play_wind",
          rtpc="wind_speed",
          rtpcValue=0.1,
        },
      },
      tod=
      {
        [etod.PARAM_SUN_INTENSITY]=						{0.2, method=emix.MULTIPLY, min=100}, -- lux is logaritmic so half it by decreasing by factor 10
        [etod.PARAM_FOG_RADIAL_COLOR_MULTIPLIER]=		{0.1},

        -- Non-Volumetric Fog
        [etod.PARAM_VOLFOG_GLOBAL_DENSITY]=				{1.0, undergroundFactor=_uff, insideFactor=_iff},
        [etod.PARAM_VOLFOG_RAMP_INFLUENCE]=				{0.25, undergroundFactor=_uff, insideFactor=_iff},
        [etod.PARAM_VOLFOG_HEIGHT_OFFSET]=				{1.0, undergroundFactor=_uff},

        -- Volumetric Fog
        [etod.PARAM_VOLFOG2_GLOBAL_DENSITY]=			{1.0, method=emix.QUART, undergroundFactor=_uff, insideFactor=_iff},

        [etod.PARAM_COLORGRADING_FILTERS_GRAIN]=		{0.3},
        [etod.PARAM_COLORGRADING_DOF_FOCUSRANGE]=		{250, undergroundFactor=_ufd, insideFactor=_ifd},
        [etod.PARAM_COLORGRADING_DOF_BLURAMOUNT]=		{0.2, method=emix.ADDITIVE, undergroundFactor=_ufd, insideFactor=_ifd},
      },
    },

--------------------------------------------------------------------------------------------
    {
      name="HeavyFog",
      probability=1,
      danger=14,
      dangerlimit=40,
      duration={10, 20},
      continue={
        -- Continue pattern starts at fade out of current pattern (so both are active some time)
        ["LightFog"] = 1, -- Light fog 10% chance
      }, 
      ramp={0.2, 0.4}, -- use 20% fade-in and 40% fade-out for fog
      modifiers = { -- values added to current baseline (faded in and out)
        --          outside, inside, underground, underwater
        humidity=   {0.3,     0.2,    0.15,       },
        light=      {-0.4,    -0.25,              },
        temperature={-5,      -2,                 },
        fog=        {1.0,     0,      0,          },
      },
      entities={
        {
          class="ParticleEffect",
          properties=
          {
            ParticleEffect= {"weather.fog.fog_heavy"}, 
            PulsePeriod= {20}, 
            Strength={1.0}, -- Strength={0.0, 1.0},
          },
        },
      },
      audio=
      {
        {
          class="AudioAreaAmbience",
          trigger="Play_wind",
          rtpc="wind_speed",
          rtpcValue=0.2,
        },
      },
      tod=
      {
        [etod.PARAM_SUN_INTENSITY]=						{0.2, method=emix.MULTIPLY, min=100}, -- lux is logaritmic so half it by decreasing by factor 10
        [etod.PARAM_FOG_RADIAL_COLOR_MULTIPLIER]=		{0.1},

        -- Non-Volumetric Fog
        [etod.PARAM_VOLFOG_GLOBAL_DENSITY]=				{3.5, undergroundFactor=_uff, insideFactor=_iff},
        [etod.PARAM_VOLFOG_RAMP_INFLUENCE]=				{0.01, undergroundFactor=_uff, insideFactor=_iff},
        [etod.PARAM_VOLFOG_HEIGHT_OFFSET]=				{1.0, undergroundFactor=_uff},

        -- Volumetric Fog
        [etod.PARAM_VOLFOG2_GLOBAL_DENSITY]=			{2.0, method=emix.QUART, undergroundFactor=_uff, insideFactor=_iff},

        [etod.PARAM_COLORGRADING_FILTERS_GRAIN]=		{0.3},
        [etod.PARAM_COLORGRADING_DOF_FOCUSRANGE]=		{250, undergroundFactor=_ufd, insideFactor=_ifd},
        [etod.PARAM_COLORGRADING_DOF_BLURAMOUNT]=		{0.2, method=emix.ADDITIVE, undergroundFactor=_ufd, insideFactor=_ifd},

        [etod.PARAM_SUN_RAYS_VISIBILITY]=				{0.4},
      },
    },

--------------------------------------------------------------------------------------------
    {
      name="TheMist",
      probability=1,
      danger=40,
      dangerlimit=40,
      duration={3, 5},
      continue={
        -- Continue pattern starts at fade out of current pattern (so both are active some time)
        ["LightFog"] = 1, -- Light fog 10% chance
      }, 
      ramp={0.3, 0.4}, -- use 30% fade-in and 40% fade-out for fog
      modifiers = { -- values added to current baseline (faded in and out)
        --          outside, inside, underground, underwater
        humidity=   {0.4,     0.3,    0.2,        },
        light=      {-0.6,    -0.3,               },
        temperature={-9,      -6,                 },
        fog=        {0.8,     0,      0,          },
      },
      entities={
        {
          class="ParticleEffect",
          properties=
          {
            ParticleEffect= {"weather.fog.fog_heavy"}, 
            PulsePeriod= {20}, 
            Strength={1.0}, -- Strength={0.0, 1.0},
          },
        },
      },
      audio={
        {
          class="AudioAreaAmbience",
          trigger="Play_nuclear_winter",
          rtpc="freeze_strength",
          rtpcValue=0.2,
        },
      },
      tod=
      {
        [etod.PARAM_SUN_INTENSITY]=						{0.1, method=emix.MULTIPLY, min=100}, -- lux is logaritmic so half it by decreasing by factor 10
        [etod.PARAM_FOG_RADIAL_COLOR_MULTIPLIER]=		{0.1, undergroundFactor=_uff, insideFactor=_iff},

        -- Non-Volumetric Fog
        [etod.PARAM_VOLFOG_GLOBAL_DENSITY]=				{50, undergroundFactor=_uff, insideFactor=_iff},
        [etod.PARAM_VOLFOG_RAMP_INFLUENCE]=				{0.01, undergroundFactor=_uff, insideFactor=_iff},
        [etod.PARAM_VOLFOG_HEIGHT_OFFSET]=				{1.0, undergroundFactor=_uff},

        -- Volumetric Fog
        [etod.PARAM_VOLFOG2_GLOBAL_DENSITY]=			{100.0, method=emix.QUART, undergroundFactor=_uff, insideFactor=_iff},

        [etod.PARAM_COLORGRADING_FILTERS_GRAIN]=		{0.6},
        [etod.PARAM_COLORGRADING_DOF_FOCUSRANGE]=		{15, undergroundFactor=_ufd, insideFactor=_ifd},
        [etod.PARAM_COLORGRADING_DOF_BLURAMOUNT]=		{0.45, method=emix.ADDITIVE, undergroundFactor=_ufd, insideFactor=_ifd},

        [etod.PARAM_SUN_RAYS_VISIBILITY]=				{0.0},
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
          pos={ x=4096, y=4096, z=450 }, -- override normal spawn pos which is somewhere in center of map
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
          pos={ x=4096, y=4096, z=400 }, -- override normal spawn pos which is somewhere in center of map
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
      probability=2,
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
        gas_radiation=  {0.166,      0.07,            },
        rain_radiation= {0.155,      0.0,              },
        ray_radiation= {0.056,       0.008,           },
        geigercounter=  {2,        1.75,    0.0,    1  },
      },
      entities=
      {
        NukeSirenTriggers[1],NukeSirenTriggers[2],NukeSirenTriggers[3],NukeSirenTriggers[4],NukeSirenTriggers[5],NukeSirenTriggers[6],NukeSirenTriggers[7],NukeSirenTriggers[8],NukeSirenTriggers[9],NukeSirenTriggers[10],NukeSirenTriggers[11],
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
        gas_radiation=  {0.5,       0.125,              },
        rain_radiation= {0.40,       0.0,              },
        ray_radiation= {0.20,       0.025,              },
        geigercounter=  {3,        2.75,    0.0,    1  },
      },
      entities=
      {
        BellTriggers[1],BellTriggers[2],BellTriggers[3],
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

        -- Non-Volumetric Fog
        [etod.PARAM_VOLFOG_GLOBAL_DENSITY]=         {7.0, undergroundFactor=_uff, insideFactor=_iff},
        [etod.PARAM_VOLFOG_DENSITY]=                {0.9, undergroundFactor=_uff, insideFactor=_iff},
        [etod.PARAM_FOG_COLOR_MULTIPLIER]=          {0.9},
        [etod.PARAM_FOG_COLOR2_MULTIPLIER]=         {0.9},

        [etod.PARAM_FOG_COLOR]=                     {{ x=61/255, y=68/255, z=26/255 }, constraint=econ.DARKEN }, -- bottom
        [etod.PARAM_FOG_COLOR2]=                    {{ x=119/255, y=126/255, z=54/255 }, constraint=econ.DARKEN }, -- top
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
        gas_radiation=  {0.19,       0.04,              },
        rain_radiation= {0.16,       0.0,              },
        ray_radiation=  {0.105,       0.0075,              },
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
        temperature=    {-20,       -8,       -3,    -6   },
        gas_radiation=  {0.02875,     0.006,                },
        rain_radiation= {0.0275,      0.006,                },
        geigercounter=  {1,          0.75,    0.0,    1  },
        blizzard=       {0.5,        0,       0,       0  },
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
        temperature=    {-40,     -25,    -8,    -21  },
        gas_radiation=  {0.375,     0.02,              },
        rain_radiation= {0.325,     0.035,              },
        ray_radiation=  {0.255,     0.0075,              },
        geigercounter=  {1.5,      0.75,    0.0,    1  },
        blizzard=       {1.0,      0,       0,       0  },
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
        temperature=    {-30,     -8,    -3,    -17       },
        gas_radiation=  {0.10,       0.01,                },
        rain_radiation= {0.05,       0.015,                },
        ray_radiation=  {0.04,       0.015,                },
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
      name="Snow",
      probability=6,
      danger=15,
      dangerlimit=20,
      duration={10, 20},
      continue={
        ["Blizzard"] = 10,
        ["BlizzardThunder"] = 10, 
        ["ClearSkyWindySnow_Outro"] = { probability = 20, stage = 1, }, -- jump directly to peak
        ["Snow_Outro"] = 60, -- Continue pattern starts at fade out of this pattern, so blending works
      }, 
      ramp={0.1, 0.1}, -- use 10% fade-in and 10% fade-out
      modifiers = { -- values added to current baseline (faded in and out)
        --              outside, inside, underground, underwater
        humidity=       {0.3,       0.2,    0.15,         },
        light=          {-0.4,      -0.25,                },
        temperature=    {-40,       -25,      -6,    -17   },
      },
      entities={
        {
          class="Snow",
          pos={ x=4096, y=4096, z=450 }, -- center of map
          properties=
          {
            bEnabled= {1},
            fRadius= {8000}, -- whole map
            ["SnowFall.fBrightness"]= {20}, -- so its visible at night
            ["SnowFall.fGravityScale"]= {0.1,1.0,1.0},
            ["SnowFall.nSnowFlakeCount"]= {200,350,3},
            ["Surface.fSnowAmount"]= {0.0,10.0,10.0},
            ["Surface.fFrostAmount"]= {0.0,1.0,1.0},
            ["Surface.fSurfaceFreezing"]= {0.0,0.35,0.3},
          },
          OnCustomUpdate=windMover,
        },
        {
          class="Rain",
          properties=
          {
            --            start,  full(default=start), end(default=start)
            bEnabled=       {1},
            fAmount=        {0,   0.0, 0.1},
            fDiffuseDarkening=    {0,   0.3, 0.4},
            fPuddlesAmount=     {0,   1.0, 2.0},
            fPuddlesMaskAmount=   {0.8, 0.0, 0.0},
            fPuddlesRippleAmount= {0, 0, 0.005},
            fRainDropsAmount=   {0,   0, 0.02},
            fRainDropsLighting=   {1.0},
            fRainDropsSpeed=    {1}, -- speed cant be interpolated it, because of how rain entity works
            fSplashesAmount=    {0, 0.0, 0.2},
          },
        },
        {
          class="WindArea", -- cant be interpolated unless physicalized per frame, but not really needed
          properties=
          {
            --        start,  full(default=start), end(default=start)
            bActive=    {1},
            bEllipsoidal= {0},
            Speed=      {1.0},
            Size=     {{ x=200,y=200,z=200 }},
          },
          OnCustomUpdate=windMover,
        },
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
        {
          class="AudioAreaAmbience",
          trigger="Play_rain",
          rtpc="weather_intensity",
          rtpcValue=0.25,
        },
        {
          class="AudioAreaAmbience",
          trigger="Play_nuclear_winter",
          rtpc="freeze_strength",
          rtpcValue=0.07,
        },
      },
      tod=
      {
        -- Fog + slight color grading blue
        [etod.PARAM_SUN_INTENSITY]=           {0.2, method=emix.MULTIPLY, min=100}, -- lux is logaritmic so half it by decreasing by factor 10
        [etod.PARAM_FOG_RADIAL_COLOR_MULTIPLIER]=   {0.1},

        -- Non-Volumetric Fog
        [etod.PARAM_VOLFOG_GLOBAL_DENSITY]=       {0.5, undergroundFactor=_uff, insideFactor=_iff},
        [etod.PARAM_VOLFOG_RAMP_INFLUENCE]=       {0.5, undergroundFactor=_uff, insideFactor=_iff},
        [etod.PARAM_VOLFOG_HEIGHT_OFFSET]=        {1.0, undergroundFactor=_uff},

        -- Volumetric Fog
        [etod.PARAM_VOLFOG2_GLOBAL_DENSITY]=      {0.27, method=emix.QUART, undergroundFactor=_uff, insideFactor=_iff},

        [etod.PARAM_SKYLIGHT_SUN_INTENSITY_MULTIPLIER]= {10},

        [etod.PARAM_COLORGRADING_FILTERS_GRAIN]=    {0.3},
        [etod.PARAM_COLORGRADING_DOF_FOCUSRANGE]=   {300, undergroundFactor=_ufd, insideFactor=_ifd},
        [etod.PARAM_COLORGRADING_DOF_BLURAMOUNT]=   {0.2, method=emix.ADDITIVE, undergroundFactor=_ufd, insideFactor=_ifd},

        -- Colorgrading
        [etod.PARAM_COLORGRADING_FILTERS_PHOTOFILTER_COLOR]=    {{ x=4/255, y=2/255, z=62/255 }, }, -- dark blue
        [etod.PARAM_COLORGRADING_FILTERS_PHOTOFILTER_DENSITY]=  {0.15, undergroundFactor=_ufc, insideFactor=_ifc},
      },
    },

--------------------------------------------------------------------------------------------
    {
      name="Snow_Outro",
      probability=0,
      danger=15,
      duration={4, 5},
      ramp={0.2, 0.5}, -- use 20% fade-in and 50% fade-out
      modifiers = { -- values added to current baseline (faded in and out)
        --              outside, inside, underground, underwater
        humidity=       {0.3,       0.2,    0.15,         },
        light=          {-0.3,      -0.2,                },
        temperature=    {-20,       -12,       -2,    -5   },
      },
      entities={
        {
          class="Snow",
          pos={ x=4096, y=4096, z=450 }, -- center of map
          properties=
          {
            bEnabled= {1},
            fRadius= {8000}, -- whole map
            ["SnowFall.fBrightness"]= {20}, -- so its visible at night
            ["SnowFall.fGravityScale"]= {1.0,1.0,0.1},
            ["SnowFall.nSnowFlakeCount"]= {3,3,0},
            ["Surface.fSnowAmount"]= {10.0,3.0,0.0},
            ["Surface.fFrostAmount"]= {0.9,0.9,0.0},
            ["Surface.fSurfaceFreezing"]= {0.3,0.3,0.0},
          },
          OnCustomUpdate=windMover,
        },
        {
          class="Rain",
          properties=
          {
            --            start,  full(default=start), end(default=start)
            bEnabled=       {1},
            fAmount=        {0.1,   0.3, 0},
            fDiffuseDarkening=    {0.4,   0.3, 0.0},
            fPuddlesAmount=     {2.0,   2.0, 0.0},
            fPuddlesMaskAmount=   {0.0, 0.0, 0.8},
            fPuddlesRippleAmount= {0.005, 0.005, 0.0},
            fRainDropsAmount=   {0.02, 0.02, 0},
            fRainDropsLighting=   {1.0},
            fRainDropsSpeed=    {1}, -- speed cant be interpolated it, because of how rain entity works
            fSplashesAmount=    {0.2, 0.2, 0.0},
          },
        },
        {
          class="WindArea", -- cant be interpolated unless physicalized per frame, but not really needed
          properties=
          {
            --        start,  full(default=start), end(default=start)
            bActive=    {1},
            bEllipsoidal= {0},
            Speed=      {0.5},
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
          rtpcValue=0.2,
        },
        {
          class="AudioAreaAmbience",
          trigger="Play_rain",
          rtpc="weather_intensity",
          rtpcValue=0.75,
        },
        {
          class="AudioAreaAmbience",
          trigger="Play_nuclear_winter",
          rtpc="freeze_strength",
          rtpcValue=-0.4,
        },
      },
      tod=
      {
        -- lower sun + slight dof
        [etod.PARAM_SUN_INTENSITY]=           {0.5, method=emix.MULTIPLY, min=100}, -- lux is logaritmic so half it by decreasing by factor 10

        [etod.PARAM_COLORGRADING_DOF_FOCUSRANGE]=   {500},
        [etod.PARAM_COLORGRADING_DOF_BLURAMOUNT]=   {0.1, method=emix.ADDITIVE},
      },
    },

--------------------------------------------------------------------------------------------
    {
      name="ClearSkyWindySnow_Outro",
      probability=0,
      danger=10,
      continue={
        ["ClearSkyWindySnow_Outro"] = { probability = 10, stage = 1, }, -- jump directly to peak
        ["Snow_Outro"] = 90, -- Continue pattern starts at fade out of this pattern, so blending works
      }, 
      duration={4, 15},
      ramp={0.1, 0.005}, -- use 10% fade-in and 0.5% fade-out
      modifiers = { -- values added to current baseline (faded in and out)
        --              outside, inside, underground, underwater
        humidity=       {0.3,       0.2,    0.15,         },
        light=          {-0.3,      -0.2,                },
        temperature=    {-25,       -15,       -3,    -7   },
      },
      entities={
        {
          class="Snow",
          pos={ x=4096, y=4096, z=450 }, -- center of map
          properties=
          {
            bEnabled= {1},
            fRadius= {8000}, -- whole map
            ["SnowFall.fBrightness"]= {20},
            ["SnowFall.fGravityScale"]= {1.0},
            ["SnowFall.nSnowFlakeCount"]= {0},
            ["Surface.fSnowAmount"]= {10.0},
            ["Surface.fFrostAmount"]= {1.0,0.7, 0.7},
            ["Surface.fSurfaceFreezing"]= {0.3},
          },
          OnCustomUpdate=windMover,
        },
        {
          class="Rain",
          properties=
          {
            --            start,  full(default=start), end(default=start)
            bEnabled=       {1},
            fAmount=        {0},
            fDiffuseDarkening=    {0.1,   0.1, 0.0},
            fPuddlesAmount=     {0.0},
            fPuddlesMaskAmount=   {0.0,},
            fPuddlesRippleAmount= {0.005, },
            fRainDropsAmount=   {0.02},
            fRainDropsLighting=   {1.0},
            fRainDropsSpeed=    {1}, -- speed cant be interpolated it, because of how rain entity works
            fSplashesAmount=    {0.0},
          },
        },
        {
          class="WindArea", -- cant be interpolated unless physicalized per frame, but not really needed
          properties=
          {
            --        start,  full(default=start), end(default=start)
            bActive=    {1},
            bEllipsoidal= {0},
            Speed=      {0.5},
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
          rtpcValue=0.5,
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
      name="ClearSkyWindy",
      probability=30,
      danger=-7,
      duration={5, 19},
      continue={
        ["ClearSkyStormy"] = 5,
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
      name="ClearSkyStormy",
      probability=2, 
      danger=1,
      dangerlimit=20,
      duration={5, 8},
      continue={
        ["StormyDistantThunder"] = 5,
        ["HeavyStorm"] = 2,
      }, 
      modifiers = { -- values added to current baseline (faded in and out)
        --          outside, inside, underground, underwater
        light=      {-0.05,    -0.03,               },
        temperature={-4,      -2,                 },
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
            Speed=      {1.5},
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
          rtpcValue=1.2,
        },
      },
      tod=
      {
        -- method=default lerp, min=totalmin, max=totalmax
        [etod.PARAM_SUN_INTENSITY]=           {0.9, method=emix.MULTIPLY, min=100}, -- lux is logaritmic so halve it by decreasing by factor 10

        [etod.PARAM_COLORGRADING_DOF_FOCUSRANGE]=   {800},
        [etod.PARAM_COLORGRADING_DOF_BLURAMOUNT]=   {0.14, method=emix.ADDITIVE},
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
        ["HeavyStorm"] = 2,
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
      name="MediumRain",
      probability=1,
      danger=7,
      dangerlimit=40,
      duration={5, 15},
      continue={
        -- Continue pattern starts at fade out of current pattern (so both are active some time)
        ["Rainbow"] = 10,
        ["RainbowHalf"] = 10,
        ["LightRain"] = 1,
        ["StormyDistantThunder"] = 3,
      }, 
      modifiers = { -- values added to current baseline (faded in and out)
        --          outside, inside, underground, underwater
        humidity=   {0.4,    0.13,   0.1,        },
        rain=       {0.5,                         },
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
            fRainDropsLighting=   {2.5},
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
        [etod.PARAM_FOG_RADIAL_COLOR_MULTIPLIER]=   {0.1},
        [etod.PARAM_VOLFOG_GLOBAL_DENSITY]=       {0.4, undergroundFactor=_uff, insideFactor=_iff},
        [etod.PARAM_VOLFOG_RAMP_INFLUENCE]=       {0.1, undergroundFactor=_uff, insideFactor=_iff},
        [etod.PARAM_FOG_COLOR_MULTIPLIER]=        {0.15},
        [etod.PARAM_FOG_COLOR2]=            {{ x=150/255, y=175/255, z=190/255 }, constraint=econ.DARKEN, },
        [etod.PARAM_FOG_COLOR2_MULTIPLIER]=       {0.15},
        [etod.PARAM_VOLFOG_HEIGHT2]=          {4000},
        [etod.PARAM_VOLFOG_DENSITY2]=         {0.4, undergroundFactor=_uff, insideFactor=_iff},
        [etod.PARAM_VOLFOG_RADIAL_SIZE]=        {0.5, undergroundFactor=_uff, insideFactor=_iff},

        -- Volumetric Fog
        [etod.PARAM_VOLFOG2_HEIGHT2]=         {10000},
        [etod.PARAM_VOLFOG2_GLOBAL_DENSITY]=      {0.5, method=emix.QUART, undergroundFactor=_uff, insideFactor=_iff},

        [etod.PARAM_SKYLIGHT_SUN_INTENSITY_MULTIPLIER]= {15},

        [etod.PARAM_COLORGRADING_FILTERS_GRAIN]=    {0.1},
        [etod.PARAM_COLORGRADING_DOF_FOCUSRANGE]=   {250, undergroundFactor=_ufd, insideFactor=_ifd},
        [etod.PARAM_COLORGRADING_DOF_BLURAMOUNT]=   {0.35, method=emix.ADDITIVE, undergroundFactor=_ufd, insideFactor=_ifd},
      },
    },

--------------------------------------------------------------------------------------------
    {
      name="HeavyRain",
      probability=1,
      danger=15,
      dangerlimit=40,
      duration={7, 20},
      continue={
        -- Continue pattern starts at fade out of current pattern (so both are active some time)
        ["Rainbow"] = 10,
        ["RainbowHalf"] = 10,
        ["LightRain"] = 1,
        ["StormyDistantThunder"] = 3,
      }, 
      modifiers = { -- values added to current baseline (faded in and out)
        --          outside, inside, underground, underwater
        humidity=   {0.7,    0.2,   0.2,        },
        rain=       {0.7,                         },
        light=      {-0.6,    -0.2,               },
        temperature={-9,      -3,     -1,         },
        wind=       {10,       3,     2,          },
      },
      entities=
      {
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
            --            start,  full(default=start), end(default=start)
            bEnabled=       {1},
            fAmount=        {0,   3},
            fDiffuseDarkening=    {0,   1.0},
            fPuddlesAmount=     {0,   2.0},
            fPuddlesMaskAmount=   {0.7},
            fPuddlesRippleAmount= {0,   2.0},
            fRainDropsAmount=   {0,   0.05},
            fRainDropsLighting=   {3.0},
            fRainDropsSpeed=    {2}, -- speed cant be interpolated it, because of how rain entity works
            fSplashesAmount=    {0,   2.0},
          },
        },
        {
          class="WindArea", -- cant be interpolated unless physicalized per frame, but not really needed
          properties=
          {
            --        start, full(default=start), end(default=start)
            bActive=    {1},
            bEllipsoidal= {0},
            Speed=      {2.4},
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
          trigger="Play_rain",
          rtpc="weather_intensity",
          rtpcValue=3.9,
        },
        {
          class="AudioAreaAmbience",
          trigger="Play_wind",
          rtpc="wind_speed",
          rtpcValue=5.0,
        },
      },
      tod=
      {
        -- method=default lerp, min=totalmin, max=totalmax
        [etod.PARAM_SUN_INTENSITY]=           {0.15, method=emix.MULTIPLY, min=100}, -- lux is logaritmic so half it by decreasing by factor 10

        -- Non-Volumetric Fog
        [etod.PARAM_FOG_RADIAL_COLOR_MULTIPLIER]=   {0.1},
        [etod.PARAM_VOLFOG_GLOBAL_DENSITY]=       {0.5, undergroundFactor=_uff, insideFactor=_iff},
        [etod.PARAM_VOLFOG_RAMP_INFLUENCE]=       {0.1, undergroundFactor=_uff, insideFactor=_iff},
        [etod.PARAM_FOG_COLOR_MULTIPLIER]=        {0.3},
        [etod.PARAM_FOG_COLOR2]=            {{ x=150/255, y=175/255, z=190/255 }, constraint=econ.DARKEN, },
        [etod.PARAM_FOG_COLOR2_MULTIPLIER]=       {0.33},
        [etod.PARAM_VOLFOG_HEIGHT2]=          {4000},
        [etod.PARAM_VOLFOG_DENSITY2]=         {0.8, undergroundFactor=_uff, insideFactor=_iff},
        [etod.PARAM_VOLFOG_RADIAL_SIZE]=        {0.5, undergroundFactor=_uff, insideFactor=_iff},

        -- Volumetric Fog
        [etod.PARAM_VOLFOG2_HEIGHT2]=         {10000},
        [etod.PARAM_VOLFOG2_GLOBAL_DENSITY]=      {0.75, method=emix.QUART, undergroundFactor=_uff, insideFactor=_iff},

        [etod.PARAM_SKYLIGHT_SUN_INTENSITY_MULTIPLIER]= {50},

        [etod.PARAM_COLORGRADING_FILTERS_GRAIN]=    {0.2},
        [etod.PARAM_COLORGRADING_DOF_FOCUSRANGE]=   {200, undergroundFactor=_ufd, insideFactor=_ifd},
        [etod.PARAM_COLORGRADING_DOF_BLURAMOUNT]=   {0.5, method=emix.ADDITIVE, undergroundFactor=_ufd, insideFactor=_ifd},
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
        WeatherSirenTriggers[1],WeatherSirenTriggers[2],WeatherSirenTriggers[3],WeatherSirenTriggers[4],WeatherSirenTriggers[5],WeatherSirenTriggers[6],WeatherSirenTriggers[7],WeatherSirenTriggers[8],WeatherSirenTriggers[9],WeatherSirenTriggers[10],WeatherSirenTriggers[11],
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

        [etod.PARAM_COLORGRADING_FILTERS_PHOTOFILTER_COLOR]=    {{ x=244/255, y=223/255, z=66/255 }, constraint=econ.BRIGTHEN, },
        [etod.PARAM_COLORGRADING_FILTERS_PHOTOFILTER_DENSITY]=  {0.25},
        [etod.PARAM_COLORGRADING_FILTERS_GRAIN]=    {0.1},
        [etod.PARAM_COLORGRADING_DOF_FOCUSRANGE]=   {500},
        [etod.PARAM_COLORGRADING_DOF_BLURAMOUNT]=   {0.2, method=emix.ADDITIVE},
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
        ["LightRain"] = 1,
        ["StormyDistantThunder"] = 3,
      }, 
      modifiers = { -- values added to current baseline (faded in and out)
        --          outside, inside, underground, underwater
        humidity=   {0.4,    0.13,   0.1,        },
        rain=       {0.5,                         },
        rain_acid=  {1.20,     0.0,    0.0,  0.1    },
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

        [etod.PARAM_COLORGRADING_FILTERS_PHOTOFILTER_COLOR]=    {{ x=244/255, y=223/255, z=66/255 }, constraint=econ.BRIGTHEN, },
        [etod.PARAM_COLORGRADING_FILTERS_PHOTOFILTER_DENSITY]=  {0.3, undergroundFactor=_ufc, insideFactor=_ifc},
        [etod.PARAM_COLORGRADING_FILTERS_GRAIN]=    {0.24},
        [etod.PARAM_COLORGRADING_DOF_FOCUSRANGE]=   {250, undergroundFactor=_ufd, insideFactor=_ifd},
        [etod.PARAM_COLORGRADING_DOF_BLURAMOUNT]=   {0.4, method=emix.ADDITIVE, undergroundFactor=_ufd, insideFactor=_ifd},
      },
    },

--------------------------------------------------------------------------------------------
    {
      name="Blizzard",
      probability=0,
      danger=20,
      dangerlimit=25,
      duration={8, 13},
      continue={
        ["Snow"] = { probability = 100, stage = 1, }, -- jump directly to peak
      },
      ramp={0.1, 0.1}, -- use 10% fade-in and 10% fade-out
      modifiers = { -- values added to current baseline (faded in and out)
        --              outside, inside, underground, underwater
        humidity=       {0.4,       0.4,    0.2,         },
        light=          {-0.5,      -0.45,                },
        temperature=    {-45,       -25,       -6,    -15   },
        blizzard=       {1.0,       0,       0,       0   },
      },
      entities={
        {
          class="Snow",
          pos={ x=4096, y=4096, z=450 }, -- center of map
          properties=
          {
            bEnabled= {1},
            fRadius= {8000}, -- whole map
            ["SnowFall.fBrightness"]= {100}, -- so its visible at night
            ["SnowFall.fGravityScale"]= {0.6,1.0,0.5},
            ["SnowFall.nSnowFlakeCount"]= {50,1000,10},
            ["SnowFall.fSnowFlakeSize"]= {3},
            ["SnowFall.fWindScale"]= {0.1},
            ["SnowFall.fTurbulenceStrength"]= {1,10,0.3},
            ["SnowFall.fTurbulenceFreq"]= {0.1,0.5,0.3},
            ["Surface.fSnowAmount"]= {10.0,10.0,3.0},
            ["Surface.fFrostAmount"]= {1.0,100.0,1.0},
            ["Surface.fSurfaceFreezing"]= {0.3,1.0,0.3},
          },
          OnCustomUpdate=windMover,
        },
        {
          class="WindArea", -- cant be interpolated unless physicalized per frame, but not really needed
          properties=
          {
            --        start,  full(default=start), end(default=start)
            bActive=    {1},
            bEllipsoidal= {0},
            Speed=      {3.5},
            Size=     {{ x=200,y=200,z=200 }},
          },
          OnCustomUpdate=windMover,
        },
        {
          class="ParticleEffect",
          properties=
          {
            ParticleEffect= {"weather.snow.blizzard"}, 
            PulsePeriod= {20}, 
            Strength={1.0}, -- Strength={0.0, 1.0},
          },
        },
        BellTriggers[1],BellTriggers[2],BellTriggers[3],
      },
      audio={
        {
          class="AudioAreaAmbience",
          trigger="Play_wind",
          rtpc="wind_speed",
          rtpcValue=8.5,
        },
        {
          class="AudioAreaAmbience",
          trigger="Play_nuclear_winter",
          rtpc="freeze_strength",
          rtpcValue=0.35,
        },
        {
          class="AudioAreaAmbience",
          trigger="Play_rain",
          rtpc="weather_intensity",
          rtpcValue=0.9,
        },
      },
      tod=
      {
        -- Fog + slight color grading blue
        [etod.PARAM_SUN_INTENSITY]=           {0.1, method=emix.MULTIPLY, min=100}, -- lux is logaritmic so half it by decreasing by factor 10
        [etod.PARAM_FOG_RADIAL_COLOR_MULTIPLIER]=   {0.1},

        -- Non-Volumetric Fog
        [etod.PARAM_VOLFOG_GLOBAL_DENSITY]=       {2.3, undergroundFactor=_uff, insideFactor=_iff},
        [etod.PARAM_VOLFOG_RAMP_INFLUENCE]=       {0.08, undergroundFactor=_uff, insideFactor=_iff},
        [etod.PARAM_VOLFOG_HEIGHT_OFFSET]=        {1.0, undergroundFactor=_uff},
        [etod.PARAM_FOG_COLOR2]=            {{ x=150/255, y=175/255, z=190/255 }, constraint=econ.DARKEN, },
        [etod.PARAM_FOG_COLOR2_MULTIPLIER]=       {0.33},
        [etod.PARAM_VOLFOG_HEIGHT2]=          {4000},
        [etod.PARAM_VOLFOG_DENSITY2]=         {0.8, undergroundFactor=_uff, insideFactor=_iff},
        [etod.PARAM_VOLFOG_RADIAL_SIZE]=        {0.5, undergroundFactor=_uff, insideFactor=_iff},

        -- Volumetric Fog
        [etod.PARAM_VOLFOG2_GLOBAL_DENSITY]=      {2.3, method=emix.QUART, undergroundFactor=_uff, insideFactor=_iff},

        [etod.PARAM_SKYLIGHT_SUN_INTENSITY_MULTIPLIER]= {10},

        [etod.PARAM_COLORGRADING_FILTERS_GRAIN]=    {0.35},
        [etod.PARAM_COLORGRADING_DOF_FOCUSRANGE]=   {180, undergroundFactor=_ufd, insideFactor=_ifd},
        [etod.PARAM_COLORGRADING_DOF_BLURAMOUNT]=   {0.5, method=emix.ADDITIVE, undergroundFactor=_ufd, insideFactor=_ifd},

        -- Colorgrading
        [etod.PARAM_COLORGRADING_FILTERS_PHOTOFILTER_COLOR]=    {{ x=4/255, y=2/255, z=62/255 }, }, -- dark blue
        [etod.PARAM_COLORGRADING_FILTERS_PHOTOFILTER_DENSITY]=  {0.3, undergroundFactor=_ufc, insideFactor=_ifc},
      },
    },

--------------------------------------------------------------------------------------------
    {
      name="BlizzardThunder",
      probability=0,
      danger=25,
      dangerlimit=30,
      duration={8, 13},
      continue={
        ["Snow"] = { probability = 100, stage = 1, }, -- jump directly to peak
      },
      ramp={0.1, 0.1}, -- use 10% fade-in and 10% fade-out
      modifiers = { -- values added to current baseline (faded in and out)
        --              outside, inside, underground, underwater
        humidity=       {0.4,       0.4,    0.2,         },
        light=          {-0.5,      -0.45,                },
        temperature=    {-45,       -25,       -6,    -15   },
        blizzard=       {1.0,       0,       0,       0   },
      },
      entities={
        {
          class="Snow",
          pos={ x=4096, y=4096, z=450 }, -- center of map
          properties=
          {
            bEnabled= {1},
            fRadius= {8000}, -- whole map
            ["SnowFall.fBrightness"]= {100}, -- so its visible at night
            ["SnowFall.fGravityScale"]= {0.6,1.0,0.5},
            ["SnowFall.nSnowFlakeCount"]= {50,1000,10},
            ["SnowFall.fSnowFlakeSize"]= {3},
            ["SnowFall.fWindScale"]= {0.1},
            ["SnowFall.fTurbulenceStrength"]= {1,10,0.3},
            ["SnowFall.fTurbulenceFreq"]= {0.1,0.5,0.3},
            ["Surface.fSnowAmount"]= {10.0,10.0,3.0},
            ["Surface.fFrostAmount"]= {1.0,100.0,1.0},
            ["Surface.fSurfaceFreezing"]= {0.3,1.0,0.3},
          },
          OnCustomUpdate=windMover,
        },
        {
          class="WindArea", -- cant be interpolated unless physicalized per frame, but not really needed
          properties=
          {
            --        start,  full(default=start), end(default=start)
            bActive=    {1},
            bEllipsoidal= {0},
            Speed=      {3.5},
            Size=     {{ x=200,y=200,z=200 }},
          },
          OnCustomUpdate=windMover,
        },
        {
          class="ParticleEffect",
          properties=
          {
            ParticleEffect= {"weather.snow.blizzard"}, 
            PulsePeriod= {20}, 
            Strength={1.0}, -- Strength={0.0, 1.0},
          },
        },
        BellTriggers[1],BellTriggers[2],BellTriggers[3],
        {
          class="Lightning",
          properties=
          {
            bActive= {1},
            fDistance= {800,500}, -- lightning closes distance to player and then goes away again
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
            ["Effects.ParticleEffect"]= {"weather.lightning.lightningbolt1"},
            ["Effects.ParticleScale"]= {4,3}, -- have them a bit larger at distance
            ["Effects.SkyHighlightVerticalOffset"]= {300,60},
            ["Effects.SkyHighlightMultiplier"]= {0.3,1},
            ["Audio.audioTriggerPlayTrigger"]= {"Play_thunder"},
          },
        },
      },
      audio={
        {
          class="AudioAreaAmbience",
          trigger="Play_wind",
          rtpc="wind_speed",
          rtpcValue=8.5,
        },
        {
          class="AudioAreaAmbience",
          trigger="Play_nuclear_winter",
          rtpc="freeze_strength",
          rtpcValue=0.35,
        },
        {
          class="AudioAreaAmbience",
          trigger="Play_rain",
          rtpc="weather_intensity",
          rtpcValue=0.9,
        },
      },
      tod=
      {
        -- Fog + slight color grading blue
        [etod.PARAM_SUN_INTENSITY]=           {0.1, method=emix.MULTIPLY, min=100}, -- lux is logaritmic so half it by decreasing by factor 10
        [etod.PARAM_FOG_RADIAL_COLOR_MULTIPLIER]=   {0.1},

        -- Non-Volumetric Fog
        [etod.PARAM_VOLFOG_GLOBAL_DENSITY]=       {2.3, undergroundFactor=_uff, insideFactor=_iff},
        [etod.PARAM_VOLFOG_RAMP_INFLUENCE]=       {0.08, undergroundFactor=_uff, insideFactor=_iff},
        [etod.PARAM_VOLFOG_HEIGHT_OFFSET]=        {1.0, undergroundFactor=_uff},
        [etod.PARAM_FOG_COLOR2]=            {{ x=150/255, y=175/255, z=190/255 }, constraint=econ.DARKEN, },
        [etod.PARAM_FOG_COLOR2_MULTIPLIER]=       {0.33},
        [etod.PARAM_VOLFOG_HEIGHT2]=          {4000},
        [etod.PARAM_VOLFOG_DENSITY2]=         {0.8, undergroundFactor=_uff, insideFactor=_iff},
        [etod.PARAM_VOLFOG_RADIAL_SIZE]=        {0.5, undergroundFactor=_uff, insideFactor=_iff},

        -- Volumetric Fog
        [etod.PARAM_VOLFOG2_GLOBAL_DENSITY]=      {2.3, method=emix.QUART, undergroundFactor=_uff, insideFactor=_iff},

        [etod.PARAM_SKYLIGHT_SUN_INTENSITY_MULTIPLIER]= {10},

        [etod.PARAM_COLORGRADING_FILTERS_GRAIN]=    {0.35},
        [etod.PARAM_COLORGRADING_DOF_FOCUSRANGE]=   {180, undergroundFactor=_ufd, insideFactor=_ifd},
        [etod.PARAM_COLORGRADING_DOF_BLURAMOUNT]=   {0.5, method=emix.ADDITIVE, undergroundFactor=_ufd, insideFactor=_ifd},

        -- Colorgrading
        [etod.PARAM_COLORGRADING_FILTERS_PHOTOFILTER_COLOR]=    {{ x=4/255, y=2/255, z=62/255 }, }, -- dark blue
        [etod.PARAM_COLORGRADING_FILTERS_PHOTOFILTER_DENSITY]=  {0.3, undergroundFactor=_ufc, insideFactor=_ifc},
      },
    },

--------------------------------------------------------------------------------------------
    {
      name="Fireflies",
      probability=3,
      danger=-10,
      duration={8, 14},
      todlimit={20,5},
      ramp={0.3, 0.3},
      modifiers = {
        --          outside, inside, underground, underwater
        humidity=   {0.05,   0,      0,          },
        temperature={-2,     0,                  },
      },
      entities=
      {
        {
          class="ParticleEffect",
          properties=
          {
            ParticleEffect= {"environment_fx.fireflies"},
            PulsePeriod= {30},
            Strength={0.0, 1.0},
          },
          OnCustomUpdate=windMover,
        },
      },
      audio={},
    },
--------------------------------------------------------------------------------------------
    -- ApproachingStorm: Ominous buildup - sky darkens, wind rises, distant flickering lightning
    -- Players get a warning window to find shelter before the storm hits
    {
      name="ApproachingStorm",
      probability=1,
      danger=3,
      dangerlimit=30,
      duration={4, 7},
      continue={
        ["HeavyRainThunder"] = 40,
        ["HeavyStorm"] = 30,
        ["MediumRain"] = 20,
        ["ClearSkyStormy"] = 10,
      },
      ramp={0.4, 0.15},
      modifiers = {
        --              outside, inside, underground, underwater
        humidity=       {0.08,    0.04,   0.02,       },
        light=          {-0.15,   -0.08,              },
        temperature=    {-3,      -1,                 },
        wind=           {12,      3,      1,          },
      },
      entities=
      {
        BellTriggers[1],BellTriggers[2],BellTriggers[3],
        {
          class="ParticleEffect",
          properties=
          {
            ParticleEffect= {"weather.approaching_storm"},
            PulsePeriod= {0},
            Strength={0.0, 1.0},
          },
        },
        {
          class="ParticleEffect",
          properties=
          {
            ParticleEffect= {"environment_fx.debris_wind"},
            PulsePeriod= {15},
            Strength={1.0},
          },
        },
        {
          class="Lightning",
          properties=
          {
            bActive= {1},
            fDistance= {900,850},
            bRelativeToPlayer= {1},
            ["Timing.fDelay"]= {40},
            ["Timing.fDelayVariation"]= {0.8},
            ["Timing.fLightningDuration"]= {0.1},
            ["Effects.LightIntensity"]= {0.02,0.05},
            ["Effects.ParticleEffect"]= {"weather.lightning.lightningbolt1"},
            ["Effects.ParticleScale"]= {0.4},
            ["Effects.SkyHighlightVerticalOffset"]= {350,300},
            ["Effects.SkyHighlightMultiplier"]= {0.02,0.04},
            ["Audio.audioTriggerPlayTrigger"]= {"Play_thunder"},
          },
        },
        {
          class="WindArea",
          properties=
          {
            bActive=      {1},
            bEllipsoidal= {0},
            Speed=        {1.5},
            Size=         {{ x=200,y=200,z=200 }},
            Dir=          {{ x=1,y=0.5,z=-0.3 }},
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
          rtpcValue=2.0,
        },
      },
      tod=
      {
        [etod.PARAM_SUN_INTENSITY]=                       {0.7, method=emix.MULTIPLY, min=100},
        [etod.PARAM_FOG_COLOR2]=                          {{ x=80/255, y=85/255, z=95/255 }, constraint=econ.DARKEN, },
        [etod.PARAM_FOG_COLOR2_MULTIPLIER]=               {0.5},
        [etod.PARAM_SKYLIGHT_SUN_INTENSITY_MULTIPLIER]=   {25},
        [etod.PARAM_CLOUDSHADING_SUNLIGHT_MULTIPLIER]=    {0.4},
        [etod.PARAM_COLORGRADING_DOF_FOCUSRANGE]=         {600, undergroundFactor=_ufd, insideFactor=_ifd},
        [etod.PARAM_COLORGRADING_DOF_BLURAMOUNT]=         {0.15, method=emix.ADDITIVE, undergroundFactor=_ufd, insideFactor=_ifd},
      },
    },
--------------------------------------------------------------------------------------------
    -- MorningMist: Terrain-hugging fog at dawn with crepuscular rays breaking through
    -- Reduced ground visibility but clear sky above - eerie forest encounters
    {
      name="MorningMist",
      probability=1,
      danger=8,
      dangerlimit=30,
      duration={6, 10},
      todlimit={4,9},
      ramp={0.3, 0.5},
      continue={
        ["LightFog"] = 15,
        ["ClearSky"] = 50,
      },
      modifiers = {
        --              outside, inside, underground, underwater
        humidity=       {0.25,    0.15,   0.1,        },
        light=          {-0.15,   -0.05,              },
        temperature=    {-6,      -2,                 },
        fog=            {0.4,     0,      0,          },
      },
      entities=
      {
        {
          class="ParticleEffect",
          properties=
          {
            ParticleEffect= {"environment_fx.morning_mist_drift"},
            PulsePeriod= {0},
            Strength={0.0, 1.0, 0.3},
          },
        },
        {
          class="ParticleEffect",
          properties=
          {
            ParticleEffect= {"environment_fx.crepuscular_rays"},
            PulsePeriod= {0},
            Strength={0.0, 0.8},
          },
        },
      },
      audio=
      {
        {
          class="AudioAreaAmbience",
          trigger="Play_wind",
          rtpc="wind_speed",
          rtpcValue=0.3,
        },
      },
      tod=
      {
        [etod.PARAM_SUN_INTENSITY]=                       {0.4, method=emix.MULTIPLY, min=100},
        [etod.PARAM_VOLFOG_GLOBAL_DENSITY]=               {0.05, undergroundFactor=_uff, insideFactor=_iff},
        [etod.PARAM_VOLFOG_RAMP_INFLUENCE]=               {0.8, undergroundFactor=_uff, insideFactor=_iff},
        [etod.PARAM_VOLFOG_HEIGHT_OFFSET]=                {-0.5, undergroundFactor=_uff},
        [etod.PARAM_VOLFOG2_GLOBAL_DENSITY]=              {0.02, method=emix.QUART, undergroundFactor=_uff, insideFactor=_iff},
        [etod.PARAM_VOLFOG2_COLOR1]=                      {{ x=220/255, y=210/255, z=180/255 }, constraint=econ.NONE,},
        [etod.PARAM_SUN_SHAFTS_VISIBILITY]=               {1.5},
        [etod.PARAM_SUN_RAYS_VISIBILITY]=                 {1.5},
        [etod.PARAM_COLORGRADING_FILTERS_GRAIN]=          {0.15},
        [etod.PARAM_COLORGRADING_DOF_FOCUSRANGE]=         {300, undergroundFactor=_ufd, insideFactor=_ifd},
        [etod.PARAM_COLORGRADING_DOF_BLURAMOUNT]=         {0.12, method=emix.ADDITIVE, undergroundFactor=_ufd, insideFactor=_ifd},
      },
    },
--------------------------------------------------------------------------------------------
    -- AuroraBorealis: Rare nighttime spectacle - shimmering green/purple sky curtains
    -- Nuclear fallout in the upper atmosphere makes aurora visible at low latitudes
    -- Peaceful and beautiful - a respite from the harshness of survival
    {
      name="AuroraBorealis",
      probability=1,
      danger=-5,
      duration={10, 20},
      todlimit={21,4},
      ramp={0.4, 0.4},
      modifiers = {
        --              outside, inside, underground, underwater
        humidity=       {0.05,    0.0,                },
        temperature=    {-8,      -3,     0,     -2   },
      },
      --entities= Instead of this we need a custom shader/skybox
      --{
        --{
          --class="ParticleEffect",
          --pos={ x=4096, y=5500, z=600 },
          --properties=
          --{
            --ParticleEffect= {"weather.aurora_borealis"},
            --PulsePeriod= {0},
            --Strength={1.0},
          --},
        --},
      --},
      audio=
      {
        {
          class="AudioAreaAmbience",
          trigger="Play_wind",
          rtpc="wind_speed",
          rtpcValue=0.3,
        },
      },
      tod=
      {
        [etod.PARAM_NIGHSKY_HORIZON_COLOR]=               {{ x=20/255, y=180/255, z=80/255 }},
        [etod.PARAM_NIGHSKY_HORIZON_COLOR_MULTIPLIER]=    {1.5},
        [etod.PARAM_NIGHSKY_ZENITH_COLOR]=                {{ x=60/255, y=20/255, z=140/255 }},
        [etod.PARAM_NIGHSKY_ZENITH_COLOR_MULTIPLIER]=     {1.2},
        [etod.PARAM_NIGHSKY_MOON_OUTERCORONA_COLOR]=      {{ x=50/255, y=200/255, z=100/255 }},
        [etod.PARAM_SKYBOX_MULTIPLIER]=                   {2.0},
        [etod.PARAM_COLORGRADING_FILTERS_PHOTOFILTER_COLOR]=  {{ x=30/255, y=200/255, z=100/255 }, constraint=econ.BRIGTHEN, },
        [etod.PARAM_COLORGRADING_FILTERS_PHOTOFILTER_DENSITY]= {0.08, undergroundFactor=_ufc, insideFactor=_ifc},
        [etod.PARAM_AURORA_COLOR]=                        {{ x=20/255, y=180/255, z=80/255 }},
        [etod.PARAM_AURORA_INTENSITY]=                    {1.0},
      },
    },
--------------------------------------------------------------------------------------------
    -- DustStorm: High wind drives dust and debris through the ruins
    -- Amber-brown visibility reduction, wind pushes player, flying debris hazard
    {
      name="DustStorm",
      probability=1,
      danger=18,
      dangerlimit=35,
      duration={8, 15},
      ramp={0.25, 0.35},
      continue={
        ["LightFog"] = 20,
        ["ClearSkyWindy"] = 30,
      },
      modifiers = {
        --              outside, inside, underground, underwater
        humidity=       {-0.05,   0.0,    0.0,        },
        light=          {-0.4,    -0.15,              },
        temperature=    {3,       1,                  },
        wind=           {45,      8,      2,      1   },
        dust=           {1.0,     0,      0,      0   },
      },
      entities=
      {
        {
          class="ParticleEffect",
          properties=
          {
            ParticleEffect= {"weather.dust_devil"},
            PulsePeriod= {25},
            Strength={0.0, 0.7},
          },
        },
        {
          class="ParticleEffect",
          properties=
          {
            ParticleEffect= {"environment_fx.debris_wind"},
            PulsePeriod= {10},
            Strength={0.0, 1.0},
          },
        },
        {
          class="WindArea",
          properties=
          {
            bActive=      {1},
            bEllipsoidal= {0},
            Speed=        {4.5},
            Size=         {{ x=200,y=200,z=200 }},
            Dir=          {{ x=1,y=0.8,z=-0.3 }},
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
          rtpcValue=7.0,
        },
      },
      tod=
      {
        [etod.PARAM_SUN_INTENSITY]=                       {0.2, method=emix.MULTIPLY, min=100},
        [etod.PARAM_FOG_RADIAL_COLOR_MULTIPLIER]=         {0.15},
        [etod.PARAM_VOLFOG_GLOBAL_DENSITY]=               {2.0, undergroundFactor=_uff, insideFactor=_iff},
        [etod.PARAM_VOLFOG_RAMP_INFLUENCE]=               {0.1, undergroundFactor=_uff, insideFactor=_iff},
        [etod.PARAM_FOG_COLOR]=                           {{ x=160/255, y=120/255, z=60/255 }, constraint=econ.DARKEN },
        [etod.PARAM_FOG_COLOR2]=                          {{ x=180/255, y=140/255, z=70/255 }, constraint=econ.DARKEN, },
        [etod.PARAM_VOLFOG2_GLOBAL_DENSITY]=              {1.5, method=emix.QUART, undergroundFactor=_uff, insideFactor=_iff},
        [etod.PARAM_COLORGRADING_FILTERS_PHOTOFILTER_COLOR]=  {{ x=210/255, y=160/255, z=60/255 }, constraint=econ.BRIGTHEN, },
        [etod.PARAM_COLORGRADING_FILTERS_PHOTOFILTER_DENSITY]= {0.4, undergroundFactor=_ufc, insideFactor=_ifc},
        [etod.PARAM_COLORGRADING_FILTERS_GRAIN]=          {0.3},
        [etod.PARAM_COLORGRADING_DOF_FOCUSRANGE]=         {150, undergroundFactor=_ufd, insideFactor=_ifd},
        [etod.PARAM_COLORGRADING_DOF_BLURAMOUNT]=         {0.45, method=emix.ADDITIVE, undergroundFactor=_ufd, insideFactor=_ifd},
      },
    },
--------------------------------------------------------------------------------------------
    -- VolcanicHaze: Distant eruption pushes warm amber haze across the island
    -- Sun becomes a dim red disc, temperature rises, slight radiation from particulate
    {
      name="VolcanicHaze",
      probability=1,
      danger=15,
      dangerlimit=35,
      duration={12, 25},
      ramp={0.3, 0.4},
      continue={
        ["DustStorm"] = 10,
      },
      modifiers = {
        --              outside, inside, underground, underwater
        humidity=       {-0.05,   0.0,    0.0,        },
        light=          {-0.3,    -0.1,               },
        temperature=    {8,       4,      1,     2    },
        gas_radiation=  {0.025,    0.005,               },
        geigercounter=  {0.5,     0.25,   0.0,   0   },
        dust=           {0.7,     0,      0,      0   },
        fog=            {0.6,     0,      0,      0   },
      },
      entities=
      {
        {
          class="ParticleEffect",
          properties=
          {
            ParticleEffect= {"weather.volcanic_haze"},
            PulsePeriod= {0},
            Strength={0.0, 1.0},
          },
        },
        {
          class="ParticleEffect",
          properties=
          {
            ParticleEffect= {"weather.ash.volcanic_ash"},
            PulsePeriod= {0},
            Strength={0.0, 1.0},
          },
        },
        {
          class="ParticleEffect",
          properties=
          {
            ParticleEffect= {"environment_fx.heat_shimmer"},
            PulsePeriod= {0},
            Strength={0.0, 0.6},
          },
        },
      },
      audio=
      {
        {
          class="AudioAreaAmbience",
          trigger="Play_wind",
          rtpc="wind_speed",
          rtpcValue=0.8,
        },
      },
      tod=
      {
        [etod.PARAM_SUN_INTENSITY]=                       {0.15, method=emix.MULTIPLY, min=100},
        [etod.PARAM_SUN_COLOR]=                           {{ x=255/255, y=100/255, z=30/255 }, constraint=econ.DARKEN, },
        [etod.PARAM_FOG_COLOR]=                           {{ x=140/255, y=80/255, z=30/255 }, constraint=econ.DARKEN },
        [etod.PARAM_FOG_COLOR2]=                          {{ x=170/255, y=100/255, z=40/255 }, constraint=econ.DARKEN, },
        [etod.PARAM_FOG_COLOR_MULTIPLIER]=                {0.6},
        [etod.PARAM_VOLFOG_GLOBAL_DENSITY]=               {1.2, undergroundFactor=_uff, insideFactor=_iff},
        [etod.PARAM_VOLFOG2_GLOBAL_DENSITY]=              {0.8, method=emix.QUART, undergroundFactor=_uff, insideFactor=_iff},
        [etod.PARAM_COLORGRADING_FILTERS_PHOTOFILTER_COLOR]=  {{ x=220/255, y=130/255, z=40/255 }, constraint=econ.BRIGTHEN, },
        [etod.PARAM_COLORGRADING_FILTERS_PHOTOFILTER_DENSITY]= {0.35, undergroundFactor=_ufc, insideFactor=_ifc},
        [etod.PARAM_COLORGRADING_FILTERS_GRAIN]=          {0.25},
        [etod.PARAM_SUN_RAYS_VISIBILITY]=                 {0.2},
        [etod.PARAM_COLORGRADING_DOF_FOCUSRANGE]=         {400, undergroundFactor=_ufd, insideFactor=_ifd},
        [etod.PARAM_COLORGRADING_DOF_BLURAMOUNT]=         {0.2, method=emix.ADDITIVE, undergroundFactor=_ufd, insideFactor=_ifd},
      },
    },
--------------------------------------------------------------------------------------------
    -- FreezingRain: Rain freezes on contact - surfaces ice over, hypothermia risk
    -- Rapid temperature drop with glinting ice particles
    {
      name="FreezingRain",
      probability=1,
      danger=20,
      dangerlimit=35,
      duration={6, 12},
      ramp={0.2, 0.3},
      continue={
        ["Snow"] = 40,
        ["Snow_Outro"] = 30,
        ["LightFog"] = 10,
      },
      modifiers = {
        --              outside, inside, underground, underwater
        humidity=       {0.5,     0.2,    0.1,        },
        rain=           {0.4,                         },
        light=          {-0.35,   -0.15,              },
        temperature=    {-25,     -10,    -3,    -8   },
        wind=           {8,       2,      1,          },
      },
      entities=
      {
        {
          class="ParticleEffect",
          properties=
          {
            ParticleEffect= {"weather.freezing_rain"},
            PulsePeriod= {0},
            Strength={0.0, 1.0},
          },
        },
        {
          class="ParticleEffect",
          properties=
          {
            ParticleEffect= {"environment_fx.frost_crystals"},
            PulsePeriod= {20},
            Strength={0.0, 0.8},
          },
        },
        {
          class="Rain",
          properties=
          {
            bEnabled=             {1},
            fAmount=              {0,    1.5},
            fDiffuseDarkening=    {0,    0.6},
            fPuddlesAmount=       {0,    1.5},
            fPuddlesMaskAmount=   {0.7},
            fPuddlesRippleAmount= {0,    1.0},
            fRainDropsAmount=     {0,    0.04},
            fRainDropsLighting=   {3.0},
            fRainDropsSpeed=      {0.6},
            fSplashesAmount=      {0,    0.8},
          },
        },
        {
          class="Snow",
          pos={ x=4096, y=4096, z=450 },
          properties=
          {
            bEnabled= {1},
            fRadius= {8000},
            ["SnowFall.nSnowFlakeCount"]= {0},
            ["Surface.fSnowAmount"]= {0.0},
            ["Surface.fFrostAmount"]= {0.0, 0.9},
            ["Surface.fSurfaceFreezing"]= {0.0, 0.15},
          },
        },
        {
          class="WindArea",
          properties=
          {
            bActive=      {1},
            bEllipsoidal= {0},
            Speed=        {1.5},
            Size=         {{ x=200,y=200,z=200 }},
            Dir=          {{ x=1,y=1,z=-0.5 }},
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
          rtpcValue=1.8,
        },
        {
          class="AudioAreaAmbience",
          trigger="Play_wind",
          rtpc="wind_speed",
          rtpcValue=1.5,
        },
        {
          class="AudioAreaAmbience",
          trigger="Play_nuclear_winter",
          rtpc="freeze_strength",
          rtpcValue=0.5,
        },
      },
      tod=
      {
        [etod.PARAM_SUN_INTENSITY]=                       {0.3, method=emix.MULTIPLY, min=100},
        [etod.PARAM_FOG_RADIAL_COLOR_MULTIPLIER]=         {0.15},
        [etod.PARAM_VOLFOG_GLOBAL_DENSITY]=               {0.4, undergroundFactor=_uff, insideFactor=_iff},
        [etod.PARAM_VOLFOG2_GLOBAL_DENSITY]=              {0.35, method=emix.QUART, undergroundFactor=_uff, insideFactor=_iff},
        [etod.PARAM_VOLFOG2_COLOR1]=                      {{ x=160/255, y=175/255, z=210/255 }, constraint=econ.NONE,},
        [etod.PARAM_SKYLIGHT_SUN_INTENSITY_MULTIPLIER]=   {15},
        [etod.PARAM_COLORGRADING_FILTERS_PHOTOFILTER_COLOR]=  {{ x=150/255, y=180/255, z=220/255 }, constraint=econ.BRIGTHEN, },
        [etod.PARAM_COLORGRADING_FILTERS_PHOTOFILTER_DENSITY]= {0.15, undergroundFactor=_ufc, insideFactor=_ifc},
        [etod.PARAM_COLORGRADING_FILTERS_GRAIN]=          {0.2},
        [etod.PARAM_COLORGRADING_DOF_FOCUSRANGE]=         {280, undergroundFactor=_ufd, insideFactor=_ifd},
        [etod.PARAM_COLORGRADING_DOF_BLURAMOUNT]=         {0.3, method=emix.ADDITIVE, undergroundFactor=_ufd, insideFactor=_ifd},
      },
    },
--------------------------------------------------------------------------------------------
    -- SwampGas: Glowing methane pockets and eerie luminescent fog
    -- Mutated swamp biology creates alien atmosphere with slight radiation
    {
      name="SwampGas",
      probability=0,
      danger=12,
      dangerlimit=30,
      duration={8, 16},
      todlimit={19,6},
      ramp={0.35, 0.4},
      modifiers = {
        --              outside, inside, underground, underwater
        humidity=       {0.3,     0.15,   0.1,        },
        light=          {-0.1,    -0.05,              },
        temperature=    {2,       1,                  },
        gas_radiation=  {0.04,    0.01,               },
        geigercounter=  {0.5,     0.25,   0.0,   0.3 },
        fog=            {0.5,     0,      0,      0   },
      },
      entities=
      {
        {
          class="ParticleEffect",
          properties=
          {
            ParticleEffect= {"environment_fx.marsh_gas"},
            PulsePeriod= {15},
            Strength={0.0, 1.0},
          },
        },
        {
          class="ParticleEffect",
          properties=
          {
            ParticleEffect= {"environment_fx.swamp_bubbles"},
            PulsePeriod= {10},
            Strength={0.5, 1.0},
          },
        },
        {
          class="ParticleEffect",
          properties=
          {
            ParticleEffect= {"weather.fog.fog_light"},
            PulsePeriod= {20},
            Strength={0.0, 0.7},
          },
        },
      },
      audio=
      {
        {
          class="AudioAreaAmbience",
          trigger="Play_wind",
          rtpc="wind_speed",
          rtpcValue=0.3,
        },
      },
      tod=
      {
        [etod.PARAM_SUN_INTENSITY]=                       {0.4, method=emix.MULTIPLY, min=100},
        [etod.PARAM_VOLFOG_GLOBAL_DENSITY]=               {0.8, undergroundFactor=_uff, insideFactor=_iff},
        [etod.PARAM_VOLFOG_RAMP_INFLUENCE]=               {0.6, undergroundFactor=_uff, insideFactor=_iff},
        [etod.PARAM_VOLFOG_HEIGHT_OFFSET]=                {-0.3, undergroundFactor=_uff},
        [etod.PARAM_VOLFOG2_GLOBAL_DENSITY]=              {0.5, method=emix.QUART, undergroundFactor=_uff, insideFactor=_iff},
        [etod.PARAM_VOLFOG2_COLOR1]=                      {{ x=80/255, y=180/255, z=60/255 }, constraint=econ.NONE,},
        [etod.PARAM_NIGHSKY_HORIZON_COLOR]=               {{ x=40/255, y=100/255, z=30/255 }},
        [etod.PARAM_NIGHSKY_HORIZON_COLOR_MULTIPLIER]=    {0.8},
        [etod.PARAM_COLORGRADING_FILTERS_PHOTOFILTER_COLOR]=  {{ x=100/255, y=200/255, z=80/255 }, constraint=econ.BRIGTHEN, },
        [etod.PARAM_COLORGRADING_FILTERS_PHOTOFILTER_DENSITY]= {0.12, undergroundFactor=_ufc, insideFactor=_ifc},
        [etod.PARAM_COLORGRADING_FILTERS_GRAIN]=          {0.25},
      },
    },
--------------------------------------------------------------------------------------------
    -- NuclearSunset: Upper-atmosphere nuclear particulate creates vivid red/orange sky
    -- Harmless but stunning - the sky looks like it is on fire
    {
      name="NuclearSunset",
      probability=1,
      danger=-3,
      duration={4, 7},
      todlimit={16,20},
      ramp={0.3, 0.5},
      modifiers = {
        --              outside, inside, underground, underwater
        temperature=    {2,       1,                  },
      },
      entities=
      {
        {
          class="ParticleEffect",
          pos={ x=4096, y=4096, z=450 },
          properties=
          {
            ParticleEffect= {"weather.nuclear_sunset_particles"},
            PulsePeriod= {0},
            Strength={1.0},
          },
        },
      },
      audio=
      {
        {
          class="AudioAreaAmbience",
          trigger="Play_wind",
          rtpc="wind_speed",
          rtpcValue=0.4,
        },
      },
      tod=
      {
        [etod.PARAM_SUN_COLOR]=                           {{ x=255/255, y=80/255, z=20/255 }, constraint=econ.DARKEN, },
        [etod.PARAM_FOG_COLOR]=                           {{ x=255/255, y=100/255, z=30/255 }},
        [etod.PARAM_FOG_COLOR_MULTIPLIER]=                {1.2},
        [etod.PARAM_FOG_COLOR2]=                          {{ x=255/255, y=60/255, z=10/255 }},
        [etod.PARAM_FOG_COLOR2_MULTIPLIER]=               {0.8},
        [etod.PARAM_FOG_RADIAL_COLOR]=                    {{ x=255/255, y=120/255, z=40/255 }},
        [etod.PARAM_FOG_RADIAL_COLOR_MULTIPLIER]=         {1.5},
        [etod.PARAM_SKYBOX_MULTIPLIER]=                   {1.8},
        [etod.PARAM_SUN_RAYS_VISIBILITY]=                 {1.5},
        [etod.PARAM_CLOUDSHADING_SUNLIGHT_MULTIPLIER]=    {2.0},
        [etod.PARAM_COLORGRADING_FILTERS_PHOTOFILTER_COLOR]=  {{ x=255/255, y=120/255, z=40/255 }, constraint=econ.BRIGTHEN, },
        [etod.PARAM_COLORGRADING_FILTERS_PHOTOFILTER_DENSITY]= {0.2, undergroundFactor=_ufc, insideFactor=_ifc},
      },
    },
--------------------------------------------------------------------------------------------
    -- RadMist: Insidious low-lying radioactive fog rolls in from contaminated zones
    -- Less dramatic than RadStorm but persistent and dangerous - sirens warn players
    {
      name="RadMist",
      probability=1,
      danger=30,
      dangerlimit=40,
      duration={5, 10},
      continue={
        ["RadMist_Peak"] = 100,
      },
      ramp={0.4, 0.1},
      modifiers = {
        --              outside, inside, underground, underwater
        humidity=       {0.2,     0.1,    0.1,        },
        light=          {-0.25,   -0.1,               },
        temperature=    {3,       2,                  },
        gas_radiation=  {0.075,    0.02,               },
        ray_radiation=  {0.025,    0.004,              },
        geigercounter=  {1.5,     1.0,    0.0,   0.5 },
        fog=            {0.5,     0,      0,      0   },
      },
      entities=
      {
        NukeSirenTriggers[1],NukeSirenTriggers[2],NukeSirenTriggers[3],NukeSirenTriggers[4],NukeSirenTriggers[5],NukeSirenTriggers[6],NukeSirenTriggers[7],NukeSirenTriggers[8],NukeSirenTriggers[9],NukeSirenTriggers[10],NukeSirenTriggers[11],
        {
          class="ParticleEffect",
          properties=
          {
            ParticleEffect= {"environment_fx.rad_motes"},
            PulsePeriod= {0},
            Strength={0.0, 0.6},
          },
        },
        {
          class="ParticleEffect",
          properties=
          {
            ParticleEffect= {"weather.fog.fog_medium"},
            PulsePeriod= {20},
            Strength={0.0, 1.0},
          },
        },
      },
      audio=
      {
        {
          class="AudioAreaAmbience",
          trigger="Play_wind",
          rtpc="wind_speed",
          rtpcValue=0.5,
        },
      },
      tod=
      {
        [etod.PARAM_SUN_INTENSITY]=                       {0.3, method=emix.MULTIPLY, min=100},
        [etod.PARAM_VOLFOG_GLOBAL_DENSITY]=               {2.0, undergroundFactor=_uff, insideFactor=_iff},
        [etod.PARAM_VOLFOG_RAMP_INFLUENCE]=               {0.3, undergroundFactor=_uff, insideFactor=_iff},
        [etod.PARAM_VOLFOG_HEIGHT_OFFSET]=                {0.2, undergroundFactor=_uff},
        [etod.PARAM_FOG_COLOR]=                           {{ x=70/255, y=90/255, z=35/255 }, constraint=econ.DARKEN },
        [etod.PARAM_FOG_COLOR2]=                          {{ x=100/255, y=110/255, z=45/255 }, constraint=econ.DARKEN, },
        [etod.PARAM_VOLFOG2_GLOBAL_DENSITY]=              {1.5, method=emix.QUART, undergroundFactor=_uff, insideFactor=_iff},
        [etod.PARAM_COLORGRADING_FILTERS_PHOTOFILTER_COLOR]=  {{ x=160/255, y=220/255, z=70/255 }, constraint=econ.BRIGTHEN, },
        [etod.PARAM_COLORGRADING_FILTERS_PHOTOFILTER_DENSITY]= {0.2, undergroundFactor=_ufc, insideFactor=_ifc},
        [etod.PARAM_COLORGRADING_FILTERS_GRAIN]=          {0.3},
        [etod.PARAM_COLORGRADING_DOF_FOCUSRANGE]=         {200, undergroundFactor=_ufd, insideFactor=_ifd},
        [etod.PARAM_COLORGRADING_DOF_BLURAMOUNT]=         {0.3, method=emix.ADDITIVE, undergroundFactor=_ufd, insideFactor=_ifd},
      },
    },
--------------------------------------------------------------------------------------------
    -- RadMist_Peak: Radioactive fog at full density - lethal radiation outdoors
    -- Visibility severely reduced, must shelter or die
    {
      name="RadMist_Peak",
      probability=0,
      danger=25,
      duration={4, 8},
      continue={
        ["LightFog"] = 30,
        ["ClearSky"] = 40,
      },
      ramp={0.1, 0.5},
      modifiers = {
        --              outside, inside, underground, underwater
        humidity=       {0.35,    0.15,   0.1,        },
        light=          {-0.5,    -0.2,               },
        temperature=    {5,       3,                  },
        gas_radiation=  {0.275,    0.05,                },
        rain_radiation= {0.125,    0.0,                },
        ray_radiation=  {0.09,    0.01,               },
        geigercounter=  {2.5,     1.5,    0.0,   0.8 },
        fog=            {0.7,     0,      0,      0   },
      },
      entities=
      {
        BellTriggers[1],BellTriggers[2],BellTriggers[3],
        {
          class="ParticleEffect",
          properties=
          {
            ParticleEffect= {"environment_fx.rad_motes"},
            PulsePeriod= {0},
            Strength={1.0},
          },
        },
        {
          class="ParticleEffect",
          properties=
          {
            ParticleEffect= {"weather.fog.fog_heavy"},
            PulsePeriod= {20},
            Strength={1.0},
          },
        },
        {
          class="ParticleEffect",
          properties=
          {
            ParticleEffect= {"weather.ash.slow_ash"},
            PulsePeriod= {0},
            Strength={0.5},
          },
        },
      },
      audio=
      {
        {
          class="AudioAreaAmbience",
          trigger="Play_wind",
          rtpc="wind_speed",
          rtpcValue=0.4,
        },
      },
      tod=
      {
        [etod.PARAM_SUN_INTENSITY]=                       {0.1, method=emix.MULTIPLY, min=100},
        [etod.PARAM_FOG_RADIAL_COLOR_MULTIPLIER]=         {0.05},
        [etod.PARAM_VOLFOG_GLOBAL_DENSITY]=               {8.0, undergroundFactor=_uff, insideFactor=_iff},
        [etod.PARAM_VOLFOG_RAMP_INFLUENCE]=               {0.25, undergroundFactor=_uff, insideFactor=_iff},
        [etod.PARAM_VOLFOG_HEIGHT_OFFSET]=                {0.3, undergroundFactor=_uff},
        [etod.PARAM_VOLFOG_FINAL_DENSITY_CLAMP]=          {0.95, undergroundFactor=_uff, insideFactor=_iff},
        [etod.PARAM_FOG_COLOR]=                           {{ x=50/255, y=70/255, z=25/255 }, constraint=econ.DARKEN },
        [etod.PARAM_FOG_COLOR2]=                          {{ x=80/255, y=100/255, z=35/255 }, constraint=econ.DARKEN, },
        [etod.PARAM_VOLFOG2_GLOBAL_DENSITY]=              {5.0, method=emix.QUART, undergroundFactor=_uff, insideFactor=_iff},
        [etod.PARAM_COLORGRADING_FILTERS_PHOTOFILTER_COLOR]=  {{ x=140/255, y=200/255, z=60/255 }, constraint=econ.BRIGTHEN, },
        [etod.PARAM_COLORGRADING_FILTERS_PHOTOFILTER_DENSITY]= {0.6, undergroundFactor=_ufc, insideFactor=_ifc},
        [etod.PARAM_COLORGRADING_FILTERS_GRAIN]=          {0.7},
        [etod.PARAM_COLORGRADING_DOF_FOCUSRANGE]=         {30, undergroundFactor=_ufd, insideFactor=_ifd},
        [etod.PARAM_COLORGRADING_DOF_BLURAMOUNT]=         {0.6, method=emix.ADDITIVE, undergroundFactor=_ufd, insideFactor=_ifd},
        [etod.PARAM_SUN_RAYS_VISIBILITY]=                 {0.0},
      },
    },
--------------------------------------------------------------------------------------------
    -- HeatWave: Oppressive heat with shimmering distortion - dehydration danger
    -- Bright, washed-out visuals, temperature soars - find shade and water
    {
      name="HeatWave",
      probability=1,
      danger=10,
      dangerlimit=30,
      duration={15, 30},
      todlimit={10,17},
      ramp={0.3, 0.3},
      modifiers = {
        --              outside, inside, underground, underwater
        humidity=       {-0.1,    -0.05,  0.0,        },
        light=          {0.05,    0.02,               },
        temperature=    {15,      6,      1,     3    },
        wind=           {-5,      0,      0,          },
      },
      entities=
      {
        {
          class="ParticleEffect",
          properties=
          {
            ParticleEffect= {"environment_fx.heat_shimmer"},
            PulsePeriod= {5},
            Strength={0.0, 5.0},
          },
        },
      },
      audio=
      {
        {
          class="AudioAreaAmbience",
          trigger="Play_wind",
          rtpc="wind_speed",
          rtpcValue=0.3,
        },
      },
      tod=
      {
        [etod.PARAM_SUN_INTENSITY]=                       {1.5, method=emix.MULTIPLY, min=100},
        [etod.PARAM_FOG_RADIAL_COLOR]=                    {{ x=255/255, y=240/255, z=200/255 }},
        [etod.PARAM_FOG_RADIAL_COLOR_MULTIPLIER]=         {0.8},
        [etod.PARAM_VOLFOG_GLOBAL_DENSITY]=               {0.08, undergroundFactor=_uff, insideFactor=_iff},
        [etod.PARAM_SKYLIGHT_SUN_INTENSITY_MULTIPLIER]=   {5},
        [etod.PARAM_COLORGRADING_FILTERS_PHOTOFILTER_COLOR]=  {{ x=255/255, y=230/255, z=180/255 }, constraint=econ.BRIGTHEN, },
        [etod.PARAM_COLORGRADING_FILTERS_PHOTOFILTER_DENSITY]= {0.15, undergroundFactor=_ufc, insideFactor=_ifc},
        [etod.PARAM_COLORGRADING_FILTERS_GRAIN]=          {0.4},
        [etod.PARAM_COLORGRADING_DOF_FOCUSRANGE]=         {600, undergroundFactor=_ufd, insideFactor=_ifd},
        [etod.PARAM_COLORGRADING_DOF_BLURAMOUNT]=         {0.3, method=emix.ADDITIVE, undergroundFactor=_ufd, insideFactor=_ifd},
      },
    },
--------------------------------------------------------------------------------------------
    -- BallLightning: Extremely rare electrical anomaly - luminous energy spheres
    -- Sporadic lightning, St. Elmo's fire on structures - short and dangerous
    {
      name="BallLightning",
      probability=1,
      danger=35,
      dangerlimit=45,
      duration={3, 6},
      continue={
        ["StormyDistantThunder"] = 40,
        ["ClearSkyStormy"] = 30,
      },
      modifiers = {
        --              outside, inside, underground, underwater
        humidity=       {0.1,     0.05,               },
        light=          {-0.15,   -0.05,              },
        temperature=    {-3,      -1,                 },
        wind=           {5,       1,      0,          },
        ray_radiation=  {0.03,    0.005,               },
        geigercounter=  {1.0,     0.5,    0.0,   0   },
      },
      entities=
      {
        {
          class="ParticleEffect",
          properties=
          {
            ParticleEffect= {"environment_fx.ball_lightning"},
            PulsePeriod= {20},
            Strength={0.0, 1.0},
          },
        },
        {
          class="ParticleEffect",
          properties=
          {
            ParticleEffect= {"environment_fx.st_elmos_fire"},
            PulsePeriod= {15},
            Strength={0.0, 0.8},
          },
        },
        {
          class="Lightning",
          properties=
          {
            bActive= {1},
            fDistance= {200,50},
            bRelativeToPlayer= {1},
            ["Timing.fDelay"]= {8},
            ["Timing.fDelayVariation"]= {0.9},
            ["Timing.fLightningDuration"]= {0.5},
            ["Effects.LightIntensity"]= {0.6,1.5},
            ["Effects.color_SkyHighlightColor"]= {{ x=180/255, y=200/255, z=255/255 }},
            ["Effects.ParticleEffect"]= {"weather.lightning.lightningbolt1"},
            ["Effects.ParticleScale"]= {2,1},
            ["Effects.SkyHighlightVerticalOffset"]= {100,40},
            ["Effects.SkyHighlightMultiplier"]= {0.5,1.2},
            ["Audio.audioTriggerPlayTrigger"]= {"Play_thunder"},
          },
        },
        {
          class="Lightning",
          properties=
          {
            bActive= {1},
            fDistance= {400,150},
            bRelativeToPlayer= {1},
            ["Timing.fDelay"]= {12},
            ["Timing.fDelayVariation"]= {0.7},
            ["Timing.fLightningDuration"]= {0.3},
            ["Effects.LightIntensity"]= {0.3,0.8},
            ["Effects.color_SkyHighlightColor"]= {{ x=200/255, y=220/255, z=255/255 }},
            ["Effects.ParticleEffect"]= {"weather.lightning.lightningbolt2"},
            ["Effects.ParticleScale"]= {3,2},
            ["Effects.SkyHighlightVerticalOffset"]= {150,60},
            ["Effects.SkyHighlightMultiplier"]= {0.3,0.8},
            ["Audio.audioTriggerPlayTrigger"]= {"Play_thunder"},
          },
        },
        {
          class="WindArea",
          properties=
          {
            bActive=      {1},
            bEllipsoidal= {0},
            Speed=        {1.0},
            Size=         {{ x=200,y=200,z=200 }},
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
          rtpcValue=1.5,
        },
      },
      tod=
      {
        [etod.PARAM_SUN_INTENSITY]=                       {0.6, method=emix.MULTIPLY, min=100},
        [etod.PARAM_VOLFOG_GLOBAL_DENSITY]=               {0.2, undergroundFactor=_uff, insideFactor=_iff},
        [etod.PARAM_COLORGRADING_FILTERS_GRAIN]=          {0.4},
        [etod.PARAM_COLORGRADING_DOF_FOCUSRANGE]=         {500, undergroundFactor=_ufd, insideFactor=_ifd},
        [etod.PARAM_COLORGRADING_DOF_BLURAMOUNT]=         {0.15, method=emix.ADDITIVE, undergroundFactor=_ufd, insideFactor=_ifd},
      },
    },
--------------------------------------------------------------------------------------------
    -- EmberDrift: Hot embers and ash drift from a distant wildfire
    -- Orange glow on horizon, rising temperature, degraded air quality
    {
      name="EmberDrift",
      probability=1,
      danger=12,
      dangerlimit=30,
      duration={10, 20},
      ramp={0.2, 0.4},
      continue={
        ["VolcanicHaze"] = 15,
        ["DustStorm"] = 10,
      },
      modifiers = {
        --              outside, inside, underground, underwater
        humidity=       {-0.05,   0.0,    0.0,        },
        light=          {-0.1,    -0.05,              },
        temperature=    {6,       3,      0,     1    },
        gas_radiation=  {0.015,    0.0025,              },
        geigercounter=  {0.3,     0.15,   0.0,   0   },
        dust=           {0.5,     0,      0,      0   },
      },
      entities=
      {
        {
          class="ParticleEffect",
          properties=
          {
            ParticleEffect= {"environment_fx.ember_drift"},
            PulsePeriod= {0},
            Strength={0.0, 1.0},
          },
        },
        {
          class="ParticleEffect",
          properties=
          {
            ParticleEffect= {"weather.ash.slow_ash"},
            PulsePeriod= {0},
            Strength={0.0, 0.8},
          },
        },
        {
          class="WindArea",
          properties=
          {
            bActive=      {1},
            bEllipsoidal= {0},
            Speed=        {1.5},
            Size=         {{ x=200,y=200,z=200 }},
            Dir=          {{ x=1,y=0.3,z=-0.2 }},
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
          rtpcValue=1.2,
        },
      },
      tod=
      {
        [etod.PARAM_SUN_INTENSITY]=                       {0.5, method=emix.MULTIPLY, min=100},
        [etod.PARAM_FOG_COLOR]=                           {{ x=180/255, y=90/255, z=30/255 }, constraint=econ.DARKEN },
        [etod.PARAM_FOG_COLOR_MULTIPLIER]=                {0.5},
        [etod.PARAM_FOG_RADIAL_COLOR]=                    {{ x=220/255, y=100/255, z=20/255 }},
        [etod.PARAM_FOG_RADIAL_COLOR_MULTIPLIER]=         {0.6},
        [etod.PARAM_VOLFOG_GLOBAL_DENSITY]=               {0.6, undergroundFactor=_uff, insideFactor=_iff},
        [etod.PARAM_VOLFOG2_GLOBAL_DENSITY]=              {0.4, method=emix.QUART, undergroundFactor=_uff, insideFactor=_iff},
        [etod.PARAM_NIGHSKY_HORIZON_COLOR]=               {{ x=200/255, y=80/255, z=15/255 }},
        [etod.PARAM_NIGHSKY_HORIZON_COLOR_MULTIPLIER]=    {1.0},
        [etod.PARAM_COLORGRADING_FILTERS_PHOTOFILTER_COLOR]=  {{ x=230/255, y=140/255, z=50/255 }, constraint=econ.BRIGTHEN, },
        [etod.PARAM_COLORGRADING_FILTERS_PHOTOFILTER_DENSITY]= {0.2, undergroundFactor=_ufc, insideFactor=_ifc},
        [etod.PARAM_COLORGRADING_FILTERS_GRAIN]=          {0.2},
      },
    },
--------------------------------------------------------------------------------------------
    -- LightSnowFlurry: Gentle meandering flakes - melancholy atmospheric mood
    -- Modest temperature drop, no accumulation, peaceful transition weather
    {
      name="LightSnowFlurry",
      probability=2,
      danger=5,
      dangerlimit=25,
      duration={8, 18},
      ramp={0.2, 0.3},
      continue={
        ["Snow"] = 20,
        ["ClearSky"] = 30,
        ["MorningMist"] = 10,
      },
      modifiers = {
        --              outside, inside, underground, underwater
        humidity=       {0.1,     0.05,   0.02,       },
        light=          {-0.1,    -0.05,              },
        temperature=    {-12,     -5,     -1,    -3   },
      },
      entities=
      {
        {
          class="ParticleEffect",
          properties=
          {
            ParticleEffect= {"weather.light_snow_flurry"},
            PulsePeriod= {0},
            Strength={0.0, 1.0, 0.0},
          },
        },
        {
          class="Snow",
          pos={ x=4096, y=4096, z=450 },
          properties=
          {
            bEnabled= {1},
            fRadius= {8000},
            ["SnowFall.fBrightness"]= {15},
            ["SnowFall.fGravityScale"]= {0.05, 0.3, 0.1},
            ["SnowFall.nSnowFlakeCount"]= {10, 80, 5},
            ["Surface.fSnowAmount"]= {0.0},
            ["Surface.fFrostAmount"]= {0.0, 0.2, 0.0},
            ["Surface.fSurfaceFreezing"]= {0.0},
          },
          OnCustomUpdate=windMover,
        },
        {
          class="WindArea",
          properties=
          {
            bActive=      {1},
            bEllipsoidal= {0},
            Speed=        {0.5},
            Size=         {{ x=200,y=200,z=200 }},
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
          rtpcValue=0.4,
        },
      },
      tod=
      {
        [etod.PARAM_SUN_INTENSITY]=                       {0.7, method=emix.MULTIPLY, min=100},
        [etod.PARAM_VOLFOG_GLOBAL_DENSITY]=               {0.15, undergroundFactor=_uff, insideFactor=_iff},
        [etod.PARAM_VOLFOG2_GLOBAL_DENSITY]=              {0.1, method=emix.QUART, undergroundFactor=_uff, insideFactor=_iff},
        [etod.PARAM_SKYLIGHT_SUN_INTENSITY_MULTIPLIER]=   {8},
        [etod.PARAM_COLORGRADING_FILTERS_PHOTOFILTER_COLOR]=  {{ x=180/255, y=200/255, z=230/255 }, constraint=econ.BRIGTHEN, },
        [etod.PARAM_COLORGRADING_FILTERS_PHOTOFILTER_DENSITY]= {0.08, undergroundFactor=_ufc, insideFactor=_ifc},
        [etod.PARAM_COLORGRADING_DOF_FOCUSRANGE]=         {500, undergroundFactor=_ufd, insideFactor=_ifd},
        [etod.PARAM_COLORGRADING_DOF_BLURAMOUNT]=         {0.1, method=emix.ADDITIVE, undergroundFactor=_ufd, insideFactor=_ifd},
      },
    },
--------------------------------------------------------------------------------------------
    -- MidnightGale: Powerful sustained nighttime wind - near-zero visibility in darkness
    -- Howling wind, flying debris, an endurance test in the dark
    {
      name="MidnightGale",
      probability=1,
      danger=15,
      dangerlimit=35,
      duration={8, 15},
      todlimit={22,4},
      ramp={0.2, 0.3},
      continue={
        ["ClearSky"] = 50,
        ["LightFog"] = 20,
      },
      modifiers = {
        --              outside, inside, underground, underwater
        humidity=       {0.05,    0.02,               },
        light=          {-0.5,    -0.2,               },
        temperature=    {-8,      -3,     -1,    -2   },
        wind=           {60,      12,     3,     2    },
      },
      entities=
      {
        {
          class="ParticleEffect",
          properties=
          {
            ParticleEffect= {"environment_fx.debris_wind"},
            PulsePeriod= {8},
            Strength={0.0, 1.0},
          },
        },
        {
          class="WindArea",
          properties=
          {
            bActive=      {1},
            bEllipsoidal= {0},
            Speed=        {5.0},
            Size=         {{ x=200,y=200,z=200 }},
            Dir=          {{ x=1,y=0.5,z=-0.4 }},
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
          rtpcValue=8.0,
        },
      },
      tod=
      {
        [etod.PARAM_SUN_INTENSITY]=                       {0.05, method=emix.MULTIPLY, min=100},
        [etod.PARAM_NIGHSKY_MOON_COLOR]=                  {{ x=30/255, y=30/255, z=40/255 }, constraint=econ.DARKEN, },
        [etod.PARAM_NIGHSKY_ZENITH_COLOR]=                {{ x=5/255, y=5/255, z=10/255 }},
        [etod.PARAM_NIGHSKY_ZENITH_COLOR_MULTIPLIER]=     {0.3},
        [etod.PARAM_VOLFOG_GLOBAL_DENSITY]=               {0.3, undergroundFactor=_uff, insideFactor=_iff},
        [etod.PARAM_COLORGRADING_FILTERS_GRAIN]=          {0.5},
        [etod.PARAM_COLORGRADING_DOF_FOCUSRANGE]=         {400, undergroundFactor=_ufd, insideFactor=_ifd},
        [etod.PARAM_COLORGRADING_DOF_BLURAMOUNT]=         {0.3, method=emix.ADDITIVE, undergroundFactor=_ufd, insideFactor=_ifd},
      },
    },
--------------------------------------------------------------------------------------------
    -- AcidDrizzle: Persistent low-intensity acid drizzle - no siren warning
    -- Yellowish tint, slow health drain for exposed players over long duration
    {
      name="AcidDrizzle",
      probability=1,
      danger=10,
      dangerlimit=30,
      duration={12, 25},
      ramp={0.3, 0.3},
      continue={
        ["AcidRain"] = 15,
        ["LightRain"] = 20,
        ["ClearSky"] = 30,
      },
      modifiers = {
        --              outside, inside, underground, underwater
        humidity=       {0.2,     0.08,   0.05,       },
        rain=           {0.2,                         },
        rain_acid=      {0.35,    0.0,    0.0,   0.02 },
        light=          {-0.15,   -0.05,              },
        temperature=    {-2,      -1,                 },
        wind=           {3,       1,      0,          },
      },
      entities=
      {
        {
          class="Rain",
          properties=
          {
            bEnabled=             {1},
            fAmount=              {0,    0.8},
            fDiffuseDarkening=    {0,    0.3},
            fPuddlesAmount=       {0,    1.0},
            fPuddlesMaskAmount=   {0.75},
            fPuddlesRippleAmount= {0,    0.8},
            fRainDropsAmount=     {0,    0.03},
            fRainDropsLighting=   {2.5},
            fRainDropsSpeed=      {0.7},
            fSplashesAmount=      {0,    0.4},
          },
        },
        {
          class="ParticleEffect",
          properties=
          {
            ParticleEffect= {"weather.fog.acid_rain"},
            PulsePeriod= {25},
            Strength={0.0, 0.5},
          },
        },
        {
          class="ParticleEffect",
          properties=
          {
            ParticleEffect= {"environment_fx.rain_puddle_ripples"},
            PulsePeriod= {0},
            Strength={0.0, 0.6},
          },
        },
        {
          class="WindArea",
          properties=
          {
            bActive=      {1},
            bEllipsoidal= {0},
            Speed=        {0.8},
            Size=         {{ x=200,y=200,z=200 }},
            Dir=          {{ x=1,y=1,z=-0.5 }},
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
          rtpcValue=1.0,
        },
        {
          class="AudioAreaAmbience",
          trigger="Play_wind",
          rtpc="wind_speed",
          rtpcValue=0.5,
        },
      },
      tod=
      {
        [etod.PARAM_SUN_INTENSITY]=                       {0.5, method=emix.MULTIPLY, min=100},
        [etod.PARAM_FOG_RADIAL_COLOR_MULTIPLIER]=         {0.2},
        [etod.PARAM_FOG_COLOR]=                           {{ x=140/255, y=170/255, z=40/255 }, constraint=econ.NONE,},
        [etod.PARAM_FOG_COLOR2]=                          {{ x=120/255, y=150/255, z=30/255 }, constraint=econ.NONE,},
        [etod.PARAM_VOLFOG_GLOBAL_DENSITY]=               {0.35, undergroundFactor=_uff, insideFactor=_iff},
        [etod.PARAM_VOLFOG2_GLOBAL_DENSITY]=              {0.25, method=emix.QUART, undergroundFactor=_uff, insideFactor=_iff},
        [etod.PARAM_VOLFOG2_COLOR1]=                      {{ x=160/255, y=200/255, z=40/255 }, constraint=econ.NONE,},
        [etod.PARAM_COLORGRADING_FILTERS_PHOTOFILTER_COLOR]=  {{ x=230/255, y=210/255, z=70/255 }, constraint=econ.BRIGTHEN, },
        [etod.PARAM_COLORGRADING_FILTERS_PHOTOFILTER_DENSITY]= {0.18, undergroundFactor=_ufc, insideFactor=_ifc},
        [etod.PARAM_COLORGRADING_FILTERS_GRAIN]=          {0.1},
        [etod.PARAM_COLORGRADING_DOF_FOCUSRANGE]=         {400, undergroundFactor=_ufd, insideFactor=_ifd},
        [etod.PARAM_COLORGRADING_DOF_BLURAMOUNT]=         {0.2, method=emix.ADDITIVE, undergroundFactor=_ufd, insideFactor=_ifd},
      },
    },
--------------------------------------------------------------------------------------------
    -- FireflySwarm: Dense cloud of bioluminescent insects across the landscape
    -- Enhanced version of Fireflies - wider coverage, warmer atmosphere
    {
      name="FireflySwarm",
      probability=1,
      danger=-8,
      duration={10, 18},
      todlimit={20,4},
      ramp={0.35, 0.35},
      continue={
        ["MorningMist"] = 20,
      },
      modifiers = {
        --              outside, inside, underground, underwater
        humidity=       {0.1,     0.02,   0.0,        },
        temperature=    {-1,      0,                  },
      },
      entities=
      {
        {
          class="ParticleEffect",
          properties=
          {
            ParticleEffect= {"environment_fx.firefly_swarm_large"},
            PulsePeriod= {25},
            Strength={0.0, 1.0, 0.0},
          },
          OnCustomUpdate=windMover,
        },
        {
          class="ParticleEffect",
          properties=
          {
            ParticleEffect= {"environment_fx.fireflies"},
            PulsePeriod= {30},
            Strength={0.0, 0.8},
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
          rtpcValue=0.3,
        },
      },
      tod=
      {
        [etod.PARAM_NIGHSKY_HORIZON_COLOR]=               {{ x=20/255, y=40/255, z=15/255 }},
        [etod.PARAM_NIGHSKY_HORIZON_COLOR_MULTIPLIER]=    {0.5},
        [etod.PARAM_COLORGRADING_FILTERS_PHOTOFILTER_COLOR]=  {{ x=180/255, y=220/255, z=100/255 }, constraint=econ.BRIGTHEN, },
        [etod.PARAM_COLORGRADING_FILTERS_PHOTOFILTER_DENSITY]= {0.04, undergroundFactor=_ufc, insideFactor=_ifc},
      },
    },
--------------------------------------------------------------------------------------------
    -- GloomyOvercast: Persistent dreary overcast - flat light, oppressive cloud ceiling
    -- Common mood weather that makes everything feel abandoned and hopeless
    {
      name="GloomyOvercast",
      probability=2,
      danger=2,
      dangerlimit=20,
      duration={15, 30},
      ramp={0.3, 0.3},
      continue={
        ["LightRain"] = 15,
        ["MediumRain"] = 10,
        ["ApproachingStorm"] = 5,
        ["MediumFog"] = 5,
      },
      modifiers = {
        --              outside, inside, underground, underwater
        humidity=       {0.1,     0.05,   0.02,       },
        light=          {-0.25,   -0.1,               },
        temperature=    {-3,      -1,                 },
        wind=           {5,       1,      0,          },
        fog=            {0.3,     0,      0,          },
      },
      entities=
      {
        {
          class="WindArea",
          properties=
          {
            bActive=      {1},
            bEllipsoidal= {0},
            Speed=        {0.8},
            Size=         {{ x=200,y=200,z=200 }},
            Dir=          {{ x=1,y=0.5,z=-0.2 }},
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
          rtpcValue=0.6,
        },
      },
      tod=
      {
        [etod.PARAM_SUN_INTENSITY]=                       {0.3, method=emix.MULTIPLY, min=100},
        [etod.PARAM_FOG_RADIAL_COLOR_MULTIPLIER]=         {0.15},
        [etod.PARAM_VOLFOG_GLOBAL_DENSITY]=               {0.15, undergroundFactor=_uff, insideFactor=_iff},
        [etod.PARAM_VOLFOG2_GLOBAL_DENSITY]=              {0.1, method=emix.QUART, undergroundFactor=_uff, insideFactor=_iff},
        [etod.PARAM_SKYLIGHT_SUN_INTENSITY_MULTIPLIER]=   {30},
        [etod.PARAM_CLOUDSHADING_SUNLIGHT_MULTIPLIER]=    {0.3},
        [etod.PARAM_COLORGRADING_FILTERS_PHOTOFILTER_COLOR]=  {{ x=160/255, y=170/255, z=180/255 }, constraint=econ.DARKEN, },
        [etod.PARAM_COLORGRADING_FILTERS_PHOTOFILTER_DENSITY]= {0.1, undergroundFactor=_ufc, insideFactor=_ifc},
        [etod.PARAM_SUN_SHAFTS_VISIBILITY]=               {0.1},
        [etod.PARAM_SUN_RAYS_VISIBILITY]=                 {0.1},
        [etod.PARAM_COLORGRADING_DOF_FOCUSRANGE]=         {600, undergroundFactor=_ufd, insideFactor=_ifd},
        [etod.PARAM_COLORGRADING_DOF_BLURAMOUNT]=         {0.12, method=emix.ADDITIVE, undergroundFactor=_ufd, insideFactor=_ifd},
      },
    },
--------------------------------------------------------------------------------------------
    -- EarlyFrost: Dawn cold snap - frost crystals sparkle on every surface
    -- Beautiful but dangerous - rapid heat loss for exposed players at dawn
    {
      name="EarlyFrost",
      probability=1,
      danger=12,
      dangerlimit=25,
      duration={5, 10},
      todlimit={4,8},
      ramp={0.2, 0.4},
      continue={
        ["LightSnowFlurry"] = 20,
        ["ClearSky"] = 40,
        ["MorningMist"] = 15,
      },
      modifiers = {
        --              outside, inside, underground, underwater
        humidity=       {0.15,    0.05,   0.02,       },
        light=          {-0.05,   -0.02,              },
        temperature=    {-18,     -8,     -2,    -5   },
      },
      entities=
      {
        {
          class="ParticleEffect",
          properties=
          {
            ParticleEffect= {"environment_fx.frost_crystals"},
            PulsePeriod= {0},
            Strength={0.0, 1.0, 0.0},
          },
        },
        {
          class="Snow",
          pos={ x=4096, y=4096, z=450 },
          properties=
          {
            bEnabled= {1},
            fRadius= {8000},
            ["SnowFall.nSnowFlakeCount"]= {0},
            ["Surface.fSnowAmount"]= {0.0},
            ["Surface.fFrostAmount"]= {0.0, 0.7, 0.0},
            ["Surface.fSurfaceFreezing"]= {0.0, 0.05, 0.0},
          },
        },
      },
      audio=
      {
        {
          class="AudioAreaAmbience",
          trigger="Play_wind",
          rtpc="wind_speed",
          rtpcValue=0.3,
        },
        {
          class="AudioAreaAmbience",
          trigger="Play_nuclear_winter",
          rtpc="freeze_strength",
          rtpcValue=0.15,
        },
      },
      tod=
      {
        [etod.PARAM_SUN_INTENSITY]=                       {0.6, method=emix.MULTIPLY, min=100},
        [etod.PARAM_FOG_RADIAL_COLOR]=                    {{ x=200/255, y=220/255, z=255/255 }},
        [etod.PARAM_FOG_RADIAL_COLOR_MULTIPLIER]=         {0.5},
        [etod.PARAM_COLORGRADING_FILTERS_PHOTOFILTER_COLOR]=  {{ x=180/255, y=210/255, z=255/255 }, constraint=econ.BRIGTHEN, },
        [etod.PARAM_COLORGRADING_FILTERS_PHOTOFILTER_DENSITY]= {0.1, undergroundFactor=_ufc, insideFactor=_ifc},
        [etod.PARAM_COLORGRADING_DOF_FOCUSRANGE]=         {600, undergroundFactor=_ufd, insideFactor=_ifd},
        [etod.PARAM_COLORGRADING_DOF_BLURAMOUNT]=         {0.1, method=emix.ADDITIVE, undergroundFactor=_ufd, insideFactor=_ifd},
      },
    },
--------------------------------------------------------------------------------------------
    -- BloodMoon: Rare terrifying night - deep red moon bathes landscape in crimson
    -- Nuclear debris scatters red wavelengths - the quintessential apocalyptic night
    {
      name="BloodMoon",
      probability=1,
      danger=5,
      dangerlimit=20,
      duration={10, 20},
      todlimit={21,3},
      ramp={0.4, 0.4},
      modifiers = {
        --              outside, inside, underground, underwater
        humidity=       {0.05,    0.0,                },
        temperature=    {-5,      -2,     0,     -1   },
        gas_radiation=  {0.01,    0.0025,              },
        geigercounter=  {0.3,     0.15,   0.0,   0   },
      },
      entities=
      {
        {
          class="ParticleEffect",
          properties=
          {
            ParticleEffect= {"environment_fx.rad_motes"},
            PulsePeriod= {30},
            Strength={0.0, 0.3},
          },
        },
      },
      audio=
      {
        {
          class="AudioAreaAmbience",
          trigger="Play_wind",
          rtpc="wind_speed",
          rtpcValue=0.4,
        },
      },
      tod=
      {
        [etod.PARAM_NIGHSKY_MOON_COLOR]=                  {{ x=255/255, y=30/255, z=10/255 }},
        [etod.PARAM_NIGHSKY_MOON_COLOR_MULTIPLIER]=       {3.0},
        [etod.PARAM_NIGHSKY_MOON_INNERCORONA_COLOR]=      {{ x=255/255, y=50/255, z=20/255 }},
        [etod.PARAM_NIGHSKY_MOON_OUTERCORONA_COLOR]=      {{ x=200/255, y=20/255, z=5/255 }},
        [etod.PARAM_NIGHSKY_HORIZON_COLOR]=               {{ x=100/255, y=10/255, z=5/255 }},
        [etod.PARAM_NIGHSKY_HORIZON_COLOR_MULTIPLIER]=    {1.2},
        [etod.PARAM_NIGHSKY_ZENITH_COLOR]=                {{ x=30/255, y=5/255, z=15/255 }},
        [etod.PARAM_NIGHSKY_ZENITH_COLOR_MULTIPLIER]=     {0.8},
        [etod.PARAM_COLORGRADING_FILTERS_PHOTOFILTER_COLOR]=  {{ x=255/255, y=40/255, z=20/255 }, constraint=econ.BRIGTHEN, },
        [etod.PARAM_COLORGRADING_FILTERS_PHOTOFILTER_DENSITY]= {0.15, undergroundFactor=_ufc, insideFactor=_ifc},
        [etod.PARAM_COLORGRADING_FILTERS_GRAIN]=          {0.35},
        [etod.PARAM_VOLFOG_GLOBAL_DENSITY]=               {0.15, undergroundFactor=_uff, insideFactor=_iff},
        [etod.PARAM_VOLFOG2_COLOR1]=                      {{ x=120/255, y=20/255, z=10/255 }, constraint=econ.NONE,},
        [etod.PARAM_SKYBOX_MULTIPLIER]=                   {1.5},
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