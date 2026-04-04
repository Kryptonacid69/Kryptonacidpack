SMODS.Atlas {
	key = 'StickerAtlas',
	path = 'StickerSpritesheet.png',
	px = 71,
	py = 95,
}

SMODS.Sticker {
    key = 'GreenSticker',
	pos = { x = 0, y = 0 },	
	loc_txt = {
        name = "Green Sticker",
        label = "Green Sticker",
        text = {
            "Retrigger this",
            "Joker {C:mult}1{} time For",
            "each green joker",
			"{C:inactive}(Currently 1 times){}"
        }
    },
    badge_colour = HEX("2fb555"),
    atlas = "StickerAtlas",
    default_compat = true
}