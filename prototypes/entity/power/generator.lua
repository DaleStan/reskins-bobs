-- Copyright (c) 2020 Kirazy
-- Part of Artisanal Reskins: Bob's Mods
--     
-- See LICENSE.md in the project directory for license information.

-- Check to see if reskinning needs to be done.
if not mods["bobpower"] then return end
if settings.startup["bobmods-power-fluidgenerator"].value == false then return end
if settings.startup["reskins-bobs-do-bobpower"].value == false then return end 

-- Set input parameters
local inputs = {
    type = "generator",
    icon_name = "fluid-generator",
    base_entity = "steam-turbine",
    directory = reskins.bobs.directory,
    group = "power",
    particles = {["medium"] = 2,["big"] = 1},
    make_remnants = false,
}

local function setup_fluid_generator(tint)
    return 
    {
        layers = {
            -- Base
            {
                filename = inputs.directory.."/graphics/entity/power/fluid-generator/fluid-generator-base.png",
                width = 101,
                height = 130,
                frame_count = 8,
                line_length = 4,
                shift = util.by_pixel(2.5, -11),
                hr_version = {
                    filename = inputs.directory.."/graphics/entity/power/fluid-generator/hr-fluid-generator-base.png",
                    width = 202,
                    height = 260,
                    frame_count = 8,
                    line_length = 4,
                    shift = util.by_pixel(2.5, -11),
                    scale = 0.5
                }
            },
            -- Mask
            {
                filename = inputs.directory.."/graphics/entity/power/fluid-generator/fluid-generator-mask.png",
                width = 101,
                height = 130,
                repeat_count = 8,
                tint = inputs.tint,
                shift = util.by_pixel(2.5, -11),
                hr_version = {
                    filename = inputs.directory.."/graphics/entity/power/fluid-generator/hr-fluid-generator-mask.png",
                    width = 202,
                    height = 260,
                    repeat_count = 8,
                    tint = inputs.tint,
                    shift = util.by_pixel(2.5, -11),
                    scale = 0.5
                }
            },
            -- Highlights
            {
                filename = inputs.directory.."/graphics/entity/power/fluid-generator/fluid-generator-highlights.png",
                width = 101,
                height = 130,
                repeat_count = 8,
                blend_mode = "additive",
                shift = util.by_pixel(2.5, -11),
                hr_version = {
                    filename = inputs.directory.."/graphics/entity/power/fluid-generator/hr-fluid-generator-highlights.png",
                    width = 202,
                    height = 260,
                    repeat_count = 8,
                    blend_mode = "additive",
                    shift = util.by_pixel(2.5, -11),
                    scale = 0.5
                }
            },
            -- Shadow
            {
                filename = inputs.directory.."/graphics/entity/power/fluid-generator/fluid-generator-shadow.png",
                width = 162,
                height = 130,
                repeat_count = 8,
                draw_as_shadow = true,
                shift = util.by_pixel(33, -11),
                hr_version = {
                    filename = inputs.directory.."/graphics/entity/power/fluid-generator/hr-fluid-generator-shadow.png",
                    width = 324,
                    height = 260,
                    repeat_count = 8,
                    draw_as_shadow = true,
                    shift = util.by_pixel(33, -11),
                    scale = 0.5
                }
            },
        }
    }
end

-- Fluid generators have two sets of tiers; determine which we are using
local fluid_generators = {
        ["fluid-generator"] = {1, 2, 2/16},
        ["fluid-generator-2"] = {2, 3, 3/16},
        ["fluid-generator-3"] = {3, 4, 4/16},
        ["hydrazine-generator"] = {4, 5, 5/16, util.color("7ac1de")}
    }

-- Reskin entities, create and assign extra details
for name, map in pairs(fluid_generators) do
    -- Fetch entity
    entity = data.raw[inputs.type][name]

    -- Check if entity exists, if not, skip this iteration
    if not entity then
        goto continue
    end

    -- Parse map
    if settings.startup["reskins-lib-tier-mapping"].value == "name-map" then
        tier = map[1]
    else
        tier = map[2]
    end

    frequency = map[3]
    
    -- Determine what tint we're using
    inputs.tint = map[4] or reskins.lib.tint_index["tier-"..tier]
    
    reskins.lib.setup_standard_entity(name, tier, inputs)

    -- Reskin entities
    entity.horizontal_animation = setup_fluid_generator(inputs.tint)
    entity.vertical_animation = setup_fluid_generator(inputs.tint)

    -- Clear out working_visualisations
    entity.working_visualisations = nil

    -- Handle smoke
    if name == "hydrazine-generator" then
        entity.smoke = {
            {
                name = "light-smoke",
                north_position = util.by_pixel(-30, -44),
                east_position = util.by_pixel(-30, -44),
                frequency = frequency,
                starting_vertical_speed = 0.04,
                slow_down_factor = 1,
                starting_frame_deviation = 60
            }
        }
    else
        entity.smoke = {
            {
                name = "smoke",
                north_position = util.by_pixel(-30, -44),
                east_position = util.by_pixel(-30, -44),
                frequency = frequency,
                starting_vertical_speed = 0.04,
                slow_down_factor = 1,
                starting_frame_deviation = 60
            }
        }
    end

    -- Label to skip to next iteration
    ::continue::
end
