local upd = Game.update
function Game:update(dt)
    upd(self, dt)

    if KryptonacidPack.ticks == nil then KryptonacidPack.ticks = 0 end
    if KryptonacidPack.dtcounter == nil then KryptonacidPack.dtcounter = 0 end
    KryptonacidPack.dtcounter = KryptonacidPack.dtcounter+dt
    KryptonacidPack.dt = dt

    while KryptonacidPack.dtcounter >= 0.010 do
        KryptonacidPack.ticks = KryptonacidPack.ticks + 1
        KryptonacidPack.dtcounter = KryptonacidPack.dtcounter - 0.010
        if G.jumpscare and G.jumpscare > 0 then G.jumpscare = G.jumpscare - 1 end
		if G.jumpscare2 and G.jumpscare2 > 0 then G.jumpscare2 = G.jumpscare2 - 1 end
		if G.jumpscare3 and G.jumpscare3 > 0 then G.jumpscare3 = G.jumpscare3 - 1 end
    end
end

local drawhook = love.draw
function love.draw()
    drawhook()

	function ImageLoader(fn)
        local full_path = (KryptonacidPack.path .. "customimages/" .. fn)
        local file_data = assert(NFS.newFileData(full_path),("Epic fail"))
        local tempimagedata = assert(love.image.newImageData(file_data),("Epic fail 2"))
        return (assert(love.graphics.newImage(tempimagedata),("Epic fail 3")))
    end
	
	local _xscale = love.graphics.getWidth()/1920
    local _yscale = love.graphics.getHeight()/1080
	
	if G.jumpscare and (G.jumpscare > 0) then
        if KryptonacidPack.Jumpscare == nil then KryptonacidPack.Jumpscare = ImageLoader("jumpscare_1.png") end
        love.graphics.setColor(1, 1, 1, 1) 
        love.graphics.draw(KryptonacidPack.Jumpscare, 0*_xscale*2, 0*_yscale*2,0,_xscale*2*2,_yscale*2*2)
    end
	
	if G.jumpscare2 and (G.jumpscare2 > 0) then
        if KryptonacidPack.Jumpscare2 == nil then KryptonacidPack.Jumpscare2 = ImageLoader("jumpscare_2.png") end
        love.graphics.setColor(1, 1, 1, 1) 
        love.graphics.draw(KryptonacidPack.Jumpscare2, 0*_xscale*2, 0*_yscale*2,0,_xscale*2*2,_yscale*2*2)
    end
	if G.jumpscare3 and (G.jumpscare3 > 0) then
        if KryptonacidPack.Jumpscare3 == nil then KryptonacidPack.Jumpscare3 = ImageLoader("jumpscare_3.png") end
        love.graphics.setColor(1, 1, 1, 0.725) 
        love.graphics.draw(KryptonacidPack.Jumpscare3, 0*_xscale*2, 0*_yscale*2,0,_xscale*2*2,_yscale*2*2)
    end
end
--[[
local StayTheStill = CardArea.add_to_highlighted
function CardArea:add_to_highlighted(card, silent, ...)
	if card.config.center.key == "j_Krypton_LiamCat" or card.config.center.key == "j_Krypton_UltimaJungle" and self == G.jokers then 
		return nil 
	end    	 
    return StayTheStill(self, card, silent, ...)
end
--]]

local lcpref = Controller.L_cursor_press
function Controller:L_cursor_press(x, y)
    lcpref(self, x, y)
    if G and G.jokers and G.jokers.cards and not G.SETTINGS.paused then
        SMODS.calculate_context({ MouseClick = true })
    end
end

--- @param obj Moveable|table
function KryptonacidPack.force_hover_desc_update(obj)
    if obj.states.hover.is and obj.discovered ~= false and obj.locked ~= false then
        obj:stop_hover()
        obj:hover()
    end
end