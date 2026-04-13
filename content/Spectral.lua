SMODS.Atlas {
    key = 'Spectral',
    path = 'SpectralSpritesheet.png',
    px = 71,
    py = 96,
}

SMODS.Consumable {
    key = '[Bladetrail]',
    set = 'Spectral',
    object_type = "Consumable",
    name = "Krypton_[Bladetrail]",
    loc_txt = {
        name = "Bladetrail",
        text={
        "Select up to {C:attention}#1#{} cards to become ",
        "{C:blue}Bladetrail [Afterimage]{} Cards.",
        },
    },
	cost = 4,
    atlas = 'Spectral',
	pos = { x = 0, y = 0 },
    config = { max_highlighted = 2, mod_conv = 'm_Krypton_BladeTrailCard' },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS[card.ability.mod_conv]
        return { vars = { card.ability.max_highlighted, localize { type = 'name_text', set = 'Enhanced', key = card.ability.mod_conv } } }
    end
}