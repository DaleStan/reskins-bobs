-- Copyright (c) 2021 Kirazy
-- Part of Artisanal Reskins: Bob's Mods
--
-- See LICENSE in the project directory for license information.

-- Check to see if reskinning needs to be done.
if not mods["boblogistics"] then return end
if reskins.lib.setting("reskins-bobs-do-boblogistics") == false then return end

-- Set input parameters
local inputs = {
    type = "storage-tank",
    icon_name = "storage-tank-all-corners",
    base_entity = "storage-tank",
    mod = "bobs",
    group = "logistics",
    particles = {["big"] = 1},
}

local tier_map = {
    ["bob-storage-tank-all-corners"] = {1, 2},
    ["bob-storage-tank-all-corners-2"] = {2, 3},
    ["bob-storage-tank-all-corners-3"] = {3, 4},
    ["bob-storage-tank-all-corners-4"] = {4, 5},
}

-- Reskin entities, create and assign extra details
for name, map in pairs(tier_map) do
    -- Fetch entity
    local entity = data.raw[inputs.type][name]

    -- Check if entity exists, if not, skip this iteration
    if not entity then goto continue end

    -- Parse map
    local tier = map[1]
    if reskins.lib.setting("reskins-lib-tier-mapping") == "progression-map" then
        tier = map[2]
    end

    -- Determine what tint we're using
    inputs.tint = reskins.lib.tint_index["tier-"..tier]

    reskins.lib.setup_standard_entity(name, tier, inputs)

    -- Fetch remnant, handle dependency on storage-tanks
    local remnant = data.raw["corpse"][name.."-remnants"]

    -- Reskin remnants
    remnant.animation = {
        layers = {
            -- Base
            {
                filename = "__base__/graphics/entity/storage-tank/remnants/storage-tank-remnants.png",
                line_length = 1,
                width = 214,
                height = 142,
                frame_count = 1,
                direction_count = 1,
                shift = util.by_pixel(27, 21),
                hr_version = {
                    filename = "__base__/graphics/entity/storage-tank/remnants/hr-storage-tank-remnants.png",
                    line_length = 1,
                    width = 426,
                    height = 282,
                    frame_count = 1,
                    direction_count = 1,
                    shift = util.by_pixel(27, 21),
                    scale = 0.5,
                }
            },
            -- Mask
            {
                filename = reskins.bobs.directory.."/graphics/entity/logistics/storage-tank/remnants/storage-tank-remnants-mask.png",
                line_length = 1,
                width = 214,
                height = 142,
                frame_count = 1,
                direction_count = 1,
                shift = util.by_pixel(27, 21),
                tint = inputs.tint,
                hr_version = {
                    filename = reskins.bobs.directory.."/graphics/entity/logistics/storage-tank/remnants/hr-storage-tank-remnants-mask.png",
                    line_length = 1,
                    width = 426,
                    height = 282,
                    frame_count = 1,
                    direction_count = 1,
                    shift = util.by_pixel(27, 21),
                    tint = inputs.tint,
                    scale = 0.5,
                }
            },
            -- Highlights
            {
                filename = reskins.bobs.directory.."/graphics/entity/logistics/storage-tank/remnants/storage-tank-remnants-highlights.png",
                line_length = 1,
                width = 214,
                height = 142,
                frame_count = 1,
                direction_count = 1,
                shift = util.by_pixel(27, 21),
                blend_mode = reskins.lib.blend_mode, -- "additive",
                hr_version = {
                    filename = reskins.bobs.directory.."/graphics/entity/logistics/storage-tank/remnants/hr-storage-tank-remnants-highlights.png",
                    line_length = 1,
                    width = 426,
                    height = 282,
                    frame_count = 1,
                    direction_count = 1,
                    shift = util.by_pixel(27, 21),
                    blend_mode = reskins.lib.blend_mode, -- "additive",
                    scale = 0.5,
                }
            }
        }
    }

    -- Reskin entities
    entity.pictures = {
        picture = {
            sheets = {
                -- Base
                {
                    filename = reskins.bobs.directory.."/graphics/entity/logistics/storage-tank-all-corners/base/storage-tank-all-corners.png",
                    priority = "extra-high",
                    frames = 1,
                    width = 110,
                    height = 108,
                    shift = util.by_pixel(0, 4),
                    hr_version = {
                        filename = reskins.bobs.directory.."/graphics/entity/logistics/storage-tank-all-corners/base/hr-storage-tank-all-corners.png",
                        priority = "extra-high",
                        frames = 1,
                        width = 219,
                        height = 215,
                        shift = util.by_pixel(-0.25, 3.75),
                        scale = 0.5
                    }
                },
                -- Mask
                {
                    filename = reskins.bobs.directory.."/graphics/entity/logistics/storage-tank-all-corners/storage-tank-all-corners-mask.png",
                    priority = "extra-high",
                    frames = 1,
                    width = 110,
                    height = 108,
                    shift = util.by_pixel(0, 4),
                    tint = inputs.tint,
                    hr_version = {
                        filename = reskins.bobs.directory.."/graphics/entity/logistics/storage-tank-all-corners/hr-storage-tank-all-corners-mask.png",
                        priority = "extra-high",
                        frames = 1,
                        width = 219,
                        height = 215,
                        shift = util.by_pixel(-0.25, 3.75),
                        tint = inputs.tint,
                        scale = 0.5
                    }
                },
                -- Highlights
                {
                    filename = reskins.bobs.directory.."/graphics/entity/logistics/storage-tank-all-corners/storage-tank-all-corners-highlights.png",
                    priority = "extra-high",
                    frames = 1,
                    width = 110,
                    height = 108,
                    shift = util.by_pixel(0, 4),
                    blend_mode = reskins.lib.blend_mode, -- "additive",
                    hr_version = {
                        filename = reskins.bobs.directory.."/graphics/entity/logistics/storage-tank-all-corners/hr-storage-tank-all-corners-highlights.png",
                        priority = "extra-high",
                        frames = 1,
                        width = 219,
                        height = 215,
                        shift = util.by_pixel(-0.25, 3.75),
                        blend_mode = reskins.lib.blend_mode, -- "additive",
                        scale = 0.5
                    }
                },
                -- Shadow
                {
                    filename = reskins.bobs.directory.."/graphics/entity/logistics/storage-tank-all-corners/base/storage-tank-all-corners-shadow.png",
                    priority = "extra-high",
                    frames = 1,
                    width = 146,
                    height = 77,
                    shift = util.by_pixel(30, 22.5),
                    draw_as_shadow = true,
                    hr_version = {
                        filename = reskins.bobs.directory.."/graphics/entity/logistics/storage-tank-all-corners/base/hr-storage-tank-all-corners-shadow.png",
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
        fluid_background = {
            filename = "__base__/graphics/entity/storage-tank/fluid-background.png",
            priority = "extra-high",
            width = 32,
            height = 15
        },
        window_background = {
            filename = "__base__/graphics/entity/storage-tank/window-background.png",
            priority = "extra-high",
            width = 17,
            height = 24,
            hr_version = {
            filename = "__base__/graphics/entity/storage-tank/hr-window-background.png",
            priority = "extra-high",
            width = 34,
            height = 48,
            scale = 0.5
            }
        },
        flow_sprite = {
            filename = "__base__/graphics/entity/pipe/fluid-flow-low-temperature.png",
            priority = "extra-high",
            width = 160,
            height = 20
        },
        gas_flow = {
            filename = "__base__/graphics/entity/pipe/steam.png",
            priority = "extra-high",
            line_length = 10,
            width = 24,
            height = 15,
            frame_count = 60,
            axially_symmetrical = false,
            direction_count = 1,
            animation_speed = 0.25,
            hr_version = {
                filename = "__base__/graphics/entity/pipe/hr-steam.png",
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

    entity.water_reflection = util.copy(data.raw[inputs.type]["storage-tank"].water_reflection)

    -- Label to skip to next iteration
    ::continue::
end