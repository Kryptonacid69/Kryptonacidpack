if not KryptonacidPack then
    KryptonacidPack = {}
end

SMODS.current_mod.optional_features = {
	retrigger_joker = true,
}

local global = {}

local mod_path = "" .. SMODS.current_mod.path
KryptonacidPack.path = mod_path
KryptonacidPack_config = SMODS.current_mod.config

local files = NFS.getDirectoryItems(mod_path .. "content")
for _, file in ipairs(files) do
	print("[KryptonacidPack] Loading lua file " .. file)
	local f, err = SMODS.load_file("content/" .. file)
	if err then
		error(err) 
	end
	f()
end