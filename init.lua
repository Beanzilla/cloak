
cloak = {}

cloak.version = "1.0.0"

cloak.log = function (msg)
    if type(msg) == "table" or type(msg) == "userdata" then
        msg = minetest.serialize(msg)
    end
    minetest.log("action", "[cloak] " .. tostring(msg))
end

cloak.dofile = function (filename)
    local modpath = minetest.get_modpath(minetest.get_current_modname())
    dofile(modpath .. DIR_DELIM .. filename .. ".lua")
end

-- To store our players old attributes
cloak.old_attrs = {}

cloak.dofile("core") -- The actual cloak and uncloak function
cloak.dofile("priv") -- The privs (cloak, cloak_admin)
cloak.dofile("chat") -- The chat commands ("/cloak", "/cloak_list")

cloak.log("Version: ".. cloak.version)

