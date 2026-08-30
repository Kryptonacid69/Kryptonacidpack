SMODS.Joker {
	key = 'JimboExe',
	loc_txt = {
		name = 'Joker.exe',
		text = {
			"Grants {X:mult,C:white} X#1# {} Mult",
			"{C:mult,s:1.4}    EVIL   {} "
		}
	},	
	config = { extra = { Xmult = 2 } },
	rarity = 2,
	atlas = 'Modtest',
	pos = { x = 0, y = 1 },
	cost = 5,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.Xmult } }
	end,
    calculate = function(self, card, context)
		if context.joker_main then
			G.jumpscare = 230
			play_sound("Krypton_EvilScream")
			return {
				Xmult = card.ability.extra.Xmult 
			}
		end
	end
}