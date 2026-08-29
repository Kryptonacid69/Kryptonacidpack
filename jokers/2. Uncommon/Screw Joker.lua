SMODS.Joker {
  key = 'SCREWSCREWSCREW',
  config = { extra = { chips = 25, chip_gain = 0 } },
  loc_txt = {
	  name = 'Screw Joker',
	  text = {
		 "Gains Half its Chips {C:inactive}({}{C:chips}+#3#{}{C:inactive}){}",
		 "As Chips After the {C:attention}Boss Blind{}",
		 "{C:inactive}(Currently {}{C:chips}+#1#{}{C:inactive} Chips){}",
      }
  },
  rarity = 2,
  pos = { x = 6, y = 1 },
  atlas = 'Modtest',
  cost = 8,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.chips, card.ability.extra.chip_gain, (card.ability.extra.chips/2) } }
	end,
	calculate = function(self, card, context)
		if context.joker_main then
			return {
                chips = card.ability.extra.chips,
                chip_message = {
                    message = localize { type = 'variable', key = 'a_chips', vars = { card.ability.extra.chips } },
					colour = G.C.CHIPS
				}
			}
		end
		local chips = card.ability.extra.chips
		if not context.blueprint and context.end_of_round and G.GAME.blind.boss and context.main_eval then
			card.ability.extra.chips = card.ability.extra.chips + (chips/2)
			return {
				message = 'Screwed!',
				colour = G.C.CHIPS,
			}
		end
	end
}
