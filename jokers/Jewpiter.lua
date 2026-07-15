SMODS.Joker {
	key = 'JewPiter',
	loc_txt = {
		name = 'Jewpiter',
		text = {
			'If {C:attention}Poker Hand{} Is a {C:attention}Flush,{}',
			'Earn {C:money}$#1#{} And increase payout by {C:money}$#2#{}',
			'{C:attention}Increase{} by {C:money}$#3#{} If {C:attention}Poker hand{} is a',
			'{C:attention}Straight Flush{} Instead, And Payout {X:money,C:white}#4#X{}',
			'{C:inactive,s:0.9}(Resets on Non-Flush Containing Hand){}'
		}
	},
	config = { extra = { Dollars = 1, FlushIncrease = 1, StraightFlushIncrease = 2, XDollars = 2 } },
	rarity = 2,
	cost = 7,
	atlas = 'Modtest',
	pos = { x = 1, y = 2},
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.Dollars, card.ability.extra.FlushIncrease, card.ability.extra.StraightFlushIncrease, card.ability.extra.XDollars } }
	end,
	calculate = function(self, card, context)
		if context.before and (context.scoring_name == 'Flush') then
			card.ability.extra.Dollars = card.ability.extra.Dollars + card.ability.extra.FlushIncrease
			return {
				message = 'Upgrade!',
				color = G.C.MONEY,
			}
		end
		if context.joker_main and (context.scoring_name == 'Flush') then
			return {
				dollars = card.ability.extra.Dollars,
			}
		end
		if context.before and (context.scoring_name == 'Straight Flush') then
			card.ability.extra.Dollars = card.ability.extra.Dollars + card.ability.extra.StraightFlushIncrease
			return {
				message = 'Upgrade!',
				color = G.C.MONEY,
			}
		end
		if context.joker_main and (context.scoring_name == 'Straight Flush') then
			return {
				dollars = (card.ability.extra.Dollars * card.ability.extra.XDollars),
			}
		end
		if context.final_scoring_step and not (context.scoring_name == 'Flush' or context.scoring_name == 'Straight Flush' or context.scoring_name == 'Flush Five' or context.scoring_name == 'Flush House') and card.ability.extra.Dollars > 1 then
		    card.ability.extra.Dollars = 1
			return {	
				message = 'Reset',
				color = G.C.MONEY,
			}
		end
	end,
}
