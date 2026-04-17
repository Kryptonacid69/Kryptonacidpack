SMODS.Atlas {
	key = 'EnhancementsAtlas',
	path = 'EnhancementsSpritesheet.png',
	px = 71,
	py = 95
}

SMODS.Enhancement {
    key = 'poorlydownloadedglasscard',
	pos = { x = 0, y = 0 },
    config = {
        extra = {
            Xmult = 1.66
        }
    },
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
    weight = 4,
	config = { extra = { Xmult = 0.1, TotalXmult = 1, Required = 10, RequiredOriginal = 10, Max = 2.5 } },
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
			if card.ability.extra.TotalXmult > 2.5 then
				card.ability.extra.TotalXmult = card.ability.extra.Max
			end
		end
	end,
}
