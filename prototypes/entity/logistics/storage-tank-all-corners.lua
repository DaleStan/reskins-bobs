-- Copyright (c) 2020 Kirazy
-- Part of Reskin Series: Bob's Structures
--     
-- See LICENSE.md in the project directory for license information.

-- Check to see if reskinning needs to be done.
if not mods["boblogistics"] then return end
if settings.startup["reskin-series-do-boblogistics"].value == false then return end 

-- Set input parameters
local inputs = 
{
    type = "storage-tank",
    root_name = "storage-tank-all-corners",
    base_entity = "storage-tank",
    directory = reskins.bobs_structures.directory,
    group = "logistics",
    particles = {["big"] = 1},
}

-- Storage tanks have two different sets of tiers; determine which we are using
local tier_map
if settings.startup["reskin-series-tier-mapping"].value == "name-map" then
    tier_map =
    {
        ["bob-storage-tank-all-corners"]   = 1,
        ["bob-storage-tank-all-corners-2"] = 2,
        ["bob-storage-tank-all-corners-3"] = 3,
        ["bob-storage-tank-all-corners-4"] = 4
    }
else
    tier_map =
    {
        ["bob-storage-tank-all-corners"]   = 2,
        ["bob-storage-tank-all-corners-2"] = 3,
        ["bob-storage-tank-all-corners-3"] = 4,
        ["bob-storage-tank-all-corners-4"] = 5
    }
end

-- Reskin entities, create and assign extra details
for name, tier in pairs(tier_map) do
    -- Fetch entity
    entity = data.raw[inputs.type][name]

    -- Check if entity exists, if not, skip this iteration
    if not entity then
        goto continue
    end

    -- Map entity to name used internally
    inputs.internal_name = inputs.root_name.."-"..tier
    
    reskins.lib.setup_common_attributes(name, tier, inputs)

    -- Fetch remnant, handle dependency on storage-tanks
    remnant = data.raw["corpse"][name.."-remnants"]
    remnant_name = inputs.base_entity.."-"..tier

    -- Reskin remnants
    remnant.animation = 
    {
        layers = 
        {
            {
                filename = inputs.directory.."/graphics/entity/logistics/storage-tank/base/remnants/storage-tank-remnants.png",
                line_length = 1,
                width = 214,
                height = 142,
                frame_count = 1,
                direction_count = 1,
                shift = util.by_pixel(27, 21),
                hr_version =
                {
                    filename = inputs.directory.."/graphics/entity/logistics/storage-tank/base/remnants/hr-storage-tank-remnants.png",
                    line_length = 1,
                    width = 426,
                    height = 282,
                    frame_count = 1,
                    direction_count = 1,
                    shift = util.by_pixel(27, 21),
                    scale = 0.5,
                }
            },
            {
                filename = inputs.directory.."/graphics/entity/logistics/storage-tank/mask/"..remnant_name.."/remnants/"..remnant_name.."-remnants.png",
                line_length = 1,
                width = 214,
                height = 142,
                frame_count = 1,
                direction_count = 1,
                shift = util.by_pixel(27, 21),
                hr_version =
                {
                    filename = inputs.directory.."/graphics/entity/logistics/storage-tank/mask/"..remnant_name.."/remnants/hr-"..remnant_name.."-remnants.png",
                    line_length = 1,
                    width = 426,
                    height = 282,
                    frame_count = 1,
                    direction_count = 1,
                    shift = util.by_pixel(27, 21),
                    scale = 0.5,
                }
            }
        }
    }

    -- Reskin entities
    entity.pictures =
    {
        picture =
        {
            sheets =
            {
                {
                    filename = inputs.directory.."/graphics/entity/logistics/storage-tank-all-corners/base/storage-tank-all-corners.png",
                    priority = "extra-high",
                    frames = 1,
                    width = 110,
                    height = 108,
                    shift = util.by_pixel(0, 4),
                    hr_version =
                    {
                        filename = inputs.directory.."/graphics/entity/logistics/storage-tank-all-corners/base/hr-storage-tank-all-corners.png",
                        priority = "extra-high",
                        frames = 1,
                        width = 219,
                        height = 215,
                        shift = util.by_pixel(-0.25, 3.75),
                        scale = 0.5
                    }
                },
                {
                    filename = inputs.directory.."/graphics/entity/logistics/storage-tank-all-corners/mask/"..inputs.internal_name.."/"..inputs.internal_name..".png",
                    priority = "extra-high",
                    frames = 1,
                    width = 110,
                    height = 108,
                    shift = util.by_pixel(0, 4),
                    hr_version =
                    {
                        filename = inputs.directory.."/graphics/entity/logistics/storage-tank-all-corners/mask/"..inputs.internal_name.."/hr-"..inputs.internal_name..".png",
                        priority = "extra-high",
                        frames = 1,
                        width = 219,
                        height = 215,
                        shift = util.by_pixel(-0.25, 3.75),
                        scale = 0.5
                    }
                },
                {
                    filename = inputs.directory.."/graphics/entity/logistics/storage-tank-all-corners/base/storage-tank-all-corners-shadow.png",
                    priority = "extra-high",
                    frames = 1,
                    width = 146,
                    height = 77,
                    shift = util.by_pixel(30, 22.5),
                    draw_as_shadow = true,
                    hr_version =
                    {
                        filename = inputs.directory.."/graphics/entity/logistics/storage-tank-all-corners/base/hr-storage-tank-all-corners-shadow.png",
                        priority = "extra-high",
                        frames = 1,
                        width = 291,
                        height = 153,
                        shift = util.by_pixel(29.75, 22.25),
                        scale = 0.5,
                        draw_as_shadow = true
                    }
                }
            }
        },
        fluid_background =
        {
            filename = inputs.directory.."/graphics/entity/logistics/storage-tank/base/fluid-background.png",
            priority = "extra-high",
            width = 32,
            height = 15
        },
        window_background =
        {
            filename = inputs.directory.."/graphics/entity/logistics/storage-tank/base/window-background.png",
            priority = "extra-high",
            width = 17,
            height = 24,
            hr_version =
            {
            filename = inputs.directory.."/graphics/entity/logistics/storage-tank/base/hr-window-background.png",
            priority = "extra-high",
            width = 34,
            height = 48,
            scale = 0.5
            }
        },
        flow_sprite =
        {
            filename = inputs.directory.."/graphics/entity/logistics/pipe/base/animations/fluid-flow-low-temperature.png",
            priority = "extra-high",
            width = 160,
            height = 20
        },
        gas_flow =
        {
            filename = inputs.directory.."/graphics/entity/logistics/pipe/base/animations/steam.png",
            priority = "extra-high",
            line_length = 10,
            width = 24,
            height = 15,
            frame_count = 60,
            axially_symmetrical = false,
            direction_count = 1,
            animation_speed = 0.25,
            hr_version =
            {
                filename = inputs.directory.."/graphics/entity/logistics/pipe/base/animations/hr-steam.png",
                priority = "extra-high",
                line_length = 10,
                width = 48,
                height = 30,
                frame_count = 60,
                axially_symmetrical = false,
                animation_speed = 0.25,
                direction_count = 1,
                scale = 0.5
            }
        }
    }
    -- Label to skip to next iteration
    ::continue::
end