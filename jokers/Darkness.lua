SMODS.Joker{
  key = 'Darkness',
  atlas = 'Modtest',
  loc_txt = {
	  name = 'Darkness',
	  text = {
		  "Gains {C:mult}+#2#{} Mult played hand is not{C:attention} Pair{}",
		  "Evokes all Mult when playing{C:attention} Pair{}",
		  "{C:inactive}(Currently {}{C:mult}+#1#{}{C:inactive} Mult){}"
      }
  },
  rarity = 1,
  cost = 4,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = false,
  pos = { x = 5, y = 0 },
  config = { extra = { MultMod = 16, mult = 0 } },
	
	loc_vars = function(self,info_queue,card)
		return {vars = {card.ability.extra.mult, card.ability.extra.MultMod}}
	end,
	
	calculate = function(self,card,context)
		if context.before and not (context.scoring_name == 'Pair') and not context.blueprint then
			card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.MultMod
			return {
				message = 'Upgrade!',
				color = G.C.MULT,
			}
		end
		if context.joker_main and (context.scoring_name == 'Pair') then
			return {
				mult_mod = card.ability.extra.mult,
				message = 'Evoked!',
				color = G.C.MULT,
			}
		end
		if context.final_scoring_step and (context.scoring_name == 'Pair') then
		    card.ability.extra.mult = 0
		end
	end,
}