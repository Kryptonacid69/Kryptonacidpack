SMODS.Joker {
	key = 'Ryu_Ishigori',
	loc_txt = {
		name = 'Jane Juliet Joker',
		text = {
			"{C:attention}Larps as any category of Joker{}",
			"Obtaining This Joker allows more copies",
			"To appear in the shop, {C:attention}+#1#{} Joker slot",
			"{C:inactive,s:0.8}Let's Larp{}",
		}
	},
	config = { extra = { SlotChange = 1 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.SlotChange } }
	end,
	rarity = 2,
	atlas = 'Modtest',
	pos = { x = 14, y = 0 },
	cost = 4,
	--weight = 10,	
	in_pool = function(self, args) return true, {allow_duplicates = true} end,
	--[[get_weight = function(self, weight)
		return weight*(1.3^#SMODS.find_card(self.key))
    end,--]]
	add_to_deck = function (self, card, from_debuff)
		G.jokers:change_size(1*(card.ability.extra.SlotChange))
	end,
	remove_from_deck = function (self, card, from_debuff)
		G.jokers:change_size(-1*(card.ability.extra.SlotChange))
	end,
}
