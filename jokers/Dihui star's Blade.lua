SMODS.Joker {
	key = 'DihuiBladeSword',
	loc_txt = {
		name = "Dihui star's Blade",
		text = {
			"{C:attention}Retrigger {}all {C:Krypton_bladetrail}Bladetrail Cards {}{C:attention}#1#{} time(s).",
			"{C:inactive,s:0.7}Lacerating Afterimages from Myriad Moments{}",
		}
	},

	config = { extra = { repetitions = 1 } },
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS.m_Krypton_BladeTrailCard		
		return { vars = { card.ability.extra.repetitions } }
	end,
	rarity = 3,
	atlas = 'Modtest',
	pos = { x = 7, y = 0},
	cost = 8,
	calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play and SMODS.get_enhancements(context.other_card)["m_Krypton_BladeTrailCard"] == true then
            return {
                message = localize('k_again_ex'),
                repetitions = 1,
                card = card
            }
		end
	end,
    in_pool = function(self, args) 
        for _, playing_card in ipairs(G.playing_cards or {}) do
            if SMODS.has_enhancement(playing_card, 'm_Krypton_BladeTrailCard') then
                return true
            end
        end
        return false
    end
}
