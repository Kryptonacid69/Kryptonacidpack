SMODS.Joker {
    key = "bettingonanout",
    config = {
        extra = {
            odds = 1000
        }
    },
    loc_txt = {
        name = 'Betting on an out',
        text = {
			'{C:green} #1# in #2# {}Chance to Create a',
			'{C:dark_edition}Negative Soul{} Card When {C:attention}Cards Score{}',
			'{C:inactive}(Self destructs){}'
        },
    },
    pos = { x = 1, y = 0},
    cost = 0,
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = false,
    unlocked = true,
    discovered = true,
    atlas = 'Modtest',
    
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS.c_soul
		local new_numerator, new_denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'j_Krypton_bettingonanout') 
        return {vars = {new_numerator, new_denominator}}
    end,
    
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play  then
            if true then
                if SMODS.pseudorandom_probability(card, '1', 1, card.ability.extra.odds, 'j_Krypton_bettingonanout', false) then
                    for i = 1, 1 do
                        G.E_MANAGER:add_event(Event({
                            delay = 0.4,
                            func = function()                           
                                play_sound('timpani')
								SMODS.add_card({ set = 'Spectral', key = 'c_soul', edition = 'e_negative'})                            
                                card:juice_up(0.3, 0.5)
								SMODS.destroy_cards(card)
								return true
                            end
                        }))
                    end
					return {
					    message = 'GAMBA!!!!'
					}
                end
            end
        end
    end
}