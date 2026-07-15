SMODS.Joker {
  key = 'Aeonglass',
  config = { extra = { CardsPlayed = 6, Hands = 1, XmultScale = 0.05, ChipsScale = 5 } },
  loc_txt = {
	  name = "Aeonglass",
	  text = {
		  "Every {C:attention}6{} {C:inactive}[#1#]{} Card(s) Played, {C:attention}Convert{} a {C:attention}Random{}",
		  "{C:attention}Card{} in your {C:attention}Deck{} into a {C:green}Withered{} Card.",
		  "Every {C:attention}3{} {C:inactive}[#2#]{} Hand(s) played, Increase the {X:mult,C:white}XMult{} and {C:chips}Chips{}",
		  "Of {C:attention}ALL{} {C:green}Withered{} Cards by {X:mult,C:white}X#3#{} Mult And {C:chips}+#4#{} Chips",
      }
  },
  rarity = 2,
  pos = { x = 6, y = 2 },
  atlas = 'Modtest',
  cost = 5,
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue+1] = G.P_CENTERS.m_Krypton_Withered
		return { vars = { card.ability.extra.CardsPlayed, card.ability.extra.Hands, card.ability.extra.XmultScale, card.ability.extra.ChipsScale } }
	end,
	calculate = function(self, card, context)	
		if context.individual and context.cardarea == G.play then
			card.ability.extra.CardsPlayed = card.ability.extra.CardsPlayed - 1
		end
		if card.ability.extra.CardsPlayed <= 0 and context.final_scoring_step then
			local card = pseudorandom_element(G.playing_cards, 'seed')
				card:set_ability('m_Krypton_Withered')
			card.ability.extra.CardsPlayed = 6
		end
		if context.joker_main then
			card.ability.extra.Hands = card.ability.extra.Hands - 1
		end
		if card.ability.extra.Hands >= 0 then
			--[[for k, v in pairs(G.playing_cards) do
				if v.config.center.key == 'm_Krypton_Withered' then
					--scale card somehow
				end
			end--]]
			card.ability.extra.Hands = 1
		end
	end	
}