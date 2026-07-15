SMODS.Joker {
  key = 'Obese_Joker',
  rarity = 3,
  pos = { x = 4, y = 1 },
  config = { extra = { Xmult = 1.1, Scalar = 0.04, odds = 5 } },
  loc_txt = {
      name = 'Obese Joker',
	  text = {
		  "All cards score {X:mult,C:white}X#1#{} But,",
          "{C:green} #2# in #3# {}chance Cards Scored",
		  "Are {C:attention}Eaten{}, And Gains",
		  "{X:mult,C:white}X#4#{} Per Card {C:attention}Eaten{}"
    }
  },
  atlas = 'Modtest',
  cost = 10,
  unlocked = true,
  discovered = true,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,

	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.Xmult, (G.GAME.probabilities.normal or 1), card.ability.extra.odds, card.ability.extra.Scalar } }
	end,
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play then
				return {
					Xmult = card.ability.extra.Xmult,
				}
			end		
		
		if not context.blueprint and context.after and context.main_eval and pseudorandom('Obese_Joker') < G.GAME.probabilities.normal / card.ability.extra.odds then
          local destroyed_cards = {}		  
	      if pseudorandom('Obese_Joker') < G.GAME.probabilities.normal / card.ability.extra.odds then
			for _, v in ipairs(G.play.cards) do
				destroyed_cards[#destroyed_cards + 1] = v
				card.ability.extra.Xmult = card.ability.extra.Xmult + card.ability.extra.Scalar
			end
			SMODS.destroy_cards(destroyed_cards)
		    return {
				message = 'Eaten!',
			}
		  end
		end
	end
    
}
