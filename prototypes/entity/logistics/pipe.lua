-- Copyright (c) 2020 Kirazy
-- Part of Reskins: Bob's Mods
--     
-- See LICENSE.md in the project directory for license information.

-- Function to reskin the base pipe
local function reskin_pipe_icon()
    reskins.lib.generate_basic_icon("pipe", false, "pipe", reskins.bobs.directory.."/graphics/icons/logistics/pipe/iron-pipe-icon.png")
    reskins.lib.generate_basic_icon("pipe-to-ground", false, "pipe-to-ground", reskins.bobs.directory.."/graphics/icons/logistics/pipe-to-ground/iron-pipe-to-ground-icon.png")
end

-- Restore vanilla pipes to their proper glory, since Bob's sprites are pre-color-correction
local function reskin_pipe_entity()
    
    data.raw["pipe"]["pipe"].pictures = pipepictures()
    data.raw["pipe-to-ground"]["pipe-to-ground"].pictures = {
        up = {
            filename = "__base__/graphics/entity/pipe-to-ground/pipe-to-ground-up.png",
            priority = "high",
            width = 64,
            height = 64,
            hr_version = {
                filename = "__base__/graphics/entity/pipe-to-ground/hr-pipe-to-ground-up.png",
                priority = "extra-high",
                width = 128,
                height = 128,
                scale = 0.5
            }
        },
        down = {
            filename = "__base__/graphics/entity/pipe-to-ground/pipe-to-ground-down.png",
            priority = "high",
            width = 64,
            height = 64,
            hr_version = {
                filename = "__base__/graphics/entity/pipe-to-ground/hr-pipe-to-ground-down.png",
                priority = "extra-high",
                width = 128,
                height = 128,
                scale = 0.5
            }
        },
        left = {
            filename = "__base__/graphics/entity/pipe-to-ground/pipe-to-ground-left.png",
            priority = "high",
            width = 64,
            height = 64,
            hr_version = {
                filename = "__base__/graphics/entity/pipe-to-ground/hr-pipe-to-ground-left.png",
                priority = "extra-high",
                width = 128,
                height = 128,
                scale = 0.5
            }
        },
        right = {
            filename = "__base__/graphics/entity/pipe-to-ground/pipe-to-ground-right.png",
            priority = "high",
            width = 64,
            height = 64,
            hr_version = {
                filename = "__base__/graphics/entity/pipe-to-ground/hr-pipe-to-ground-right.png",
                priority = "extra-high",
                width = 128,
                height = 128,
                scale = 0.5
            }
        }
    }
end

-- Check to see if reskinning needs to be done
if not mods["boblogistics"] then reskin_pipe_icon() return else reskin_pipe_entity() end
if settings.startup["reskins-bobs-do-boblogistics"].value == false then return end

-- Set input parameters
local inputs = {directory = reskins.bobs.directory}

local material_map = {
    ["copper"] = {1, "d45539"},
    ["iron"] = {1},
    ["stone"] = {1, "cfcfcf"},
    ["bronze"] = {2, "b09954"},
    ["steel"] = {2, "877c76"},
    ["plastic"] = {3, "0078ff"},
    ["brass"] = {3, "f9c854"},
    ["titanium"] = {4, "adadb2"},
    ["ceramic"] = {4, "8f7967"},
    ["tungsten"] = {4, "3b3b3b"},
    ["nitinol"] = {5, "706f6b"},
    ["copper-tungsten"] = {5, "99593d"},
}

-- Reskin pipes, create and assign extra details
for material, map in pairs(material_map) do
    -- This needs to be done earlier
    inputs.material = material

    -- Check if we're trying to work with iron
    if material == "iron" then
        goto do_icons
    end

    -- Parse map
    tier = map[1]
    tint = util.color(map[2])

    -- Fetch entities
    pipe_entity = data.raw["pipe"][material.."-pipe"]
    underground_pipe_entity =  data.raw["pipe-to-ground"][material.."-pipe-to-ground"]

    -- Check if entity exists, if not, skip this iteration; assume if we have one we have both
    if not pipe_entity then
        goto continue
    end

    -- Create explosions
    reskins.lib.create_explosion(inputs.material.."-pipe", {type = "pipe", base_entity = "pipe"})
    reskins.lib.create_explosion(inputs.material.."-pipe-to-ground", {type = "pipe-to-ground", base_entity = "pipe-to-ground"})

    -- Create particles
    reskins.lib.create_particle(inputs.material.."-pipe", "pipe", reskins.lib.particle_index["medium"], 1, tint)
    reskins.lib.create_particle(inputs.material.."-pipe", "pipe", reskins.lib.particle_index["small"], 2, tint)
    reskins.lib.create_particle(inputs.material.."-pipe-to-ground", "pipe-to-ground", reskins.lib.particle_index["medium"], 1, tint)
    reskins.lib.create_particle(inputs.material.."-pipe-to-ground", "pipe-to-ground", reskins.lib.particle_index["small"], 2, tint)

    -- Create remnants
    reskins.lib.create_remnant(inputs.material.."-pipe", {type = "pipe", base_entity = "pipe"})
    reskins.lib.create_remnant(inputs.material.."-pipe-to-ground", {type = "pipe-to-ground", base_entity = "pipe-to-ground"})

    -- Fetch remnant
    pipe_remnant = data.raw["corpse"][inputs.material.."-pipe-remnants"]
    underground_pipe_remnant = data.raw["corpse"][inputs.material.."-pipe-to-ground-remnants"]

    -- Reskin remnants
    pipe_remnant.animation = make_rotated_animation_variations_from_sheet(2, {
        filename = inputs.directory.."/graphics/entity/logistics/pipe/"..inputs.material.."/remnants/pipe-remnants.png",
        width = 61,
        height = 60,
        line_length = 1,
        frame_count = 1,
        direction_count = 2,
        shift = util.by_pixel(1.5, 2.5),
        hr_version = {
            filename = inputs.directory.."/graphics/entity/logistics/pipe/"..inputs.material.."/remnants/hr-pipe-remnants.png",
            width = 122,
            height = 120,
            line_length = 1,
            frame_count = 1,
            direction_count = 2,
            shift = util.by_pixel(1.5, 2.5),
            scale = 0.5,
        },
    })

    underground_pipe_remnant.animation = {
        filename = inputs.directory.."/graphics/entity/logistics/pipe-to-ground/"..inputs.material.."/remnants/pipe-to-ground-remnants.png",
        width = 45,
        height = 40,
        line_length = 1,
        frame_count = 1,
        direction_count = 1,
        shift = util.by_pixel(0.5, -3),
        hr_version = {
            filename = inputs.directory.."/graphics/entity/logistics/pipe-to-ground/"..inputs.material.."/remnants/hr-pipe-to-ground-remnants.png",
            width = 90,
            height = 80,
            line_length = 1,
            frame_count = 1,
            direction_count = 1,
            shift = util.by_pixel(0.5, -3),
            scale = 0.5,
        },
    }

    -- Reskin entities
    pipe_entity.pictures = reskins.bobs.pipe_pictures(inputs)
    underground_pipe_entity.pictures = reskins.bobs.underground_pipe_pictures(inputs)

    -- Label to work icons
    ::do_icons::

    -- Setup Icons
    local pipe_icon_inputs = {
        icon = inputs.directory.."/graphics/icons/logistics/pipe/"..inputs.material.."-pipe-icon.png",
        icon_picture = {
            filename = inputs.directory.."/graphics/icons/logistics/pipe/"..inputs.material.."-pipe-icon.png",
            size = 64,
            mipmaps = 4,
            scale = 0.25
        },
        icon_size = 64,
        icon_mipmaps = 4,
        type = "pipe"
    }

    local pipe_to_ground_icon_inputs = {
        icon = inputs.directory.."/graphics/icons/logistics/pipe-to-ground/"..inputs.material.."-pipe-to-ground-icon.png",
        icon_picture = {
            filename = inputs.directory.."/graphics/icons/logistics/pipe-to-ground/"..inputs.material.."-pipe-to-ground-icon.png",
            size = 64,
            mipmaps = 4,
            scale = 0.25
        },
        icon_size = 64,
        icon_mipmaps = 4,
        type = "pipe-to-ground"
    }

    -- Setup tier labels
    if settings.startup["reskins-lib-icon-tier-labeling"].value == true and settings.startup["reskins-bobs-do-pipe-tier-labeling"].value == true and tier > 0 then
        pipe_icon_inputs.icon = {{icon = pipe_icon_inputs.icon}}
        pipe_to_ground_icon_inputs.icon = {{icon = pipe_to_ground_icon_inputs.icon}}
        reskins.lib.append_tier_labels(tier, pipe_icon_inputs)
        reskins.lib.append_tier_labels(tier, pipe_to_ground_icon_inputs)
    end

    local pipe_icon_name, pipe_to_ground_icon_name
    -- Handle naming
    if material ~= "iron" then
        pipe_icon_name = inputs.material.."-pipe"
        pipe_to_ground_icon_name = inputs.material.."-pipe-to-ground"
    else
        pipe_icon_name = "pipe"
        pipe_to_ground_icon_name = "pipe-to-ground"
    end

    reskins.lib.assign_icons(pipe_icon_name, pipe_icon_inputs)
    reskins.lib.assign_icons(pipe_to_ground_icon_name, pipe_to_ground_icon_inputs)

    -- Label to skip to next iteration
    ::continue::    
end