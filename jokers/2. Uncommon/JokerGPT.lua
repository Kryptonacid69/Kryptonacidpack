SMODS.Joker {
	key = 'JokerGPT',
	loc_txt = {
		name = "JokerGPT",
		text = {
			"If {C:blue}Splash{} is present at {C:attention}End of Round{},",
			"This Joker {C:attention}Destroys{} it and creates",
			" a Random {C:dark_edition}Negative{} {C:attention}Common{} Joker",
			"{C:inactive,s:0.7}Filthy Clanker{}",
		}
	},

	config = { extra = {} },
	loc_vars = function(self, info_queue, card)	
        info_queue[#info_queue+1] = G.P_CENTERS.j_splash		
		return { vars = { card.ability.extra.Xmoney } }
	end,
	rarity = 2,
	atlas = 'Modtest',
	pos = { x = 14, y = 1},
	cost = 6,
	calculate = function(self, card, context)
		if context.end_of_round and context.main_eval then
			local AIFuel = {}
			for k, v in pairs(G.jokers.cards) do 
				if G.jokers.cards[k].config.center.pools and G.jokers.cards[k].config.center.pools.Krypton_AIFuel then
					table.insert(AIFuel, v)
				end
			end
			if #AIFuel > 0 then
				local AIFuelWinner =
					pseudorandom_element(AIFuel, pseudoseed("AIFuel"))
				SMODS.destroy_cards(AIFuelWinner)
				G.E_MANAGER:add_event(Event({
					trigger = 'after',
					delay = 0.4,
					func = function()
						play_sound('timpani')
						SMODS.add_card({ set = 'Joker', rarity = 'Common' , edition = 'e_negative' })
						card:juice_up(0.3, 0.5)
						message = 'Generated!'
						return true
					end
				}))
			end
		end
    end
}
