SMODS.Joker {
  key = 'MichaelCatV1',
  config = { extra = { mult = 10, odds = 10, oddsscale = 5 } },
  loc_txt = {
	  name = 'Shelby',
	  text = {
		  "Gives {C:mult}+#1#{} Mult",
		  "{C:green}#2# in #3#{} Chance to upgrade",
		  "when this {C:attention}joker triggers{}",
      }
  },
  rarity = 1,
  pos = { x = 7, y = 1 },
  atlas = 'Modtest',
  cost = 5,
  eternal_compat = false,
	loc_vars = function(self, info_queue, card)
		local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'Krypton_MichaelCatV1')	
		return { vars = { card.ability.extra.mult, numerator, denominator } }
	end,
	calculate = function(self, card, context)
		kittycount = 0
		for i = 1, #G.jokers.cards do
			if G.jokers.cards[i].config.center.pools and G.jokers.cards[i].config.center.pools.Krypton_MichealCats then
				kittycount = kittycount + 1
			end
		end
		if kittycount >= 2 then
			card.ability.extra.odds = card.ability.extra.oddsscale * (card.ability.extra.oddsscale ^ (kittycount - 1))
		end
		if context.final_scoring_step and not context.blueprint then
		    if SMODS.pseudorandom_probability(card, 'Krypton_MichaelCatV1', 1, card.ability.extra.odds) then
				G.E_MANAGER:add_event(Event({
					trigger = 'after',
					delay = 0.4,
					func = function()                           
						play_sound('timpani')
						SMODS.add_card({ set = 'joker', key = 'j_Krypton_MichaelCatV2', edition = card.edition})                            
						card:juice_up(0.3, 0.5)
						SMODS.destroy_cards(card)
						return true
					end	
				}))	
			end	
		end
		if context.joker_main then
			return {
			mult_mod = card.ability.extra.mult,
			message = localize { type = 'variable',  key = 'a_mult', vars = { card.ability.extra.mult } },
			}   
	    end
	end
}
