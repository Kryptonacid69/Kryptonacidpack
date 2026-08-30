SMODS.Joker {
  key = 'Aeonglass',
  config = { extra = { CardsPlayed = 6, Hands = 3, Mult = 3, Chips = 6, MultScale = 3, ChipsScale = 6, MulterScale = 3, ChipserScale = 6, reducer = 1 } },
  loc_txt = {
	  name = "Aeonglass",
	  text = {
		  "Every {C:attention}#8#{} {C:inactive}[#1#]{} cards {C:attention}scored{}, This Joker",
		  "{C:attention}gains{} {C:chips}+#6#{} Chips and {C:mult}+#5#{} Mult",
		  "Every {C:attention}#7#{} {C:inactive}[#2#]{} {C:attention}Hands{} played, {C:attention}increase{} the",
		  "gain by {C:chips}+#8#{} Chips and {C:mult}+#7#{} Mult",
		  "{C:inactive}(Currently{}{}{C:chips} +#4#{}{C:inactive} Chips and{C:mult} +#3#{} {C:inactive}Mult){}"
      }
  },
  rarity = 2,
  pos = { x = 6, y = 2 },
  atlas = 'Modtest',
  cost = 5,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.CardsPlayed,  card.ability.extra.Hands, card.ability.extra.Mult, card.ability.extra.Chips, 
					card.ability.extra.MultScale, card.ability.extra.ChipsScale, card.ability.extra.MulterScale, card.ability.extra.ChipserScale} }
	end,
	calculate = function(self, card, context)	
		if context.individual and context.cardarea == G.play then
			card.ability.extra.CardsPlayed = card.ability.extra.CardsPlayed - card.ability.extra.reducer
		end
		if card.ability.extra.CardsPlayed <= 0 and context.final_scoring_step then
			card.ability.extra.Mult = card.ability.extra.Mult + card.ability.extra.MultScale
			card.ability.extra.Chips = card.ability.extra.Chips + card.ability.extra.ChipsScale			
			card.ability.extra.CardsPlayed = card.ability.extra.ChipserScale
		end
		if context.joker_main then
			card.ability.extra.Hands = card.ability.extra.Hands - card.ability.extra.reducer
			return {
				mult = card.ability.extra.Mult,
				chips = card.ability.extra.Chips
			}
		end
		if card.ability.extra.Hands <= 0 then
			card.ability.extra.MultScale = card.ability.extra.MultScale + card.ability.extra.MulterScale
			card.ability.extra.ChipsScale = card.ability.extra.ChipsScale + card.ability.extra.ChipserScale
			card.ability.extra.Hands = card.ability.extra.MulterScale
		end
	end	
}

-- every 6 cards played, gain +3 mult and +6 chips
-- every 3 hands scored, increase the amount by +3 and +6 respectively