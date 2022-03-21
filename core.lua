
-- Shrinks the visible size to 0 and removes any nametag
cloak.vanish = function (player)
    local pname = player:get_player_name()
    local attrs = player:get_properties()
    local name_attrs = player:get_nametag_attributes()

    if cloak.old_attrs[pname] ~= nil then
        return {success=false, errmsg="Player '"..pname.."' is already cloaked, try cloak.unvanish('"..pname.."') first."}
    else
        cloak.old_attrs[pname] = {
            attr = attrs,
            name = name_attrs
        }
    end

    player:set_properties({
        visual_size = {x = 0.0, y = 0.0, z = 0.0},
        make_footstep_sound = false,
        show_on_minimap = false
    })
    player:set_nametag_attributes({
        text = " ",
        color = {r = 0.0, g = 0.0, b = 0.0, a = 0.0}
    })
    cloak.log("Player '"..pname.."' is now cloaked.")
    return {success=true, errmsg=""}
end

-- Restores the players size and their nametag
cloak.unvanish = function (player)
    local pname = player:get_player_name()
    if cloak.old_attrs[pname] == nil then
        return {success=false, errmsg="Player '"..pname.."' isn't cloaked, try cloak.vanish('"..pname.."') first."}
    end
    player.set_properties(cloak.old_attrs[pname].attr)
    player.set_nametag_attributes(cloak.old_attrs[pname].name)
    cloak.old_attrs[pname] = nil
    cloak.log("Player '"..pname.."' is now uncloaked.")
end

-- Return them to uncloaked on them leaving
minetest.register_on_leaveplayer(function (player)
    local pname = player:get_player_name()
    if cloak.old_attrs[pname] ~= nil then
        cloak.unvanish(player)
    end
end)

-- Return them to uncloaked on their death
minetest.register_on_dieplayer(function(player, reason)
    local pname = player:get_player_name()
    if cloak.old_attrs[pname] ~= nil then
        cloak.unvanish(player)
    end
end)

-- Gets a list and count of players cloaked
cloak.get_vanished = function ()
    local list = ""
    local count = 0
    for player, tab in pairs(cloak.old_attrs) do
        if tab ~= nil then
            list = list .. " " .. player .. "\n"
            count = count + 1
        end
    end
    return {list = list, count = count}
end
