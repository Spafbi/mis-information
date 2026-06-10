Script.ReloadScript("Scripts/Spawners/holiday_config.lua")

HolidayManager       = {}
HolidayManager._last = nil   -- last known holiday (nil = not yet polled)

-- Delegates to C++ which always recomputes from current date + override.
-- Returns the active holiday name ("christmas", "halloween", "easter") or nil.
function HolidayManager.GetActiveHoliday()
    if not g_HolidayManager then return nil end
    return g_HolidayManager.GetCurrentHoliday()
end

function HolidayManager.IsHolidayActive(name)
    return HolidayManager.GetActiveHoliday() == name
end

-- ---------------------------------------------------------------
-- Transition polling (5-minute interval)
-- ---------------------------------------------------------------

HolidayManager._checkEntity = {}

function HolidayManager._CheckTransition(self)
    local current = HolidayManager.GetActiveHoliday()
    if current ~= HolidayManager._last then
        Log("[HolidayManager] Transition: " .. tostring(HolidayManager._last)
               .. " -> " .. tostring(current))
        HolidayManager._last = current

        -- C++ handles recipe file copy/remove.
        g_HolidayManager.ApplyHolidayTransition(current or "")

        -- Reload recipe system so crafting UI picks up new XMLs.
        Game.ReloadRecipes()

        -- Reload item spawner: re-executes ItemSpawnerManager.lua (BuildGroup/BuildClasses
        -- re-run with new holiday) then rebuilds the C++ category cache.
        ISM.Reload()

        -- PartSpawnerManager is pure Lua (no C++ cache) - script reload is sufficient.
        Script.ReloadScript("Scripts/Spawners/PartSpawnerManager.lua")
    end

    Script.SetTimerForFunction(300000, "HolidayManager._CheckTransition",
                               HolidayManager._checkEntity)
end

-- Called from Miscreated.Server:OnInit() to start the polling loop.
-- Also applies the current holiday immediately so the spawner cache is
-- correct from startup (the initial LoadScript ran before g_HolidayManager existed).
function HolidayManager.StartPolling()
    local current = HolidayManager.GetActiveHoliday()
    if current then
        Log("[HolidayManager] Startup apply: " .. current)
        g_HolidayManager.ApplyHolidayTransition(current)
        Game.ReloadRecipes()
        ISM.Reload()
        Script.ReloadScript("Scripts/Spawners/PartSpawnerManager.lua")
    end
    HolidayManager._last = current
    Script.SetTimerForFunction(300000, "HolidayManager._CheckTransition",
                               HolidayManager._checkEntity)
end

-- ---------------------------------------------------------------
-- Percent-rebalancing helpers used by spawner scripts
-- ---------------------------------------------------------------

-- For 'classes' categories (pick-one-weighted). Scales base item percents DOWN
-- proportionally to make room for holiday items.
-- holiday_defs = { halloween = { add = {...}, remove = {"CategoryName"} }, ... }
function HolidayManager.BuildClasses(base_items, holiday_defs)
    local active = HolidayManager.GetActiveHoliday()
    local def    = holiday_defs and holiday_defs[active]
    if not def then return base_items end

    local add_items  = def.add    or {}
    local remove_set = {}
    for _, cat in ipairs(def.remove or {}) do remove_set[cat] = true end

    -- Remove items in the remove set
    local filtered = {}
    for _, item in ipairs(base_items) do
        local key = item.class or item.category or ""
        if not remove_set[key] then table.insert(filtered, item) end
    end

    -- Scale filtered items down to make room for holiday items
    local base_total    = 0
    for _, item in ipairs(filtered)  do base_total    = base_total    + (item.percent or 0) end
    local holiday_total = 0
    for _, item in ipairs(add_items) do holiday_total = holiday_total + (item.percent or 0) end

    local scale = (base_total > 0) and (base_total / (base_total + holiday_total)) or 1.0
    local result = {}
    for _, item in ipairs(filtered) do
        local copy = {}
        for k, v in pairs(item) do copy[k] = v end
        if copy.percent then copy.percent = copy.percent * scale end
        table.insert(result, copy)
    end
    for _, item in ipairs(add_items) do table.insert(result, item) end
    return result
end

-- For 'group' categories (independent per-item rolls). Holiday items are appended
-- with no scaling - each item's percent is an independent roll, not a weight.
function HolidayManager.BuildGroup(base_items, holiday_defs)
    local active  = HolidayManager.GetActiveHoliday()
    local holiday = holiday_defs and holiday_defs[active]
    if not holiday or #holiday == 0 then return base_items end

    local result = {}
    for _, item in ipairs(base_items) do table.insert(result, item) end
    for _, item in ipairs(holiday)    do table.insert(result, item) end
    return result
end
