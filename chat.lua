
-- Toggles if the issuing player is cloaked or uncloaked
minetest.register_chatcommand("cloak", {
    privs = {
        interact = true,
        cloak = true -- Require our cloak priv
    },
    func = function(name, param)
        local player = minetest.get_player_by_name(name) or nil
        if player == nil then
            return false, "You need to be online to issue this command."
        end
        -- Toggle cloaked or uncloaked
        if cloak.old_attrs[name] ~= nil then
            -- Already cloaked so uncloak
            local r = cloak.unvanish(player)
            if r.success ~= true then
                return false, r.errmsg
            else
                return true, "Uncloaked!"
            end
        else
            -- Uncloaked so cloak
            local r = cloak.vanish(player)
            if r.success ~= true then
                return false, r.errmsg
            else
                return true, "Cloaked!"
            end
        end
    end,
})

-- Makes the list of cloaked players giving it to the player issuing this command
minetest.register_chatcommand("cloak_list", {
    privs = {
        interact = true,
        cloak_admin = true
    },
    func = function (name, param)
        local r = cloak.get_vanished()
        return true, "Cloaked: "..tostring(r.count).."\n"..r.list
    end
})
