SMODS.Joker {
  key = 'MichaelCatV2',
  config = { extra = { Xmult = 1.5, odds = 15, repetitions = 1 } },
  loc_txt = {
	  name = 'Shelby - Drinking',
	  text = {
		  "Gives {X:mult,C:white}X#1#{} Mult, {C:green}#2# in #3#{}",
		  "Chance to upgrade when this",
		  "{C:attention}joker triggers{}, retriggers the",
		  "{C:attention}first card{} played {C:attention}#4# time{}",
      }
  },
  rarity = 2,
  pos = { x = 8, y = 1 },
  atlas = 'Modtest',
  cost = 6,
    in_pool = function(self, args)
      return false
    end,
	loc_vars = function(self, info_queue, card)
		local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'Krypton_MichaelCatV2')		
		return { vars = { card.ability.extra.Xmult, numerator, denominator, card.ability.extra.repetitions } }
	end,
	calculate = function(self, card, context)
		if context.cardarea == G.play and context.repetition then
			if context.other_card == context.scoring_hand[1] then
				return {
					message = localize("k_again_ex"),
					repetitions = card.ability.extra.repetitions,
					card = card,
				}
			end
		end
		if context.final_scoring_step and not context.blueprint then
		    if SMODS.pseudorandom_probability(card, 'Krypton_MichaelCatV2', 1, card.ability.extra.odds) then
				G.E_MANAGER:add_event(Event({
					trigger = 'after',
					delay = 0.4,
					func = function()                           
						play_sound('timpani')
						SMODS.add_card({ set = 'joker', key = 'j_Krypton_MichaelCatV3', edition = card.edition})                            
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
	end
}
