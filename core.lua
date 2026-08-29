if not KryptonacidPack then
    KryptonacidPack = {}
end

SMODS.current_mod.optional_features = function()
    return {
        post_trigger = false,
        retrigger_joker = true,
        quantum_enhancements = false,
		object_weights = false,
		cardareas = {
            discard = true,
            deck = true
        }
    }
end

local global = {}

local mod_path = "" .. SMODS.current_mod.path
KryptonacidPack.path = mod_path
KryptonacidPack_config = SMODS.current_mod.config

-- i <3 copy pasting code to hack something together fuck my chud life

local files = NFS.getDirectoryItems(mod_path .. "lib")
for _, file in ipairs(files) do
	print("[KryptonacidPack] Loading library file " .. file)
	local f, err = SMODS.load_file("lib/" .. file)
	if err then
		error(err)
	end
	f()
end

local files = NFS.getDirectoryItems(mod_path .. "content")
for _, file in ipairs(files) do
	print("[KryptonacidPack] Loading lua file " .. file)
	local f, err = SMODS.load_file("content/" .. file)
	if err then
		error(err) 
	end
	f()
end

local files = NFS.getDirectoryItems(mod_path .. "jokers/1. Common")
for _, file in ipairs(files) do
	print("[KryptonacidPack] Loading Jokers " .. file)
	local f, err = SMODS.load_file("jokers/1. Common/" .. file)
	if err then
		error(err) 
	end
	f()
end

local files = NFS.getDirectoryItems(mod_path .. "jokers/2. Uncommon")
for _, file in ipairs(files) do
	print("[KryptonacidPack] Loading Jokers " .. file)
	local f, err = SMODS.load_file("jokers/2. Uncommon/" .. file)
	if err then
		error(err) 
	end
	f()
end

local files = NFS.getDirectoryItems(mod_path .. "jokers/3. Rare")
for _, file in ipairs(files) do
	print("[KryptonacidPack] Loading Jokers " .. file)
	local f, err = SMODS.load_file("jokers/3. Rare/" .. file)
	if err then
		error(err) 
	end
	f()
end

local files = NFS.getDirectoryItems(mod_path .. "jokers/4. Legendary")
for _, file in ipairs(files) do
	print("[KryptonacidPack] Loading Jokers " .. file)
	local f, err = SMODS.load_file("jokers/4. Legendary/" .. file)
	if err then
		error(err) 
	end
	f()
end
