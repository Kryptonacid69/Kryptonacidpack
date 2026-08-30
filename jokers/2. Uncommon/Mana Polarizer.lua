SMODS.Joker {
	key = 'Mana_Polarizer',
	loc_txt = {
		name = 'Mana Polarizer',
		text = {
			"{C:attention}Stone Cards{} Score",
			"Additional {C:mult}+Mult{} {C:attention}Equal{}",
			"To Their {C:chips}Chip Value{}",
		}
	},
	config = { extra = { enhancement = "m_stone" } },
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS.m_stone		
	end,
	rarity = 2,
	immutable = true,
	atlas = 'Modtest',
	pos = { x = 3, y = 2 },
	cost = 4,
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play then
			if SMODS.has_enhancement(context.other_card, card.ability.extra.enhancement) then			
				return {
					mult = context.other_card:get_chip_bonus(),
				}
			end
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
