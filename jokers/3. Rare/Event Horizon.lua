SMODS.Joker {
	key = 'Event_Horizon',
	loc_txt = {
		name = 'Event Horizon',
		text = {
			'{C:green}Jokers{} to {C:attention}either side{} of this are',
			'{C:mult}Destroyed{} at {C:attention}Round start{} and this {C:green}Jokers{} {C:krypton_stats}stats{}', 
			'are {C:krypton_stats}Multiplied{} By their total {C:money}sell value{}{C:green} / 2{}',
			'{C:inactive}(Currently {C:white,X:mult}X#1#{}{C:inactive} Mult)'
		}
	},
	config = { extra = { Xmult = 1.5 } },
	rarity = 3,
	eternal_compat = false,
	cost = 11,
	atlas = 'Modtest',
	pos = { x = 0, y = 2},
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.Xmult } }
	end,
	calculate = function(self, card, context)
		if context.setting_blind and not context.blueprint then
            local my_pos = nil
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i] == card then
                    my_pos = i
                    break
                end
            end
            if my_pos and G.jokers.cards[my_pos + 1] and not SMODS.is_eternal(G.jokers.cards[my_pos + 1], card) and not G.jokers.cards[my_pos + 1].getting_sliced and G.jokers.cards[my_pos - 1] and not SMODS.is_eternal(G.jokers.cards[my_pos - 1], card) and not G.jokers.cards[my_pos - 1].getting_sliced then
                local front_card = G.jokers.cards[my_pos + 1]
				local back_card = G.jokers.cards[my_pos - 1]
                front_card.getting_sliced = true 
				back_card.getting_sliced = true
                G.GAME.joker_buffer = G.GAME.joker_buffer - 2
                G.E_MANAGER:add_event(Event({
                    func = function()
                        G.GAME.joker_buffer = 0
                        card.ability.extra.Xmult = card.ability.extra.Xmult * ((front_card.sell_cost + back_card.sell_cost)/ 2)
                        card:juice_up(0.8, 0.8)
						front_card:start_dissolve({ HEX("821d82") }, nil, 1.6)
						back_card:start_dissolve({ HEX("821d82") }, nil, 1.6)
                        play_sound('Krypton_VoidImplode', 0.96 + math.random() * 0.08)
                        return true
                    end
                }))			
			end
			if context.joker_main then
				return {
					xmult = card.ability.extra.Xmult
				}
			end	
		end
	end,
}

-- jokers either side of this are destroyed at round end, and this jokers
-- Xmult is times by their ((sell value / 2) +1)
-- Starts at 1.5x mult