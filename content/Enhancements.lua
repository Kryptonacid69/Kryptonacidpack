SMODS.Enhancement {
    key = 'poorlydownloadedglasscard',
	pos = { x = 0, y = 0 },
    config = { extra = { Xmult = 1 + 2/3 } },
    loc_txt = {
        name = '92 KB glass',
        text = {
            '{X:red,C:white}X#1# {} Mult'
        }
    },
    loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.Xmult }, }
	end,
	atlas = 'EnhancementsAtlas',
    any_suit = false,
    replace_base_card = false,
    no_rank = false,
    no_suit = false,
    always_scores = false,
    unlocked = true,
    discovered = true,
    no_collection = false,
	shatters = true,
    weight = 5,
    calculate = function(self, card, context)
        if context.main_scoring and context.cardarea == G.play then
            return {
                Xmult = card.ability.extra.Xmult
            }
        end
    end
}

SMODS.Enhancement {
    key = 'BladeTrailCard',
	pos = { x = 1, y = 0 },
    loc_txt = {
        name = 'Bladetrail [Afterimage] Card',
        text = {
            'When triggered with {C:attention}#4#{} {C:inactive}[#3#]{} other',
			'scoring cards, Gain {X:mult,C:white}X#1#{} Mult',
			'This effect Maxes out at {X:mult,C:white}X#5#{} Mult',
			'{C:inactive}(Currently {}{X:mult,C:white}X#2#{}{C:inactive} Mult){}'
        }
    },
    atlas = 'EnhancementsAtlas',
    any_suit = false,
    replace_base_card = false,
    no_rank = false,
    no_suit = false,
    always_scores = false,
    unlocked = true,
    discovered = true,
    no_collection = false,
    weight = 3,
	badge_colour = G.C.HEX.BLADETRAIL,
	config = { extra = { Xmult = 0.1, TotalXmult = 1, Required = 10, RequiredOriginal = 10, Max = 2 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.Xmult, card.ability.extra.TotalXmult, card.ability.extra.Required, card.ability.extra.RequiredOriginal, card.ability.extra.Max }, }
	end,
	calculate = function(self, card, context)
		if context.cardarea == G.play and context.main_scoring then
			if #context.scoring_hand > 0 then
				card.ability.extra.Required = card.ability.extra.Required - (#context.scoring_hand)
				while card.ability.extra.Required <= 0 do
					card.ability.extra.Required = card.ability.extra.Required + card.ability.extra.RequiredOriginal
					card.ability.extra.TotalXmult = card.ability.extra.TotalXmult + card.ability.extra.Xmult
				end
				if card.ability.extra.TotalXmult > card.ability.extra.Max then
					card.ability.extra.TotalXmult = card.ability.extra.Max
				end
			end
			local StarBlade = next(SMODS.find_card('j_Krypton_DihuiBlade'))
			if context.main_scoring and context.cardarea == G.play and StarBlade then
				return {
					Xmult = card.ability.extra.TotalXmult,
					xchips = card.ability.extra.TotalXmult
				}
			else
				return {
					Xmult = card.ability.extra.TotalXmult
				}
			end
		end
	end,
}

SMODS.Enhancement {
    key = 'Withered',
	pos = { x = 0, y = 1 },
    loc_txt = {
        name = 'Withered',
        text = {
			"{C:chips}+#2#{} Chips, {X:mult,C:white}X#1#{} Mult",
			"{C:inactive,s:0.85}Scales Based on Aeonglass{}"
        }
    },
    atlas = 'EnhancementsAtlas',
    any_suit = false,
    replace_base_card = false,
    no_rank = false,
    no_suit = false,
    always_scores = false,
    unlocked = true,
    discovered = true,
    no_collection = false,
    weight = 0,
	config = { extra = { Chips = 5, Xmult = 1.05, XmultScalar = 0.05, ChipsScalar = 5} },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.Xmult, card.ability.extra.Chips, card.ability.extra.ChipsScalar, card.ability.extra.XmultScalar  }, }
	end,
	calculate = function(self, card, context)
		local Aeonglass = next(SMODS.find_card('j_Krypton_Aeonglass'))
		if context.cardarea == G.hand and context.main_scoring then
			return {
				Xmult = card.ability.extra.Xmult,
				chips = card.ability.extra.Chips
			}
		end
		if (context.cardarea == G.hand or context.card_area == G.deck or context.cardarea == G.discard) and context.final_scoring_step and Aeonglass then
			card.ability.extra.Chips = card.ability.extra.Chips + card.ability.extra.ChipsScalar
			card.ability.extra.Xmult = card.ability.extra.Xmult + card.ability.extra.XmultScalar
			return {
				message = "Upgrade!"
			}
		end
	end
}
--[[
SMODS.Enhancement {
    key = 'Blooming',
	pos = { x = 1, y = 0 },
    loc_txt = {
        name = 'Blooming',
        text = {
            'After {C:attention}Scoring, Gain {C:money}$#1#{} Of Destroy {C:money}Value{}',
			'After Being {C:attention}Played #2# Time{}{C:inactive}({C:attention}s{}{C:inactive}){}, {C:mult}Destroy{} Self',
			'{C:inactive}(Currently {}{C:money}$#3#{}{C:inactive} &{} {C:Krypton_bloom}#4#{}{C:inactive}/#2#){}',
        }
    },
    atlas = 'EnhancementsAtlas',
    any_suit = false,
    replace_base_card = false,
    no_rank = false,
    no_suit = false,
    always_scores = false,
    unlocked = true,
    discovered = true,
    no_collection = false,
    weight = 5,
	badge_colour = G.C.HEX.BLOOM,	
	config = { extra = { MoneyGain = 5, TotalScores = 5, MoneyTotal = 0, ScoresCurrent = 0, Emult = 1.15 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.MoneyGain, card.ability.extra.TotalScores, card.ability.extra.MoneyTotal, card.ability.extra.ScoresCurrent }, }
	end,
	calculate = function(self, card, context)
		local SpiceBush = next(SMODS.find_card('j_Krypton_SpicebushV2'))
		if context.cardarea == G.play and context.main_scoring then
			card.ability.extra.ScoresCurrent = card.ability.extra.ScoresCurrent + 1
			card.ability.extra.MoneyTotal = card.ability.extra.MoneyTotal + card.ability.extra.MoneyGain
		end
		if context.cardarea == G.play and context.main_scoring and SpiceBush and card.ability.extra.TotalScores <= card.ability.extra.ScoresCurrent then
			return { 
				emult = card.ability.extra.Emult,
				remove_default_message = true,
				message = ('^' .. card.ability.extra.Emult),
				colour = G.C.PURPLE,
				sound = 'Krypton_emult',				
			} 
		end
		if context.remove_playing_cards then
			for _, removed in ipairs(context.removed) do
				if removed == card and card.ability.extra.MoneyTotal > 0 and not SpiceBush then 
					return { 
						dollars = card.ability.extra.MoneyTotal,
						color = G.C.HEX.BLOOM,
					} 
				end
			end
		end
		if context.destroy_card and context.cardarea == G.play and context.destroy_card == card and card.ability.extra.TotalScores <= card.ability.extra.ScoresCurrent then
			return { remove = true }
		end
	end
}
--]]