SMODS.Joker {
  key = '92pxjoker',
  loc_txt = {
	  name = 'Badly Cropped Joker',
	  text = {
		  "First {C:attention}Scored{} card each",
		  "Blind Becomes a {C:attention}92 KB{} Glass Card",
		  "{C:inactive,s:0.8}Enriquee!!{}"
    }
  },
  config = {
    extra = {
      enabled = true
    }
  },
  rarity = 3,
  pos = { x = 0, y = 0 },
  atlas = 'Modtest',
  cost = 5,
  blueprint_compat = false,
  
  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue+1] = G.P_CENTERS.m_Krypton_poorlydownloadedglasscard
	return { vars = { card.ability.extra.rounds_left } }
  end,

  calculate = function(self, card, context)
    if context.before and not context.blueprint and card.ability.extra.enabled then
      card.ability.extra.enabled = false
      local to92kb = context.scoring_hand[1]

      if not SMODS.has_enhancement(to92kb, 'm_Krypton_poorlydownloadedglasscard') then
        to92kb:set_ability('m_Krypton_poorlydownloadedglasscard', nil, true)
        G.E_MANAGER:add_event(Event({
          func = function()
            to92kb:juice_up()
            return true
          end
        }))
        return {
          message = 'Glass!',
        }
      end
    end

    if context.end_of_round and context.cardarea == G.jokers then
      card.ability.extra.enabled = true
    end
  end
}
