--[[
SMODS.Joker {
	key = 'Spicebush',
	loc_txt = {
		name = 'Like Flowers in Full Bloom',
		text = {
			'Convert the {C:attention}First{} Played Card',
			'Each {C:attention}Hand{} into a {C:Krypton_bloom}Blooming{} Card',
			'{C:inactive}(#2#/{C:krypton_bloom}#3#{}{C:inactive}){}',
		}
	},
	config = { extra = { enhancement = "m_Krypton_Blooming", Count = 0, Max = 10 } },
	rarity = 2,
	cost = 6,
	atlas = 'Modtest',
	pos = { x = 1, y = 2},
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS.m_Krypton_Blooming		
		return { vars = { card.ability.extra.enhancement, card.ability.extra.Count, card.ability.extra.Max } }
	end,
	calculate = function(self, card, context)
		if context.before and not context.blueprint then
			local Bloomed = context.scoring_hand[1]
			if not SMODS.has_enhancement(Bloomed, card.ability.extra.enhancement) then
				Bloomed:set_ability(card.ability.extra.enhancement, nil, true)
				card.ability.extra.Count = card.ability.extra.Count + 1
				G.E_MANAGER:add_event(Event({
					func = function()
						Bloomed:juice_up()
						return true
					end
				}))
				return {
					message = 'Blooming!',
					color = G.C.HEX.BLOOM,
				}
			end
		end
		if context.final_scoring_step and not context.blueprint and card.ability.extra.Count >= card.ability.extra.Max then
			G.E_MANAGER:add_event(Event({
				trigger = 'after',
				delay = 0.4,
				func = function()                           
					play_sound('timpani')
					SMODS.add_card({ set = 'joker', key = 'j_Krypton_SpicebushV2', edition = card.edition})                            
					card:juice_up(0.3, 0.5)
					SMODS.destroy_cards(card)
					return true
				end	
			}))	
		end
    end
}
Base the art for this joker on Spicebush yisangs bloodied spicebush branch thing in the uptie art--]]
