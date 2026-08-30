SMODS.Joker {
	key = 'Logan',
	loc_txt = {
		name = 'Logan Paul Joker',
		text = {
			"{X:mult,C:white} X#1# {} Mult, Increases by {X:mult,C:white} X#2# {}",
			" For each joker that {C:attention}Dies in 5 years{}",
			"{C:inactive}(Currently {X:mult,C:white}X#3#{C:inactive} Mult)",
			"{C:inactive,s:0.6}Uhh guys? i think theres a joker hanging there.{}"
		}
	},
	config = { extra = { Xmult = 1, XmultMod = 1.5, XmultTotal = 1 } },
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = {key = 'Krypton_Deadin5s', set = 'Other'}
		return { vars = { card.ability.extra.Xmult, card.ability.extra.XmultMod, card.ability.extra.XmultTotal, } }
	end,
	rarity = 3,
	atlas = 'Modtest',
	pos = { x = 3, y = 0 },
	cost = 8,
	calculate = function(self, card, context)
    paulcount = 0
    for i = 1, #G.jokers.cards do
        if G.jokers.cards[i].config.center.pools and G.jokers.cards[i].config.center.pools.Krypton_Deadin5 then
            paulcount = paulcount + 1
        end
    end
	card.ability.extra.XmultTotal = paulcount * card.ability.extra.XmultMod+card.ability.extra.Xmult
	if context.joker_main then
        return {
            Xmult = card.ability.extra.XmultTotal
        }
		end
	end
}