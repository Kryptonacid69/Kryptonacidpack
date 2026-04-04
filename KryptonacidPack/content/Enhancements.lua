SMODS.Atlas {
	key = 'EnhancementsAtlas',
	path = 'EnhancementsSpritesheet.png',
	px = 73,
	py = 97
}

SMODS.Enhancement {
    key = 'poorlydownloadedglasscard',
	pos = { x = 0, y = 0 },
    config = {
        extra = {
            xmult0 = 1.66
        }
    },
    loc_txt = {
        name = '92 KB glass',
        text = {
            '{X:red,C:white}X1.66 {} Mult'
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
	shatters = true,
    weight = 5,
    calculate = function(self, card, context)
        if context.main_scoring and context.cardarea == G.play then
            return {
                Xmult = 1.66
            }
        end
    end
}
