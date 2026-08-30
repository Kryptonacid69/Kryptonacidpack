SMODS.Joker {
	key = 'GreenSquare',
	loc_txt = {
		name = 'Green Square',
		text = {
			"{X:purple,C:white} ^#1# {} Mult, Increases by {X:purple,C:white} ^#2# {}",
			" For each {C:Krypton_green}Green Joker{} owned",
			"{C:inactive}(Currently {X:purple,C:white}^#3#{C:inactive} Mult)"
		}
	},
	config = { extra = { emult = 1.2, emult_mod = 0.4, emulttotal = 1.2 } },
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = {key = 'Krypton_GreenSquareloctext', set = 'Other'}
		return { vars = { card.ability.extra.emult, card.ability.extra.emult_mod, card.ability.extra.emulttotal, } }
	end,
	rarity = 4,
	atlas = 'Modtest',
	pos = { x = 13, y = 0 },
	cost = 20,
	calculate = function(self, card, context)
    greencount = 0
    for i = 1, #G.jokers.cards do
        if G.jokers.cards[i].config.center.pools and G.jokers.cards[i].config.center.pools.Krypton_Green then
            greencount = greencount + 1
        end
    end
	card.ability.extra.emulttotal = (greencount - 1) * card.ability.extra.emult_mod + card.ability.extra.emult
	if context.joker_main then		
		return {
            emult = card.ability.extra.emulttotal,
			remove_default_message = true,
			message = ('^' .. card.ability.extra.emulttotal), 
			colour = G.C.PURPLE,
			sound = 'Krypton_emult',
        }
		end
	end
}