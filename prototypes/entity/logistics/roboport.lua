-- Copyright (c) 2020 Kirazy
-- Part of Reskins: Bob's Mods
--     
-- See LICENSE.md in the project directory for license information.

-- Check to see if reskinning needs to be done.
if not mods["boblogistics"] then return end
if settings.startup["reskins-bobs-do-boblogistics"].value == false then return end

-- Set input parameters
local inputs = 
{
    type = "roboport",
    root_name = "roboport",
    base_entity = "roboport",
    directory = reskins.bobs.directory,
    mod = "logistics",
    particles = {["medium"] = 2},
    make_icons = false
}

-- Roboports have two different sets of tiers; determine which we are using
local tier_map
if settings.startup["reskins-lib-tier-mapping"].value == "name-map" then
    tier_map =
    {
        ["roboport"]       = {1,1},
        ["bob-roboport-2"] = {2,2},
        ["bob-roboport-3"] = {3,3},
        ["bob-roboport-4"] = {4,4}
    }
else
    tier_map =
    {
        ["roboport"]       = {2,1},
        ["bob-roboport-2"] = {3,2},
        ["bob-roboport-3"] = {4,3},
        ["bob-roboport-4"] = {5,4}
    }
end

-- Reskin entities, create and assign extra details
for name, map in pairs(tier_map) do
    -- Fetch entity
    entity = data.raw[inputs.type][name]

    -- Check if entity exists, if not, skip this iteration
    if not entity then
        goto continue
    end

    -- Parse map
    tier = map[1]
    subtier = map[2]

    -- Map entity to name used internally
    inputs.internal_name = inputs.root_name.."-"..tier

    -- Determine what tint we're using
    inputs.tint = reskins.lib.tint_index["tier-"..tier]
    
    reskins.lib.setup_standard_entity(name, tier, inputs)

    -- Fetch remnant
    remnant = data.raw["corpse"][name.."-remnants"]    

    -- Reskin remnants
    remnant.animation = make_rotated_animation_variations_from_sheet (2,
    {
        layers =
        {
            -- Base
            {
                filename = inputs.directory.."/graphics/entity/logistics/roboport/base/remnants/roboport-remnants.png",
                line_length = 1,
                width = 182,
                height = 180,
                frame_count = 1,
                variation_count = 1,
                axially_symmetrical = false,
                direction_count = 1,
                shift = util.by_pixel(2, 8),
                hr_version =
                {
                    filename = inputs.directory.."/graphics/entity/logistics/roboport/base/remnants/hr-roboport-remnants.png",
                    line_length = 1,
                    width = 364,
                    height = 358,
                    frame_count = 1,
                    variation_count = 1,
                    axially_symmetrical = false,
                    direction_count = 1,
                    shift = util.by_pixel(2, 8),
                    scale = 0.5,
                }
            },
            -- Mask
            {
                filename = inputs.directory.."/graphics/entity/logistics/roboport/remnants/roboport-remnants-mask.png",
                line_length = 1,
                width = 182,
                height = 180,
                frame_count = 1,
                variation_count = 1,
                axially_symmetrical = false,
                direction_count = 1,
                shift = util.by_pixel(2, 8),
                tint = inputs.tint,
                hr_version =
                {
                    filename = inputs.directory.."/graphics/entity/logistics/roboport/remnants/hr-roboport-remnants-mask.png",
                    line_length = 1,
                    width = 364,
                    height = 358,
                    frame_count = 1,
                    variation_count = 1,
                    axially_symmetrical = false,
                    direction_count = 1,
                    shift = util.by_pixel(2, 8),
                    tint = inputs.tint,
                    scale = 0.5,
                }
            },
            -- Highlights
            {
                filename = inputs.directory.."/graphics/entity/logistics/roboport/remnants/roboport-remnants-highlights.png",
                line_length = 1,
                width = 182,
                height = 180,
                frame_count = 1,
                variation_count = 1,
                axially_symmetrical = false,
                direction_count = 1,
                shift = util.by_pixel(2, 8),
                blend_mode = "additive",
                hr_version =
                {
                    filename = inputs.directory.."/graphics/entity/logistics/roboport/remnants/hr-roboport-remnants-highlights.png",
                    line_length = 1,
                    width = 364,
                    height = 358,
                    frame_count = 1,
                    variation_count = 1,
                    axially_symmetrical = false,
                    direction_count = 1,
                    shift = util.by_pixel(2, 8),
                    blend_mode = "additive",
                    scale = 0.5,
                }
            },
            -- Antenna
            {
                filename = inputs.directory.."/graphics/entity/logistics/roboport/base/remnants/antennas/roboport-"..subtier.."-antenna-remnants.png",
                line_length = 1,
                width = 182,
                height = 180,
                frame_count = 1,
                variation_count = 1,
                axially_symmetrical = false,
                direction_count = 1,
                shift = util.by_pixel(2, 8),
                hr_version =
                {
                    filename = inputs.directory.."/graphics/entity/logistics/roboport/base/remnants/antennas/hr-roboport-"..subtier.."-antenna-remnants.png",
                    line_length = 1,
                    width = 364,
                    height = 358,
                    frame_count = 1,
                    variation_count = 1,
                    axially_symmetrical = false,
                    direction_count = 1,
                    shift = util.by_pixel(2, 8),
                    scale = 0.5,
                }
            },
            -- Door
            {
                filename = inputs.directory.."/graphics/entity/logistics/roboport/base/remnants/doors/roboport-"..subtier.."-door-remnants.png",
                line_length = 1,
                width = 182,
                height = 180,
                frame_count = 1,
                variation_count = 1,
                axially_symmetrical = false,
                direction_count = 1,
                shift = util.by_pixel(2, 8),
                hr_version =
                {
                    filename = inputs.directory.."/graphics/entity/logistics/roboport/base/remnants/doors/hr-roboport-"..subtier.."-door-remnants.png",
                    line_length = 1,
                    width = 364,
                    height = 358,
                    frame_count = 1,
                    variation_count = 1,
                    axially_symmetrical = false,
                    direction_count = 1,
                    shift = util.by_pixel(2, 8),
                    scale = 0.5,
                }
            }
        }
    })

    -- Reskin entities
    entity.spawn_and_station_height = -0.1
    entity.base =
    {
        layers =
        {
            -- Base
            {
                filename = inputs.directory.."/graphics/entity/logistics/roboport/base/roboport-base.png",
                width = 143,
                height = 135,
                shift = {0.5, 0.25},
                hr_version =
                {
                    filename = inputs.directory.."/graphics/entity/logistics/roboport/base/hr-roboport-base.png",
                    width = 228,
                    height = 277,
                    shift = util.by_pixel(2, 7.75),
                    scale = 0.5
                }
            },
            -- Mask
            {
                filename = inputs.directory.."/graphics/entity/logistics/roboport/roboport-base-mask.png",
                width = 143,
                height = 135,
                shift = {0.5, 0.25},
                tint = inputs.tint,
                hr_version =
                {
                    filename = inputs.directory.."/graphics/entity/logistics/roboport/hr-roboport-base-mask.png",
                    width = 228,
                    height = 277,
                    shift = util.by_pixel(2, 7.75),
                    tint = inputs.tint,
                    scale = 0.5
                }
            },
            -- Highlights
            {
                filename = inputs.directory.."/graphics/entity/logistics/roboport/roboport-base-highlights.png",
                width = 143,
                height = 135,
                shift = {0.5, 0.25},
                blend_mode = "additive",
                hr_version =
                {
                    filename = inputs.directory.."/graphics/entity/logistics/roboport/hr-roboport-base-highlights.png",
                    width = 228,
                    height = 277,
                    shift = util.by_pixel(2, 7.75),
                    blend_mode = "additive",
                    scale = 0.5
                }
            },
            -- Shadow
            {
                filename = inputs.directory.."/graphics/entity/logistics/roboport/base/roboport-shadow.png",
                width = 147,
                height = 101,
                draw_as_shadow = true,
                shift = util.by_pixel(28.5, 19.25),
                hr_version =
                {
                    filename = inputs.directory.."/graphics/entity/logistics/roboport/base/hr-roboport-shadow.png",
                    width = 294,
                    height = 201,
                    draw_as_shadow = true,
                    force_hr_shadow = true,
                    shift = util.by_pixel(28.5, 19.25),
                    scale = 0.5
                }
            }
        }
    }
    
    entity.base_patch =
    {
        layers =
        {
            -- Padding
            {
                filename = inputs.directory.."/graphics/empty.png",
                priority = "medium",
                width = 1,
                height = 1,
                frame_count = 1,
                hr_version =
                {
                    filename = inputs.directory.."/graphics/empty.png",
                    priority = "medium",
                    width = 1,
                    height = 1,
                    frame_count = 1,
                }
            },
            -- Base
            {
                filename = inputs.directory.."/graphics/entity/logistics/roboport/base/roboport-base-patch.png",
                priority = "medium",
                width = 69,
                height = 50,
                frame_count = 1,
                shift = {0.03125, 0.203125},
                hr_version =
                {
                    filename = inputs.directory.."/graphics/entity/logistics/roboport/base/hr-roboport-base-patch.png",
                    priority = "medium",
                    width = 138,
                    height = 100,
                    frame_count = 1,
                    shift = util.by_pixel(1.5, 5),
                    scale = 0.5
                }
            },
            -- Mask
            {
                filename = inputs.directory.."/graphics/entity/logistics/roboport/roboport-base-patch-mask.png",
                priority = "medium",
                width = 69,
                height = 50,
                frame_count = 1,
                shift = {0.03125, 0.203125},
                tint = inputs.tint,
                hr_version =
                {
                    filename = inputs.directory.."/graphics/entity/logistics/roboport/hr-roboport-base-patch-mask.png",
                    priority = "medium",
                    width = 138,
                    height = 100,
                    frame_count = 1,
                    shift = util.by_pixel(1.5, 5),
                    tint = inputs.tint,
                    scale = 0.5
                }
            },
            -- Highlights
            {
                filename = inputs.directory.."/graphics/entity/logistics/roboport/roboport-base-patch-highlights.png",
                priority = "medium",
                width = 69,
                height = 50,
                frame_count = 1,
                shift = {0.03125, 0.203125},
                blend_mode = "additive",
                hr_version =
                {
                    filename = inputs.directory.."/graphics/entity/logistics/roboport/hr-roboport-base-patch-highlights.png",
                    priority = "medium",
                    width = 138,
                    height = 100,
                    frame_count = 1,
                    shift = util.by_pixel(1.5, 5),
                    blend_mode = "additive",
                    scale = 0.5
                }
            }
        }
    }

    entity.base_animation =
    {
        filename = inputs.directory.."/graphics/entity/logistics/roboport/base/antennas/roboport-"..subtier.."-base-animation.png",
        priority = "medium",
        width = 42,
        height = 31,
        frame_count = 8,
        animation_speed = 0.5,
        shift = {-0.5315, -1.9375},
        hr_version =
        {
            filename = inputs.directory.."/graphics/entity/logistics/roboport/base/antennas/hr-roboport-"..subtier.."-base-animation.png",
            priority = "medium",
            width = 83,
            height = 59,
            frame_count = 8,
            animation_speed = 0.5,
            shift = util.by_pixel(-17.75, -61.25),
            scale = 0.5
        }
    }
    
    entity.door_animation_up =
    {
        layers =
        {
            {
                filename = inputs.directory.."/graphics/entity/logistics/roboport/base/doors/roboport-"..subtier.."-door-up.png",
                priority = "medium",
                width = 52,
                height = 20,
                frame_count = 16,
                shift = {0.015625, -0.890625},
                hr_version =
                {
                    filename = inputs.directory.."/graphics/entity/logistics/roboport/base/doors/hr-roboport-"..subtier.."-door-up.png",
                    priority = "medium",
                    width = 97,
                    height = 38,
                    frame_count = 16,
                    shift = util.by_pixel(-0.25, -29.5),
                    scale = 0.5
                }
            }
        }
    }
    
    entity.door_animation_down =
    {
        filename = inputs.directory.."/graphics/entity/logistics/roboport/base/doors/roboport-"..subtier.."-door-down.png",
        priority = "medium",
        width = 52,
        height = 22,
        frame_count = 16,
        shift = {0.015625, -0.234375},
        hr_version =
        {
            filename = inputs.directory.."/graphics/entity/logistics/roboport/base/doors/hr-roboport-"..subtier.."-door-down.png",
            priority = "medium",
            width = 97,
            height = 41,
            frame_count = 16,
            shift = util.by_pixel(-0.25,-9.75),
            scale = 0.5
        }
    }
    
    entity.recharging_animation =
    {
        filename = inputs.directory.."/graphics/entity/logistics/roboport/base/roboport-recharging.png",
        priority = "high",
        width = 37,
        height = 35,
        frame_count = 16,
        scale = 1.5,
        animation_speed = 0.5
    }

    -- Label to skip to next iteration
    ::continue::
end