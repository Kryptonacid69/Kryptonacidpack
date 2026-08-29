SMODS.Joker {
	key = 'IhateArchieKysDieDieDie',
	loc_txt = {
		name = 'Troll Joker',
		text = {
			"Grants {X:mult,C:white} X#3# {} Mult",
			"{C:mult,s:1.1}Annoying Bitch{} "
		}
	},
	
	config = { extra = { Xmult = 2.25 } },
	rarity = 1,
	atlas = 'Modtest',
	pos = { x = 2, y = 1 },
	cost = -1,
	
	loc_vars = function(self, info_queue, card)
		return { vars = { num, denom, card.ability.extra.Xmult } }
	end,

    calculate = function(self, card, context)
	if context.joker_main then
		G.jumpscare3 = 67676767 -- Number created by The dumb idiot who drew the joker	
		return 
			{
			Xmult = card.ability.extra.Xmult 
			} 
		end
		if not context.blueprint and context.end_of_round and context.game_over or context.selling_self then
			if G.jumpscare3 == nil then G.jumpscare3 = 0 end
				G.jumpscare3 = 0
		end
	end,
}