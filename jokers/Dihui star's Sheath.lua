SMODS.Joker {
	key = 'DihuiBlade',
	loc_txt = {
		name = "Dihui star's Sheath",
		text = {
			"All {C:Krypton_bladetrail}Bladetrail{} Cards Score {C:attention}Bonus{}",
			"{X:chips,C:white}XChips{} Equal to their {X:mult,C:white}XMult{}",
			"{C:inactive,s:0.7}'. . .  I'm weary of this stigma of a blade.'{}",
		}
	},

	config = { extra = { repetitions = 1 } },
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS.m_Krypton_BladeTrailCard		
		return { vars = { card.ability.extra.repetitions } }
	end,
	rarity = 2,
	atlas = 'Modtest',
	pos = { x = 8, y = 0},
	cost = 6,
    in_pool = function(self, args) 
        for _, playing_card in ipairs(G.playing_cards or {}) do
            if SMODS.has_enhancement(playing_card, 'm_Krypton_BladeTrailCard') then
                return true
            end
        end
        return false
    end
}
