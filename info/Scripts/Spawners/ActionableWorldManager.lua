ActionableWorldManager =
{

--[[

Selection prio is model, material and lastly surface

regenerate:				is in minutes (-1 or 0 means no regen)
minUses:				tools only: the minimal uses that gets scaled up to the max uses
uses:					-1 means unlimited uses, otherwise the number of usages
minRefDiameter: 		tools only: the minimum reference diameter for "minUses" (vector length of the bounding box)
maxRefDiameter:			tools only: the maximum reference diameter for "uses" (vector length of the bounding box)
sound:					uses the _fp / _3p setup if available
gridsize:				is how many times a object can be picked up per meter (min is 1 -> one pickup per meter/ max 200 -> one pickup per 200 meter grid)
tactical:				false if it shouldn't be available when raised (defaults to true)
swim:	 				false if it shouldn't be collectible when swimminging (defaults to true)
toolrequired: 			true if it requires a tool to harvest the resource (defaults to false) checks the firemode SMeleeSurfaceBehaviors surfacebehaviour, action causes attack instead a direct harvest (and attack causes then the action)
check:					true if item/success check serverside should be requested (defaults to true)
precheck:				true if the check is a requirement for showing the action at all (defaults to false)
forceinteraction:		true if the check should always perform the sound/animation (defaults to false)

consumableType:				int of fluid type (for refills etc) (defaults to 2: clean (or -1 which is also converts to clean))
						0 Diesel = 0,
						1 Propane,
						2 Clean,
						3 Dirty,
						4 Poisoned,
						5 Irradiated,
						6 PoisonedIrradiated,
						7 Alcohol,
useWithAction:			string of action (default "none")
drinkAmount:			consumable type
foodAmount:
poisonChance:
radiationAmount:
staminaAmount:
geigercounter:			consumable type - used for geiger counter markup
--]]
	
	actionables =
	{

		--------------------------------------------------
		-- Harvest WoodPile
		--------------------------------------------------
		{
			text = "@harvest_wood",
			fail = "@harvest_wood_failed",
			surface = { "mat_wood_harvest" },
			sound = "Play_pickup_wood",
			minUses = 6, -- this is a quarter of largest wall
			uses = 66, -- two walls + a few/ one 3x4 wall is 24 wood logs
			minRefDiameter = 1.5, -- smallest tree
			maxRefDiameter = 26, -- biggest trees are around 34/32/30, most are around 15-22
			regenerate = 60,
			percentage = 100,
			spawn = "WoodPile",
			gridsize = 2,
			tactical = true,
			toolrequired = true,
			AIResponseChance = 0.5, -- this is the tool harvest chance should be relatively low (5 in 1000 now)
			AIResponseStrCategory = "ai_actionable_critter",
		},

		--------------------------------------------------
		-- Harvest ScrapMetal
		--------------------------------------------------
		{
			text = "@harvest_scrap_metal",
			fail = "@harvest_scrap_metal_failed",
			surface = { "mat_metal_harvest" },
			sound = "Play_pickup_metal",
			minUses = 2, -- this is one basepart upgrade
			uses = 20, -- this is 5 basepart upgrades
			minRefDiameter = 2, -- smallest (bike is 2, f100/sedan about 6, bus is 13)
			maxRefDiameter = 13, -- 
			regenerate = 90,
			percentage = 100,
			spawn = "ScrapMetal",
			gridsize = 2,
			tactical = true,
			toolrequired = true,
		},

		--------------------------------------------------
		-- Harvest Rocks
		--------------------------------------------------
		{
			text = "@harvest_rock",
			fail = "@harvest_rock_failed",
			surface = { "mat_rock_harvest" },
			sound = "Play_pickup_plastic",
			minUses = 2,
			uses = 20,
			minRefDiameter = 0.5, 
			maxRefDiameter = 5,
			regenerate = 2,
			percentage = 100,
			spawn = "RocksAndPyrite",
			gridsize = 2,
			tactical = true,
			toolrequired = true,
		},
		{
			text = "@harvest_iron",
			fail = "@harvest_iron_failed",
			surface = { "mat_iron_harvest" },
			sound = "Play_pickup_plastic",
			minUses = 2,
			uses = 40,
			minRefDiameter = 0.5, 
			maxRefDiameter = 5,
			regenerate = 2,
			percentage = 100,
			spawn = "IronAndRocks",
			gridsize = 2,
			tactical = true,
			toolrequired = true,
		},
		{
			text = "@harvest_coal",
			fail = "@harvest_coal_failed",
			surface = { "mat_coal_harvest" },
			sound = "Play_pickup_plastic",
			minUses = 2,
			uses = 40,
			minRefDiameter = 0.5, 
			maxRefDiameter = 5,
			regenerate = 2,
			percentage = 100,
			spawn = "CoalAndRocks",
			gridsize = 2,
			tactical = true,
			toolrequired = true,
		},
		{
			text = "@harvest_pyrite",
			fail = "@harvest_pyrite_failed",
			surface = { "mat_pyrite_harvest" },
			sound = "Play_pickup_plastic",
			minUses = 2,
			uses = 40,
			minRefDiameter = 0.5, 
			maxRefDiameter = 5,
			regenerate = 2,
			percentage = 100,
			spawn = "PyriteAndRocks",
			gridsize = 2,
			tactical = true,
			toolrequired = true,
		},
		
		--------------------------------------------------
		-- Water sources
		--------------------------------------------------
		{
			text = "@drink_dirty_water",
			fail = "@drink_water_contaminated",
			surface = { "mat_water" },
			sound = "Play_drinkStream_waterScoop",
			uses = -1,
			consumableType = 5,
			useWithAction = "refill_item",
			drinkAmount = 300,
			geigercounter = 1,
			tactical = 0,
			swim = 0,
		},
		{
			text = "@drink_dirty_water",
			fail = "@drink_water_empty",
			surface = { "mat_puddle_water" },
			sound = "Play_drinkStream_drink",
			uses = 2,
			regenerate = 120,
			consumableType = 5,
			useWithAction = "refill_item",
			drinkAmount = 100,
			geigercounter = 1,
			gridsize = 4,
			tactical = 0,
			swim = 0,
		},
		{
			text = "@drink_dirty_water",
			fail = "@drink_water_contaminated",
			surface = { "mat_contaminated_water" },
			sound = "Play_drinkStream_waterScoop",
			uses = -1,
			consumableType = 4,
			useWithAction = "refill_item",
			drinkAmount = 300,
			poisonChance = 95,
			tactical = 0,
			swim = 0,
		},
		{
			text = "@drink_clean_water",
			fail = "@drink_water_contaminated",
			surface = { "mat_pristine_water", "mat_clean_water", "clean_water", },
			material = { "Materials/water/waterVolumes/water_cave_inside_flow_clean", "Materials/water/waterVolumes/water_cave_inside_clean", "Materials/water/waterVolumes/water_creek_clean", "Materials/water/waterVolumes/water_forest_a_clean", },
			sound = "Play_drinkStream_waterScoop",
			uses = -1,
			consumableType = 2,
			useWithAction = "refill_item",
			drinkAmount = 300,
			tactical = 0,
			swim = 0,
		},
		{
			text = "@drink_sea_water",
			fail = "@drink_water_contaminated",
			surface = { "mat_ocean_water" },
			sound = "Play_drinkStream_waterScoop",
			uses = -1,
			consumableType = 6,
			useWithAction = "refill_item",
			drinkAmount = 300,
			poisonChance = 30,
			geigercounter = 1.5,
			tactical = 0,
			swim = 0,
		},
		{
			text = "drink_dirty_water",
			fail = "@drink_water_contaminated",
			surface = { "mat_irradiated_water" },
			sound = "Play_drinkStream_waterScoop",
			uses = -1,
			consumableType = 5,
			useWithAction = "refill_item",
			drinkAmount = 300,
			radiationAmount = 33,
			geigercounter = 3.5,
			tactical = 0,
			swim = 0,
		},
		{
			text = "@drink_from_toilet",
			fail = "@drink_water_empty",
			material = { "Objects/props/bathroom/toilet_parts", "Objects/props/toilet/waterbox", "Objects/props/toilet/toilet" },
			model = { "objects/props/furniture/appliances/bathroom/abandoned_toilet_a.cgf" },
			sound = "Play_drinkStream_drink",
			uses = 2,
			consumableType = 2,
			useWithAction = "refill_item",
			regenerate = 120,
			percentage = 33,
			drinkAmount = 150,
			tactical = 0,
			swim = 0,
			AIResponseChance = 3,
			AIResponseStrCategory = "ai_actionable_critter",
		},
		{
			text = "@drink_from_pump",
			fail = "@drink_water_empty",
			model = { "Objects/props/water_pump/water_pump.cgf" },
			sound = "Play_drinkStream_waterScoop",
			uses = 4,
			consumableType = 2,
			useWithAction = "refill_item",
			regenerate = 20,
			percentage = 95,
			drinkAmount = 400,
			tactical = 0,
			swim = 0,
		},
		{
			text = "@drink_from_hydrant",
			fail = "@drink_water_empty",
			model = { "Objects/props/firehydrant/firehydrant.cgf" },
			sound = "Play_drinkStream_waterScoop",
			uses = 1,
			consumableType = 3,
			useWithAction = "refill_item",
			regenerate = 60,
			percentage = 25,
			drinkAmount = 300,
			staminaAmount = -30,
			tactical = 0,
			swim = 0,
		},
		{
			text = "@grab_arm",
			fail = "@grab_arm_failed",
			model = {
				"Objects/props/shop_mannequin/male_arm_right.cgf",
				"Objects/props/shop_mannequin/female_arm_right.cgf",
				},
			sound = "Play_pickup_plastic",
			uses = 1,
			regenerate = 120,
			percentage = 35,
			spawn = "MannequinArm",
			forceinteraction = true,
		},
		{
			text = "@drink_dirty_water",
			fail = "@drink_water_empty",
			model = {
				"Objects/props/residential_assets/kitchen_set/kitchenset_sink_corner.cgf",
				"Objects/props/residential_assets/kitchen_set/kitchenset_sink.cgf",
				"Objects/props/residential_assets/kitchen_set/kitchen_sink.cgf",
				"Objects/props/sinks/46_sink_a.cgf",
				"Objects/props/kitchen_cabinets/kitchen_cabinet_sink.cgf",
				"Objects/props/furniture/kks_bath/sink.cgf",
				"Objects/props/furniture/appliances/bathroom/abandoned_sink_b.cgf",
				"Objects/props/furniture/appliances/bathroom/abandoned_sink_a.cgf",
				"Objects/props/residential_assets/bathroom_sink/bathroom_sink.cgf",
				"Objects/props/Restaurant_equipment/sink_dishwasher/under_bar_sink.cgf",
				"Objects/props/bathroom/sink_01.cgf",
				"Objects/props/bathroom/sink_02.cgf",
				"Objects/props/cabinets/with_countertops/46_lowersink_a.cgf",
				"Objects/props/cabinets/with_countertops/46_lowersink_c.cgf",
			},
			sound = "Play_drinkStream_drink",
			uses = 1,
			regenerate = 120,
			percentage = 33,
			consumableType = 5,
			useWithAction = "refill_item",
			drinkAmount = 100,
			geigercounter = 1,
			tactical = 0,
			swim = 0,
			AIResponseChance = 3,
			AIResponseStrCategory = "ai_actionable_critter",
		},
		{
			text = "@drink_from_dispenser",
			fail = "@drink_water_empty",
			model = {
				"Objects/props/hospital/hospital_water_dispenser_bottle.cgf",
				"Objects/props/hospital/hospital_water_dispenser.cgf",
				"Objects/props/hospital/hospital_water_dispenser_with_bottle.cgf",
			},
			sound = "Play_drinkStream_waterScoop",
			uses = 1,
			regenerate = 120,
			percentage = 50,
			consumableType = 2,
			useWithAction = "refill_item",
			drinkAmount = 150,
			tactical = 0,
			swim = 0,
		},
		{
			text = "@drink_from_container",
			fail = "@drink_water_empty",
			model = { "Objects/props/ibc_container/ibc_container.cgf" },
			sound = "Play_drinkStream_waterScoop",
			uses = 5,
			regenerate = 120,
			percentage = 66,
			consumableType = 2,
			useWithAction = "refill_item",
			drinkAmount = 150,
			tactical = 0,
			swim = 0,
		},
		{
			text = "@drink_from_pump",
			fail = "@drink_water_empty",
			model = { "objects/props/restaurant_props/bar_pump/bar_pump.cgf" },
			sound = "Play_drinkStream_drink",
			uses = 2,
			regenerate = 90,
			percentage = 90,
			consumableType = 7,
			useWithAction = "refill_item",
			drinkAmount = 200,
			torpidityAmount = 25,
		},
		{
			text = "@drink_from_pump",
			fail = "@drink_water_empty",
			model = { 
				"Objects/props/gasPump/gasPump.cgf",
				"Objects/props/misc/old_gas_pump/old_gas_pump_01.cgf",
			},
			sound = "Play_drinkStream_waterScoop",
			uses = 2,
			regenerate = 90,
			percentage = 90,
			consumableType = 0,
			useWithAction = "refill_item",
			drinkAmount = 1,
			torpidityAmount = 25,
			staminaAmount = -25,
			poisonChance = 50,
		},
		{
			text = "@siphon_fuel",
			fail = "@siphon_fuel_failed",
			model = { 
				"Objects/props/industrial/tanks/oil_tank/oil_tank_a.cgf",
				"Objects/props/industrial/tanks/oil_tank/oil_tank_b.cgf",
			},
			sound = "Play_drinkStream_waterScoop",
			uses = 2,
			regenerate = 90,
			percentage = 90,
			consumableType = 0,
			useWithAction = "refill_item",
			drinkAmount = 1,
			torpidityAmount = 10,
			staminaAmount = -10,
			poisonChance = 10,
		},
		{
			text = "@drink_from_valve",
			fail = "@drink_water_empty",
			model = { 
				"Objects/props/Nitrogen_Tank/nitrogentank_red.cgf",
			},
			sound = "Play_drinkStream_drink",
			uses = 1,
			regenerate = 180,
			percentage = 90,
			consumableType = 1,
			useWithAction = "refill_gastank",
			drinkAmount = 1,
			torpidityAmount = 33,
			staminaAmount = -33,
		},

		--------------------------------------------------
		-- Stick sources
		--------------------------------------------------
		{
			text = "@search_bush",
			fail = "@nothing_was_found",
			material = {
				"objects/natural/bushes/cliffbush/cliff_bush_green", 
				"objects/natural/bushes/cliffbush/cliff_bush_yellow" 
			},
			model = {
				"objects/natural/bushes/cliffbush/cliff_bush_green_mini.cgf", 
				"objects/natural/bushes/cliffbush/cliff_bush_yellow_mini.cgf", 
			},
			sound = "Play_bush_movement_dry_large",
			uses = 1,
			regenerate = 120,
			percentage = 75,
			spawn = "StickPileOrThatch",
			gridsize = 4,
			tactical = false,
			check = false,
			AIResponseChance = 3,
			AIResponseStrCategory = "ai_actionable_spider",
			forceinteraction = true,
		},

		--------------------------------------------------
		-- Drink Vending machine
		--------------------------------------------------
		{
			text = "@search_vending_machine",
			fail = "@nothing_was_found",
			model = {
				"objects/props/vendingmachine/vendingmachine.cgf",
				"objects/props/misc/vending_machine/vending_machine.cgf",
				"objects/props/industrial/vending_machines/coffeemachine.cgf",
				"objects/props/industrial/vending_machines/vendingmachine_01.cgf",
				"objects/props/industrial/vending_machines/vendingmachine_02.cgf",
				"objects/props/industrial/vending_machines/vendingmachine_03.cgf",
				},
			sound = "Play_pickup_plastic",
			uses = 2,
			regenerate = 120,
			percentage = 40,
			spawn = "RandomDrinkVendingMachineContent",
		},

		--------------------------------------------------
		-- Electrical parts
		--------------------------------------------------
		{
			text = "@salvage_electronics",
			fail = "@salvage_failed",
			model = {
				"objects/props/brokentv/brokentv.cgf",
				"objects/props/furniture/computer/computer.cgf",
				"objects/props/old_computer/old_compuer_monitor.cgf",
				"objects/props/security_monitor/security_monitor.cgf",
				"objects/props/laptop/laptop.cgf",
				"objects/props/radio/radio_black.cgf",
				"objects/props/radio/radio_white.cgf",
				"objects/props/radio/radio_blue.cgf",
				"objects/props/radio/radio_pink.cgf",
				"objects/props/radio/radio_red.cgf",
				"objects/props/radio/radio_silver.cgf",
				"objects/props/industrial/electrical/panels/panel_a.cgf",
				"objects/props/industrial/electrical/panels/panel_b.cgf",
				"objects/props/industrial/electrical/panels/panel_c.cgf",
				"objects/props/heater/ceiling_heater.cgf",
				"objects/props/solar_panel/solar_panel_angled_controlbox.cgf",
				"objects/props/residential_assets/gadgets/laptop_open.cgf",
				"objects/props/residential_assets/gadgets/laptop_closed.cgf",
				"objects/props/residential_assets/gadgets/tv_hanging.cgf",
				"objects/props/residential_assets/gadgets/tv.cgf",
				"Objects/props/hospital/hospital_electrical/hospital_screen_keyboard_mouse.cgf",
				"Objects/props/hospital/hospital_electrical/hospital_monitor_01c.cgf",
				"Objects/props/hospital/hospital_electrical/hospital_computer.cgf",
				"Objects/props/hospital/hospital_electrical/hospital_monitor_01b.cgf",
				"Objects/props/hospital/hospital_electrical/hospital_monitor_01a.cgf",
				"Objects/props/hospital/hospital_electrical/hospital_computer_screen.cgf",
				"Objects/props/hospital/hospital_electrical/hospital_debibrillator_01a.cgf",
				"Objects/props/hospital/hospital_electrical/hospital_debibrillator_01b.cgf",
				"Objects/props/hospital/hospital_electrical/hospital_defib_02a.cgf",
				"Objects/props/hospital/hospital_electrical/hospital_defib_02b.cgf",
				"Objects/props/hospital/hospital_electrical/hospital_defib_02c.cgf",
				"Objects/props/hospital/hospital_electrical/hospital_defib_02e.cgf",
				"Objects/props/hospital/hospital_electrical/hospital_eye_examiner.cgf",
				"Objects/props/hospital/hospital_electrical/hospital_ecg_monitor_01d.cgf",
				"Objects/props/hospital/hospital_electrical/hospital_ecg_monitor_01b.cgf",
				"Objects/props/hospital/hospital_electrical/hospital_ecg_monitor_01a.cgf",
				"Objects/props/hospital/hospital_electrical/hospital_vital_signs_monitor_01a.cgf",
				"Objects/props/hospital/hospital_electrical/hospital_vital_signs_monitor_01b.cgf",
				"Objects/props/hospital/hospital_electrical/hospital_xray_machine.cgf",
				"Objects/props/hospital/hospital_electrical/ultrasound_machine.cgf",
				},
			sound = "Play_pickup_metal",
			uses = 1,
			regenerate = 300,
			percentage = 10,
			spawn = "RandomElectronicsContent",
			forceinteraction = true,
		},

		--------------------------------------------------
		-- Registers
		--------------------------------------------------
		{
			text = "@search_amcoins",
			fail = "@nothing_was_found",
			model = { 
				"Objects/props/diner_assets/cash_register/cash_register.cgf",
				"Objects/props/cash_register/cash_register.cgf",
				"Objects/props/atm/atm.cgf",
				"Objects/props/PayPhone/PayPhone.cgf",
			},
			sound = "Play_pickup_metal",
			uses = 1,
			regenerate = 40,
			percentage = 8, -- that is about one amcoin per town per hour.
			spawn = "CheckoutContent",
			AIResponseChance = 3,
			AIResponseStrCategory = "ai_actionable_critter",
		},

		--------------------------------------------------
		-- Hiding Place (Small)
		--------------------------------------------------
		{
			text = "@search_hiding_spot",
			fail = "@nothing_was_found",
			model = { 
				"Objects/props/residential_assets/toys/toy_bunny.cgf",
				"Objects/props/clock/wallclock_2.cgf",
				"Objects/props/residential_assets/deskware/notebook_stack_a.cgf",
				"Objects/props/residential_assets/deskware/notebook_stack_b.cgf",
				"Objects/props/furniture/PictureFrame_3_pack/table_frame_pic2.cgf",
				"Objects/props/furniture/PictureFrame_3_pack/table_frame.cgf",
				"Objects/props/furniture/pictureFrame/pictureFrame.cgf",
				"Objects/props/Vase_flowers/ceramic_vase.cgf",
				"Objects/props/residential_assets/vases/vase_a.cgf",
				"Objects/props/residential_assets/vases/vase_b.cgf",
				"Objects/props/residential_assets/vases/vase_c.cgf",
				"Objects/props/residential_assets/vases/vase_d.cgf",
				"Objects/props/residential_assets/vases/vase_e.cgf",
				"Objects/props/residential_assets/vases/vase_f.cgf",
				"Objects/props/furniture/frames_with_pictures/picture_frame001.cgf",
				"Objects/props/furniture/frames_with_pictures/picture_frame002.cgf",
				"Objects/props/furniture/frames_with_pictures/picture_frame003.cgf",
				"Objects/props/furniture/frames_with_pictures/picture_frame004.cgf",
				"Objects/props/furniture/frames_with_pictures/picture_frame005.cgf",
				"Objects/props/furniture/frames_with_pictures/picture_frame006.cgf",
				"Objects/props/furniture/frames_with_pictures/picture_frame007.cgf",
				"Objects/props/furniture/frames_with_pictures/picture_frame008.cgf",
				"Objects/props/furniture/frames_with_pictures/picture_frame009.cgf",
				"Objects/props/furniture/frames_with_pictures/picture_frame010.cgf",
				"Objects/props/furniture/frames_with_pictures/picture_frame011.cgf",
				"Objects/props/furniture/frames_with_pictures/picture_frame012.cgf",
				"Objects/props/furniture/frames_with_pictures/picture_frame013.cgf",
				"Objects/props/furniture/frames_with_pictures/picture_frame014.cgf",
				"Objects/props/furniture/frames_with_pictures/picture_frame015.cgf",
				"Objects/props/furniture/frames_with_pictures/picture_frame016.cgf",
				"Objects/props/furniture/frames_with_pictures/picture_frame017.cgf",
				"Objects/props/furniture/frames_with_pictures/picture_frame018.cgf",
				"Objects/props/furniture/frames_with_pictures/picture_frame019.cgf",
				"Objects/props/furniture/frames_with_pictures/picture_frame020.cgf",
				"Objects/props/furniture/frames_with_pictures/picture_frame021.cgf",
				"Objects/props/furniture/frames_with_pictures/picture_frame022.cgf",
				"Objects/props/furniture/frames_with_pictures/picture_frame023.cgf",
				"Objects/props/furniture/frames_with_pictures/picture_frame024.cgf",
				"Objects/props/furniture/frames_with_pictures/picture_frame025.cgf",
				"Objects/props/furniture/frames_with_pictures/picture_frame026.cgf",
				"Objects/props/furniture/frames_with_pictures/picture_frame027.cgf",
				"Objects/props/furniture/frames_with_pictures/picture_frame028.cgf",
				"Objects/props/furniture/frames_with_pictures/picture_frame029.cgf",
				"Objects/props/furniture/frames_with_pictures/picture_frame020.cgf",
				"Objects/props/furniture/frames_with_pictures/picture_frame021.cgf",
				"Objects/props/furniture/frames_with_pictures/picture_frame022.cgf",
				"Objects/props/furniture/frames_with_pictures/picture_frame023.cgf",
				"Objects/props/furniture/frames_with_pictures/picture_frame024.cgf",
				"Objects/props/furniture/frames_with_pictures/picture_frame025.cgf",
				"Objects/props/furniture/frames_with_pictures/picture_frame026.cgf",
				"Objects/props/furniture/frames_with_pictures/picture_frame027.cgf",
				"Objects/props/furniture/frames_with_pictures/picture_frame028.cgf",
				"Objects/props/furniture/frames_with_pictures/picture_frame029.cgf",
				"Objects/props/furniture/frames_with_pictures/picture_frame030.cgf",
				"Objects/props/furniture/frames_with_pictures/picture_frame031.cgf",
				"Objects/props/furniture/frames_with_pictures/picture_frame032.cgf",
				"Objects/props/furniture/frames_with_pictures/picture_frame033.cgf",
				"Objects/props/furniture/frames_with_pictures/picture_frame034.cgf",
				"Objects/props/furniture/frames_with_pictures/picture_frame035.cgf",
				"Objects/props/furniture/frames_with_pictures/picture_frame036.cgf",
				"Objects/props/furniture/frames_with_pictures/picture_frame037.cgf",
				"Objects/props/furniture/frames_with_pictures/picture_frame038.cgf",
				"Objects/props/furniture/frames_with_pictures/picture_frame039.cgf",
				"Objects/props/furniture/frames_with_pictures/picture_frame040.cgf",
				"Objects/props/furniture/frames_with_pictures/picture_frame041.cgf",
				"Objects/props/furniture/frames_with_pictures/picture_frame042.cgf",
				"Objects/props/furniture/frames_with_pictures/picture_frame043.cgf",
				"Objects/props/furniture/frames_with_pictures/picture_frame044.cgf",
				"Objects/props/furniture/frames_with_pictures/picture_frame045.cgf",
				"Objects/props/furniture/frames_with_pictures/picture_frame046.cgf",
				"Objects/props/furniture/frames_with_pictures/picture_frame047.cgf",
				"Objects/props/furniture/frames_with_pictures/picture_frame048.cgf",
				"Objects/props/furniture/frames_with_pictures/picture_frame049.cgf",
				"Objects/props/furniture/frames_with_pictures/picture_frame050.cgf",
				"Objects/props/furniture/frames_with_pictures/picture_frame051.cgf",
				"Objects/props/furniture/frames_with_pictures/picture_frame052.cgf",
				"Objects/props/furniture/frames_with_pictures/picture_frame053.cgf",
				"Objects/props/furniture/frames_with_pictures/picture_frame054.cgf",
				"Objects/props/furniture/frames_with_pictures/picture_frame055.cgf",
				"Objects/props/furniture/frames_with_pictures/picture_frame056.cgf",
				"Objects/props/furniture/frames_with_pictures/picture_frame057.cgf",
				"Objects/props/furniture/frames_with_pictures/picture_frame058.cgf",
				"Objects/props/furniture/frames_with_pictures/picture_frame059.cgf",
				"Objects/props/furniture/frames_with_pictures/picture_frame060.cgf",
				"Objects/props/furniture/frames_with_pictures/picture_frame061.cgf",
				"Objects/props/furniture/frames_with_pictures/picture_frame062.cgf",
				"Objects/props/furniture/frames_with_pictures/picture_frame063.cgf",
				"Objects/props/furniture/frames_with_pictures/picture_frame064.cgf",
				"Objects/props/furniture/frames_with_pictures/picture_frame065.cgf",
				"Objects/props/furniture/frames_with_pictures/picture_frame066.cgf",
				"Objects/props/furniture/frames_with_pictures/picture_frame067.cgf",
				"Objects/props/furniture/frames_with_pictures/picture_frame068.cgf",
				"Objects/props/furniture/frames_with_pictures/picture_frame069.cgf",
				"Objects/props/furniture/frames_with_pictures/picture_frame070.cgf",
				"Objects/props/furniture/frames_with_pictures/picture_frame071.cgf",
				"Objects/props/furniture/frames_with_pictures/picture_frame072.cgf",
				"Objects/props/furniture/frames_with_pictures/picture_frame073.cgf",
				"Objects/props/furniture/frames_with_pictures/picture_frame074.cgf",
				"Objects/props/furniture/frames_with_pictures/picture_frame075.cgf",
				"Objects/props/furniture/frames_with_pictures/picture_frame076.cgf",
				"Objects/props/furniture/frames_with_pictures/picture_frame077.cgf",
				"Objects/props/furniture/frames_with_pictures/picture_frame078.cgf",
				"Objects/props/furniture/frames_with_pictures/picture_frame079.cgf",
				"Objects/props/furniture/frames_with_pictures/picture_frame080.cgf",
				"Objects/props/furniture/frames_with_pictures/picture_frame081.cgf",
				"Objects/props/furniture/frames_with_pictures/picture_frame082.cgf",
				"Objects/props/furniture/frames_with_pictures/picture_frame083.cgf",
				"Objects/props/furniture/frames_with_pictures/picture_frame084.cgf",
				"Objects/props/furniture/frames_with_pictures/picture_frame085.cgf",
				"Objects/props/furniture/frames_with_pictures/picture_frame086.cgf",
				"Objects/props/furniture/frames_with_pictures/picture_frame087.cgf",
				"Objects/props/furniture/frames_with_pictures/picture_frame088.cgf",
				"Objects/props/furniture/frames_with_pictures/picture_frame089.cgf",
				"Objects/props/furniture/frames_with_pictures/picture_frame090.cgf",
				"Objects/props/furniture/frames_with_pictures/picture_frame091.cgf",
				"Objects/props/furniture/frames_with_pictures/picture_frame092.cgf",
				"Objects/props/furniture/frames_with_pictures/picture_frame093.cgf",
				"Objects/props/furniture/frames_with_pictures/picture_frame094.cgf",
				"Objects/props/furniture/frames_with_pictures/picture_frame095.cgf",
				"Objects/props/furniture/frames_with_pictures/picture_frame096.cgf",
				"Objects/props/furniture/frames_with_pictures/picture_frame097.cgf",
				"Objects/props/furniture/frames_with_pictures/picture_frame098.cgf",
				"Objects/props/furniture/frames_with_pictures/picture_frame099.cgf",
				"Objects/props/furniture/frames_with_pictures/picture_frame100.cgf",
				"Objects/props/furniture/frames_with_pictures/picture_frame101.cgf",
				"Objects/props/furniture/frames_with_pictures/picture_frame102.cgf",
				"Objects/props/furniture/frames_with_pictures/picture_frame103.cgf",
				"Objects/props/furniture/frames_with_pictures/picture_frame104.cgf",
				"Objects/props/furniture/frames_with_pictures/picture_frame105.cgf",
				"Objects/props/furniture/frames_with_pictures/picture_frame106.cgf",
				"Objects/props/furniture/frames_with_pictures/picture_frame107.cgf",
				"Objects/props/furniture/frames_with_pictures/picture_frame108.cgf",
				"Objects/props/furniture/frames_with_pictures/picture_frame109.cgf",
				"Objects/props/furniture/frames_with_pictures/picture_frame110.cgf",
				"Objects/props/furniture/frames_with_pictures/picture_frame111.cgf",
				"Objects/props/furniture/frames_with_pictures/picture_frame112.cgf",
				"Objects/props/furniture/frames_with_pictures/picture_frame113.cgf",
				"Objects/props/furniture/frames_with_pictures/picture_frame114.cgf",
				"Objects/props/furniture/frames_with_pictures/picture_frame115.cgf",
				"Objects/props/furniture/frames_with_pictures/picture_frame116.cgf",
				"Objects/props/furniture/frames_with_pictures/picture_frame117.cgf",
				"Objects/props/furniture/frames_with_pictures/picture_frame118.cgf",
				"Objects/props/furniture/frames_with_pictures/picture_frame119.cgf",
				"Objects/props/furniture/frames_with_pictures/picture_frame120.cgf",
				"Objects/props/furniture/frames_with_pictures/picture_frame121.cgf",
				"Objects/props/furniture/frames_with_pictures/picture_frame122.cgf",
				"Objects/props/furniture/frames_with_pictures/picture_frame123.cgf",
				"Objects/props/furniture/frames_with_pictures/picture_frame124.cgf",
				"Objects/props/furniture/frames_with_pictures/picture_frame125.cgf",
				"Objects/props/furniture/frames_with_pictures/picture_frame126.cgf",
				"Objects/props/furniture/frames_with_pictures/picture_frame127.cgf",
				"Objects/props/furniture/frames_with_pictures/picture_frame128.cgf",
				"Objects/props/furniture/frames_with_pictures/picture_frame129.cgf",
				"Objects/props/furniture/frames_with_pictures/picture_frame130.cgf",
				"Objects/props/furniture/frames_with_pictures/picture_frame131.cgf",
				"Objects/props/furniture/frames_with_pictures/picture_frame132.cgf",
				"Objects/props/furniture/frames_with_pictures/picture_frame133.cgf",
				"Objects/props/furniture/frames_with_pictures/picture_frame134.cgf",
				"Objects/props/furniture/frames_with_pictures/picture_frame135.cgf",
				"Objects/props/furniture/frames_with_pictures/picture_frame136.cgf",
				"Objects/props/furniture/frames_with_pictures/picture_frame137.cgf",
				"Objects/props/furniture/frames_with_pictures/picture_frame138.cgf",
				"Objects/props/furniture/frames_with_pictures/picture_frame139.cgf",
				"Objects/props/furniture/frames_with_pictures/picture_frame140.cgf",
				"Objects/props/furniture/frames_with_pictures/picture_frame141.cgf",
				"Objects/props/furniture/frames_with_pictures/picture_frame142.cgf",
				"Objects/props/furniture/frames_with_pictures/picture_frame143.cgf",
				"Objects/props/furniture/frames_with_pictures/picture_frame144.cgf",
				"Objects/props/furniture/frames_with_pictures/picture_frame145.cgf",
				"Objects/props/furniture/frames_with_pictures/picture_frame146.cgf",
				"Objects/props/furniture/frames_with_pictures/picture_frame147.cgf",
				"Objects/props/furniture/frames_with_pictures/picture_frame148.cgf",
				"Objects/props/furniture/frames_with_pictures/picture_frame149.cgf",
				"Objects/props/furniture/frames_with_pictures/picture_frame150.cgf",
				"Objects/props/furniture/frames_with_pictures/picture_frame151.cgf",
				"Objects/props/furniture/frames_with_pictures/picture_frame152.cgf",
				"Objects/props/furniture/frames_with_pictures/picture_frame153.cgf",
				"Objects/props/furniture/frames_with_pictures/picture_frame154.cgf",
				"Objects/props/furniture/frames_with_pictures/picture_frame155.cgf",
				"Objects/props/furniture/frames_with_pictures/picture_frame156.cgf",
				"Objects/props/furniture/frames_with_pictures/picture_frame157.cgf",
				"Objects/props/furniture/frames_with_pictures/picture_frame158.cgf",
				"Objects/props/furniture/frames_with_pictures/picture_frame159.cgf",
				"Objects/props/furniture/frames_with_pictures/picture_frame160.cgf",
				"Objects/props/furniture/frames_with_pictures/picture_frame161.cgf",
				"Objects/props/furniture/frames_with_pictures/picture_frame162.cgf",
				"Objects/props/furniture/frames_with_pictures/picture_frame163.cgf",
				"Objects/props/furniture/frames_with_pictures/picture_frame164.cgf",
				"Objects/props/furniture/frames_with_pictures/picture_frame165.cgf",
				"Objects/props/furniture/frames_with_pictures/picture_frame166.cgf",
				"Objects/props/furniture/frames_with_pictures/picture_frame167.cgf",
				"Objects/props/furniture/frames_with_pictures/picture_frame168.cgf",
				"Objects/props/rubble_debris/Rubble_Pile_Small_Decal_01.cgf",
				"Objects/props/rubble_debris/Rubble_Pile_Small_Decal_02.cgf",
				"Objects/props/rubble_debris/Rubble_Pile_Small_Decal_03.cgf",
				"Objects/props/rubble_debris/Rubble_Pile_Small_Decal_04.cgf",
				"Objects/props/residential_assets/deskware/pencil_case.cgf",
				"Objects/props/residential_assets/deskware/pencil_case_filled.cgf",
				"Objects/props/residential_assets/deskware/notebook_stack_a.cgf",
				"Objects/props/residential_assets/deskware/notebook_stack_b.cgf",
				"Objects/props/residential_assets/kitchen_ware/teapot.cgf",
				"Objects/props/biohazard_assets/air_duct_fan_1.cgf",
				"Objects/props/biohazard_assets/air_duct_fan_2.cgf",
				"Objects/props/vent_wall_coverings/wall_vent_closed.cgf",
				"Objects/props/vent_wall_coverings/wall_vent_fan.cgf",
				"Objects/props/vent_wall_coverings/wall_vent_fan_closed.cgf",
				"Objects/props/vent_wall_coverings/wall_vent_fan_half_closed.cgf",
				"Objects/props/vent_wall_coverings/wall_vent_fan_nogrill.cgf",
				"Objects/props/vent_wall_coverings/wall_vent_fan_round.cgf",
				"Objects/props/vent_wall_coverings/wall_vent_fan_round_closed.cgf",
				"Objects/props/vent_wall_coverings/wall_vent_fan_round_half_closed.cgf",
				"Objects/props/vent_wall_coverings/wall_vent_round_closed.cgf",
				"Objects/props/vent_wall_coverings/wall_vent_round_nogrill.cgf",
				"Objects/props/aircon/air_con_fan.cgf",
				"Objects/props/aircon/aircon.cgf",
				"Objects/props/aircon/house_aircon.cgf",
				"Objects/props/aircon/roof_aircon.cgf",
				"Objects/props/smokedetector/smokedetector.cgf",
			},
			sound = "Play_pickup_plastic",
			uses = 1,
			regenerate = 200,
			percentage = 4,
			spawn = "SmallHidingPlaceContent",
			precheck = true,
		},

		--------------------------------------------------
		-- Hiding Place (Medium)
		--------------------------------------------------
		{
			text = "@search_hiding_spot",
			fail = "@nothing_was_found",
			model = { 
				"Objects/props/residential_assets/books/book_set_a.cgf",
				"Objects/props/residential_assets/books/book_set_b.cgf",
				"Objects/props/furniture/PictureFrame_3_pack/metal_landscape_fancy_pic2.cgf",
				"Objects/props/furniture/PictureFrame_3_pack/metal_landscape_fancy.cgf",
				"Objects/props/furniture/PictureFrame_3_pack/metal_landscape_basic_pic2.cgf",
				"Objects/props/furniture/PictureFrame_3_pack/metal_landscape_basic.cgf",
				"Objects/props/painting/painting_landscape.cgf",
				"Objects/props/painting/painting_square.cgf",
				"Objects/props/newspaperDispencer/newspaperdispencer.cgf",
				"Objects/props/newspaperMachine/newspapermachine.cgf",
				"Objects/props/newspaperMachine_blue/newspapermachine.cgf",
				"Objects/props/newspaperMachine_gray/newspapermachine.cgf",
				"Objects/props/newspaperMachine_red/newspapermachine.cgf",
				"Objects/props/newspaperMachine_yellow/newspapermachine.cgf",
				"Objects/props/city_planter/city_planter.cgf",
				"Objects/props/city_planter/city_planter02.cgf",
				"Objects/props/city_planter/city_planter_round01.cgf",
				"Objects/props/city_planter/city_planter_round03.cgf",
				"Objects/props/city_planter/city_planter_round02.cgf",
				"Objects/props/office_small_props/cardboard_box_open_lid.cgf",
				"Objects/props/office_small_props/cardboard_box_2.cgf",
				"Objects/props/office_small_props/cardboard_box_1.cgf",
				"Objects/props/office_small_props/metal_box_open_lid.cgf",
				"Objects/props/tire/tire_pile/tarp_crushed_cars1.cgf",
				"Objects/props/tire/tire_pile/tarp_crushed_cars2.cgf",
				"Objects/props/rubble_debris/Rubble_Pile_Big.cgf",
				"Objects/props/rubble_debris/Rubble_Pile_Corner_Inside.cgf",
				"Objects/props/rubble_debris/Rubble_Pile_Corner_Outside.cgf",
				"Objects/props/rubble_debris/Rubble_Pile_Medium_01.cgf",
				"Objects/props/rubble_debris/Rubble_Pile_Medium_02.cgf",
				"Objects/props/rubble_debris/Rubble_Pile_Medium_03.cgf",
				"Objects/props/rubble_debris/Rubble_Pile_Medium_04.cgf",
				"Objects/props/residential_assets/bathroom_sink/bathroom_mirror.cgf",
				"Objects/props/diner_assets/branding_sheet/board_a.cgf",
				"Objects/props/diner_assets/branding_sheet/board_b.cgf",
				"Objects/props/diner_assets/branding_sheet/board_c.cgf",
				"Objects/natural/trees/rocky_ravine/g_spruce_fall_stand.cgf",
				"Objects/props/furniture/matress/matress_bent.cgf",
				"Objects/props/furniture/matress/matress.cgf",
				"Objects/props/hospital/hospital_beds/hospital_gurney_01d.cgf",
				"Objects/props/hospital/hospital_beds/hospital_gurney_01c.cgf",
				"Objects/props/hospital/hospital_beds/hospital_gurney_01b.cgf",
			},
			sound = "Play_pickup_plastic",
			uses = 1,
			regenerate = 200,
			percentage = 3,
			spawn = "MediumHidingPlaceContent",
			precheck = true,
		},

		--------------------------------------------------
		-- Very good seed source (bunker platers)
		--------------------------------------------------
		{
			text = "@collect_seeds",
			fail = "@nothing_was_found",
			model = {
				"Objects/props/city_planter/plant_tray.cgf",
				},
			sound = "Play_sandbag_fill",
			uses = 3,
			regenerate = 120,
			percentage = 90,
			spawn = "RandomSeeds",
		},

		--------------------------------------------------
		-- Tire / Wheels
		--------------------------------------------------
		{
			text = "@search_wheel",
			fail = "@nothing_was_found",
			model = {
				"Objects/props/tire/tire_pile/tire_pile001.cgf",
				"Objects/props/tire/tire_pile/tire_pile002.cgf",
				"Objects/props/tire/tire_pile/tire_pile003.cgf",
				},
			sound = "Play_pickup_plastic",
			uses = 3,
			regenerate = 240,
			percentage = 60,
			spawn = "Wheel",
		},

		--------------------------------------------------
		-- Rope
		--------------------------------------------------
		{
			text = "@salvage_rope",
			fail = "@salvage_failed",
			model = {
				"objects/props/maritime/fishing_net/fishing_net.cgf",
				"Objects/props/maritime/fisher_boat/lifebelt_rope.cgf",
				"Objects/structures/dock/rope_bollard.cgf",
				"Objects/structures/dock/rope_bollard_01.cgf",
				"Objects/structures/dock/rope_ground.cgf",
				},
			sound = "Play_pickup_fabric",
			uses = 1,
			regenerate = 120,
			percentage = 70,
			spawn = "Rope",
		},

		--------------------------------------------------
		-- Nails / Tools
		--------------------------------------------------
		{
			text = "@salvage_tools",
			fail = "@salvage_failed",
			model = {
				"objects/props/tool_box_large/toolbox_large_closed.cgf",
				"objects/props/tool_box_large/toolbox_large.cgf",
				"objects/props/small_toolbox/small_toolbox.cgf",
				"objects/props/furniture/workbenches/workbench_a.cgf",
				"objects/props/furniture/workbenches/workbench_b.cgf",
				"Objects/basebuilding/other/workbench/workbench.cgf", -- someone started using basebuilding items in prefabs... so give it an action as well
				},
			sound = "Play_toolbox_search",
			uses = 1,
			regenerate = 120,
			percentage = 75,
			spawn = "RandomToolboxContent",
			forceinteraction = true,
		},

		--------------------------------------------------
		-- Rocks
		--------------------------------------------------
		{
			text = "@search_rocks",
			fail = "@nothing_was_found",
			surface = { "mat_gravel" },
			model = {
				"objects/props/fishing_camp/campfire_burned.cgf",
				"objects/props/fishing_camp/campfire.cgf",
				"objects/props/misc/fireplace/fireplace_a.cgf",
				"objects/props/campground/campfire_b.cgf",
				"objects/props/campground/campfire_a.cgf",
				"Objects/architecture/walls/stone_barrier/stone_barrier_high_corner.cgf",
				"Objects/architecture/walls/stone_barrier/stone_barrier_high_a_cap.cgf",
				"Objects/architecture/walls/stone_barrier/stone_barrier_high_a.cgf",
				"Objects/sidewalk/mud_stone1.cgf",
				"Objects/sidewalk/mud_stone2.cgf",
			},
			sound = "Play_pickup_plastic",
			uses = 1,
			regenerate = 240,
			percentage = 33,
			spawn = "Rocks",
			gridsize = 4,
			tactical = false,
		},

		--------------------------------------------------
		-- Wood
		--------------------------------------------------
		{
			text = "@search_wood",
			fail = "@nothing_usable_was_found",
			model = {
				"objects/natural/groundwood/groundwood_01.cgf",
				"objects/natural/groundwood/groundwood_02.cgf",
				"objects/natural/woodland/woodland_wood_pile_a.cgf",
				"objects/natural/woodland/woodland_wood_pile_b.cgf",
				"objects/natural/woodland/woodland_wood_pile_c.cgf",
				"objects/props/cabinassets/logpile_01.cgf",
				"objects/props/cabinassets/logpile_02.cgf",
				"objects/props/misc/stacked_logs/stacked_logs_half_4m_a.cgf",
				"objects/props/misc/stacked_logs/stacked_logs_full_4m_a.cgf",
				"objects/props/misc/stacked_logs/log_path_a.cgf",
				"objects/architecture/buildings/loghouse/loghouse_pile.cgf",
			},
			sound = "Play_pickup_wood",
			uses = 3,
			regenerate = 240,
			percentage = 95,
			spawn = "WoodPile",
			AIResponseChance = 3,
			AIResponseStrCategory = "ai_actionable_critter",
		},

		--------------------------------------------------
		-- Lumber
		--------------------------------------------------
		{
			text = "@tear_off_lumber",
			fail = "@nothing_usable_was_found",
			model = {
				"objects/props/woodpalette/woodpalette.cgf",
				"objects/props/wooden_pallet/wooden_pallet.cgf",
				"objects/structures/constructables/wood/wallsbarricades/wood_short.cgf",
				"objects/props/mine/random_woodplanks.cgf",
				"objects/props/industrial/palette/palette_mp.cgf",
				"objects/props/farmfence/crawlunder.cgf",
				"objects/props/farmfence/fencebroken.cgf",
				"objects/props/farmfence/brokenfence2.cgf",
				"Objects/props/junkyard/junkyard_fence_missingplanks.cgf",
				"Objects/props/junkyard/junkyard_fence_missingplanks1.cgf",
				"Objects/props/junkyard/junkyard_fence_uneven_missingplanks.cgf",
				"Objects/props/junkyard/junkyard_fence_uneven_missingplanks2.cgf",
				"Objects/props/junkyard/junkyard_fence_uneven_missingplanks3.cgf",
			},
			sound = "Play_pickup_wood",
			uses = 2,
			regenerate = 240,
			percentage = 95,
			spawn = "Lumber",
			tactical = false,
			AIResponseChance = 4,
			AIResponseStrCategory = "ai_actionable_spider",
		},

		--------------------------------------------------
		-- Rags
		--------------------------------------------------
		{
			text = "@tear_off_rags",
			fail = "@nothing_usable_was_found",
			model = {
				"objects/props/campground/sleepingbag_a.cgf",
				"objects/props/campground/sleepingbag_b.cgf",
				"objects/props/campground/sleepingbag_c.cgf",
				"objects/props/campground/sleepingbag_d.cgf",
				"objects/props/misc/sleepingbag/sleepingbag.cgf",
				"objects/props/simpletable/tablecloth.cgf",
				"objects/props/furniture/standardbed/cloth.cgf",
				"objects/props/furniture/standardbed/pillow.cgf",
				"objects/props/furniture/beds/pillow.cgf",
				"objects/props/flag/office_flag.cgf",
				"Objects/props/bed_bunker/bed_bunker.cgf",
				"Objects/props/residential_assets/bed/bed.cgf",
				"Objects/props/residential_assets/bed_table/pillow.cgf",
				"Objects/props/residential_assets/baby_bed/babybed.cgf",
				"Objects/props/hospital/hospital_curtains/hospital_curtain_corner.cgf",
				"Objects/props/hospital/hospital_curtains/hospital_curtain_straight.cgf",
				"Objects/props/hospital/hospital_curtains/hospital_standingcurtain_01a.cgf",
				"Objects/props/hospital/hospital_curtains/hospital_standingcurtain_01b.cgf",
				"Objects/props/hospital/hospital_curtains/hospital_standingcurtain_01c.cgf",
				"Objects/props/hospital/hospital_curtains/hospital_standingcurtain_01d.cgf",
				"Objects/props/hospital/hospital_curtains/hospital_standingcurtain_01e.cgf",
			},
			material = {
				"objects/props/simpletable/tablecloth",
				"objects/props/furniture/standardbed/cloth",
				"objects/props/furniture/standardbed/cloth2",
				"objects/props/furniture/standardbed/cloth3",
				"objects/props/furniture/standardbed/cloth4",
			},
			sound = "Play_fabric_tear",
			uses = 1,
			regenerate = 240,
			percentage = 70,
			spawn = "Rags",
			AIResponseChance = 4,
			AIResponseStrCategory = "ai_actionable_critter",
		},

		--------------------------------------------------
		-- Barbed wire
		--------------------------------------------------
		{
			text = "@tear_off_barbed_wire",
			fail = "@nothing_usable_was_found",
			model = {
				"objects/architecture/fences/barbwire_fence/barbwire_fence_16m.cgf",
				"objects/architecture/fences/barbwire_fence/barbwire_fence_2m.cgf",
				"objects/architecture/fences/barbwire_fence/barbwire_fence_2m_door.cgf",
				"objects/architecture/fences/barbwire_fence/barbwire_fence_4m.cgf",
				"objects/architecture/fences/barbwire_fence/barbwire_fence_8m.cgf",
				"objects/architecture/fences/barbwire_fence/barbwire_fence_corner_a.cgf",
				"objects/architecture/fences/barbwire_fence/barbwire_fence_corner_b.cgf",
				"objects/architecture/fences/barbwire_fence/barbwire_fence_gate_a.cgf",
				"objects/architecture/fences/barbwire_fence/barbwire_fence_gate_b.cgf",
				"objects/architecture/fences/barbwire_fence/barbwire_fence_gate_d_door_a.cgf",
				"objects/architecture/fences/barbwire_fence/barbwire_fence_gate_d_door_b.cgf",
				"objects/barriers/barbed_wired/barbed_wire_3m.cgf",
				"objects/props/fences/rusty_chainlink/chainlink_3m_bw.cgf",
				"objects/props/fences/rusty_chainlink/fence_4m_chainlink_1.cgf",
				"objects/props/fences/rusty_chainlink/fence_chainlink_4m_1.cgf",
				"objects/props/fences/rusty_chainlink/fence_chainlink_4m_2.cgf",
				"objects/props/fences/rusty_chainlink/fence_chainlink_4m_3.cgf",
				"objects/props/fences/rusty_chainlink/fence_chainlink_8m_1.cgf",
				"objects/props/fences/rusty_chainlink/gate_chainlink_1.cgf",
			},
			sound = "Play_pickup_metal",
			uses = 1,
			regenerate = 300,
			percentage = 33,
			spawn = "BarbedWireCoil",
			gridsize = 5, -- so there isnt too much searchables in one place
			tactical = false,
		},

		--------------------------------------------------
		-- Tarp
		--------------------------------------------------
		{
			text = "@tear_off_tarp",
			fail = "@nothing_usable_was_found",
			material = {
				"Objects/props/Tarp/hb_tarp/tarp_plastic_single_blue_01.cgf",
				"Objects/props/Tarp/hb_tarp/tarp_plastic_single_blue_ground_002.cgf",
				"Objects/props/Tarp/hb_tarp/tarp_plastic_single_blue_ground_01.cgf",
				"Objects/props/Tarp/hb_tarp/tarp_plastic_single_blue_roof_01.cgf",
				"Objects/props/Tarp/hb_tarp/tarp_plastic_single_green_01.cgf",
				"Objects/props/Tarp/hb_tarp/tarp_plastic_single_yellow_01.cgf",
				"Objects/props/Tarp/hb_tarp/tarp_plastic_single_green_ground_01.cgf",
				"Objects/props/Tarp/hb_tarp/tarp_plastic_single_yellow_ground_01.cgf",
				"Objects/props/Tarp/hb_tarp/tarp_plastic_double_yellow_001.cgf",
				"Objects/props/Tarp/hb_tarp/tarp_plastic_double_blue_001.cgf",
				"objects/props/tarp/hb_tarp/tarp_plastic_triple_blue_001.cgf",
				"Objects/props/Tarp/hb_tarp/tarp_plastic_triple_yellow_001.cgf",
				"Objects/props/Tarp/hb_tarp/tarps_plastic_4_set_01.cgf",
				"Objects/props/hospital/hospital_SupplyCart_bag_only.cgf",
				"Objects/props/hospital/hospital_SupplyCart_complete.cgf",
				"Objects/props/hospital/hospital_disposal_stand_ripped1.cgf",
				"Objects/props/hospital/hospital_disposal_stand_ripped3.cgf",
			},
			sound = "Play_fabric_tear",
			uses = 1,
			regenerate = 300,
			percentage = 33,
			spawn = "Tarp",
			gridsize = 2, -- so there isnt too much searchables in one place
			tactical = false,
		},

		--------------------------------------------------
		-- Solar
		--------------------------------------------------
--[[
		{
			text = "Tear off solar panel",
			fail = "No usable solar panel left",
			material = {
				"Objects/props/solar_panel/solar_panel_angled_clean.cgf",
				"Objects/props/solar_panel/solar_panel_angled_cracked.cgf",
				"Objects/props/solar_panel/solar_panel_angled_dirty.cgf",
				"Objects/props/solar_panel/solar_panel_attachment.cgf",
				"Objects/props/solar_panel/solar_panel_flat_clean.cgf",
				"Objects/props/solar_panel/solar_panel_flat_clean_single.cgf",
				"Objects/props/solar_panel/solar_panel_flat_cracked.cgf",
				"Objects/props/solar_panel/solar_panel_flat_cracked_single.cgf",
				"Objects/props/solar_panel/solar_panel_flat_dirty.cgf",
				"Objects/props/solar_panel/solar_panel_flat_dirty_single.cgf",
			},
			sound = "Play_pickup_plastic",
			uses = 1,
			regenerate = 300,
			percentage = 33,
			spawn = "SolarPanelPiece",
			gridsize = 5, -- so there isnt too much searchables in one place
			tactical = false,
		},
--]]
		--------------------------------------------------
		-- Sandbags
		--------------------------------------------------
		{
			text = "@search_sandbags",
			fail = "@nothing_usable_was_found",
			model = {
				"objects/props/sandbags/sandbag_10.cgf",
				"objects/props/sandbags/sandbag_5.cgf",
				"objects/props/sandbags/sandbag_7.cgf",
				"objects/props/sandbags/sandbag_6.cgf",
				"objects/props/sandbags/sandbag_9.cgf",
				"objects/props/sandbags/sandbag_8.cgf",
			},
			sound = "Play_pickup_plastic",
			uses = 1,
			regenerate = 300,
			percentage = 45,
			spawn = "sandbag_crafted_single",
			gridsize = 4, -- so there isnt too much searchables in one place
			tactical = false,
		},

		--------------------------------------------------
		-- Trash / Mailbox
		--------------------------------------------------
		{
			text = "@search_trash",
			fail = "@nothing_usable_was_found",
			model = {
				-- mail
				"objects/props/usmailbox/usmailbox.cgf",
				"objects/props/mailbox/mailbox.cgf",

				-- bins
				"objects/props/recycle_bin/recycle_bin.cgf",
				"Objects/props/Trashcan/trashcan_openfull.cgf",
				"Objects/props/Trashcan/trashcan_openhalf.cgf",
				"objects/props/Trashcan/trashcan.cgf",
				"Objects/props/metalcan/metalcan.cgf",
				"Objects/props/metalcan/metalcan_damaged.cgf",
				"objects/props/gasStationAssets/gasTrashCan.cgf",
				"objects/props/industrial/junk/trashbin/trashbin_a.cgf",
				"objects/props/industrial/junk/trashbin/trashbin_b.cgf",

				-- cardboards
				"Objects/props/cardboard/cardboard_closed.cgf",
				"Objects/props/cardboard/cardboard_half.cgf",

				"Objects/props/Trash/city_trash/trash_box4.cgf",
				"Objects/props/Trash/city_trash/trash_box6.cgf",
				"Objects/props/Trash/city_trash/trash_box8.cgf",
				"Objects/props/Trash/city_trash/trash_box9.cgf",
				"Objects/props/Trash/city_trash/trash_box11.cgf",

				"Objects/props/industrial/boxes/cardboard_box/cardboard_box100x60cm.cgf",
				"Objects/props/industrial/boxes/cardboard_box/cardboard_box60cm.cgf",
				"Objects/props/industrial/boxes/cardboard_box/cardboard_box60cm_b.cgf",
				"Objects/props/industrial/boxes/cardboard_box/cardboard_box60cm_c.cgf",
				"Objects/props/industrial/boxes/cardboard_box/cardboard_box60x30cm.cgf",
				"Objects/props/industrial/boxes/cardboard_box/cardboard_box80cm.cgf",
				"Objects/props/industrial/boxes/cardboard_box/cardboard_box80cm_c.cgf",
				"Objects/props/industrial/boxes/cardboard_box/cardboard_box80cm_b.cgf",

				-- bags
				"Objects/props/Trash/city_trash/black_trashbag_split_01.cgf",
				"Objects/props/Trash/city_trash/trash_bag_black1.cgf",
				"Objects/props/Trash/city_trash/trash_bag_black2.cgf",
				"Objects/props/Trash/city_trash/trash_bag_black3.cgf",
				"Objects/props/Trash/city_trash/trash_bag_black4.cgf",
				"Objects/props/Trash/city_trash/trash_bag_blue1.cgf",
				"Objects/props/Trash/city_trash/trash_bag_blue2.cgf",
				"Objects/props/Trash/city_trash/trash_bag_blue3.cgf",
				"Objects/props/Trash/city_trash/trash_bag_blue4.cgf",

				"Objects/props/Trash/BinBags/BinBags.cgf",
				"Objects/props/industrial/junk/garbage/garbage_bag_a.cgf",
				"Objects/props/industrial/junk/garbage/garbage_bag_b.cgf",
				"Objects/props/industrial/junk/garbage/garbage_bag_c.cgf",
				"Objects/props/industrial/junk/garbage/garbage_bag_d.cgf",
				"Objects/props/industrial/junk/garbage/garbage_bag_e.cgf",

				-- garbage combines
				"Objects/props/industrial/junk/garbage/garbage_a.cgf",
				"Objects/props/industrial/junk/garbage/garbage_b.cgf",
				"Objects/props/industrial/junk/garbage/garbage_c.cgf",
				"Objects/props/industrial/junk/garbage/garbage_d.cgf",

				"Objects/props/industrial/junk/trash_combine/trash_combine_a.cgf",
				"Objects/props/industrial/junk/trash_combine/trash_combine_b.cgf",
				"Objects/props/industrial/junk/trash_combine/trash_combine_c.cgf",
				"Objects/props/industrial/junk/trash_combine/trash_combine_d.cgf",

				"Objects/props/Trash/TrashPile/prefab_trashpile_large.cgf",
				"Objects/props/Trash/TrashPile/prefab_trashpile_medium01.cgf",
				"Objects/props/Trash/TrashPile/Trash_GarbagePile1.cgf",
				"Objects/props/Trash/TrashPile/Trash_PileLarge01.cgf",
				"Objects/props/Trash/TrashPile/Trashe_GarbagePile2.cgf",

				-- boxes
				"Objects/props/office_small_props/office_box01.cgf",
				"Objects/props/office_small_props/paperbox_01.cgf",

				-- biohazard garbage
				"Objects/props/biohazard_assets/cylinder_container.cgf",
				"Objects/props/biohazard_assets/garbage_bag_yellow_a.cgf",
				"Objects/props/biohazard_assets/garbage_bag_yellow_b.cgf",
				"Objects/props/biohazard_assets/garbage_bag_yellow_c.cgf",
				"Objects/props/biohazard_assets/garbage_bag_yellow_d.cgf",

				-- hospital trash
				"Objects/props/hospital/hospital_disposal_stand_01.cgf",
				"Objects/props/hospital/hospital_disposal_stand_02.cgf",
				"Objects/props/hospital/hospital_disposal_stand_03.cgf",
				"Objects/props/hospital/hospital_dripstand_01e.cgf",
				"Objects/props/hospital/hospital_dripstand_01f.cgf",

			},
			sound = "Play_backpack_move_item",
			uses = 1,
			regenerate = 150,
			percentage = 12,
			spawn = "RandomTrashContent",
			tactical = false,
			AIResponseChance = 2,
			AIResponseStrCategory = "ai_actionable_critter",
			forceinteraction = true,
		},

		--------------------------------------------------
		-- Commercial crate
		--------------------------------------------------
		{
			text = "@search_box",
			fail = "@nothing_was_found",
			model = {
				"objects/props/storage/crates/wood_crate_medium.cgf",
				"objects/props/storage/crates/wood_crate_long.cgf",
				"Objects/props/industrial/boxes/civil_box/civil_box_a.cgf",
				"Objects/props/industrial/boxes/civil_box/civil_box_b.cgf",
			},
			sound = "Play_door_wood_closed",
			uses = 1,
			regenerate = 150,
			percentage = 35,
			spawn = "RandomCommercialCrateContent",
			forceinteraction = true,
			AIResponseChance = 1,
			AIResponseStrCategory = "ai_actionable_critter",
		},

		--------------------------------------------------
		-- Normal locker
		--------------------------------------------------
		{
			text = "@search_locker",
			fail = "@nothing_was_found",
			model = {
				"objects/props/locker/lockerwhole.cgf",
			},
			sound = "Play_door_actionable_close",
			uses = 1,
			regenerate = 150,
			percentage = 38,
			spawn = "RandomLockerContent",
			forceinteraction = true,
			AIResponseChance = 1,
			AIResponseStrCategory = "ai_actionable_critter",
		},

		--------------------------------------------------
		-- Switchbox/Computer (Industrial)
		--------------------------------------------------
		{
			text = "@search",
			fail = "@nothing_was_found",
			model = {
				"Objects/props/industrial/switchboard/switchboard_01.cgf",
				"Objects/props/industrial/switchboard/switchboard_02.cgf",
				"Objects/props/industrial/switchboard/switchboard_03.cgf",
				"Objects/props/industrial/switchboard/switchboard_04.cgf",
			},
			sound = "Play_door_actionable_close",
			uses = 1,
			regenerate = 150,
			percentage = 38,
			spawn = "RandomSwitchboardContent",
			forceinteraction = true,
			AIResponseChance = 1,
			AIResponseStrCategory = "ai_actionable_critter",
		},

		--------------------------------------------------
		-- Sink stuff
		--------------------------------------------------
		{
			text = "@search",
			fail = "@nothing_was_found",
			model = {
				"Objects/props/Restaurant_equipment/sink_dishwasher/under_bar_sink.cgf",
				"Objects/props/cabinets/46_lowersink_a.cgf",
				"Objects/props/Restaurant_equipment/sink_dishwasher/dishwasher.cgf",
				"Objects/props/cabinets/with_countertops/46_lowersink_a.cgf",
				"Objects/props/kitchen_cabinets/kitchen_cabinet_sink.cgf",
			},
			sound = "Play_door_actionable_open",
			uses = 1,
			regenerate = 150,
			percentage = 38,
			spawn = "RandomSinkContent",
			forceinteraction = true,
			AIResponseChance = 1,
			AIResponseStrCategory = "ai_actionable_critter",
		},

		--------------------------------------------------
		-- Desk stuff
		--------------------------------------------------
		{
			text = "@search_desk",
			fail = "@nothing_was_found",
			model = {
				"Objects/props/CoffeeTable_v2/coffeetable_v2.cgf",
				"Objects/props/CoffeeTable_v2/coffeetable_nobase_v2.cgf",
				"Objects/props/homeOffficeDesk/homeOffficeDesk.cgf",
				"Objects/props/office_desk/office_desk.cgf",
				"Objects/props/Office_Furniture/cabinet_3draws.cgf",
			},
			sound = "Play_door_actionable_open",
			uses = 1,
			regenerate = 150,
			percentage = 38,
			spawn = "RandomDeskContent",
			forceinteraction = true,
			AIResponseChance = 1,
			AIResponseStrCategory = "ai_actionable_critter",
		},

		--------------------------------------------------
		-- Kitchen stuff
		--------------------------------------------------
		{
			text = "@search",
			fail = "@nothing_was_found",
			model = {
				"Objects/props/diner_assets/diner_furniture/diner_metaldesk.cgf",
				"Objects/props/kitchen_cabinets/kitchen_cabinet_3.cgf",
				"Objects/props/kitchen_cabinets/kitchen_cabinet_4.cgf",
				"Objects/props/kitchen_cabinets/kitchen_cabinet_5.cgf",
				"Objects/props/cabinets/36_lower_a.cgf",
				"Objects/props/cabinets/36_lower_b.cgf",
				"Objects/props/cabinets/36_upper_a.cgf",
				"Objects/props/cabinets/46_lower_a.cgf",
				"Objects/props/cabinets/46_lower_b.cgf",
				"Objects/props/cabinets/30_lower_b.cgf",
				"Objects/props/cabinets/30_upper_a.cgf",
				"Objects/props/cabinets/30_lower_a.cgf",
				"Objects/props/cabinets/22_upper_a.cgf",
				"Objects/props/cabinets/18_upper_a.cgf",
				"Objects/props/cabinets/18_lower_b.cgf",
				"Objects/props/cabinets/18_lower_a.cgf",
				"Objects/props/cabinets/12_upper_a.cgf",
				"Objects/props/cabinets/with_countertops/36_lower_a.cgf",
				"Objects/props/cabinets/with_countertops/36_lower_b.cgf",
				"Objects/props/cabinets/with_countertops/36_upper_a.cgf",
				"Objects/props/cabinets/with_countertops/46_lower_a.cgf",
				"Objects/props/cabinets/with_countertops/46_lower_b.cgf",
				"Objects/props/cabinets/with_countertops/30_lower_b.cgf",
				"Objects/props/cabinets/with_countertops/30_upper_a.cgf",
				"Objects/props/cabinets/with_countertops/30_lower_a.cgf",
				"Objects/props/cabinets/with_countertops/22_upper_a.cgf",
				"Objects/props/cabinets/with_countertops/18_upper_a.cgf",
				"Objects/props/cabinets/with_countertops/18_lower_b.cgf",
				"Objects/props/cabinets/with_countertops/18_lower_a.cgf",
				"Objects/props/cabinets/with_countertops/12_upper_a.cgf",
				"Objects/props/hospital/hospital_furniture/hospital_sinkunit_1.cgf",
				"Objects/props/hospital/hospital_furniture/hospital_sinkunit.cgf",
			},
			sound = "Play_door_actionable_open",
			uses = 1,
			regenerate = 150,
			percentage = 38,
			spawn = "RandomKitchenContent",
			forceinteraction = true,
			AIResponseChance = 1,
			AIResponseStrCategory = "ai_actionable_critter",
		},

		--------------------------------------------------
		-- Office stuff
		--------------------------------------------------
		{
			text = "@search",
			fail = "@nothing_was_found",
			model = {
				"Objects/props/Cabinet/cabinet_Opening3_4.cgf",
				"Objects/props/Cabinet/cabinet_Cloed.cgf",
				"Objects/props/office_metal_props/filecab_004.cgf",
				"Objects/props/office_metal_props/filecab_005.cgf",
				"Objects/props/office_metal_props/filecab_006.cgf",
				"Objects/props/office_metal_props/filecab_01.cgf",
				"Objects/props/office_metal_props/filecab_02.cgf",
				"Objects/props/office_metal_props/filecab_03.cgf",
			},
			sound = "Play_door_actionable_open",
			uses = 1,
			regenerate = 150,
			percentage = 38,
			spawn = "RandomOfficeContent",
			forceinteraction = true,
			AIResponseChance = 1,
			AIResponseStrCategory = "ai_actionable_critter",
		},

		--------------------------------------------------
		-- Office stuff (merged stuff shelfs)
		--------------------------------------------------
		{
			text = "@search",
			fail = "@nothing_was_found",
			model = {
				"Objects/props/office_shelfs/metal_shelf_stuff01.cgf",
				"Objects/props/office_shelfs/metal_shelf_stuff02.cgf",
				"Objects/props/office_shelfs/metal_shelf_stuff03.cgf",
				"Objects/props/office_shelfs/metal_shelf_stuff04.cgf",
				"Objects/props/office_shelfs/wood_shelf_stuff01.cgf",
				"Objects/props/office_shelfs/wood_shelf_stuff02.cgf",
				"Objects/props/office_shelfs/wood_shelf_stuff03.cgf",
				"Objects/props/office_shelfs/wood_shelf_stuff04.cgf",
				"Objects/props/office_shelfs/wood_shelf_stuff05.cgf",
				"Objects/props/office_shelfs/wood_shelf_stuff06.cgf",
				"Objects/props/office_shelfs/wood_shelf_stuff07.cgf",
				"Objects/props/office_shelfs/wood_shelf_stuff08.cgf",
				"Objects/props/office_shelfs/wood_shelf_stuff09.cgf",
			},
			sound = "Play_pickup_plastic",
			uses = 1,
			regenerate = 150,
			percentage = 38,
			spawn = "RandomOfficeContent",
			forceinteraction = true,
			AIResponseChance = 1,
			AIResponseStrCategory = "ai_actionable_critter",
		},

		--------------------------------------------------
		-- Living area stuff
		--------------------------------------------------
		{
			text = "@search",
			fail = "@nothing_was_found",
			model = {
				"Objects/props/lakewood/lakewood_dresser_a.cgf",
				"Objects/props/lakewood/lakewood_hutch_a.cgf",
				"Objects/props/lakewood/lakewood_hutch_b.cgf",
				"Objects/props/lakewood/lakewood_talldresser_a.cgf",
				"Objects/props/lakewood/lakewood_curio_cabinet_a.cgf",
				"Objects/props/lakewood/lakewood_curio_cabinet_d.cgf",
				"Objects/props/furniture/wooden/wood_shelf_b.cgf",
				"Objects/props/furniture/modern/chest_of_drawers_old.cgf",
				"Objects/props/furniture/bedroom_set/set1/wardrobe.cgf",
				"Objects/props/furniture/bedroom_set/set1/commode2.cgf",
				"Objects/props/furniture/bedroom_set/set1/commode1.cgf",
				"Objects/props/furniture/bedroom_set/set1/bed_stand.cgf",
				"Objects/props/furniture/bedroom_set/set1/cabinnet.cgf",
				"Objects/props/Nightstand/nightstand.cgf",
			},
			sound = "Play_door_actionable_open",
			uses = 1,
			regenerate = 150,
			percentage = 38,
			spawn = "RandomLivingAreaContent",
			forceinteraction = true,
			AIResponseChance = 1,
			AIResponseStrCategory = "ai_actionable_critter",
		},

		--------------------------------------------------
		-- Hospital stuff big
		--------------------------------------------------
		{
			text = "@search",
			fail = "@nothing_was_found",
			model = {
				"Objects/props/hospital/hospital_reception/hospital_supplycabinet_closed.cgf",
			},
			sound = "Play_door_fridge_open",
			uses = 1,
			regenerate = 150,
			percentage = 34,
			spawn = "RandomHospitalContentBig",
			forceinteraction = true,
			AIResponseChance = 2,
			AIResponseStrCategory = "ai_actionable_critter",
		},

		--------------------------------------------------
		-- Hospital stuff medium
		--------------------------------------------------
		{
			text = "@search",
			fail = "@nothing_was_found",
			model = {
				"Objects/props/hospital/hospital_furniture/hospital_medicalcabinet_open.cgf",
				"Objects/props/hospital/hospital_furniture/hospital_medicalcabinet_01.cgf",
				"Objects/props/hospital/hospital_furniture/hospital_medicalcabinet.cgf",
				"Objects/props/hospital/hospital_furniture/hospital_bedsidetable_01b.cgf",
				"Objects/props/hospital/hospital_furniture/hospital_Drawer_unit_closed.cgf",
				"Objects/props/hospital/hospital_reception/hospital_supplycabinet_full.cgf",
			},
			sound = "Play_door_fridge_open",
			uses = 1,
			regenerate = 150,
			percentage = 34,
			spawn = "RandomHospitalContentMedium",
			forceinteraction = true,
			AIResponseChance = 1,
			AIResponseStrCategory = "ai_actionable_critter",
		},

		--------------------------------------------------
		-- Hospital stuff small
		--------------------------------------------------
		{
			text = "@search",
			fail = "@nothing_was_found",
			model = {
				"Objects/props/hospital/hospital_electrical/hospital_incubator_01a.cgf",
				"Objects/props/hospital/hospital_furniture/hospital_drugcart_full.cgf",
				"Objects/props/hospital/hospital_furniture/hospital_SupplyCart_full.cgf",
			},
			sound = "Play_door_fridge_open",
			uses = 1,
			regenerate = 150,
			percentage = 34,
			spawn = "RandomHospitalContentSmall",
			forceinteraction = true,
		},

		--------------------------------------------------
		-- Hospital stuff medical
		--------------------------------------------------
		{
			text = "@search_medical_supplies",
			fail = "@nothing_usable_was_found",
			model = {
				"Objects/props/hospital/hospital_reception/hospital_tub_double_shelf_full.cgf",
				"Objects/props/hospital/hospital_reception/hospital_tub_shelf_full.cgf",
				"Objects/props/hospital/hospital_accessories/hospital_utilities_01b.cgf",
				"Objects/props/hospital/hospital_accessories/hospital_utilities_01d.cgf",
				"Objects/props/hospital/hospital_accessories/hospital_utilities_01e.cgf",
				"Objects/props/hospital/hospital_accessories/hospital_supply_02d.cgf",
				"Objects/props/hospital/hospital_accessories/hospital_supply_02c.cgf",
				"Objects/props/hospital/hospital_accessories/hospital_supply_02b.cgf",
				"Objects/props/hospital/hospital_furniture/hospital_ShelfSet_accessories_2.cgf",
				"Objects/props/hospital/hospital_accessories/hospital_floor_trash_group1.cgf",

			},
			sound = "Play_backpack_move_item",
			uses = 1,
			regenerate = 150,
			percentage = 34,
			spawn = "RandomHospitalMedical",
			forceinteraction = true,
		},

		--------------------------------------------------
		-- Hospital stuff bandage
		--------------------------------------------------
		{
			text = "@search_medical_supplies",
			fail = "@nothing_usable_was_found",
			model = {
				"Objects/props/hospital/hospital_accessories/hospital_utilities_01r.cgf",
				"Objects/props/hospital/hospital_accessories/hospital_utilities_01s.cgf",
				"Objects/props/hospital/hospital_accessories/hospital_utilities_01c.cgf",
				"Objects/props/hospital/hospital_accessories/hospital_utilities_01a.cgf",

			},
			sound = "Play_bandage_use",
			uses = 1,
			regenerate = 150,
			percentage = 34,
			spawn = "RandomHospitalBandage",
			forceinteraction = true,
		},

		--------------------------------------------------
		-- Hospital stuff syringes
		--------------------------------------------------
		{
			text = "@search_medical_supplies",
			fail = "Nothing usable left",
			model = {
				"Objects/props/hospital/hospital_accessories/hospital_needledeposit_01a.cgf",
				"Objects/props/hospital/hospital_accessories/hospital_needledeposit_01e.cgf",
				"Objects/props/hospital/hospital_accessories/hospital_needledeposit_01b.cgf",
				"Objects/props/hospital/hospital_accessories/hospital_needledeposit_01c.cgf",
				"Objects/props/hospital/hospital_accessories/needle.cgf",
			},
			sound = "Play_pickup_plastic",
			uses = 1,
			regenerate = 150,
			percentage = 16,
			spawn = "AdrenalineSyringe",
			forceinteraction = true,
		},

		--------------------------------------------------
		-- Stoves
		--------------------------------------------------
		{
			text = "@search_food",
			fail = "@nothing_was_found",
			model = {
				"Objects/props/elecStove/elecStove.cgf",
				"Objects/props/furniture/appliances/gas_stove/gas_stove.cgf",
				-- "Objects/props/cabinAssets/cabinStove.cgf", now dws
				-- "objects/props/microwave/microwave.cgf", - now dws
				"Objects/props/residential_assets/kitchen_devices/microwave.cgf",
				"Objects/props/residential_assets/kitchen_devices/cooker_stove.cgf",
			},
			sound = "Play_door_fridge_open",
			uses = 1,
			regenerate = 240,
			percentage = 25,
			spawn = "RandomStoveContent",
			forceinteraction = true,
			AIResponseChance = 1,
			AIResponseStrCategory = "ai_actionable_critter",
		},

		--------------------------------------------------
		-- Fridge
		--------------------------------------------------
		{
			text = "@search_food",
			fail = "@nothing_was_found",
			model = {
				"Objects/props/furniture/appliances/fridge/fridge_a.cgf",
				"Objects/props/furniture/appliances/fridge/fridge_b.cgf",
				"Objects/props/fridge/Fridge_old_Doors.cgf",
				"Objects/props/fridge_modern/fridgemodern_closed.cgf",
				"Objects/props/fridge_modern_2/modern_fridge_closed.cgf",
				"Objects/props/icemachine/icemachine.cgf",
				"Objects/props/hospital/hospital_OrganCooler_1.cgf",
				"Objects/props/hospital/hospital_OrganCooler_2.cgf",
				"Objects/props/hospital/hospital_OrganCooler_3.cgf",
				"Objects/props/hospital/hospital_electrical/hospital_sterilizer_closed.cgf",
			},
			sound = "Play_door_fridge_open",
			uses = 1,
			regenerate = 240,
			percentage = 38,
			spawn = "RandomFridgeContent",
			AIResponseChance = 4,
			AIResponseStrCategory = "ai_actionable_critter",
			forceinteraction = true,
		},

		--------------------------------------------------
		-- Washing Machine / Dryer
		--------------------------------------------------
		{
			text = "@search_clothes",
			fail = "@nothing_was_found",
			model = {
				"Objects/props/bathroom/Washing_Machine.cgf",
				"Objects/props/laundry_assets/topwasher_open.cgf",
				"Objects/props/laundry_assets/topwasher.cgf",
				"Objects/props/laundry_assets/dryer.cgf",
				"Objects/props/laundry_assets/double_dryer.cgf",
				"objects/props/residential_assets/laundry/dryer.cgf",
				"objects/props/residential_assets/laundry/washing.cgf",
				"Objects/props/residential_assets/clothes_basket/clothes_basket.cgf",
			},
			sound = "Play_door_actionable_open",
			uses = 1,
			regenerate = 240,
			percentage = 35,
			gridsize = 2, -- so there isnt too much searchables in one place
			spawn = "RandomWashingContent",
			AIResponseChance = 3,
			AIResponseStrCategory = "ai_actionable_critter",
			forceinteraction = true,
		},

		--------------------------------------------------
		-- Suitcase / Bodybag
		--------------------------------------------------
		{
			text = "@search_clothes",
			fail = "@nothing_was_found",
			model = {
				"Objects/props/suitcase/suitcase.cgf",
				"Objects/props/suitcase_colored/suitcase_black_open.cgf",
				"Objects/props/suitcase_colored/suitcase_black_closed.cgf",
				"Objects/props/suitcase_colored/suitcase_blue_open.cgf",
				"Objects/props/suitcase_colored/suitcase_blue_closed.cgf",
				"Objects/props/suitcase_colored/suitcase_grey_open.cgf",
				"Objects/props/suitcase_colored/suitcase_grey_closed.cgf",
				"Objects/props/suitcase_colored/suitcase_red_open.cgf",
				"Objects/props/suitcase_colored/suitcase_red_closed.cgf",
				"Objects/props/Trash/bodybag/bodybag.cgf",
				"Objects/props/hospital/hospital_BodyBag_1.cgf",
				"Objects/props/hospital/hospital_BodyBag_2.cgf",
			},
			sound = "Play_backpack_open",
			uses = 1,
			regenerate = 240,
			percentage = 45,
			gridsize = 3, -- so there isnt too much searchables in one place
			spawn = "RandomSuitcaseContent",
			forceinteraction = true,
		},

		--------------------------------------------------
		-- Map
		--------------------------------------------------
		{
			text = "@get_map",
			fail = "@nothing_usable_was_found",
			model = {
				"objects/props/mapsign/mapsign.cgf",
			},
			sound = "Play_map_open",
			uses = 2,
			regenerate = 10,
			percentage = 100,
			spawn = "Map",
		},

		--------------------------------------------------
		-- Military box
		--------------------------------------------------
		{
			text = "@search_foot_locker",
			fail = "@nothing_was_found",
			model = {
				"objects/storage/footlocker/footlocker.cgf",
				"objects/props/ammocrate/ammocrate.cgf",
			},
			sound = "Play_door_fridge_open",
			uses = 1,
			regenerate = 180,
			percentage = 45,
			spawn = "RandomMilitaryFootlockerContent",
			AIResponseChance = 2,
			AIResponseStrCategory = "ai_actionable_critter",
			forceinteraction = true,
		},

		--------------------------------------------------
		-- Military box iron sons
		--------------------------------------------------
		{
			text = "@search_iron_sons_cache",
			fail = "@nothing_was_found",
			model = {
				"objects/storage/footlocker/footlocker_iron_sons.cgf",
			},
			sound = "Play_door_fridge_open",
			uses = 2,
			regenerate = 50,
			percentage = 75,
			spawn = "RandomMilitaryFootlockerIronSonsContent",
			AIResponseChance = 3,
			AIResponseStrCategory = "ai_actionable_critter",
			forceinteraction = true,
		},

		--------------------------------------------------
		-- Military field desk
		--------------------------------------------------
		{
			text = "@search_desk",
			fail = "@nothing_was_found",
			model = {
				"objects/props/Military_desk/military_desk.cgf",
			},
			sound = "Play_door_actionable_open",
			uses = 1,
			regenerate = 300,
			percentage = 45,
			gridsize = 2, -- so there isnt too much searchables in one place
			spawn = "RandomMilitaryDeskContent",
			AIResponseChance = 2,
			AIResponseStrCategory = "ai_actionable_critter",
			forceinteraction = true,
		},

		--------------------------------------------------
		-- Food sources
		--------------------------------------------------
		{
			text = "@search_box",
			fail = "@nothing_was_found",
			model = {
				"objects/props/cabinassets/tackle.cgf",
				"objects/props/plastic_storage_containers/plastic_container_1.cgf",
				"objects/props/plastic_storage_containers/plastic_container_2.cgf",
				"objects/props/plastic_storage_containers/plastic_container_3.cgf",
			},
			sound = "Play_door_actionable_closed",
			uses = 1,
			regenerate = 240,
			percentage = 50,
			spawn = "RandomFoodBoxContent",
			forceinteraction = true,
		},

		--------------------------------------------------
		-- Beehives
		--------------------------------------------------
		{
			text = "@search_beehive",
			fail = "@nothing_usable_was_found",
			model = {
				"objects/props/bee_hive/manmade_beehive_4stack_large.cgf",
				"objects/props/bee_hive/manmade_beehive_4stack_small.cgf",
				"objects/props/bee_hive/natural_beehive_large_1.cgf",
				"objects/props/bee_hive/natural_beehive_large_2.cgf",
				"objects/props/bee_hive/natural_beehive_small_1.cgf",
				"objects/props/bee_hive/natural_beehive_small_2.cgf",
				"objects/props/bee_hive/manmade_beehive_3stack.cgf",
				"objects/props/bee_hive/manmade_beehive_3stack_large.cgf",
				"objects/props/bee_hive/manmade_beehive_3stack_small.cgf",
				"objects/props/bee_hive/manmade_beehive_4stack.cgf",
			},
			sound = "Play_map_close",
			uses = 1,
			regenerate = 240,
			percentage = 65,
			spawn = "RandomBeehiveContent",
			forceinteraction = true,
		},

		--------------------------------------------------
		-- Sheet metal source
		--------------------------------------------------
		{
			text = "@search_junk",
			fail = "@nothing_usable_was_found",
			model = {
				"objects/props/junkpile/junkpile.cgf",
			},
			sound = "Play_pickup_metal",
			uses = 1,
			regenerate = 240,
			percentage = 100,
			spawn = "SheetMetal",
			AIResponseChance = 5,
			AIResponseStrCategory = "ai_actionable_critter",
		},

		--------------------------------------------------
		-- Scrap metal source
		--------------------------------------------------
		{
			text = "@search_junk",
			fail = "@nothing_usable_was_found",
			model = {
				"objects/props/industrial/junk/junk_pile/junk_a.cgf", -- those also have some lumber in them so maybe ism category with lumber
				"objects/props/industrial/junk/junk_pile/junk_b.cgf", -- those also have some lumber in them so maybe ism category with lumber
				"objects/props/industrial/junk/junk_pile/junk_c.cgf", -- those also have some lumber in them so maybe ism category with lumber
				"objects/vehicles/extreme_model_pack/motorcycle_a.cgf",
				"objects/props/antenna/roofant8.cgf",
				"objects/props/antenna/roofant7.cgf",
				"objects/props/antenna/roofant6.cgf",
				"objects/props/antenna/roofant5.cgf",
				"objects/props/antenna/roofant4.cgf",
				"objects/props/antenna/roofant3.cgf",
				"objects/props/antenna/roofant2.cgf",
				"objects/props/antenna/roofant1.cgf",
				"objects/props/antenna/satellite_a.cgf",
				"objects/props/antenna/satellite_b.cgf",
				"objects/props/antenna/satellite_c.cgf",
				"objects/props/antenna/satellite_d.cgf",
				"objects/props/antenna/satellite_e.cgf",
				"objects/props/antenna/satellite_f.cgf",
				"objects/props/antenna/satellite_g.cgf",
				"objects/props/antenna/satellite_h.cgf",
				"objects/props/house_aerial/house_aerial.cgf",
				"Objects/props/hospital/hospital_Walker.cgf",
			},
			sound = "Play_pickup_metal",
			uses = 1,
			regenerate = 240,
			percentage = 100,
			spawn = "ScrapMetal",
		},

		--------------------------------------------------
		-- Ammo or small items
		--------------------------------------------------
		{
			text = "@search_cranny",
			fail = "@nothing_was_found",
			model = {
				"objects/props/furniture/smallcouch/smallcouch.cgf",
				"objects/props/furniture/couch/couch.cgf",
				"objects/props/furniture/living_room/sofa.cgf",
				"objects/props/furniture/living_room/sofa_armchair.cgf",
				"objects/props/office_furniture_modern/modern_sofa_corner.cgf",
				"objects/props/office_furniture_modern/modern_sofa_straight.cgf",
				"objects/props/boothchair/boothchair.cgf",
				"objects/props/diner_assets/bayseat/bayseat_straight.cgf",
				"objects/props/couch_bunker/couch_bunker.cgf",
				"Objects/props/residential_assets/bean_bag/bean_bag.cgf",
				"Objects/props/residential_assets/sofa_big/sofa_big.cgf",
				"Objects/props/residential_assets/sofa_small/sofa_small.cgf",
				"Objects/props/furniture/modern/elegant_chair_2_old.cgf",
				"Objects/props/furniture/modern/elegant_chair_old.cgf",
				"Objects/props/furniture/modern/modern_sofa_old.cgf",
				"Objects/props/furniture/modern/modern_armchair_old.cgf",
				"Objects/props/furniture/modern/leather_armchair_old.cgf",
				"Objects/props/furniture/modern/leather_sofa_2_old.cgf",
				"Objects/props/furniture/modern/leather_sofa_old.cgf",
				"Objects/props/furniture/modern/leather_chair_old.cgf",
				"Objects/props/furniture/modern/office_leather_chair_old.cgf",
				"Objects/props/residential_assets/armchair/armchair.cgf",
				"Objects/props/hospital/hospital_furniture/hospital_waitingroom_chairs.cgf",
				"Objects/props/hospital/hospital_furniture/hospital_waitingroom_chair.cgf",
				"Objects/props/hospital/hospital_beds/hospitalbed_01a.cgf",
				"Objects/props/hospital/hospital_beds/hospitalbed_01b.cgf",
				"Objects/props/hospital/hospital_beds/hospitalbed_01c.cgf",
				"Objects/props/hospital/hospital_wheelchair.cgf",
			},
			sound = "Play_backpack_move_item",
			uses = 1,
			regenerate = 240,
			percentage = 15,
			spawn = "RandomCouchContent", -- have ItemSpawnerManager spawn something from the RandomAmmo category
			forceinteraction = true,
		},

		--------------------------------------------------
		-- Berries
		--------------------------------------------------
		{
			text = "@pick_berries",
			fail = "@nothing_usable_was_found",
			material = { "objects/props/berry_bush/berry_bush", },
			model = { "Objects/props/berry_bush/berry_bush.cgf", "Objects/props/berry_bush/berry_bush_tall.cgf", },
			sound = "Play_bush_movement_dry_large",
			uses = 6,
			regenerate = 120,
			percentage = 95,
			spawn = "Berries",
			gridsize = 4,
			tactical = false,
			check = false,
			forceinteraction = true,
		},

		--------------------------------------------------
		-- Apples
		--------------------------------------------------
		{
			text = "@pick_apples",
			fail = "@nothing_usable_was_found",
			material = { "objects/props/apple_tree/apple_tree", },
			model = { 
				"objects/props/apple_tree/apple_tree_1.cgf",
				"objects/props/apple_tree/apple_tree_2.cgf",
				"objects/props/apple_tree/apple_tree_3.cgf",
			},
			sound = "Play_bush_movement_dry_large",
			uses = 4,
			regenerate = 120,
			percentage = 95,
			spawn = "RandomAppleTreeContent",
			gridsize = 4,
			tactical = false,
			check = false,
		},

		-- seaweed
		{
			text = "@harvest_seaweed",
			fail = "@nothing_usable_was_found",
			model = { 
				"objects/props/seaweed/seaweed_1.cgf",
				"objects/props/seaweed/seaweed_2.cgf",
				"objects/props/seaweed/seaweed_3.cgf",
				"objects/props/seaweed/seaweed_underwater.cgf",
				"objects/natural/water/aquatic_plants/seaweed.cgf",
			},
			material = { 
				"objects/props/seaweed/seaweed_water",
				"objects/props/seaweed/seaweed",
			 },
			sound = "Play_bush_movement_dry_large",
			uses = 2,
			regenerate = 250,
			percentage = 90,
			spawn = "Seaweed",
			gridsize = 4,
			tactical = false,
			forceinteraction = true,
		},
		
		-- clams (on beaches)
		{
			text = "@harvest_clams",
			fail = "@nothing_usable_was_found",
			model = { 
				"objects/consumables/clams/clam_bunch.cgf",
			},
			material = { "objects/consumables/clams/clam", },
			sound = "Play_pickup_fabric",
			uses = 2,
			regenerate = 360,
			percentage = 90,
			spawn = "ClamSingle",
			gridsize = 4,
			tactical = false,
		},

		-- cacti
		{
			text = "Harvest Cactus",
			fail = "@nothing_usable_was_found",
			model = { 
				"objects/natural/vegetation/desert_plants/opuntia/OpuntiaFl02.cgf",
				"objects/natural/vegetation/desert_plants/opuntia/OpuntiaFl03.cgf",
				"objects/natural/vegetation/desert_plants/opuntia/OpuntiaFl04.cgf",
				"objects/natural/vegetation/desert_plants/opuntia/OpuntiaFl01.cgf",
			},
			material = { "objects/natural/vegetation/desert_plants/opuntia/opuntia", },
			sound = "Play_bush_movement_dry_large",
			uses = 1,
			regenerate = 360,
			percentage = 40,
			spawn = "RandomCactiContent", -- or whatever the item is named
			gridsize = 4,
			tactical = false,
		},

		-- more ideas: nothing atm
	}
}

--------------------------------------------------------------------------
-- Functions called from C++
--------------------------------------------------------------------------
function ActionableWorldManager:OnInit()
	--Log("ActionableWorldManager:OnInit");
	self:OnReset();
end

------------------------------------------------------------------------------------------------------
-- OnPropertyChange called only by the editor.
------------------------------------------------------------------------------------------------------
function ActionableWorldManager:OnPropertyChange()
	self:Reset();
end

------------------------------------------------------------------------------------------------------
-- OnReset called only by the editor.
------------------------------------------------------------------------------------------------------
function ActionableWorldManager:OnReset()
	--Log("ActionableWorldManager:OnReset");
	self:Reset();
end

------------------------------------------------------------------------------------------------------
-- OnSpawn called Editor/Game.
------------------------------------------------------------------------------------------------------
function ActionableWorldManager:OnSpawn()
	self:Reset();
end

function ActionableWorldManager:Reset()
	--Log("ActionableWorldManager:Reset");
end

-- Load mods
Script.LoadScriptFolder("scripts/spawners/asm_mods", true, true)