SMODS.Joker {
  key = 'WEARESOBACK!ITSSOOVER!',
  config = { extra = { mult = 20, odds = 2 } },
  loc_txt = {
	  name = 'Slot Machine',
	  text = {
		  "Grants {C:mult}+#1#{} Mult, and {C:green}#2# in #3#{} to Double Mult",
		  "Else, Half Mult when {C:attention}Blind{} is selected",
		  "{C:inactive}Its Gamble 'o' clock{}",
      }
  },
  rarity = 2,
  pos = { x = 11, y = 1 },
  atlas = 'Modtest',
  cost = 6,
   
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.mult, (G.GAME.probabilities.normal), card.ability.extra.odds, } }
	end,
	calculate = function(self, card, context)
		if context.joker_main then
			return { mult = card.ability.extra.mult}
		end
		if pseudorandom('WEARESOBACK!ITSSOOVER!') <= G.GAME.probabilities.normal / card.ability.extra.odds then
			if context.setting_blind and context.main_eval then
				card.ability.extra.mult = (card.ability.extra.mult * 2)
				return {
					message = "I Cant Stop Winning!",
					colour = G.C.MULT,
				}
			end
		else
			if context.setting_blind and context.main_eval then	
				card.ability.extra.mult = (card.ability.extra.mult/2)
				return {
					message = 'Aw Dangit.',
					colour = G.C.MULT,
				}
			end	
        end			
	end	
}
