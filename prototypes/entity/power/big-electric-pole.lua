-- Copyright (c) 2020 Kirazy
-- Part of Reskins: Bob's Mods
--     
-- See LICENSE.md in the project directory for license information.

-- Check to see if reskinning needs to be done.
if not mods["bobpower"] then return end
if settings.startup["bobmods-power-poles"].value == false then return end
if settings.startup["reskins-bobs-do-bobpower"].value == false then return end 

-- Set input parameters
local inputs = 
{
    type = "electric-pole",
    root_name = "big-electric-pole",
    base_entity = "big-electric-pole",
    directory = reskins.bobs.directory,
    mod = "power",
    icon_subfolder = "big-electric-pole",
    particles = {["medium-long"] = 1}
}

-- Big electric poles have two different sets of tiers; determine which we are using
local tier_map
if settings.startup["reskins-lib-tier-mapping"].value == "name-map" then
    tier_map =
    {
        ["big-electric-pole"]   = 1,
        ["big-electric-pole-2"] = 2,
        ["big-electric-pole-3"] = 3,
        ["big-electric-pole-4"] = 4
    }
else
    tier_map =
    {
        ["big-electric-pole"]   = 2,
        ["big-electric-pole-2"] = 3,
        ["big-electric-pole-3"] = 4,
        ["big-electric-pole-4"] = 5
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

    -- Determine what tint we're using
    inputs.tint = reskins.lib.tint_index["tier-"..tier]
    
    reskins.lib.setup_standard_structure(name, tier, inputs)

    -- Fetch remnant
    remnant = data.raw["corpse"][name.."-remnants"]

    -- Reskin remnants
    remnant.animation = make_rotated_animation_variations_from_sheet (4,
    {
        layers =
        {
            -- Base
            {
                filename = inputs.directory.."/graphics/entity/power/big-electric-pole/base/remnants/big-electric-pole-base-remnants.png",
                line_length = 1,
                width = 184,
                height = 94,
                frame_count = 1,
                direction_count = 1,
                shift = util.by_pixel(44, 0),
                hr_version =
                {
                filename = inputs.directory.."/graphics/entity/power/big-electric-pole/base/remnants/hr-big-electric-pole-base-remnants.png",
                line_length = 1,
                width = 366,
                height = 188,
                frame_count = 1,
                direction_count = 1,
                shift = util.by_pixel(43, 0.5),
                scale = 0.5,
                }
            },
            -- Mask
            {
                filename = inputs.directory.."/graphics/entity/power/big-electric-pole/remnants/big-electric-pole-base-remnants-mask.png",
                line_length = 1,
                width = 184,
                height = 94,
                frame_count = 1,
                direction_count = 1,
                shift = util.by_pixel(44, 0),
                tint = inputs.tint,
                hr_version =
                {
                filename = inputs.directory.."/graphics/entity/power/big-electric-pole/remnants/hr-big-electric-pole-base-remnants-mask.png",
                line_length = 1,
                width = 366,
                height = 188,
                frame_count = 1,
                direction_count = 1,
                shift = util.by_pixel(43, 0.5),
                tint = inputs.tint,
                scale = 0.5,
                }
            },
            -- Highlights
            {
                filename = inputs.directory.."/graphics/entity/power/big-electric-pole/remnants/big-electric-pole-base-remnants-highlights.png",
                line_length = 1,
                width = 184,
                height = 94,
                frame_count = 1,
                direction_count = 1,
                shift = util.by_pixel(44, 0),
                blend_mode = "additive",
                hr_version =
                {
                filename = inputs.directory.."/graphics/entity/power/big-electric-pole/remnants/hr-big-electric-pole-base-remnants-highlights.png",
                line_length = 1,
                width = 366,
                height = 188,
                frame_count = 1,
                direction_count = 1,
                shift = util.by_pixel(43, 0.5),
                blend_mode = "additive",
                scale = 0.5,
                }
            },
        },
    })

    remnant.animation_overlay = make_rotated_animation_variations_from_sheet (4,
    {
        layers =
        {
            -- Base
            {
                filename = inputs.directory.."/graphics/entity/power/big-electric-pole/base/remnants/big-electric-pole-top-remnants.png",
                line_length = 1,
                width = 76,
                height = 126,
                frame_count = 1,
                direction_count = 1,
                shift = util.by_pixel(-1, -48),
                hr_version =
                {
                    filename = inputs.directory.."/graphics/entity/power/big-electric-pole/base/remnants/hr-big-electric-pole-top-remnants.png",
                    line_length = 1,
                    width = 148,
                    height = 252,
                    frame_count = 1,
                    direction_count = 1,
                    shift = util.by_pixel(-1.5, -48),
                    scale = 0.5,
                }
            },
            -- Mask
            {
                filename = inputs.directory.."/graphics/entity/power/big-electric-pole/remnants/big-electric-pole-top-remnants-mask.png",
                line_length = 1,
                width = 76,
                height = 126,
                frame_count = 1,
                direction_count = 1,
                shift = util.by_pixel(-1, -48),
                tint = inputs.tint,
                hr_version =
                {
                    filename = inputs.directory.."/graphics/entity/power/big-electric-pole/remnants/hr-big-electric-pole-top-remnants-mask.png",
                    line_length = 1,
                    width = 148,
                    height = 252,
                    frame_count = 1,
                    direction_count = 1,
                    shift = util.by_pixel(-1.5, -48),
                    tint = inputs.tint,
                    scale = 0.5,
                }
            },
            -- Highlights
            {
                filename = inputs.directory.."/graphics/entity/power/big-electric-pole/remnants/big-electric-pole-top-remnants-highlights.png",
                line_length = 1,
                width = 76,
                height = 126,
                frame_count = 1,
                direction_count = 1,
                shift = util.by_pixel(-1, -48),
                blend_mode = "additive",
                hr_version =
                {
                    filename = inputs.directory.."/graphics/entity/power/big-electric-pole/remnants/hr-big-electric-pole-top-remnants-highlights.png",
                    line_length = 1,
                    width = 148,
                    height = 252,
                    frame_count = 1,
                    direction_count = 1,
                    shift = util.by_pixel(-1.5, -48),
                    blend_mode = "additive",
                    scale = 0.5,
                }
            },
        }
    })

    -- Reskin entities
    entity.pictures =
    {
        layers =
        {
            -- Base
            {
                filename = inputs.directory.."/graphics/entity/power/big-electric-pole/base/big-electric-pole.png",
                priority = "extra-high",
                width = 76,
                height = 156,
                direction_count = 4,
                shift = util.by_pixel(1, -51),
                hr_version =
                {
                    filename = inputs.directory.."/graphics/entity/power/big-electric-pole/base/hr-big-electric-pole.png",
                    priority = "extra-high",
                    width = 148,
                    height = 312,
                    direction_count = 4,
                    shift = util.by_pixel(0, -51),
                    scale = 0.5
                }
            },
            -- Mask
            {
                filename = inputs.directory.."/graphics/entity/power/big-electric-pole/big-electric-pole-mask.png",
                priority = "extra-high",
                width = 76,
                height = 156,
                direction_count = 4,
                shift = util.by_pixel(1, -51),
                tint = inputs.tint,
                hr_version =
                {
                    filename = inputs.directory.."/graphics/entity/power/big-electric-pole/hr-big-electric-pole-mask.png",
                    priority = "extra-high",
                    width = 148,
                    height = 312,
                    direction_count = 4,
                    shift = util.by_pixel(0, -51),
                    tint = inputs.tint,
                    scale = 0.5
                }
            },
            -- Highlights
            {
                filename = inputs.directory.."/graphics/entity/power/big-electric-pole/big-electric-pole-highlights.png",
                priority = "extra-high",
                width = 76,
                height = 156,
                direction_count = 4,
                shift = util.by_pixel(1, -51),
                blend_mode = "additive",
                hr_version =
                {
                    filename = inputs.directory.."/graphics/entity/power/big-electric-pole/hr-big-electric-pole-highlights.png",
                    priority = "extra-high",
                    width = 148,
                    height = 312,
                    direction_count = 4,
                    shift = util.by_pixel(0, -51),
                    blend_mode = "additive",
                    scale = 0.5
                }
            },
            -- Shadow
            {
                filename = inputs.directory.."/graphics/entity/power/big-electric-pole/base/big-electric-pole-shadow.png",
                priority = "extra-high",
                width = 188,
                height = 48,
                direction_count = 4,
                shift = util.by_pixel(60, 0),
                draw_as_shadow = true,
                hr_version =
                {
                    filename = inputs.directory.."/graphics/entity/power/big-electric-pole/base/hr-big-electric-pole-shadow.png",
                    priority = "extra-high",
                    width = 374,
                    height = 94,
                    direction_count = 4,
                    shift = util.by_pixel(60, 0),
                    draw_as_shadow = true,
                    scale = 0.5
                }
            }
        }
    }
    
    -- Label to skip to next iteration
    ::continue::
end


