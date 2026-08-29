SMODS.Joker {
	key = 'Idle_Transfiguration',
	loc_txt = {
		name = 'Idle Transfiguration',
		text = {
			'After {C:attention}#2#{} Round(s), {C:attention}Sell{} this Joker',
			'To remove {C:mult}ALL{} {C:attention}stickers{} and',
			'{C:attention}Shuffle{} {C:mult}ALL{} editions on Jokers',
			'{C:inactive}(Currently {C:attention}#1#{}{C:inactive}/#2#){}',
			'{C:purple,s:0.8}"Mui Tenten."{}',
		}
	},
	config = { extra = { Rounds = 0, RoundsTotal = 1 } },
	rarity = 2,
	cost = 5,
	atlas = 'Modtest',
	pos = { x = 2, y = 2},
	eternal_compat = false,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.Rounds, card.ability.extra.RoundsTotal } }
	end,
	calculate = function(self, card, context)
		if context.selling_self and card.ability.extra.Rounds >= card.ability.extra.RoundsTotal and not context.blueprint  then
			local modifiers = {}
			for k, v in pairs(G.jokers.cards) do
				if v.edition then
					table.insert(modifiers, {edition = true, key = v.edition.key})
					v:set_edition(nil, true, true)
				end
				for kk, vv in pairs(SMODS.Stickers) do
					if v.ability[vv.key] then
						v:remove_sticker(vv.key)
					end
				end
			end
			pseudoshuffle(modifiers, 'seed')
			for k, v in pairs(modifiers) do
				local RandomJonkler = {}
				for kk, vv in pairs(G.jokers.cards) do
					if (v.edition and not vv.edition) and G.jokers.cards[kk].ability.name ~= card.ability.name then
						table.insert(RandomJonkler, vv)
					end
				end
				if next(RandomJonkler)then 
					local joker = pseudorandom_element(RandomJonkler)
					if v.edition then 
						joker:set_edition(v.key)
					end
				end
			end
		end
		if context.end_of_round and context.main_eval and card.ability.extra.Rounds < card.ability.extra.RoundsTotal and not context.blueprint then
			card.ability.extra.Rounds = card.ability.extra.Rounds + 1
			return {
				message = (card.ability.extra.Rounds .. '/' .. card.ability.extra.RoundsTotal),
				colour = G.C.PURPLE,
			}	
		end
		if context.end_of_round and context.main_eval and card.ability.extra.Rounds >= card.ability.extra.RoundsTotal and not context.blueprint then
			return { 
				message = 'Active!',
				colour = G.C.PURPLE,
			}
		end
	end,
}
