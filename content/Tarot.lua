SMODS.Atlas {
	key = 'TarotAtlas',
	path = 'TarotSpritesheet.png',
	px = 71,
	py = 95
}

SMODS.Consumable {
    key = "Krypton_Random",
    set = "Tarot",
    object_type = "Consumable",
    name = "Kryptonic Acid",
    loc_txt = {
        name = "Kryptonic Acid",
        text={
        "Creates a random",
        "{C:attention}KryptonacidPack Joker{}",
        "{C:inactive}(must have room){}",
        },
    },
	pos = {x=0, y= 0},
	atlas = "TarotAtlas",
    unlocked = true,
    cost = 3,
    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('timpani')
                SMODS.add_card({ set = 'Krypton_KryptonJoker' })
                card:juice_up(0.3, 0.5)
                return true
            end
        }))
        delay(0.6)
    end,
    can_use = function(self, card)
        return G.jokers and #G.jokers.cards < G.jokers.config.card_limit
    end
}