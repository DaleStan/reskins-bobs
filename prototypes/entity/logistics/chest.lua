-- Copyright (c) 2020 Kirazy
-- Part of Artisanal Reskins: Bob's Mods
--     
-- See LICENSE.md in the project directory for license information.

-- Check to see if reskinning needs to be done.
if not mods["boblogistics"] then return end
if reskins.lib.setting("reskins-bobs-do-boblogistics") == false then return end

-- Set input parameters
local inputs = {
    type = "logistic-container",
    icon_name = "logistic-chest",
    directory = reskins.bobs.directory,
    mod = "bobs",
    group = "logistics",
    particles = {["medium"] = 1},
    icon_layers = 2,
    untinted_icon_mask = true
}

local material_tints = {
    ["brass"] = util.color("f9c854"),
    ["titanium"] = util.color("adadb2"),
}

local logistic_map = {
    ["logistic-chest-active-provider"] = {1, 3},
    ["logistic-chest-passive-provider"] = {1, 3},
    ["logistic-chest-storage"] = {1, 3},
    ["logistic-chest-buffer"] = {1, 3},
    ["logistic-chest-requester"] = {1, 3},
    ["logistic-chest-active-provider-2"] = {2, 4, "brass", "active-provider"},
    ["logistic-chest-passive-provider-2"] = {2, 4, "brass", "passive-provider"},
    ["logistic-chest-storage-2"] = {2, 4, "brass", "storage"},
    ["logistic-chest-buffer-2"] = {2, 4, "brass", "buffer"},
    ["logistic-chest-requester-2"] = {2, 4, "brass", "requester"},
    ["logistic-chest-active-provider-3"] = {3, 5, "titanium", "active-provider"},
    ["logistic-chest-passive-provider-3"] = {3, 5, "titanium", "passive-provider"},
    ["logistic-chest-storage-3"] = {3, 5, "titanium", "storage"},
    ["logistic-chest-buffer-3"] = {3, 5, "titanium", "buffer"},
    ["logistic-chest-requester-3"] = {3, 5, "titanium", "requester"},
}

local function logistic_chest_shadow()
    return
    {
        filename = inputs.directory.."/graphics/entity/logistics/chest/logistic-chest-shadow.png",
        priority = "extra-high",
        width = 55,
        height = 22,
        repeat_count = 7,
        shift = util.by_pixel(12, 5),
        draw_as_shadow = true,
        hr_version = {
            filename = inputs.directory.."/graphics/entity/logistics/chest/hr-logistic-chest-shadow.png",
            priority = "extra-high",
            width = 110,
            height = 44,
            repeat_count = 7,
            shift = util.by_pixel(12, 5),
            draw_as_shadow = true,
            scale = 0.5
        }
    }
end

-- Reskin entities, create and assign extra details
for name, map in pairs(logistic_map) do
    -- Fetch entity
    local entity = data.raw[inputs.type][name]

    -- Check if entity exists, if not, skip this iteration
    if not entity then goto continue end

    -- Parse map
    local tier = map[1]
    if reskins.lib.setting("reskins-lib-tier-mapping") == "ingredients-map" then
        tier = map[2]
    end

    local material = map[3]
    local chest = map[4]

    -- Stick tier labels on the vanilla logistic chests
    if not map[3] then
        reskins.lib.append_tier_labels_to_vanilla_icon(name, tier, inputs)
        entity.animation.layers[2] = logistic_chest_shadow()
        goto continue
    end

    -- Construct inputs parameters
    inputs.base_entity = chest.."-chest"
    inputs.icon_base = chest.."-chest"
    inputs.icon_mask = material.."-logistic-chest"
    inputs.tint = material_tints[material]

    reskins.lib.setup_standard_entity(name, tier, inputs)

    -- Fetch remnant
    local remnant = data.raw["corpse"][name.."-remnants"]

    -- Reskin remnants
    remnant.animation = {
        layers = {
            -- Base
            {
                filename = "__base__/graphics/entity/logistic-chest/remnants/"..chest.."-chest-remnants.png",
                line_length = 1,
                width = 60,
                height = 42,
                frame_count = 1,
                direction_count = 1,
                shift = util.by_pixel(10.5, -2.5),
                hr_version = {
                    filename = "__base__/graphics/entity/logistic-chest/remnants/hr-"..chest.."-chest-remnants.png",
                    line_length = 1,
                    width = 116,
                    height = 82,
                    frame_count = 1,
                    direction_count = 1,
                    shift = util.by_pixel(10, -3),
                    scale = 0.5,
                }
            },
            -- Mask
            {
                filename = inputs.directory.."/graphics/entity/logistics/chest/remnants/"..material.."-logistic-chest-remnants.png",
                line_length = 1,
                width = 60,
                height = 42,
                frame_count = 1,
                direction_count = 1,
                shift = util.by_pixel(10.5, -2.5),
                hr_version = {
                    filename = inputs.directory.."/graphics/entity/logistics/chest/remnants/hr-"..material.."-logistic-chest-remnants.png",
                    line_length = 1,
                    width = 116,
                    height = 82,
                    frame_count = 1,
                    direction_count = 1,
                    shift = util.by_pixel(10, -3),
                    scale = 0.5,
                }
            }
        }
    }

    -- Reskin entities
    entity.animation = {
        layers = {
            -- Base
            {
                filename = "__base__/graphics/entity/logistic-chest/logistic-chest-"..chest..".png",
                priority = "extra-high",
                width = 34,
                height = 38,
                frame_count = 7,
                shift = util.by_pixel(0, -2),
                hr_version = {
                    filename = "__base__/graphics/entity/logistic-chest/hr-logistic-chest-"..chest..".png",
                    priority = "extra-high",
                    width = 66,
                    height = 74,
                    frame_count = 7,
                    shift = util.by_pixel(0, -2),
                    scale = 0.5
                }
            },
            -- Mask
            {
                filename = inputs.directory.."/graphics/entity/logistics/chest/"..material.."-logistic-chest.png",
                priority = "extra-high",
                width = 34,
                height = 38,
                frame_count = 7,
                shift = util.by_pixel(0, -2),
                hr_version = {
                    filename = inputs.directory.."/graphics/entity/logistics/chest/hr-"..material.."-logistic-chest.png",
                    priority = "extra-high",
                    width = 66,
                    height = 74,
                    frame_count = 7,
                    shift = util.by_pixel(0, -2),
                    scale = 0.5
                }
            },
            -- Shadow
            logistic_chest_shadow()
        }
    }

    -- Label to skip to next iteration
    ::continue::
end

-- brass-chest
-- titanium-chest