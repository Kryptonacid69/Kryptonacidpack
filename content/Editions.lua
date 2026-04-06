SMODS.Shader { 
  key = 'Green', 
  path = 'Green.fs' 
}

SMODS.Sound {
  key = 'GreenSound',
  path = 'GreenEditionPlop.ogg'
}

SMODS.Edition {
	key = "Green",
    loc_txt = {
        name = "Green",
        label = "Green",
        text = {
            "{C:attention}Retriggers{} once For",
			"Each {C:green}Green{} Joker Held",
			"{C:inactive}(Twice Maximum){}",
        }
    },
	sound = {
      sound = 'Krypton_GreenSound',
      per = 1,
      vol = 3
	},
	shader = 'Green',
	extra_cost = 4,
	pools = { ["Green"] = true },
	in_shop = true,
	weight = 1, 
	badge_colour = G.C.GREEN,
	calculate = function(self, card, context)
		if card.ability.set == 'Joker' then	
			greencount = 0	
			for i = 1, #G.jokers.cards do
				if G.jokers.cards[i].config.center.pools and G.jokers.cards[i].config.center.pools.Krypton_Green then
					greencount = greencount + 1
				end
			end
			if greencount > 2 then
				greencount = 2
			end
			if (context.repetition or context.retrigger_joker_check) and context.other_card == card then								
				return {
					repetitions = greencount,
					sound = "Krypton_GreenSound",
				}
			end
		end
	end
}

local poll_edition_ref = poll_edition
function poll_edition(_key, _mod, _no_neg, _guaranteed, _options)
  local removed, pos

  if _no_neg then
    for i, v in ipairs(G.P_CENTER_POOLS.Edition) do
      if v.key == 'e_Krypton_Green' then
        pos = i
        removed = table.remove(G.P_CENTER_POOLS.Edition, i)
        break
      end
    end
  end

  local ret = poll_edition_ref(_key, _mod, _no_neg, _guaranteed, _options)

  if _no_neg and removed and pos then
    table.insert(G.P_CENTER_POOLS.Edition, pos, removed)
  end

  return ret
end
