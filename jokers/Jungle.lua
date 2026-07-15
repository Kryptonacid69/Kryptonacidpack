SMODS.Joker {
	key = 'LiamCat',
	loc_txt = {
		name = 'Jungle',
		text = {			
			"{X:mult,C:white} X#3# {} Mult, Gains {X:mult,C:white}X#4#{} When {C:attention}Clicked on",
			"{C:green}#1# in #2#{} Chance to {C:mult}Destroy{} Itself",
			"When {C:attention}Clicked on. If {C:mult}XMult{} is Higher",
			"Than {X:mult,C:white}X#6#{} {C:attention}Upgrade{} at {C:attention}Round end{}",
			"{C:inactive}(Currently {X:mult,C:white}X#5#{}{C:inactive} Mult){}",
			"{C:inactive,s:0.6}Superior race{}",
		}
	},
	config = { extra = { odds = 15, Xmult = 1, currentquip = 0, Xquips = { 'Meow!', 'Munch Munch Munch', 'The Fog is Coming', 'I am Literally scratching your furniture' }, TotalXMult = 1, XmultScaler = 0.15, UpgradeMult = 6 }, },
	loc_vars = function(self, info_queue, card)
		local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'Krypton_LiamCat')		
		return { vars = { numerator, denominator, card.ability.extra.Xmult, card.ability.extra.XmultScaler, card.ability.extra.TotalXMult, card.ability.extra.UpgradeMult } }
	end,
	rarity = 2,
	atlas = 'Modtest',
	pos = { x = 3, y = 1 },
	eternal_compat = false,
	calculate = function(self, card, context)
		if context.MouseClick and card.states.hover.is == true then
			card.ability.extra.TotalXMult = (card.ability.extra.TotalXMult + card.ability.extra.XmultScaler)
			if SMODS.pseudorandom_probability(card, 'Krypton_LiamCat', 1, card.ability.extra.odds) then
				SMODS.destroy_cards(card)
			else
			return {
				message = ('X' .. card.ability.extra.TotalXMult),
				colour = G.C.MULT
			}
			end
		end
		if card.ability.extra.TotalXMult >= card.ability.extra.UpgradeMult and not context.blueprint and context.end_of_round and context.main_eval then
			G.E_MANAGER:add_event(Event({
				trigger = 'after',
				func = function()                           
					play_sound('timpani')
					SMODS.add_card({ set = 'joker', key = 'j_Krypton_UltimaJungle', edition = card.edition })                            
					card:juice_up(0.3, 0.5)
					SMODS.destroy_cards(card)
					return true
				end	
			}))	
		end	
		if context.joker_main then
			card.ability.extra.currentquip = card.ability.extra.currentquip + 1
			if card.ability.extra.currentquip > 4 then
				card.ability.extra.currentquip = 1
			end
			return {
				Xmult_mod = card.ability.extra.TotalXMult,
				message = card.ability.extra.Xquips[card.ability.extra.currentquip]
			}
		end
	end
}