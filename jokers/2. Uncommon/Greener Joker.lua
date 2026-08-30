SMODS.Joker {
	key = 'UncommonJoker',
	loc_txt = {
		name = 'Greener Joker',
		text = {
			"{C:mult}+#1#{} Mult"
		}
	},
	config = { extra = { mult = 20 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.mult } }
	end,
	rarity = 2,
	atlas = 'Modtest',
	pos = { x = 10, y = 0 },
	cost = 4,
	calculate = function(self, card, context)
		if context.joker_main then
			return {
				mult_mod = card.ability.extra.mult,
				message = localize { type = 'variable',  key = 'a_mult', vars = { card.ability.extra.mult } }
			}
		end
	end
}
