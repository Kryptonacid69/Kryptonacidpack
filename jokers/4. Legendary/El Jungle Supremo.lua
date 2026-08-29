SMODS.Joker {
	key = 'UltimaJungle',
	loc_txt = {
		name = 'El Jungle Supremo',
		text = {
			"{X:purple,C:white}^#1#{} Mult, Gain {X:purple,C:white}^#2#{} Mult When Clicked.",
			"{C:green}#3# in #4#{} To {C:mult}Destroy{} Itself When {C:attention}Clicked{}",
			"{C:inactive,s:0.75}Have you ever pet your cat, With your life on the line?{}"
		}
	},
	config = { extra = { TotalEMult = 1.25 , EmultScaler = 0.25, odds = 2 } },
	loc_vars = function(self, info_queue, card)
		local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'Krypton_UltimaJungle')		
		return { vars = { card.ability.extra.TotalEMult, card.ability.extra.EmultScaler, numerator, denominator } }
	end,
	rarity = 4,
	atlas = 'Modtest',
	pos = { x = 4, y = 2 },
	cost = 20,
    in_pool = function(self, args)
		return false
    end,  
	calculate = function(self, card, context)
		if context.MouseClick and card.states.hover.is == true then
			card.ability.extra.TotalEMult = card.ability.extra.TotalEMult + card.ability.extra.EmultScaler
			if SMODS.pseudorandom_probability(card, 'Krypton_UltimaJungle', 1, card.ability.extra.odds) then
				SMODS.destroy_cards(card)
			else
			return {
				message = ('^' .. card.ability.extra.TotalEMult),
				colour = G.C.PURPLE,				
			}
			end
		end	
		if context.joker_main then
			return {
				emult = card.ability.extra.TotalEMult,
				remove_default_message = true,
				message = 'Mrrow!',
				colour = G.C.PURPLE,
				sound = 'Krypton_emult',
			}
		end
	end
}