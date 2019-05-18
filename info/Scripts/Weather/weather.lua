-- definitions needed to map engine TOD param ids
etod  = {
  PARAM_SUN_COLOR = 0,
  PARAM_SUN_INTENSITY = 1,
  PARAM_SUN_SPECULAR_MULTIPLIER = 2,

  PARAM_FOG_COLOR = 3,
  PARAM_FOG_COLOR_MULTIPLIER = 4,
  PARAM_VOLFOG_HEIGHT = 5,
  PARAM_VOLFOG_DENSITY = 6,
  PARAM_FOG_COLOR2 = 7,
  PARAM_FOG_COLOR2_MULTIPLIER = 8,
  PARAM_VOLFOG_HEIGHT2 = 9,
  PARAM_VOLFOG_DENSITY2 = 10,
  PARAM_VOLFOG_HEIGHT_OFFSET = 11,

  PARAM_FOG_RADIAL_COLOR = 12,
  PARAM_FOG_RADIAL_COLOR_MULTIPLIER = 13,
  PARAM_VOLFOG_RADIAL_SIZE = 14,
  PARAM_VOLFOG_RADIAL_LOBE = 15,

  PARAM_VOLFOG_FINAL_DENSITY_CLAMP = 16,

  PARAM_VOLFOG_GLOBAL_DENSITY = 17,
  PARAM_VOLFOG_RAMP_START = 18,
  PARAM_VOLFOG_RAMP_END = 19,
  PARAM_VOLFOG_RAMP_INFLUENCE = 20,

  PARAM_VOLFOG_SHADOW_DARKENING = 21,
  PARAM_VOLFOG_SHADOW_DARKENING_SUN = 22,
  PARAM_VOLFOG_SHADOW_DARKENING_AMBIENT = 23,
  PARAM_VOLFOG_SHADOW_RANGE = 24,

  PARAM_VOLFOG2_HEIGHT = 25,
  PARAM_VOLFOG2_DENSITY = 26,
  PARAM_VOLFOG2_HEIGHT2 = 27,
  PARAM_VOLFOG2_DENSITY2 = 28,
  PARAM_VOLFOG2_GLOBAL_DENSITY = 29,
  PARAM_VOLFOG2_RAMP_START = 30,
  PARAM_VOLFOG2_RAMP_END = 31,
  PARAM_VOLFOG2_COLOR1 = 32,
  PARAM_VOLFOG2_ANISOTROPIC1 = 33,
  PARAM_VOLFOG2_COLOR2 = 34,
  PARAM_VOLFOG2_ANISOTROPIC2 = 35,
  PARAM_VOLFOG2_BLEND_FACTOR = 36,
  PARAM_VOLFOG2_BLEND_MODE = 37,
  PARAM_VOLFOG2_COLOR = 38,
  PARAM_VOLFOG2_ANISOTROPIC = 39,
  PARAM_VOLFOG2_RANGE = 40,
  PARAM_VOLFOG2_INSCATTER = 41,
  PARAM_VOLFOG2_EXTINCTION = 42,
  PARAM_VOLFOG2_GLOBAL_FOG_VISIBILITY = 43,
  PARAM_VOLFOG2_FINAL_DENSITY_CLAMP = 44,

  PARAM_SKYLIGHT_SUN_INTENSITY = 45,
  PARAM_SKYLIGHT_SUN_INTENSITY_MULTIPLIER = 46,

  PARAM_SKYLIGHT_KM = 47,
  PARAM_SKYLIGHT_KR = 48,
  PARAM_SKYLIGHT_G = 49,

  PARAM_SKYLIGHT_WAVELENGTH_R = 50,
  PARAM_SKYLIGHT_WAVELENGTH_G = 51,
  PARAM_SKYLIGHT_WAVELENGTH_B = 52,

  PARAM_NIGHSKY_HORIZON_COLOR = 53,
  PARAM_NIGHSKY_HORIZON_COLOR_MULTIPLIER = 54,
  PARAM_NIGHSKY_ZENITH_COLOR = 55,
  PARAM_NIGHSKY_ZENITH_COLOR_MULTIPLIER = 56,
  PARAM_NIGHSKY_ZENITH_SHIFT = 57,

  PARAM_NIGHSKY_START_INTENSITY = 58,

  PARAM_NIGHSKY_MOON_COLOR = 59,
  PARAM_NIGHSKY_MOON_COLOR_MULTIPLIER = 60,
  PARAM_NIGHSKY_MOON_INNERCORONA_COLOR = 61,
  PARAM_NIGHSKY_MOON_INNERCORONA_COLOR_MULTIPLIER = 62,
  PARAM_NIGHSKY_MOON_INNERCORONA_SCALE = 63,
  PARAM_NIGHSKY_MOON_OUTERCORONA_COLOR = 64,
  PARAM_NIGHSKY_MOON_OUTERCORONA_COLOR_MULTIPLIER = 65,
  PARAM_NIGHSKY_MOON_OUTERCORONA_SCALE = 66,

  PARAM_CLOUDSHADING_SUNLIGHT_MULTIPLIER = 67,
  PARAM_CLOUDSHADING_SKYLIGHT_MULTIPLIER = 68,
  PARAM_CLOUDSHADING_SUNLIGHT_CUSTOM_COLOR = 69,
  PARAM_CLOUDSHADING_SUNLIGHT_CUSTOM_COLOR_MULTIPLIER = 70,
  PARAM_CLOUDSHADING_SUNLIGHT_CUSTOM_COLOR_INFLUENCE = 71,

  PARAM_SUN_SHAFTS_VISIBILITY = 72,
  PARAM_SUN_RAYS_VISIBILITY = 73,
  PARAM_SUN_RAYS_ATTENUATION = 74,
  PARAM_SUN_RAYS_SUNCOLORINFLUENCE = 75,
  PARAM_SUN_RAYS_CUSTOMCOLOR = 76,

  PARAM_OCEANFOG_COLOR = 77,
  PARAM_OCEANFOG_COLOR_MULTIPLIER = 78,
  PARAM_OCEANFOG_DENSITY = 79,

  PARAM_SKYBOX_MULTIPLIER = 80,
--[[
  PARAM_HDR_FILMCURVE_SHOULDER_SCALE = 81,
  PARAM_HDR_FILMCURVE_LINEAR_SCALE = 82,
  PARAM_HDR_FILMCURVE_TOE_SCALE = 83,
  PARAM_HDR_FILMCURVE_WHITEPOINT = 84,

  PARAM_HDR_COLORGRADING_COLOR_SATURATION = 85,
  PARAM_HDR_COLORGRADING_COLOR_BALANCE = 86,

  PARAM_HDR_EYEADAPTATION_SCENEKEY = 87,
  PARAM_HDR_EYEADAPTATION_MIN_EXPOSURE = 88,
  PARAM_HDR_EYEADAPTATION_MAX_EXPOSURE = 89,
  PARAM_HDR_EYEADAPTATION_EV_MIN = 90,
  PARAM_HDR_EYEADAPTATION_EV_MAX = 91,
  PARAM_HDR_EYEADAPTATION_EV_AUTO_COMPENSATION = 92,
  PARAM_HDR_BLOOM_AMOUNT = 93,
]]--
  PARAM_COLORGRADING_FILTERS_GRAIN = 94,
  PARAM_COLORGRADING_FILTERS_PHOTOFILTER_COLOR = 95,
  PARAM_COLORGRADING_FILTERS_PHOTOFILTER_DENSITY = 96,

  PARAM_COLORGRADING_DOF_FOCUSRANGE = 97,
  PARAM_COLORGRADING_DOF_BLURAMOUNT = 98,

  PARAM_SHADOWSC0_BIAS = 99,
  PARAM_SHADOWSC0_SLOPE_BIAS = 100,
  PARAM_SHADOWSC1_BIAS = 101,
  PARAM_SHADOWSC1_SLOPE_BIAS = 102,
  PARAM_SHADOWSC2_BIAS = 103,
  PARAM_SHADOWSC2_SLOPE_BIAS = 104,
  PARAM_SHADOWSC3_BIAS = 105,
  PARAM_SHADOWSC3_SLOPE_BIAS = 106,
  PARAM_SHADOWSC4_BIAS = 107,
  PARAM_SHADOWSC4_SLOPE_BIAS = 108,
  PARAM_SHADOWSC5_BIAS = 109,
  PARAM_SHADOWSC5_SLOPE_BIAS = 110,
  PARAM_SHADOWSC6_BIAS = 111,
  PARAM_SHADOWSC6_SLOPE_BIAS = 112,
  PARAM_SHADOWSC7_BIAS = 113,
  PARAM_SHADOWSC7_SLOPE_BIAS = 114,
--[[
  PARAM_SHADOW_JITTERING = 115,

  PARAM_HDR_DYNAMIC_POWER_FACTOR = 116,
  PARAM_TERRAIN_OCCL_MULTIPLIER = 117,
  PARAM_GI_MULTIPLIER = 118,
  PARAM_SUN_COLOR_MULTIPLIER = 119,

  PARAM_TOTAL = 120,
  ]]--
}

-- interpolation method
emix = {
  LERP = 0, -- linear interpolation
  MULTIPLY = 1, -- multiply with original with lerp
  ADDITIVE = 2, -- add onto original with lerp
	QUAD = 3, -- interpolation (power of 2)
	CUBIC = 4, -- interpolation (power of 3)
	QUART = 5, -- interpolation (power of 4)
	QUINT = 6, -- interpolation (power of 5)
}

-- constraint method
econ = {
  NONE = 0, -- no constraint
  DARKEN = 1, -- only allow values to decrease (e.g. darken color)
  BRIGTHEN = 2, -- only allow values to increase
}

-- util function: interpolation for vecs in lua
function vecLerp(va, vb, t)
  local v = g_Vectors.vecMathTemp1;
  local ot = 1-t;

  v.x=va.x*ot+vb.x*t;
  v.y=va.y*ot+vb.y*t;
  v.z=va.z*ot+vb.z*t;

  return v;
end

-- util function: distance between vecs
function vecDistance3(a, b)
	local x = a.x-b.x;
	local y = a.y-b.y;
	local z = a.z-b.z;
	return x*x + y*y + z*z;
end

-- util function: distance between vecs
function vecDistance2(a, b)
	local x = a.x-b.x;
	local y = a.y-b.y;
	return x*x + y*y;
end

-- util function to move wind around with player
function windMover(weather, entity, ramp, down)
  local vCamPos = System.GetViewCameraPos()
  entity:SetWorldPos(vCamPos)
end

TornadoPos={
  { x=3473, y=-313, z=-102 }, -- Start (Ocean next to airport)
  { x=1951, y=8230, z=-102 }, -- End (Ocean Northwest of Hayward)
}

-- helper function to move tornados over the map
function tornadoMover(weather, entity, ramp, down, progress)
  local fDescend = 550 -- amount the tornado goes up/down during ramp up/down

  local vPos = vecLerp( TornadoPos[1], TornadoPos[2], progress )

  if ramp < 0.99 then
    -- during ramp up/down we control height (tornado moves up/down)
    if down then
      vPos.z = vPos.z + fDescend * ramp
    else
      vPos.z = vPos.z + fDescend * (1-ramp)
    end
    entity.Properties.bIsInAir = true
  else
    local oldWorldPos = entity:GetWorldPos()
    vPos.z = oldWorldPos.z -- C++ controls z position based on terrain/water
    entity.Properties.bIsInAir = false
  end

  entity:SetWorldPos(vPos)
end

-- helper function to change sound volume based on player pos
function tornadoSoundMover(weather, rtpcVal, ramp, down, progress)
  local vPos = vecLerp( TornadoPos[1], TornadoPos[2], progress )
  local vCamPos = System.GetViewCameraPos()

  local distance = math.sqrt( vecDistance2(vPos, vCamPos) )
  local scale = distance / 1500 -- tornado gets louder if closer then 1,5km
  --scale = math.max(scale, 0) -- min multiplicator
  scale = math.min(scale, 1) -- max multiplicator
  scale = 1-(scale^3) -- sound scales logaritmic
  scale = math.max(scale, 0.25) -- min multiplicator
  
  return rtpcVal * scale
end

--- helper to generate triggers
function createTriggerSpot(splay, sstop, vpos, vprops)
  local aprops = {}

  if vprops ~= nil then
    for k,v in pairs(vprops) do
      aprops[k] = v
    end
  end

  aprops.audioTriggerPlayTriggerName = { splay }
  aprops.audioTriggerStopTriggerName = { sstop }

  return {
    class = "AudioTriggerSpot",
    pos= vpos, -- Pinecrest Fire Dept
    properties = aprops,
  }
end

--- helper to generate triggertables
function createTriggerSpots(splay, sstop, tpos, vprops)
  local t = {}
  for k,v in ipairs(tpos) do
    t[k] = createTriggerSpot(splay, sstop, v, vprops)
  end

  return t
end

--[[ 
--------------------- HELP --------------------

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

--------------------- HELP --------------------
]]--

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

-- reused tod env factors
_uff = 1.0 -- underground factor fog
_iff = 0.1 -- inside
_ufd = 0.3 -- underground factor dof
_ifd = 0.1 -- inside
_ufc = 0.4 -- underground factor photofilter
_ifc = 0.2 -- inside

-- dump(NukeSirenTriggers) -- test output

-- BellTriggers[1-3]
-- WeatherSirenTriggers[1-11]
-- NukeSirenTriggers[1-11]

-- Definition of the weather patterns (can be reloaded with wm_reload)
Weather = 
{
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
      probability=23, -- probabilities need to be 100 in total, everything over that will never get selected
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
      audio={},
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
      audio={},
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
        gas_radiation=  {0.032,      0.02,            },
        rain_radiation= {0.01,      0.0,              },
        ray_radiation= {0.002,       0.004,           },
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
        gas_radiation=  {0.56,       0.15,              },
        rain_radiation= {0.19,       0.0,              },
        ray_radiation= {0.05,       0.02,              },
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
        temperature=    {-10,       -5,       -3,    -6   },
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
        temperature=    {-35,     -25,    -8,    -21  },
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
      name="Snow",
      probability=4,
      danger=15,
      dangerlimit=40,
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
        temperature=    {-25,       -12,      -6,    -12   },
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
        temperature=    {-12,       -3,       -2,    -5   },
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
      danger=15,
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
        temperature=    {-18,       -6,       -3,    -7   },
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
      probability=47, 
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
      danger=30,
      dangerlimit=40,
      duration={8, 13},
      continue={
        ["Snow"] = { probability = 100, stage = 1, }, -- jump directly to peak
      }, 
      ramp={0.1, 0.1}, -- use 10% fade-in and 10% fade-out
      modifiers = { -- values added to current baseline (faded in and out)
        --              outside, inside, underground, underwater
        humidity=       {0.4,       0.4,    0.2,         },
        light=          {-0.5,      -0.45,                },
        temperature=    {-30,       -19,       -6,    -15   },
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
      danger=30,
      dangerlimit=40,
      duration={8, 13},
      continue={
        ["Snow"] = { probability = 100, stage = 1, }, -- jump directly to peak
      }, 
      ramp={0.1, 0.1}, -- use 10% fade-in and 10% fade-out
      modifiers = { -- values added to current baseline (faded in and out)
        --              outside, inside, underground, underwater
        humidity=       {0.4,       0.4,    0.2,         },
        light=          {-0.5,      -0.45,                },
        temperature=    {-30,       -18,       -6,    -15   },
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