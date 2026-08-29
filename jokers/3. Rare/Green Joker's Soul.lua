SMODS.Joker {
  key = 'GreenJokerSoul',
  config = { extra = { rounds = 0, roundtotal = 3 } },
  loc_txt = {
	  name = "Green Joker's Soul",
	  text = {
		  "Sell this joker after {C:attention}#2#{} rounds to apply",
		  "{C:Krypton_green}Green Edition{} to a random joker",
		  "{C:inactive}(Currently {}{C:attention}#1#{}{C:inactive}/#2#){}",
      }
  },
  rarity = 3,
  pos = { x = 12, y = 0 },
  atlas = 'Modtest',
  cost = 8,
  eternal_compat = false, 
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue+1] = G.P_CENTERS.e_Krypton_Green
		return { vars = { card.ability.extra.rounds, card.ability.extra.roundtotal} }
	end,
	calculate = function(self, card, context)	
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
            card.ability.extra.rounds = card.ability.extra.rounds + 1
            if card.ability.extra.rounds == card.ability.extra.roundtotal then
                local eval = function(card) return not card.REMOVED end
                juice_card_until(card, eval, true)
            end
            return {
                message = (card.ability.extra.rounds < card.ability.extra.roundtotal) and
                    (card.ability.extra.rounds .. '/' .. card.ability.extra.roundtotal) or
                    localize('k_active_ex'),
                colour = G.C.FILTER
            }
        end
		if context.selling_self and card.ability.extra.rounds >= card.ability.extra.roundtotal and not context.blueprint  then
			local GreenList = {}
			for k, v in pairs(G.jokers.cards) do
				if v.ability.set == "Joker" and not v.edition and v ~= card then
					table.insert(GreenList, v)
				end
			end
			if #GreenList > 0 then
				local GreenListWinner =
					pseudorandom_element(GreenList, pseudoseed("Greenify~"))
				GreenListWinner:set_edition('e_Krypton_Green')
				if not context.retrigger_joker then
					card:juice_up(0.5, 0.5)
				end
			end
			return {
				message = 'Green!',
				color = G.C.GREEN,
			}
		end
	end	
}