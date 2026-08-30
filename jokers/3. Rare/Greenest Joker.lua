SMODS.Joker {
	key = 'GreenestJoker',
	loc_txt = {
		name = 'Greenest Joker',
		text = {
			"{X:mult,C:white} X#1# {} Mult",
		}
	},
	config = { extra = { Xmult = 3.5 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.Xmult } }
	end,
	rarity = 3,
	atlas = 'Modtest',
	pos = { x = 11, y = 0 },
	cost = 10,
	calculate = function(self, card, context)
		if context.joker_main then
			return {
				Xmult_mod = card.ability.extra.Xmult,
				message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.Xmult } }		
			}
		end
	end
}
