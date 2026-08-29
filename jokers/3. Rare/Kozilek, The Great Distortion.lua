SMODS.Joker {
	key = 'Kozilek',
	loc_txt = {
		name = 'Kozilek, The Great Distortion',
		text = {
			"Your {C:attention}hand size{} cannot be {C:attention}lower{} than {C:green}#2#{}",
			"{C:mult}Discard{} a card with {C:chips}Chips{} value {C:attention}X{}",
			"This {C:attention}joker{} gains {C:attention}X{}{C:green}/#3#{} {C:white,X:mult}XMult{} Until {C:attention}round end{}",
			"{C:inactive}(Currently {C:white,X:mult}X#1#{}{C:inactive} Mult)",
			"{C:inactive,s:0.7}A void as {C:inactive,s:0.7,E:1}cryptic{}{C:inactive,s:0.7} as reality itself.{}"
		}
	},
	
	config = { extra = { xmult = 1, HandSizeCap = 7, DivideBy = 50 } },
	rarity = 3,
	atlas = 'Modtest',
	pos = { x = 7, y = 2 },
	cost = 7,
	
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.xmult, card.ability.extra.HandSizeCap, card.ability.extra.DivideBy } }
	end,

	calculate = function(self, card, context)
		if context.joker_main then
			return  {
				xmult = card.ability.extra.xmult 
			} 
		end
		if G.hand.config.card_limit < 7 then
			G.E_MANAGER:add_event(Event({
				func = function()
					G.hand:change_size((card.ability.extra.HandSizeCap - G.hand.config.card_limit))
					return true
				end
			}))		
		end
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint and card.ability.extra.xmult > 1 then
            card.ability.extra.xmult = 1
            return {
                message = localize('k_reset'),
                colour = G.C.RED
            }
        end
		if context.discard then
			card.ability.extra.xmult = card.ability.extra.xmult + (context.other_card:get_chip_bonus()/card.ability.extra.DivideBy)
				return {
					message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.xmult } },
					colour = G.C.RED,
					delay = 0.45
				}
		end
	end,
}