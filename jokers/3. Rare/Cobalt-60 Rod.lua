SMODS.Joker {
	key = 'Cobalt60Rod',
	loc_txt = {
		name = 'Cobalt-60 Rod',
		text = {
			"Retrigger{C:attention} ALL{} Stone Cards {C:attention}#1#{} Time.",
			"For each {C:attention}Consecutive{} Hand That Contains a",
			"{C:inactive}Stone{} Card, Increase {C:purple}Power{} {C:chips}Chips{} by {X:purple,C:white}^#3#{}",
			"{C:inactive}(Currently{} {X:purple,C:white}^#2#{}{C:inactive} Mult){}",
			"{C:inactive,s:0.7}Why can't i get a good ghoto of{}{C:inactive,s:0.78,E:1} IT{}",
		}
	},
	config = { extra = { repetitions = 1, echips = 1, echipsscalar = 0.01, enhancement = "m_stone", original = 1 } },
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS.m_stone	
		return { vars = { card.ability.extra.repetitions , card.ability.extra.echips , card.ability.extra.echipsscalar } }
	end,
	rarity = 3,
	atlas = 'Modtest',
	pos = { x = 5, y = 2 },
	cost = 10,
	pixel_size = { w = 24, h = 90 },
	calculate = function(self, card, context)			
		if context.before and not context.blueprint then
			local stone_found = false
			for i = 1, #context.scoring_hand do
				if SMODS.has_enhancement(context.scoring_hand[i], card.ability.extra.enhancement) then
					stone_found = true
				end
			end
			if stone_found == true then
				card.ability.extra.echips = card.ability.extra.echips + card.ability.extra.echipsscalar
				return {
					message = 'Upgrade',
					colour = G.C.PURPLE,
				}
			else
				card.ability.extra.echips = card.ability.extra.original
				return {	
					message = 'Reset',
					colour = G.C.PURPLE,				
				}
			end		
		end
		if context.cardarea == G.play and context.repetition then
			return {
				message = localize("k_again_ex"),
				repetitions = card.ability.extra.repetitions,
			}
		end	
		if context.joker_main then	
			return {
				echips = card.ability.extra.echips,
				remove_default_message = true,
				message = ('^' .. card.ability.extra.echips),
				colour = G.C.PURPLE,
				sound = 'Krypton_echips',
			}   
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