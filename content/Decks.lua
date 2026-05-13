SMODS.Atlas {
	key = "Decks",
	path = "DecksSpritesheet.png",
	px = 71,
	py = 95
}


SMODS.Back {
    key = "sisyphus",
    pos = { x = 0, y = 0 },
    unlocked = true,
	loc_txt = {
		name = 'Sisyphus Deck',
		text = {
			"Add a {C:dark_edition}Negative{}{C:attention} Hanged man{}",
			"And a {C:inactive}Stone{} {C:attention}card{} to deck",
			"After {C:attention}Beating{} a {C:blue}Blind{}",
			'{C:inactive,s:0.75}"One must Imagine Jimbo Happy."{}',
		}
	},
	atlas = 'Decks',
    calculate = function(self, back, context)
		if context.end_of_round and context.main_eval then
            local stone_card = SMODS.add_card { set = "Base", enhancement = "m_stone", area = G.deck }
			G.E_MANAGER:add_event(Event({
                func = function()
					SMODS.add_card({ set = 'Tarot', key = 'c_hanged_man', edition = 'e_negative'})
                    return true
                end
            }))
			return {
                message = localize('k_plus_stone'),
                colour = G.C.SECONDARY_SET.Enhanced,
                func = function()
                    SMODS.calculate_context({ playing_card_added = true, cards = { stone_card } })
                end
            }			
        end
    end
}