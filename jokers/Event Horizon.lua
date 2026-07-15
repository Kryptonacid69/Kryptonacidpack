SMODS.Joker {
	key = 'Event_Horizon',
	loc_txt = {
		name = 'Event Horizon',
		text = {
			'At {C:attention}Round end{}, Destroys {C:attention}Adjacent{} Jokers,',
			'And Scales the {C:Krypton_stats}Stats{} of {C:attention}all{} other Jokers by',
			'{X:Krypton_stats,C:white}X#1#{} / The {C:attention} Jokers{} being Scaled by this effect',
			'{C:inactive}(Currently{} {X:Krypton_stats,C:white}X#2#{} {C:Krypton_stats}Stats{}{C:inactive}){}',
		}
	},
	config = { extra = { increase = 0.1, TotalIncrease = 1.1 } },
	rarity = 3,
	eternal_compat = false,
	cost = 11,
	atlas = 'Modtest',
	pos = { x = 0, y = 2},
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.increase, card.ability.extra.TotalIncrease } }
	end,
	calculate = function(self, card, context)
		if context.end_of_round and context.main_eval then
			local Left_Jonkler
			local Right_Jonkler
			local check = false
			for i, v in ipairs(G.jokers.cards) do
				if v == card then
					Right_Jonkler = G.jokers.cards[i + 1]
					Left_Jonkler = G.jokers.cards[i - 1]
					break
				end
			end
			local Count = 0
			if (Left_Jonkler and Left_Jonkler ~= card) then
				SMODS.destroy_cards(Left_Jonkler)
				Count = Count + 1
			end
			if (Right_Jonkler and Right_Jonkler ~= card) then
				SMODS.destroy_cards(Right_Jonkler)
				Count = Count + 1
			end
			local TableToBeScaled = {}
			for k, v in pairs(G.jokers.cards) do
				if not Right_Jonkler or Left_Jonkler or self.key then
					table.insert(TableToBeScaled, v)
				end
			end
			if Count > 0 and context.main_eval then
				local TotalJokers = #G.jokers.cards - #TableToBeScaled
				card.ability.extra.TotalIncrease = (card.ability.extra.increase / (TotalJokers * Count))
				for k, v in pairs(TableToBeScaled) do
					if v ~= self.key then
						if not Card.no(v, "immutable", true) then
							KryptonacidPack.manipulate(v, { value = card.ability.extra.TotalIncrease })
							check = true	
							Count = 0
						end
					end
				end

				if check then
					card_eval_status_text(
						card,
						"extra",
						nil,
						nil,
						nil,
						{ message = localize("k_upgrade_ex"), colour = G.C.GREEN }
					)	
				end
			end
		end
	end,
}
