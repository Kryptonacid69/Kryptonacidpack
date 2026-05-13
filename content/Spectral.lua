SMODS.Atlas {
    key = 'Spectral',
    path = 'SpectralSpritesheet.png',
    px = 71,
    py = 95,
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
        "{C:Krypton_bladetrail}Bladetrail [Afterimage]{} Cards.",
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

SMODS.Consumable {
    key = 'Masterliamne',
    set = 'Spectral',
    object_type = "Consumable",
    loc_txt = {
        name = "Masterliamne",
        text = {
			"Fill {C:attention}ALL{} Empty {C:attention}Joker Slots{} With {C:green}Random{}",
			"Jokers. If {C:attention}All{} Joker Slots Are {C:attention}Full,{}",
			" Create A {C:green}Random {C:dark_edition}Negative{} Joker Instead.",
			"{C:inactive,s:0.75}Its Shoddy work at best, but it will have to do!{}",
        },
    },
	cost = 4,
    atlas = 'Spectral',
	pos = { x = 1, y = 0 },
	use = function(self, card, area, copier)
		if G.jokers.config.card_limit > #G.jokers.cards then
			local Amount = G.jokers.config.card_limit -  #G.jokers.cards
			for i = 1, Amount do
					G.E_MANAGER:add_event(Event({
					func = function()
						play_sound('timpani')
						SMODS.add_card({ set = 'Joker' })
						card:juice_up(0.3, 0.5)
						return true
					end
				}))
			end
		end
		if G.jokers.config.card_limit <=  #G.jokers.cards then
			G.E_MANAGER:add_event(Event({
				trigger = 'after',
				delay = 0.4,
				func = function()
					play_sound('timpani')
					SMODS.add_card({ set = 'Joker', edition = 'e_negative' })
					card:juice_up(0.3, 0.5)
					return true
				end
			}))
		end
	end,
    can_use = function(self, card)
        return true
    end
}

SMODS.ObjectType({
    key = "Krypton_PowerMultCat",
    default = "j_joker", -- this is what it should give when you have all of them and showman
    cards = {
		["j_Krypton_MichaelCatV4"] = true,
		["j_Krypton_MyCutiePatootie"] = true,
    },
})

SMODS.Consumable {
    key = 'UpDownBoy',
    set = 'Spectral',
    object_type = "Consumable",
    loc_txt = {
        name = "UpDownBoy",
        text={
        "{C:attention}Enhance{} the {C:Krypton_stats}Stats{} of a",
        "{C:attention}random Cat{} Joker By {X:Krypton_stats,C:white}X#1#{}",
		"{C:inactive,s:0.75}(Doesn't Work on Jokers with {X:purple,C:white,s:0.7}^{}{C:purple,s:0.7} Mult.{}{C:inactive,s:0.7}){}",
        },
    },
	cost = 4,
    atlas = 'Spectral',
	pos = { x = 2, y = 0 },
    config = { StatIncrease = 1.5, EmultStatIncrease = 1.1 },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = {key = 'Krypton_CatGroupText', set = 'Other'}
        return { vars = { card.ability.StatIncrease, card.ability.EmultStatIncrease } }
    end,
	use = function(self, card, area, copier)
		CatTable = {}
		for k, v in pairs(G.jokers.cards) do					
			 if G.jokers.cards[k].config.center.pools and G.jokers.cards[k].config.center.pools.Krypton_Cat and not G.jokers.cards[k].config.center.pools.Krypton_PowerMultCat then
				table.insert(CatTable, v)
			end	
		end
		if #CatTable > 0 then
			local IncreasedJoker =
				pseudorandom_element(CatTable, pseudoseed("CatTable"))
			if not Card.no(IncreasedJoker, "immutable", true) then
				KryptonacidPack.manipulate(IncreasedJoker, { value = card.ability.StatIncrease })
			end
		end
	end,
    can_use = function(self, card)
        return true
    end
}