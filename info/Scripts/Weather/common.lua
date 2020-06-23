-- stuff common to all weather setups...

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

-- reused tod env factors
_uff = 1.0 -- underground factor fog
_iff = 0.1 -- inside
_ufd = 0.3 -- underground factor dof
_ifd = 0.1 -- inside
_ufc = 0.4 -- underground factor photofilter
_ifc = 0.2 -- inside

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
  { x=0, y=0, z=0 }, -- Start
  { x=0, y=0, z=0 }, -- End
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
function tornadoSoundMoverMinScale(weather, rtpcVal, ramp, down, progress, minScale)
  local vPos = vecLerp( TornadoPos[1], TornadoPos[2], progress )
  local vCamPos = System.GetViewCameraPos()

  local distance = math.sqrt( vecDistance2(vPos, vCamPos) )
  local scale = distance / 1500 -- tornado gets louder if closer then 1,5km
  --scale = math.max(scale, 0) -- min multiplicator
  scale = math.min(scale, 1) -- max multiplicator
  scale = 1-(scale^3) -- sound scales logaritmic
  scale = math.max(scale, minScale) -- min multiplicator
  
  return rtpcVal * scale
end

-- helper function to change sound volume based on player pos
function tornadoSoundMover(weather, rtpcVal, ramp, down, progress)
  return tornadoSoundMoverMinScale(weather, rtpcVal, ramp, down, progress, 0.25)
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