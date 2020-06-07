-- Copyright (c) 2020 Kirazy
-- Part of Artisanal Reskins: Bob's Mods
--     
-- See LICENSE.md in the project directory for license information.

-- Check to see if reskinning needs to be done.
if not mods["bobpower"] then return end
if settings.startup["bobmods-power-solar"] and settings.startup["bobmods-power-solar"].value == false then return end
if settings.startup["reskins-bobs-do-bobpower"].value == false then return end 

-- Set input parameters
local inputs = {
    type = "solar-panel",
    base_entity = "solar-panel",
    directory = reskins.bobs.directory,
    group = "power",
    particles = {["small"] = 2},
}

-- Solar panels have two different sets of tiers; determine which we are using
local tier_map
if settings.startup["reskins-lib-tier-mapping"].value == "name-map" then
    tier_map = {
        ["solar-panel-small"] = 1,
        ["solar-panel-small-2"] = 2,
        ["solar-panel-small-3"] = 3,
        ["solar-panel"] = 1,
        ["solar-panel-2"] = 2,
        ["solar-panel-3"] = 3,
        ["solar-panel-large"] = 1,
        ["solar-panel-large-2"] = 2,
        ["solar-panel-large-3"] = 3
    }
else
    tier_map = {
        ["solar-panel-small"] = 2,
        ["solar-panel-small-2"] = 3,
        ["solar-panel-small-3"] = 4,
        ["solar-panel"] = 2,
        ["solar-panel-2"] = 3,
        ["solar-panel-3"] = 4,
        ["solar-panel-large"] = 2,
        ["solar-panel-large-2"] = 3,
        ["solar-panel-large-3"] = 4
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

    -- Setup icon name details
    if string.find(name, "small", 1, true) then
        inputs.icon_name = "solar-panel-small"
    elseif string.find(name, "large", 1, true) then
        inputs.icon_name = "solar-panel-large"
    else
        inputs.icon_name = "solar-panel"
    end

    -- Setup additional icon details
    inputs.icon_extras = {
        -- Type indicator
        {
            icon = inputs.directory.."/graphics/icons/power/"..inputs.icon_name.."/"..inputs.icon_name.."-icon-type.png"
        },
        {
            icon = inputs.directory.."/graphics/icons/power/"..inputs.icon_name.."/"..inputs.icon_name.."-icon-type.png",
            tint = reskins.lib.adjust_alpha(reskins.lib.tint_index["tier-"..tier], 0.75)
        }
    }

    -- Determine what tint we're using
    inputs.tint = reskins.lib.tint_index["tier-"..tier]
    
    reskins.lib.setup_standard_entity(name, tier, inputs)

    -- Initialize table addresses    
    remnant = data.raw["corpse"][name.."-remnants"]

    -- Reskin remnants
    -- remnant.animation[1].filename = inputs.directory.."/graphics/entity/power/"..inputs.icon_name.."/"..inputs.internal_name.."/remnants/"..inputs.internal_name.."-remnants.png"
    -- remnant.animation[1].hr_version.filename = inputs.directory.."/graphics/entity/power/"..inputs.icon_name.."/"..inputs.internal_name.."/remnants/hr-"..inputs.internal_name.."-remnants.png"
    -- remnant.animation[2].filename = inputs.directory.."/graphics/entity/power/"..inputs.icon_name.."/"..inputs.internal_name.."/remnants/"..inputs.internal_name.."-remnants.png"
    -- remnant.animation[2].hr_version.filename = inputs.directory.."/graphics/entity/power/"..inputs.icon_name.."/"..inputs.internal_name.."/remnants/hr-"..inputs.internal_name.."-remnants.png"
    
    -- Reskin entities
    if inputs.icon_name == "solar-panel-small" then
        -- Overwrite picture table in target entity
        entity.picture = {
            layers = {
                -- Base
                {
                    filename = inputs.directory.."/graphics/entity/power/solar-panel-small/base/solar-panel-small.png",
                    priority = "high",
                    width = 90,
                    height = 75,
                    shift = util.by_pixel(2.5, 0.25),
                    hr_version = {
                        filename = inputs.directory.."/graphics/entity/power/solar-panel-small/base/hr-solar-panel-small.png",
                        priority = "high",
                        width = 180,
                        height = 150,
                        shift = util.by_pixel(5, 0.5),
                        scale = 0.5
                    }
                },
                -- Mask
                {
                    filename = inputs.directory.."/graphics/entity/power/solar-panel-small/solar-panel-small-mask.png",
                    priority = "high",
                    width = 90,
                    height = 75,
                    shift = util.by_pixel(2.5, 0.25),
                    tint = inputs.tint,
                    hr_version = {
                        filename = inputs.directory.."/graphics/entity/power/solar-panel-small/hr-solar-panel-small-mask.png",
                        priority = "high",
                        width = 180,
                        height = 150,
                        shift = util.by_pixel(5, 0.5),
                        tint = inputs.tint,
                        scale = 0.5
                    }
                },
                -- Highlights
                {
                    filename = inputs.directory.."/graphics/entity/power/solar-panel-small/solar-panel-small-highlights.png",
                    priority = "high",
                    width = 90,
                    height = 75,
                    shift = util.by_pixel(2.5, 0.25),
                    blend_mode = "additive",
                    hr_version = {
                        filename = inputs.directory.."/graphics/entity/power/solar-panel-small/hr-solar-panel-small-highlights.png",
                        priority = "high",
                        width = 180,
                        height = 150,
                        shift = util.by_pixel(5, 0.5),
                        blend_mode = "additive",
                        scale = 0.5
                    }
                },
                -- Shadow
                {
                    filename = inputs.directory.."/graphics/entity/power/solar-panel-small/base/solar-panel-small-shadow.png",
                    priority = "high",
                    width = 90,
                    height = 75,
                    shift = util.by_pixel(2.5, 0.25),
                    draw_as_shadow = true,
                    hr_version = {
                        filename = inputs.directory.."/graphics/entity/power/solar-panel-small/base/hr-solar-panel-small-shadow.png",
                        priority = "high",
                        width = 180,
                        height = 150,
                        shift = util.by_pixel(5, 0.5),
                        draw_as_shadow = true,
                        scale = 0.5
                    }
                }
            }
        }

        -- Overwrite or create overlay table in target entity
        entity.overlay = {
            layers = {
                {
                    filename = inputs.directory.."/graphics/entity/power/solar-panel-small/base/solar-panel-small-shadow-overlay.png",
                    priority = "high",
                    width = 90,
                    height = 75,
                    shift = util.by_pixel(2.5, 0.25),
                    hr_version = {
                        filename = inputs.directory.."/graphics/entity/power/solar-panel-small/base/hr-solar-panel-small-shadow-overlay.png",
                        priority = "high",
                        width = 180,
                        height = 150,
                        shift = util.by_pixel(5, 0.5),
                        scale = 0.5
                    }
                }
            }
        }
    elseif inputs.icon_name == "solar-panel" then
        -- Overwrite picture table in target entity
        entity.picture = {
            layers = {
                -- Base
                {
                    filename = "__base__/graphics/entity/solar-panel/solar-panel.png",
                    priority = "high",
                    width = 116,
                    height = 112,
                    shift = util.by_pixel(-3, 3),
                    hr_version = {
                        filename = "__base__/graphics/entity/solar-panel/hr-solar-panel.png",
                        priority = "high",
                        width = 230,
                        height = 224,
                        shift = util.by_pixel(-3, 3.5),
                        scale = 0.5
                    }
                },
                -- Mask
                {
                    filename = inputs.directory.."/graphics/entity/power/solar-panel/solar-panel-mask.png",
                    priority = "high",
                    width = 116,
                    height = 112,
                    shift = util.by_pixel(-3, 3),
                    tint = inputs.tint,
                    hr_version = {
                        filename = inputs.directory.."/graphics/entity/power/solar-panel/hr-solar-panel-mask.png",
                        priority = "high",
                        width = 230,
                        height = 224,
                        shift = util.by_pixel(-3, 3.5),
                        tint = inputs.tint,
                        scale = 0.5
                    }
                },
                -- Highlights
                {
                    filename = inputs.directory.."/graphics/entity/power/solar-panel/solar-panel-highlights.png",
                    priority = "high",
                    width = 116,
                    height = 112,
                    shift = util.by_pixel(-3, 3),
                    blend_mode = "additive",
                    hr_version = {
                        filename = inputs.directory.."/graphics/entity/power/solar-panel/hr-solar-panel-highlights.png",
                        priority = "high",
                        width = 230,
                        height = 224,
                        shift = util.by_pixel(-3, 3.5),
                        blend_mode = "additive",
                        scale = 0.5
                    }
                },
                -- Shadow
                {
                    filename = "__base__/graphics/entity/solar-panel/solar-panel-shadow.png",
                    priority = "high",
                    width = 112,
                    height = 90,
                    shift = util.by_pixel(10, 6),
                    draw_as_shadow = true,
                    hr_version = {
                        filename = "__base__/graphics/entity/solar-panel/hr-solar-panel-shadow.png",
                        priority = "high",
                        width = 220,
                        height = 180,
                        shift = util.by_pixel(9.5, 6),
                        draw_as_shadow = true,
                        scale = 0.5
                    }
                }
            }
        }

        -- Overwrite or create overlay table in target entity
        entity.overlay = {
            layers = {
                {
                    filename = "__base__/graphics/entity/solar-panel/solar-panel-shadow-overlay.png",
                    priority = "high",
                    width = 108,
                    height = 90,
                    shift = util.by_pixel(11, 6),
                    hr_version = {
                        filename = "__base__/graphics/entity/solar-panel/hr-solar-panel-shadow-overlay.png",
                        priority = "high",
                        width = 214,
                        height = 180,
                        shift = util.by_pixel(10.5, 6),
                        scale = 0.5
                    }
                }
            }
        }
    elseif inputs.icon_name == "solar-panel-large" then
        -- Overwrite picture table in target entity
        entity.picture = {
            layers = {
                -- Base
                {
                    filename = inputs.directory.."/graphics/entity/power/solar-panel-large/base/solar-panel-large.png",
                    priority = "high",
                    width = 154,
                    height = 137,
                    shift = util.by_pixel(2.5, 1.75),
                    hr_version = {
                        filename = inputs.directory.."/graphics/entity/power/solar-panel-large/base/hr-solar-panel-large.png",
                        priority = "high",
                        width = 308,
                        height = 274,
                        shift = util.by_pixel(5, 3.5),
                        scale = 0.5
                    }
                },
                -- Mask
                {
                    filename = inputs.directory.."/graphics/entity/power/solar-panel-large/solar-panel-large-mask.png",
                    priority = "high",
                    width = 154,
                    height = 137,
                    shift = util.by_pixel(2.5, 1.75),
                    tint = inputs.tint,
                    hr_version = {
                        filename = inputs.directory.."/graphics/entity/power/solar-panel-large/hr-solar-panel-large-mask.png",
                        priority = "high",
                        width = 308,
                        height = 274,
                        shift = util.by_pixel(5, 3.5),
                        tint = inputs.tint,
                        scale = 0.5
                    }
                },
                -- Highlights
                {
                    filename = inputs.directory.."/graphics/entity/power/solar-panel-large/solar-panel-large-highlights.png",
                    priority = "high",
                    width = 154,
                    height = 137,
                    shift = util.by_pixel(2.5, 1.75),
                    blend_mode = "additive",
                    hr_version = {
                        filename = inputs.directory.."/graphics/entity/power/solar-panel-large/hr-solar-panel-large-highlights.png",
                        priority = "high",
                        width = 308,
                        height = 274,
                        shift = util.by_pixel(5, 3.5),
                        blend_mode = "additive",
                        scale = 0.5
                    }
                },
                -- Shadow
                {
                    filename = inputs.directory.."/graphics/entity/power/solar-panel-large/base/solar-panel-large-shadow.png",
                    priority = "high",
                    width = 154,
                    height = 137,
                    shift = util.by_pixel(2.5, 1.75),
                    draw_as_shadow = true,
                    hr_version = {
                        filename = inputs.directory.."/graphics/entity/power/solar-panel-large/base/hr-solar-panel-large-shadow.png",
                        priority = "high",
                        width = 308,
                        height = 274,
                        shift = util.by_pixel(5, 3.5),
                        draw_as_shadow = true,
                        scale = 0.5
                    }
                }
            }
        }

        -- Overwrite or create overlay table in target entity
        entity.overlay = {
            layers = {
                {
                    filename = inputs.directory.."/graphics/entity/power/solar-panel-large/base/solar-panel-large-shadow-overlay.png",
                    priority = "high",
                    width = 154,
                    height = 137,
                    shift = util.by_pixel(2.5, 1.75),
                    hr_version = {
                        filename = inputs.directory.."/graphics/entity/power/solar-panel-large/base/hr-solar-panel-large-shadow-overlay.png",
                        priority = "high",
                        width = 308,
                        height = 274,
                        shift = util.by_pixel(5, 3.5),
                        scale = 0.5
                    }
                }
            }
        }
    end

    -- Label to skip to next iteration
    ::continue::
end