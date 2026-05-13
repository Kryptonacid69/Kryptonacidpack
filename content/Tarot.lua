SMODS.Atlas {
	key = 'TarotAtlas',
	path = 'TarotSpritesheet.png',
	px = 71,
	py = 95
}

SMODS.Consumable {
    key = "Krypton_Random",
    set = "Tarot",
    object_type = "Consumable",
    loc_txt = {
        name = "Kryptonic Acid",
        text={
        "Creates a random",
        "{C:attention}KryptonacidPack Joker{}",
        "{C:inactive}(Must have room.){}",
		"{C:inactive,s:0.66}Shameless Self-Insert{}",
        },
    },
	pos = { x = 0, y = 0 },
	atlas = "TarotAtlas",
    unlocked = true,
    cost = 3,
    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('timpani')
                SMODS.add_card({ set = 'Krypton_KryptonJoker' })
                card:juice_up(0.3, 0.5)
                return true
            end
        }))
        delay(0.6)
    end,
    can_use = function(self, card)
        return G.jokers and #G.jokers.cards < G.jokers.config.card_limit
    end
}

SMODS.Consumable {
    key = "Krypton_GrindStone",
    set = "Tarot",
    object_type = "Consumable",
    loc_txt = {
        name = "Grindstone",
        text={
        "{X:attention,C:white}#2#X{} the {C:chips}Chip Value{} Of",
		"{C:attention}#1#{} Selected {C:inactive}Stone{{} Card(s)",
        },
    },
	config = { max_highlighted = 1, Multiplier = 2, enhancement = "m_stone" },
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS.m_stone	
		return { vars = { card.ability.max_highlighted, card.ability.Multiplier } }
	end,
	pos = { x = 1, y = 0 },
	atlas = "TarotAtlas",
    unlocked = true,
    cost = 3,
    use = function(self, card, area, copier)
		local increasechips = math.ceil(G.hand.highlighted[1]:get_chip_bonus() * (card.ability.Multiplier - 1))
		if increasechips > 0 and SMODS.has_enhancement(G.hand.highlighted[1], card.ability.enhancement) then
			G.hand.highlighted[1].ability.perma_bonus = (G.hand.highlighted[1].ability.perma_bonus or 0) + increasechips
		end		
    end,
    can_use = function(self, card)
		if #G.hand.highlighted <= card.ability.max_highlighted then
			return true
		end
    end,
	in_pool = function(self, args) 
        for _, playing_card in ipairs(G.playing_cards or {}) do
            if SMODS.has_enhancement(playing_card, 'm_stone') then
                return true
            end
        end
        return false
    end
}