--- STEAMODDED HEADER
--- MOD_NAME: KryptonacidPack
--- MOD_ID: KryptonacidPack
--- MOD_AUTHOR: KryptonacidPack
--- MOD_DESCRIPTION: KryptonacidPack
--- PREFIX: KryptonacidPack
----------------------------------------------------------
----------- MOD CODE -------------------------------------
local mod = SMODS.current_mod
SMODS.Atlas({key = "modicon", path = "modicon.png", px = 33, py = 34, atlas_table = "ASSET_ATLAS"}):register()
	
SMODS.Atlas {
	key = "Modtest",
	path = "JokerSpritesheet.png",
	px = 71,
	py = 95
}
SMODS.Joker {
	key = 'UncommonJoker',
	loc_txt = {
		name = 'Greener Joker',
		text = {
			"{C:mult}+#1#{} Mult"
		}
	},
	config = { extra = { mult = 10 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.mult } }
	end,
	rarity = 2,
	atlas = 'Modtest',
	pos = { x = 7, y = 0 },
	cost = 4,
	calculate = function(self, card, context)
		if context.joker_main then
			return {
				mult_mod = card.ability.extra.mult,
				message = localize { type = 'variable',  key = 'a_mult', vars = { card.ability.extra.mult } }
			}
		end
	end
}
SMODS.Joker {
	key = 'GreenestJoker',
	loc_txt = {
		name = 'Greenest Joker',
		text = {
			"{X:mult,C:white} X#1# {} Mult",
		}
	},
	config = { extra = { Xmult = 3.5 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.Xmult } }
	end,
	rarity = 3,
	atlas = 'Modtest',
	pos = { x = 3, y = 0 },
	cost = 10,
	calculate = function(self, card, context)
		if context.joker_main then
			return {
				Xmult_mod = card.ability.extra.Xmult,
				message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.Xmult } }		
			}
		end
	end
}

SMODS.Joker {
  key = 'BluerJoker',
  config = { extra = { a_xchips = 2.5 } },
  loc_txt = {
	  name = 'Bluer Joker',
	  text = {
		  "{X:chips,C:white} X#1# {} Chips",
      }
  },
  rarity = 2,
  pos = { x = 8, y = 0 },
  atlas = 'Modtest',
  cost = 5,

  loc_vars = function(self, info_queue, card)
    local xchips
    if G.jokers then xchips = (card.ability.extra.a_xchips) end
    return {
      vars = {
        card.ability.extra.a_xchips
      }
    }
  end,

  calculate = function(self, card, context)
    if context.joker_main then
      return {
        xchips = (card.ability.extra.a_xchips) 
      }
    end
  end
}

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
  pos = { x = 5, y = 0 },
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
          message = 'glass!',
        }
      end
    end

    if context.end_of_round and context.cardarea == G.jokers then
      card.ability.extra.enabled = true
    end
  end
}

SMODS.Joker {
  key = 'Obese_Joker',
  rarity = 3,
  pos = { x = 0, y = 0 },
  config = { extra = { Xmult = 1.75, odds = 2 } },
  loc_txt = {
      name = 'Obese Joker',
	  text = {
		  "All cards score {X:mult,C:white} X#1#{} But",
          "{C:green} #2# in #3# {}Chance Cards Scored",
		  "Are {C:attention}Eaten{}"
    }
  },
  atlas = 'Modtest',
  cost = 10,
  unlocked = true,
  discovered = true,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,

	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.Xmult, (G.GAME.probabilities.normal or 1), card.ability.extra.odds } }
	end,
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play then
				return {
					Xmult = card.ability.extra.Xmult,
				}
			end		
		
		if not context.blueprint and context.after and context.main_eval and pseudorandom('Obese_Joker') < G.GAME.probabilities.normal / card.ability.extra.odds then
          local destroyed_cards = {}
		  
		  for _, v in ipairs(G.play.cards) do
            destroyed_cards[#destroyed_cards + 1] = v
          end
		  
	      if pseudorandom('Obese_Joker') < G.GAME.probabilities.normal / card.ability.extra.odds then
			SMODS.destroy_cards(destroyed_cards)
		    return {
				message = 'Eaten!',
			}
		  end
		end
	end
    
}

SMODS.Sound {
    key = "EvilScream",
    path = "Jumpscare.ogg"
}

SMODS.Sound {
    key = "Lobotomy",
    path = "lobotomy.ogg"
}

SMODS.Joker {
	key = 'JimboExe',
	loc_txt = {
		name = 'Joker.exe',
		text = {
			"Grants {X:mult,C:white} X#3# {} Mult",
			"{C:mult,s:1.4}    EVIL   {} "
		}
	},
	
	config = { extra = {numerator = 1, denominator = 2, Xmult = 2 } },
	rarity = 2,
	atlas = 'Modtest',
	pos = { x = 9, y = 0 },
	cost = 5,
	
	loc_vars = function(self, info_queue, card)
		local num, denom = SMODS.get_probability_vars(card, card.ability.extra.numerator, card.ability.extra.denominator)
		return { vars = { num, denom, card.ability.extra.Xmult } }
	end,

    calculate = function(self, card, context)
	if context.joker_main then
		if SMODS.pseudorandom_probability(card, 'example_prob', card.ability.extra.numerator, card.ability.extra.denominator) then G.jumpscare2 = 230 else G.jumpscare = 230 end	
		if SMODS.pseudorandom_probability(card, 'example_prob', card.ability.extra.numerator, card.ability.extra.denominator) then play_sound("Krypton_Lobotomy") else play_sound("Krypton_EvilScream") end
		return 
			{
			Xmult = card.ability.extra.Xmult 
			}
		end
	end,
}

SMODS.Joker {
	key = 'LiamCat',
	loc_txt = {
		name = 'Jungle',
		text = {
			"{X:mult,C:white} X#1# {} Mult, But ",
			"Explodes if Left",
			"Alone for {C:attention}#3# Seconds",
			"{C:inactive,s:0.6}Superior race{}"
		}
	},
	config = { extra = { timer = 10, Xmult = 2.5, currentquip = 0, Xquips = { 'Meow!', 'Munch Munch Munch', 'The Fog is Coming', 'I am Literally scratching your furniture' }  }, },
	update = function(self, card, dt)
	  card.ability.extra.timer = card.ability.extra.timer - (dt/4)
	  if card.ability.extra.timer <= 0 then
        card.ability.extra.timer = 69420
            G.E_MANAGER:add_event(Event({
                trigger = 'immediate',
                func = function()                           
                    play_sound('timpani')
                    SMODS.destroy_cards(card)
					return true
                end
            })) 
        blocking = false		
      end
    end,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.Xmult, card.ability.extra.Xquips, card.ability.extra.timer, } }
	end,
	rarity = 2,
	atlas = 'Modtest',
	pos = { x = 11, y = 0 },
	eternal_compat = false,
	calculate = function(self, card, context)
	if context.MouseClick and card.states.hover.is == true then
        card.ability.extra.timer = 10
	end
	if context.joker_main then
			card.ability.extra.currentquip = card.ability.extra.currentquip + 1
            if card.ability.extra.currentquip > 4 then
                card.ability.extra.currentquip = 1
				G.E_MANAGER:add_event(Event({
					func = function()
						message = 'Mrrow'
				    end
				}))
            end
			return {
				Xmult_mod = card.ability.extra.Xmult,
				message = card.ability.extra.Xquips[card.ability.extra.currentquip]
			}
		end
	end
}



SMODS.Joker {
  key = 'SCREWSCREWSCREW',
  config = { extra = { chips = 25, chip_gain = 0 } },
  loc_txt = {
	  name = 'Screw Joker',
	  text = {
		 "Gains Half its Chips {C:inactive}({}{C:chips}+#3#{}{C:inactive}){}",
		 "As Chips After the {C:attention}Boss Blind{}",
		 "{C:inactive}(Currently {}{C:chips}+#1#{}{C:inactive} Chips){}",
      }
  },
  rarity = 2,
  pos = { x = 14, y = 0 },
  atlas = 'Modtest',
  cost = 8,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.chips, card.ability.extra.chip_gain, (card.ability.extra.chips/2) } }
	end,
	calculate = function(self, card, context)
		if context.joker_main then
			return {
                chips = card.ability.extra.chips,
                chip_message = {
                    message = localize { type = 'variable', key = 'a_chips', vars = { card.ability.extra.chips } },
					colour = G.C.CHIPS
				}
			}
		end
		local chips = card.ability.extra.chips
		if not context.blueprint and context.end_of_round and G.GAME.blind.boss and context.main_eval then
			card.ability.extra.chips = card.ability.extra.chips + (chips/2)
			return {
				message = 'Screwed!',
				colour = G.C.CHIPS,
			}
		end
	end
}

SMODS.ObjectType({
    key = "Krypton_Green",
    default = "j_joker", -- this is what it should give when you have all of them and showman
    cards = {
        ["j_green_joker"] = true,
        ["j_Krypton_UncommonJoker"] = true,
        ["j_Krypton_GreenestJoker"] = true,
		["j_Krypton_GreenSquare"] = true,
		["s_Krypton_GreenSticker"] = true,
    },
})

SMODS.Joker {
	key = 'GreenSquare',
	loc_txt = {
		name = 'Green Square',
		text = {
			"{X:purple,C:white} ^#1# {} Mult, Increases by {X:purple,C:white} ^#2# {}",
			" For each {C:green}Green Joker{} owned",
			"{C:inactive}(Currently {X:purple,C:white}^#3#{C:inactive} Mult)"
		}
	},
	config = { extra = { emult = 1.2, emult_mod = 0.4, emulttotal = 1.2 } },
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = {key = 'Krypton_GreenSquareloctext', set = 'Other'}
		return { vars = { card.ability.extra.emult, card.ability.extra.emult_mod, card.ability.extra.emulttotal, } }
	end,
	rarity = 4,
	atlas = 'Modtest',
	pos = { x = 2, y = 0 },
	cost = 20,
	calculate = function(self, card, context)
    greencount = 0
    for i = 1, #G.jokers.cards do
        if G.jokers.cards[i].config.center.pools and G.jokers.cards[i].config.center.pools.Krypton_Green then
            greencount = greencount + 1
        end
    end
	card.ability.extra.emulttotal = greencount * card.ability.extra.emult_mod+card.ability.extra.emult
	if context.joker_main then
        return {
            emult = card.ability.extra.emulttotal
        }
		end
	end
}

SMODS.ObjectType({
    key = "Krypton_Deadin5",
    default = "j_joker", 
    cards = {
        ["j_raised_fist"] = true,
        ["j_dna"] = true,
        ["j_vagabond"] = true,
		["j_Krypton_Obese_Joker"] = true,
		["j_burglar"] = true,
		["j_madness"] = true,
		["j_vampire"] = true,
		["j_luchador"] = true,
		["j_mr_bones"] = true,
		["j_glass"] = true,
		["j_ring_master"] = true,
		["j_stuntman"] = true,
		["j_burnt"] = true, 
		["j_yorick"] = true,
		["j_bull"] = true, -- dies to matador, matador solos
		["j_Krypton_IhateArchieKysDieDieDie"] = true,
		["j_Krypton_LoganPaulJoker"] = true,
		
    },
})

SMODS.Joker {
	key = 'LoganPaulJoker',
	loc_txt = {
		name = "Uhh, Guys i think there's joker hanging there",
		text = {
			"{X:mult,C:white}X#1#{} Mult for each {C:attention}joker{}",
			"That will die in {C:attention}5 years{}",
			"{C:inactive}(Currently {X:mult,C:white}X#2#{}{C:inactive} Mult){}",
		}
	},
	config = { extra = { Xmult = 1.5, Xmulttotal = 1 } },
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = {key = 'Krypton_Deadin5s', set = 'Other'}
		return { vars = { card.ability.extra.Xmult, card.ability.extra.Xmulttotal } }
	end,
	rarity = 3,
	atlas = 'Modtest',
	pos = { x = 13, y = 0 },
	cost = 8,
	calculate = function(self, card, context)
    Paulcount = 0
    for i = 1, #G.jokers.cards do
        if G.jokers.cards[i].config.center.pools and G.jokers.cards[i].config.center.pools.Krypton_Deadin5 then
            Paulcount = Paulcount + 1
        end
    end
	if Paulcount > 0 then card.ability.extra.Xmulttotal = (Paulcount * card.ability.extra.Xmult) + 1 else card.ability.extra.Xmulttotal = 1
		if context.joker_main then
			return {
				Xmult = card.ability.extra.Xmulttotal
			}
			end
		end
	end
}

SMODS.Joker {
    key = "bettingonanout",
    config = {
        extra = {
            odds = 1000
        }
    },
    loc_txt = {
        name = 'Betting on an out',
        text = {
			'{C:green} #1# in #2# {}Chance to Create a',
			'Negative {C:blue}Soul{} Card When {C:attention}Cards Score{}',
			'{C:inactive}(Self destructs){}'
        },
    },
    pos = { x = 0, y = 1},
    cost = 0,
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = false,
    unlocked = true,
    discovered = true,
    atlas = 'Modtest',
    
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS.c_soul
		local new_numerator, new_denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'j_Krypton_bettingonanout') 
        return {vars = {new_numerator, new_denominator}}
    end,
    
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play  then
            if true then
                if SMODS.pseudorandom_probability(card, '1', 1, card.ability.extra.odds, 'j_Krypton_bettingonanout', false) then
                    for i = 1, 1 do
                        G.E_MANAGER:add_event(Event({
                            trigger = 'after',
                            delay = 0.4,
                            func = function()                           
                                play_sound('timpani')
								SMODS.add_card({ set = 'Spectral', key = 'c_soul', edition = 'e_negative'})                            
                                card:juice_up(0.3, 0.5)
								SMODS.destroy_cards(card)
								return true
                            end
                        }))
                    end
					return {
					    message = 'GAMBA!!!!'
					}
                end
            end
        end
    end
}
  --MICHEAL CAT IDEA !!!common cat: gives 15 mult, 1/10, uncommon cat: gives x1.5 mult, retrigger first card once, 1/40, rare cat: gives x4 mult, retrigger all cards played, 1/100, legendary cat: gives ^1.5, retrigger all cards played and in hand
SMODS.Joker {
  key = 'MichaelCatV1',
  config = { extra = { mult = 10, odds = 5 } },
  loc_txt = {
	  name = 'Shelby',
	  text = {
		  "Gives {C:mult}+#1#{} Mult",
		  "{C:green}#2# in #3#{} Chance to upgrade",
		  "when this {C:attention}joker triggers{}",
      }
  },
  rarity = 1,
  pos = { x = 10, y = 0 },
  atlas = 'Modtest',
  cost = 5,
  eternal_compat = false,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.mult, (G.GAME.probabilities.normal or 1), card.ability.extra.odds } }
	end,
	calculate = function(self, card, context)
		if context.joker_main then
		    if pseudorandom('MichaelCatV1') < G.GAME.probabilities.normal / card.ability.extra.odds then
				G.E_MANAGER:add_event(Event({
					trigger = 'after',
					delay = 0.4,
					func = function()                           
						play_sound('timpani')
						SMODS.add_card({ set = 'joker', key = 'j_Krypton_MichaelCatV2'})                            
						card:juice_up(0.3, 0.5)
						SMODS.destroy_cards(card)
						return true
					end	
				}))	
			end	
			return {
			mult_mod = card.ability.extra.mult,
			message = localize { type = 'variable',  key = 'a_mult', vars = { card.ability.extra.mult } },
			}   
	    end
	end
}

SMODS.Joker {
  key = 'MichaelCatV2',
  config = { extra = { Xmult = 1.5, odds = 10, repetitions = 1 } },
  loc_txt = {
	  name = 'Shelby - Drinking',
	  text = {
		  "Gives {X:mult,C:white}X#1#{} Mult, {C:green}#2# in #3#{}",
		  "Chance to upgrade when this",
		  "{C:attention}joker triggers{}, retriggers the",
		  "{C:attention}first card{} played {C:attention}#4# time{}",
      }
  },
  rarity = 2,
  pos = { x = 2, y = 1 },
  atlas = 'Modtest',
  cost = 6,
    in_pool = function(self, args)
      return false
    end,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.Xmult, (G.GAME.probabilities.normal or 1), card.ability.extra.odds, card.ability.extra.repetitions } }
	end,
	calculate = function(self, card, context)
		if context.cardarea == G.play and context.repetition then
			if context.other_card == context.scoring_hand[1] then
				return {
					message = localize("k_again_ex"),
					repetitions = card.ability.extra.repetitions,
					card = card,
				}
			end
		end
		if context.joker_main then
		    if pseudorandom('MichaelCatV2') < G.GAME.probabilities.normal / card.ability.extra.odds then
				G.E_MANAGER:add_event(Event({
					trigger = 'after',
					delay = 0.4,
					func = function()                           
						play_sound('timpani')
						SMODS.add_card({ set = 'joker', key = 'j_Krypton_MichaelCatV3'})                            
						card:juice_up(0.3, 0.5)
						SMODS.destroy_cards(card)
						return true
					end	
				}))	
			end	
			return {
			Xmult_mod = card.ability.extra.Xmult,
			message = localize { type = 'variable',  key = 'a_xmult', vars = { card.ability.extra.Xmult } },
			}   
	    end
	end
}

SMODS.Joker {
  key = 'MichaelCatV3',
  config = { extra = { Xmult = 2.5, odds = 20, repetitions = 1 } },
  loc_txt = {
	  name = 'Shelby - Punching',
	  text = {
		  "Gives {X:mult,C:white}X#1#{} Mult, {C:green}#2# in #3#{}",
		  "Chance to upgrade when this",
		  "{C:attention}joker triggers{}, retriggers the",
		  "{C:attention}all cards{} played {C:attention}#4# time{}",
      }
  },
  rarity = 3,
  pos = { x = 3, y = 1 },
  atlas = 'Modtest',
  cost = 8,
  in_pool = function(self, args)
    return false
  end,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.Xmult, (G.GAME.probabilities.normal or 1), card.ability.extra.odds, card.ability.extra.repetitions } }
	end,
	calculate = function(self, card, context)
		if context.cardarea == G.play and context.repetition then
			return {
				message = localize("k_again_ex"),
				repetitions = card.ability.extra.repetitions,
				card = card,
			}
		end
		if context.joker_main then
		    if pseudorandom('MichaelCatV3') < G.GAME.probabilities.normal / card.ability.extra.odds then
				G.E_MANAGER:add_event(Event({
					trigger = 'after',
					delay = 0.4,
					func = function()                           
						play_sound('timpani')
						SMODS.add_card({ set = 'joker', key = 'j_Krypton_MichaelCatV4'})                            
						card:juice_up(0.3, 0.5)
						SMODS.destroy_cards(card)
						return true
					end	
				}))	
			end	
			return {
			Xmult_mod = card.ability.extra.Xmult,
			message = localize { type = 'variable',  key = 'a_xmult', vars = { card.ability.extra.Xmult } },
			}   
	    end
	end
}

SMODS.Joker {
  key = 'MichaelCatV4',
  config = { extra = { emult = 1.25, repetitions = 1 } },
  loc_txt = {
	  name = 'Shelby - Loaf',
	  text = {
		  "Gives {X:purple,C:white}^#1#{} Mult",
		  "Retrigger{C:attention} ALL {}cards",
		  "{C:attention}#2#{} Time",
      }
  },
  rarity = 4,
  pos = { x = 1, y = 1 },
  atlas = 'Modtest',
  cost = 20,
    in_pool = function(self, args)
      return false
    end,   
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.emult, card.ability.extra.repetitions } }
	end,
	calculate = function(self, card, context)
		if context.cardarea == G.play and context.repetition then
			return {
				message = localize("k_again_ex"),
				repetitions = card.ability.extra.repetitions,
				card = card,
			}
		end	
		if context.cardarea == G.hand and context.repetition then
			return {
				message = localize("k_again_ex"),
				repetitions = card.ability.extra.repetitions,
				card = card,
			}
		end		
		if context.joker_main then	
			return {
			emult = card.ability.extra.emult,
			}   
	    end
	end
}

SMODS.Joker {
	key = 'IhateArchieKysDieDieDie',
	loc_txt = {
		name = 'Troll Joker',
		text = {
			"Grants {X:mult,C:white} X#3# {} Mult",
			"{C:mult}Annoying Bitch{} "
		}
	},
	
	config = { extra = { Xmult = 2.125 } },
	rarity = 1,
	atlas = 'Modtest',
	pos = { x = 4, y = 1 },
	cost = -1,
	
	loc_vars = function(self, info_queue, card)
		return { vars = { num, denom, card.ability.extra.Xmult } }
	end,

    calculate = function(self, card, context)
	if context.joker_main then
		G.jumpscare3 = 67676767 -- Number created by archiebald lawrence	
		return 
			{
			Xmult = card.ability.extra.Xmult 
			}
		end
		if not context.blueprint and context.end_of_round and context.game_over then
			if G.jumpscare3 == nil then G.jumpscare3 = 0 end
				G.jumpscare3 = 0
		end
	end,
}

SMODS.Joker {
  key = 'WEARESOBACK!ITSSOOVER!',
  config = { extra = { mult = 20, odds = 2 } },
  loc_txt = {
	  name = 'Slot Machine',
	  text = {
		  "Grants {C:mult}+#1#{} Mult, and {C:green}#2# in #3#{} to Double Mult",
		  "Else, Half Mult when {C:attention}Blind{} is selected",
		  "{C:inactive}Its Gamble 'o' clock{}",
      }
  },
  rarity = 2,
  pos = { x = 6, y = 1 },
  atlas = 'Modtest',
  cost = 6,
   
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.mult, (G.GAME.probabilities.normal), card.ability.extra.odds, } }
	end,
	calculate = function(self, card, context)
		if context.joker_main then
			return { mult = card.ability.extra.mult}
		end
		if pseudorandom('WEARESOBACK!ITSSOOVER!') < G.GAME.probabilities.normal / card.ability.extra.odds then
			if context.setting_blind and context.main_eval then
				card.ability.extra.mult = (card.ability.extra.mult * 2)
				return {
					message = "I Cant Stop Winning!",
					colour = G.C.MULT,
				}
			end
		end
		if pseudorandom('WEARESOBACK!ITSSOOVER!') >= G.GAME.probabilities.normal / card.ability.extra.odds then
			if context.setting_blind and context.main_eval then
				card.ability.extra.mult = (card.ability.extra.mult/2)
				return {
					message = 'Aw Dangit.',
					colour = G.C.MULT,
				}
			end
		end		
	end	
}

SMODS.Joker{
  key = 'Darkness',
  atlas = 'Modtest',
  loc_txt = {
	  name = 'Darkness',
	  text = {
		  "Gains {C:mult}+#2#{} Mult played hand is not{C:attention} Pair{}",
		  "Evokes all Mult when playing{C:attention} Pair{}",
		  "{C:inactive}(Currently {}{C:mult}+#1#{}{C:inactive} Mult){}"
      }
  },
  rarity = 1,
  cost = 4,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = false,
  pos = { x = 5, y = 1 },
  config = { extra = { MultMod = 6, mult = 0 } },
	
	loc_vars = function(self,info_queue,card)
		return {vars = {card.ability.extra.mult, card.ability.extra.MultMod}}
	end,
	
	calculate = function(self,card,context)
		if context.before and not (context.scoring_name == 'Pair') and not context.blueprint then
			card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.MultMod
			return {
				message = 'Upgrade!',
			}
		end
		if context.joker_main and (context.scoring_name == 'Pair') then
			return {
                message = 'Evoked!',
			    colour = G.C.MULT
			}
		end
		if context.final_scoring_step and (context.scoring_name == 'Pair') then
		    card.ability.extra.mult = 0
		end
	end,
}
--[[
SMODS.Joker {
  key = 'GreenJokerSoul',
  config = { extra = { rounds = 0, roundtotal = 2 } },
  loc_txt = {
	  name = "Green Joker's Soul",
	  text = {
		  "Sell this joker after {C:attention}#2#{} rounds to apply",
		  "a {C:green}Green Sticker{} to a random joker",
		  "{C:inactive}(Currently {}{C:attention}#1#{}{C:inactive}/#2#){}",
      }
  },
  rarity = 2,
  pos = { x = 4, y = 0 },
  atlas = 'Modtest',
  cost = 6,
   
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.rounds, card.ability.extra.roundtotal} }
	end,
	calculate = function(self, card, context)	
		if context.end_of_round then
			card.ability.extra.rounds = card.ability.extra.rounds + 1
		end
		if context.selling_self and card.ability.extra.rounds > card.ability.extra.roundtotal then
			
		end
	end	
}
--]]

------------------------------------------------------------------------------------------------------------------

local upd = Game.update
function Game:update(dt)
    upd(self, dt)

    if KryptonacidPack.ticks == nil then KryptonacidPack.ticks = 0 end
    if KryptonacidPack.dtcounter == nil then KryptonacidPack.dtcounter = 0 end
    KryptonacidPack.dtcounter = KryptonacidPack.dtcounter+dt
    KryptonacidPack.dt = dt

    while KryptonacidPack.dtcounter >= 0.010 do
        KryptonacidPack.ticks = KryptonacidPack.ticks + 1
        KryptonacidPack.dtcounter = KryptonacidPack.dtcounter - 0.010
        if G.jumpscare and G.jumpscare > 0 then G.jumpscare = G.jumpscare - 1 end
		if G.jumpscare2 and G.jumpscare2 > 0 then G.jumpscare2 = G.jumpscare2 - 1 end
		if G.jumpscare3 and G.jumpscare3 > 0 then G.jumpscare3 = G.jumpscare3 - 1 end
    end
end

local drawhook = love.draw
function love.draw()
    drawhook()
	
	
	function ImageLoader(fn)
        local full_path = (KryptonacidPack.path 
        .. "customimages/" .. fn)
        local file_data = assert(NFS.newFileData(full_path),("Epic fail"))
        local tempimagedata = assert(love.image.newImageData(file_data),("Epic fail 2"))
        return (assert(love.graphics.newImage(tempimagedata),("Epic fail 3")))
    end
	
	local _xscale = love.graphics.getWidth()/1920
    local _yscale = love.graphics.getHeight()/1080


    if KryptonacidPack.debug then
        love.graphics.setColor(255, 255, 255, 255) 
        love.graphics.print("ticks:"..KryptonacidPack.ticks, 300, 16)
        love.graphics.print("dtcounter:"..KryptonacidPack.dtcounter, 300, 16+32)
        love.graphics.print("dt:"..KryptonacidPack.dt, 300, 16+64)
    end
	
	if G.jumpscare and (G.jumpscare > 0) then
        if KryptonacidPack.Jumpscare == nil then KryptonacidPack.Jumpscare = ImageLoader("uncannyjokerscare.png") end
        love.graphics.setColor(1, 1, 1, 1) 
        love.graphics.draw(KryptonacidPack.Jumpscare, 0*_xscale*2, 0*_yscale*2,0,_xscale*2*2,_yscale*2*2)
    end
	
	if G.jumpscare2 and (G.jumpscare2 > 0) then
        if KryptonacidPack.Jumpscare2 == nil then KryptonacidPack.Jumpscare2 = ImageLoader("whitehousefloorplan.png") end
        love.graphics.setColor(1, 1, 1, 1) 
        love.graphics.draw(KryptonacidPack.Jumpscare2, 0*_xscale*2, 0*_yscale*2,0,_xscale*2*2,_yscale*2*2)
    end
	if G.jumpscare3 and (G.jumpscare3 > 0) then
        if KryptonacidPack.Jumpscare2 == nil then KryptonacidPack.Jumpscare2 = ImageLoader("Trollolo.png") end
        love.graphics.setColor(1, 1, 1, 0.8125) 
        love.graphics.draw(KryptonacidPack.Jumpscare2, 0*_xscale*2, 0*_yscale*2,0,_xscale*2*2,_yscale*2*2)
    end
end

local lcpref = Controller.L_cursor_press
function Controller:L_cursor_press(x, y)
    lcpref(self, x, y)
    if G and G.jokers and G.jokers.cards and not G.SETTINGS.paused then
        SMODS.calculate_context({ MouseClick = true })
    end
end
