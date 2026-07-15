--[[
SMODS.Joker {
	key = 'SpicebushV2',
	loc_txt = {
		name = 'Magnificent Spring Breeze',
		text = {
			"When {C:attention}Played {}{C:Krypton_bloom}Blooming {}Cards are About to",
			"Be {C:mult}Destroyed{} by their {C:attention}Own Effect{}, They {C:purple}Score{}",
			"{X:purple,C:white}^#1#{} Mult And Lose their {C:money}Money{} Gain effect",
			"{C:attention}Convert{} the{C:attention} First{} Played Card into A {C:Krypton_bloom}Blooming Card{}",
			"{C:inactive,s:0.7}'I've always wished to be a bud, soon to burst into {C:Krypton_bloom,s:0.7,E:1}bloom{}{C:inactive,s:0.7}.'{}",
		}
	},
	rarity = 3,
	immutable = true,
	atlas = 'Modtest',
	pos = { x = 3, y = 2 },
	cost = 4,	
	config = { immutable = { Emult = 1.15 }, extra = { enhancement = "m_Krypton_Blooming" } },
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS.m_Krypton_Blooming
		return { vars = { card.ability.immutable.Emult } }
	end,
	calculate = function(self, card, context)		
		if context.before and not context.blueprint then
			local FirstBloom = context.scoring_hand[1]
			if not SMODS.has_enhancement(FirstBloom, card.ability.extra.enhancement) then
				FirstBloom:set_ability(card.ability.extra.enhancement, nil, true)
				G.E_MANAGER:add_event(Event({
					func = function()
						FirstBloom:juice_up()
						return true
					end
				}))
				return {
					message = 'Blooming!',
					color = G.C.HEX.BLOOM,
				}
			end
		end
	end,
    in_pool = function(self, args) 
        return false
    end
}
base this things art off the dongbaek background and maybe the burst of flowers when using the namesake of the joker--]]