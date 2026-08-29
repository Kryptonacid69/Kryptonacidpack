SMODS.Joker {
  key = 'BluerJoker',
  config = { extra = { xchips = 2.5 } },
  loc_txt = {
	  name = 'Bluer Joker',
	  text = {
		  "{X:chips,C:white} X#1# {} Chips",
      }
  },
  rarity = 2,
  pos = { x = 2, y = 0 },
  atlas = 'Modtest',
  cost = 5,

  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.xchips  }  }
  end,

  calculate = function(self, card, context)
    if context.joker_main then
      return {
        xchips = card.ability.extra.xchips
      }
    end
  end
}
