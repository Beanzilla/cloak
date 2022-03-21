
minetest.register_privilege("cloak", {
    description = "Unlocks the /cloak chat command",
    give_to_singleplayer = true -- Given to singleplayers by default
})

minetest.register_privilege("cloak_admin", {
    description = "Unlocks the /cloak_list chat command to list players cloaked",
    give_to_singleplayer = true -- Given to singleplayers by default
})
