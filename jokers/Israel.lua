SMODS.Joker {
	key = 'Israel',
	loc_txt = {
		name = "Israel",
		text = {
			"Stores {C:attention}ALL{} {C:money}Money{} Gained.",
			"Gain {C:attention}Sell Value{} Equal to",
			"{X:money,C:white}#1#X{} Stored {C:money}Money{}",
			"{C:inactive,s:0.65}Your money was promised{}",
			"{C:inactive,s:0.65}to it 3000 years ago.{}",
		}
	},
	eternal_compat = false,
	config = { extra = { Xmoney = 3, StoredMoney = 0} },
	loc_vars = function(self, info_queue, card)	
		return { vars = { card.ability.extra.Xmoney } }
	end,
	rarity = 3,
	atlas = 'Modtest',
	pos = { x = 13, y = 1},
	cost = 10,
	calculate = function(self, card, context)
		if to_big(G.GAME.dollars) >= to_big(0) then
			card.ability.extra_value = card.ability.extra_value + (G.GAME.dollars * card.ability.extra.Xmoney)
            card:set_cost()
			G.GAME.dollars = 0
		end
    end,
}
