SMODS.Joker {
  key = 'MichaelCatV4',
  config = { extra = { emult = 1.25, repetitions = 1 } },
  loc_txt = {
	  name = 'Shelby - Loaf',
	  text = {
		  "Gives {X:purple,C:white}^#1#{} Mult",
		  "Retrigger{C:attention} ALL {}cards",
		  "{C:attention}#2#{} Time",
		  "{C:inactive,s:0.6}Penultimate.{}",
      }
  },
  rarity = 4,
  pos = { x = 9, y = 1 },
  atlas = 'Modtest',
  cost = 20,
    in_pool = function(self, args)
      return false
    end,   
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.emult, card.ability.extra.repetitions } }
	end,
	calculate = function(self, card, context)
		if context.cardarea == G.play and context.repetition then
			return {
				message = localize("k_again_ex"),
				repetitions = card.ability.extra.repetitions,
				card = card,
			}
		end	
		if context.cardarea == G.hand and context.repetition then
			return {
				message = localize("k_again_ex"),
				repetitions = card.ability.extra.repetitions,
				card = card,
			}
		end		
		if context.joker_main then	
			return {
			emult = card.ability.extra.emult,
			remove_default_message = true,
			message = ('^' .. card.ability.extra.emult),
			colour = G.C.PURPLE,
			sound = 'Krypton_emult',
			}   
	    end
	end
}