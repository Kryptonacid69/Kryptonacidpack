SMODS.Joker {
  key = 'Possum',
  config = { extra = { Xmult = 2, dollars = 5, odds = 10 } },
  loc_txt = {
	  name = 'Possum',
	  text = {
		  "Gives {X:mult,C:white}X#1#{} Mult",
		  "Gain {C:money}$#4#{} at {C:attention}Round End{}",
		  "{C:green}#2# in #3#{} Chance to {C:attention}Destroy",
		  "Itself at end of {C:attention}Blind{}"
      }
  },
  rarity = 2,
  pos = { x = 5, y = 1 },
  atlas = 'Modtest',
  cost = 5,
  eternal_compat = false,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.Xmult, (G.GAME.probabilities.normal or 1), card.ability.extra.odds, card.ability.extra.dollars } }
	end,
	calculate = function(self, card, context)
		if context.end_of_round and context.main_eval and not context.blueprint then
		    if pseudorandom('Possum') < G.GAME.probabilities.normal / card.ability.extra.odds then
				G.E_MANAGER:add_event(Event({
					trigger = 'after',
					delay = 0.4,
					func = function()                           
						play_sound('timpani')                           
						card:juice_up(0.3, 0.5)
						SMODS.destroy_cards(card)
						return true
					end	
				}))	
			end	
		end
		if context.joker_main then
			return {
				Xmult_mod = card.ability.extra.Xmult,
				message = localize { type = 'variable',  key = 'a_xmult', vars = { card.ability.extra.Xmult } },
			}   
		end
	end,
	calc_dollar_bonus = function(self, card)
		return card.ability.extra.dollars
	end
}
