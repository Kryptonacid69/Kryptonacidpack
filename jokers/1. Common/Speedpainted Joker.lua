SMODS.Joker {
	key = 'Speedpainted',
	loc_txt = {
		name = 'Speedpainted Joker',
		text = {
			"Earn {C:money}#1#${} If you can {C:attention}win{} the {C:blue}Small{}",
			"or {C:attention}Big{} Blind within {C:mult}#3#{} {C:attention}Seconds{}",
			"{C:inactive}({}{C:attention}#2#{}{C:inactive} Seconds Remaining){}",
			"{C:inactive,s:0.75}Took me 9 min to draw still :/{} ",
		}
	},
	
	config = { extra = { money = 8, timer = 25, length = 25 } },
	rarity = 1,
	atlas = 'Modtest',
	pos = { x = 8, y = 2 },
	cost = 3,
	
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.money, card.ability.extra.timer, card.ability.extra.length }}
	end,
	
	update = function(self, card, dt)
		if card.ability.extra.timer > 0 then
			card.ability.extra.timer = card.ability.extra.timer - dt/4
		end
    end,
	calculate = function(self, card, context)
		if context.setting_blind then
			card.ability.extra.timer = 25
		end
		if card.ability.extra.timer < 0 then
			card.ability.extra.timer = 0
		end
	end,
    calc_dollar_bonus = function(self, card)
        if card.ability.extra.timer > 0 then
			return card.ability.extra.money
		end
    end
}