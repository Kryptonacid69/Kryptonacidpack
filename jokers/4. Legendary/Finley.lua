SMODS.Joker {
	key = 'MyCutiePatootie',
	loc_txt = {
		name = 'Finley',
		text = {
			"{X:purple,C:white} ^#1# {} {C:chips}Chips{}, Increases by {X:purple,C:white} ^#2# {}",
			" For each {C:attention}Cat Joker{} owned",
			"{C:inactive}(Currently {X:purple,C:white}^#3#{C:inactive} {C:chips}Chips{}{C:inactive}){}",
			"{C:inactive,s:0.8}My Cutie Patootie{}"
		}
	},
	config = { extra = { echips = 1 + 1/3, echips_mod = 1/3, echipstotal = 1 + 1/3 } },
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = {key = 'Krypton_CatGroupText', set = 'Other'}
		return { vars = { card.ability.extra.echips, card.ability.extra.echips_mod, card.ability.extra.echipstotal, } }
	end,
	rarity = 4,
	atlas = 'Modtest',
	pos = { x = 9, y = 0 },
	cost = 20,
	calculate = function(self, card, context)
		local CatCount = 0
		for i = 1, #G.jokers.cards do
			if G.jokers.cards[i].config.center.pools and G.jokers.cards[i].config.center.pools.Krypton_Cat then
				CatCount = CatCount + 1
			end
		end
		card.ability.extra.echipstotal = ((CatCount - 1) * card.ability.extra.echips_mod) + card.ability.extra.echips
		if context.joker_main then
			local MessageBig = (card.ability.extra.echipstotal) * 100 
			local MessageRounded = MessageBig - math.floor(MessageBig)
			local MessageFinal = (math.floor(MessageRounded * 100)/100)+ math.floor(card.ability.extra.echipstotal)		
			if MessageRounded > 0.5 then	
				MessageFinal = (math.floor(MessageRounded * 100)/100) + math.floor(card.ability.extra.echipstotal) + 0.01
			end
			return {
				echips = card.ability.extra.echipstotal,
				remove_default_message = true,
				message = ('^' .. MessageFinal),
				colour = G.C.PURPLE,
				sound = 'Krypton_echips',
			}
		end
	end
}