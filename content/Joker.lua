SMODS.Sound {
	key = "emult",
	path = "ExponentialMult.ogg",
}
SMODS.Sound {
	key = "echips",
	path = "ExponentialChips.ogg",
}
SMODS.Sound {
	key = "eemult",
	path = "TetrationalMult.ogg",
}
SMODS.Sound {
	key = "eechips",
	path = "TetrationalChips.ogg",
}


SMODS.Atlas {
  key = 'modicon',
  px = 33,
  py = 34,
  path = 'modicon.png'
}
		
SMODS.ObjectType({
    key = "Krypton_KryptonJoker",
    default = "j_Krypton_UncommonJoker", 
    cards = {
		["j_Krypton_UncommonJoker"] = true,
		["j_Krypton_GreenestJoker"] = true,
		["j_Krypton_BluerJoker"] = true,
		["j_Krypton_UncommonJoker"] = true,
		["j_Krypton_92pxjoker"] = true,
	    ["j_Krypton_Obese_Joker"] = true,
		["j_Krypton_JimboExe"] = true,
		["j_Krypton_LiamCat"] = true,
		["j_Krypton_SCREWSCREWSCREW"] = true,
		["j_Krypton_LoganPaulJoker"] = true,
		["j_Krypton_bettingonanout"] = true,
		["j_Krypton_MichaelCatV1"] = true,
		["j_Krypton_IhateArchieKysDieDieDie"] = true,
		["j_Krypton_WEARESOBACK!ITSSOOVER!"] = true,
		["j_Krypton_Darkness"] = true,
		["j_Krypton_GreenJokerSoul"] = true,
		["j_Krypton_Possum"] = true,
		["j_Krypton_Ryu_Ishigori"] = true,
		["j_Krypton_Ryu_Ishigori"] = true,	
		["j_Krypton_DihuiBlade"] = true,
		["j_Krypton_DihuiSword"] = true,
		["j_Krypton_Israel"] = true,
		["j_Krypton_JokerGPT"] = true,
		["j_Krypton_Event_Horizon"] = true,
		["j_Krypton_Jewpiter"] = true,
    },
})

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
	config = { extra = { mult = 20 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.mult } }
	end,
	rarity = 2,
	atlas = 'Modtest',
	pos = { x = 10, y = 0 },
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
	pos = { x = 11, y = 0 },
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

SMODS.Joker {
  key = 'Obese_Joker',
  rarity = 3,
  pos = { x = 4, y = 1 },
  config = { extra = { Xmult = 1.05, Scalar = 0.02, odds = 2 } },
  loc_txt = {
      name = 'Obese Joker',
	  text = {
		  "All cards score {X:mult,C:white}X#1#{} But,",
          "{C:green} #2# in #3# {}chance Cards Scored",
		  "Are {C:attention}Eaten{}, And Gains",
		  "{X:mult,C:white}X#4#{} Per Card {C:attention}Eaten{}"
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
		return { vars = { card.ability.extra.Xmult, (G.GAME.probabilities.normal or 1), card.ability.extra.odds, card.ability.extra.Scalar } }
	end,
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play then
				return {
					Xmult = card.ability.extra.Xmult,
				}
			end		
		
		if not context.blueprint and context.after and context.main_eval and pseudorandom('Obese_Joker') < G.GAME.probabilities.normal / card.ability.extra.odds then
          local destroyed_cards = {}		  
	      if pseudorandom('Obese_Joker') < G.GAME.probabilities.normal / card.ability.extra.odds then
			for _, v in ipairs(G.play.cards) do
				destroyed_cards[#destroyed_cards + 1] = v
				card.ability.extra.Xmult = card.ability.extra.Xmult + card.ability.extra.Scalar
			end
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
	pos = { x = 0, y = 1 },
	cost = 5,
	
	loc_vars = function(self, info_queue, card)
		local num, denom = SMODS.get_probability_vars(card, card.ability.extra.numerator, card.ability.extra.denominator)
		return { vars = { num, denom, card.ability.extra.Xmult } }
	end,

    calculate = function(self, card, context)
	if context.joker_main then
		if SMODS.pseudorandom_probability(card, 'JimboExe', card.ability.extra.numerator, card.ability.extra.denominator) then G.jumpscare2 = 230 else G.jumpscare = 230 end	
		if SMODS.pseudorandom_probability(card, 'JimboExe', card.ability.extra.numerator, card.ability.extra.denominator) then play_sound("Krypton_Lobotomy") else play_sound("Krypton_EvilScream") end
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
			"{X:mult,C:white} X#3# {} Mult, Gains {X:mult,C:white}X#4#{} When {C:attention}Clicked on",
			"{C:green}#1# in #2#{} Chance to {C:mult}Destroy{} Itself",
			"When {C:attention}Clicked on",
			"{C:inactive}(Currently {X:mult,C:white}X#5#{}{C:inactive} Mult){}",
			"{C:inactive,s:0.6}Superior race{}",
		}
	},
	config = { extra = { odds = 15, Xmult = 1, currentquip = 0, Xquips = { 'Meow!', 'Munch Munch Munch', 'The Fog is Coming', 'I am Literally scratching your furniture' }, TotalXMult = 1, XmultScaler = 0.15 }, },
	loc_vars = function(self, info_queue, card)
		return { vars = { (G.GAME.probabilities.normal or 1), card.ability.extra.odds, card.ability.extra.Xmult, card.ability.extra.XmultScaler, card.ability.extra.TotalXMult } }
	end,
	rarity = 2,
	atlas = 'Modtest',
	pos = { x = 3, y = 1 },
	eternal_compat = false,
	calculate = function(self, card, context)
	if context.MouseClick and card.states.hover.is == true then
        if pseudorandom('LiamCat') > G.GAME.probabilities.normal / card.ability.extra.odds then
			card.ability.extra.TotalXMult = (card.ability.extra.TotalXMult + card.ability.extra.XmultScaler)
			return {
				message = ('X' .. card.ability.extra.TotalXMult),
				colour = G.C.MULT
			}
		end
		if pseudorandom('LiamCat') < G.GAME.probabilities.normal / card.ability.extra.odds then
			SMODS.destroy_cards(card)
		end
	end
	if context.joker_main then
		card.ability.extra.currentquip = card.ability.extra.currentquip + 1
        if card.ability.extra.currentquip > 4 then
           card.ability.extra.currentquip = 1
        end
		return {
	       	Xmult_mod = card.ability.extra.TotalXMult,
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
  pos = { x = 6, y = 1 },
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
    default = "j_green_joker", -- this is what it should give when you have all of them and showman
    cards = {
        ["j_green_joker"] = true,
        ["j_Krypton_UncommonJoker"] = true,
        ["j_Krypton_GreenestJoker"] = true,
		["j_Krypton_GreenSquare"] = true,
		["j_Krypton_GreenJokerSoul"] = true,
		["e_Krypton_Green"] = true,
		["j_Krypton_Ryu_Ishigori"] = true,
    },
})

SMODS.Joker {
	key = 'GreenSquare',
	loc_txt = {
		name = 'Green Square',
		text = {
			"{X:purple,C:white} ^#1# {} Mult, Increases by {X:purple,C:white} ^#2# {}",
			" For each {C:Krypton_green}Green Joker{} owned",
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
	pos = { x = 13, y = 0 },
	cost = 20,
	calculate = function(self, card, context)
    greencount = 0
    for i = 1, #G.jokers.cards do
        if G.jokers.cards[i].config.center.pools and G.jokers.cards[i].config.center.pools.Krypton_Green then
            greencount = greencount + 1
        end
    end
	card.ability.extra.emulttotal = (greencount - 1) * card.ability.extra.emult_mod + card.ability.extra.emult
	if context.joker_main then		
		return {
            emult = card.ability.extra.emulttotal,
			remove_default_message = true,
			message = ('^' .. card.ability.extra.emulttotal), 
			colour = G.C.PURPLE,
			sound = 'Krypton_emult',
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
		["j_Krypton_Logan"] = true,
		["j_Krypton_Ryu_Ishigori"] = true,
		
    },
})

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
			'{C:dark_edition}Negative Soul{} Card When {C:attention}Cards Score{}',
			'{C:inactive}(Self destructs){}'
        },
    },
    pos = { x = 1, y = 0},
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

SMODS.ObjectType({
    key = "Krypton_MichealCats",
    default = "j_Krypton_MichaelCatV1", 
    cards = {
        ["j_Krypton_MichaelCatV1"] = true,
        ["j_Krypton_MichaelCatV2"] = true,
        ["j_Krypton_MichaelCatV3"] = true,
		["j_Krypton_MichaelCatV4"] = true,
		
    },
})

SMODS.Joker {
  key = 'MichaelCatV1',
  config = { extra = { mult = 10, odds = 10, oddsscale = 5 } },
  loc_txt = {
	  name = 'Shelby',
	  text = {
		  "Gives {C:mult}+#1#{} Mult",
		  "{C:green}#2# in #3#{} Chance to upgrade",
		  "when this {C:attention}joker triggers{}",
      }
  },
  rarity = 1,
  pos = { x = 7, y = 1 },
  atlas = 'Modtest',
  cost = 5,
  eternal_compat = false,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.mult, (G.GAME.probabilities.normal or 1), card.ability.extra.odds } }
	end,
	calculate = function(self, card, context)
		kittycount = 0
		for i = 1, #G.jokers.cards do
			if G.jokers.cards[i].config.center.pools and G.jokers.cards[i].config.center.pools.Krypton_MichealCats then
				kittycount = kittycount + 1
			end
		end
		if kittycount >= 2 then
			card.ability.extra.odds = card.ability.extra.oddsscale * (card.ability.extra.oddsscale ^ (kittycount - 1))
		end
		if context.final_scoring_step and not context.blueprint then
		    if pseudorandom('MichaelCatV1') < G.GAME.probabilities.normal / card.ability.extra.odds then
				G.E_MANAGER:add_event(Event({
					trigger = 'after',
					delay = 0.4,
					func = function()                           
						play_sound('timpani')
						SMODS.add_card({ set = 'joker', key = 'j_Krypton_MichaelCatV2', edition = card.edition})                            
						card:juice_up(0.3, 0.5)
						SMODS.destroy_cards(card)
						return true
					end	
				}))	
			end	
		end
		if context.joker_main then
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
  pos = { x = 8, y = 1 },
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
		if context.final_scoring_step and not context.blueprint then
		    if pseudorandom('MichaelCatV2') < G.GAME.probabilities.normal / card.ability.extra.odds then
				G.E_MANAGER:add_event(Event({
					trigger = 'after',
					delay = 0.4,
					func = function()                           
						play_sound('timpani')
						SMODS.add_card({ set = 'joker', key = 'j_Krypton_MichaelCatV3', edition = card.edition})                            
						card:juice_up(0.3, 0.5)
						SMODS.destroy_cards(card)
						return true
					end	
				}))	
			end	
		end
		if context.joker_main then
			return {
			Xmult_mod = card.ability.extra.Xmult,
			message = localize { type = 'variable',  key = 'a_xmult', vars = { card.ability.extra.Xmult } },
			}   
	    end
	end
}

SMODS.Joker {
  key = 'MichaelCatV3',
  config = { extra = { Xmult = 2.5, odds = 25, repetitions = 1 } },
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
  pos = { x = 10, y = 1 },
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
		if context.final_scoring_step and not context.blueprint then
		    if pseudorandom('MichaelCatV3') < G.GAME.probabilities.normal / card.ability.extra.odds then
				G.E_MANAGER:add_event(Event({
					trigger = 'after',
					delay = 0.4,
					func = function()                           
						play_sound('timpani')
						SMODS.add_card({ set = 'joker', key = 'j_Krypton_MichaelCatV4', edition = card.edition})                            
						card:juice_up(0.3, 0.5)
						SMODS.destroy_cards(card)
						return true
					end	
				}))	
			end	
		end
		if context.joker_main then
			return {
			Xmult = card.ability.extra.Xmult,
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
		  "{C:inactive,s:0.6}Penultimate.{}",
      }
  },
  rarity = 4,
  pos = { x = 9, y = 1 },
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
			remove_default_message = true,
			message = ('^' .. card.ability.extra.emult),
			colour = G.C.PURPLE,
			sound = 'Krypton_emult',
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
			"{C:mult,s:1.1}Annoying Bitch{} "
		}
	},
	
	config = { extra = { Xmult = 2.25 } },
	rarity = 1,
	atlas = 'Modtest',
	pos = { x = 2, y = 1 },
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
		if not context.blueprint and context.end_of_round and context.game_over or context.selling_self then
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
  pos = { x = 11, y = 1 },
  atlas = 'Modtest',
  cost = 6,
   
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.mult, (G.GAME.probabilities.normal), card.ability.extra.odds, } }
	end,
	calculate = function(self, card, context)
		if context.joker_main then
			return { mult = card.ability.extra.mult}
		end
		if pseudorandom('WEARESOBACK!ITSSOOVER!') <= G.GAME.probabilities.normal / card.ability.extra.odds then
			if context.setting_blind and context.main_eval then
				card.ability.extra.mult = (card.ability.extra.mult * 2)
				return {
					message = "I Cant Stop Winning!",
					colour = G.C.MULT,
				}
			end
		else
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
  pos = { x = 5, y = 0 },
  config = { extra = { MultMod = 10, mult = 0 } },
	
	loc_vars = function(self,info_queue,card)
		return {vars = {card.ability.extra.mult, card.ability.extra.MultMod}}
	end,
	
	calculate = function(self,card,context)
		if context.before and not (context.scoring_name == 'Pair') and not context.blueprint then
			card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.MultMod
			return {
				message = 'Upgrade!',
				color = G.C.MULT,
			}
		end
		if context.joker_main and (context.scoring_name == 'Pair') then
			return {
				mult_mod = card.ability.extra.mult,
				message = 'Evoked!',
				color = G.C.MULT,
			}
		end
		if context.final_scoring_step and (context.scoring_name == 'Pair') then
		    card.ability.extra.mult = 0
		end
	end,
}

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
  rarity = 2,
  pos = { x = 12, y = 0 },
  atlas = 'Modtest',
  cost = 6,
   
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
--
SMODS.ObjectType({
    key = "Krypton_Cat",
    default = "j_lucky_cat", -- this is what it should give when you have all of them and showman
    cards = {
        ["j_lucky_cat"] = true,
        ["j_Krypton_LiamCat"] = true,
        ["j_Krypton_MichaelCatV1"] = true,
		["j_Krypton_MichaelCatV2"] = true,
		["j_Krypton_MichaelCatV3"] = true,
		["j_Krypton_MichaelCatV4"] = true,
		["j_Krypton_Possum"] = true,
		["j_Krypton_MyCutiePatootie"] = true,
		["j_Krypton_Ryu_Ishigori"] = true,
    },
})

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
		CatCount = 0
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

SMODS.Joker {
  key = 'Possum',
  config = { extra = { Xmult = 2, dollars = 5, odds = 10 } },
  loc_txt = {
	  name = 'Possum',
	  text = {
		  "Gives {X:mult,C:white}X#1#{} Mult",
		  "Gain {C:money}$#4#{} at {C:attention}Round End{}",
		  "{C:green}#2# in #3#{} Chance to {C:attention}Destroy",
		  "Itself at end of {C:attention}Blind{}"
      }
  },
  rarity = 2,
  pos = { x = 5, y = 1 },
  atlas = 'Modtest',
  cost = 5,
  eternal_compat = false,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.Xmult, (G.GAME.probabilities.normal or 1), card.ability.extra.odds, card.ability.extra.dollars } }
	end,
	calculate = function(self, card, context)
		if context.end_of_round and context.main_eval and not context.blueprint then
		    if pseudorandom('Possum') < G.GAME.probabilities.normal / card.ability.extra.odds then
				G.E_MANAGER:add_event(Event({
					trigger = 'after',
					delay = 0.4,
					func = function()                           
						play_sound('timpani')                           
						card:juice_up(0.3, 0.5)
						SMODS.destroy_cards(card)
						return true
					end	
				}))	
			end	
		end
		if context.joker_main then
			return {
				Xmult_mod = card.ability.extra.Xmult,
				message = localize { type = 'variable',  key = 'a_xmult', vars = { card.ability.extra.Xmult } },
			}   
		end
	end,
	calc_dollar_bonus = function(self, card)
		return card.ability.extra.dollars
	end
}


SMODS.Joker {
	key = 'DihuiBladeSword',
	loc_txt = {
		name = "Dihui star's blade",
		text = {
			"{C:attention}Retrigger {}all {C:Krypton_bladetrail}Bladetrail Cards {}{C:attention}#1#{} time(s).",
			"{C:inactive,s:0.7}Lacerating Afterimages from Myriad Moments{}",
		}
	},

	config = { extra = { repetitions = 1 } },
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS.m_Krypton_BladeTrailCard		
		return { vars = { card.ability.extra.repetitions } }
	end,
	rarity = 3,
	atlas = 'Modtest',
	pos = { x = 7, y = 0},
	cost = 8,
	calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play and SMODS.get_enhancements(context.other_card)["m_Krypton_BladeTrailCard"] == true then
            return {
                message = localize('k_again_ex'),
                repetitions = 1,
                card = card
            }
		end
	end
}

SMODS.Joker {
	key = 'DihuiBlade',
	loc_txt = {
		name = "Dihui star's Sheath",
		text = {
			"All {C:Krypton_bladetrail}Bladetrail{} Cards Score {C:attention}Bonus{}",
			"{X:chips,C:white}XChips{} Equal to their {X:mult,C:white}XMult{}",
			"{C:inactive,s:0.7}'. . .  I'm weary of this stigma of a blade.'{}",
		}
	},

	config = { extra = { repetitions = 1 } },
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS.m_Krypton_BladeTrailCard		
		return { vars = { card.ability.extra.repetitions } }
	end,
	rarity = 2,
	atlas = 'Modtest',
	pos = { x = 8, y = 0},
	cost = 6,
}

SMODS.Joker {
	key = 'Israel',
	loc_txt = {
		name = "Israel",
		text = {
			"Stores {C:attention}ALL{} {C:money}Money{} Gained.",
			"Gain {C:attention}Sell Value{} Equal to",
			"{X:money,C:white}#1#X{} Stored {C:money}Money{}",
			"{C:inactive,s:0.65}Your money was promised{}",
			"{C:inactive,s:0.65}to it 3000 years ago.{}",
		}
	},

	config = { extra = { Xmoney = 3, StoredMoney = 0} },
	loc_vars = function(self, info_queue, card)	
		return { vars = { card.ability.extra.Xmoney } }
	end,
	rarity = 3,
	atlas = 'Modtest',
	pos = { x = 13, y = 1},
	cost = 10,
	calculate = function(self, card, context)
		if to_big(G.GAME.dollars) >= to_big(0) then
			card.ability.extra_value = card.ability.extra_value + (G.GAME.dollars * card.ability.extra.Xmoney)
            card:set_cost()
			G.GAME.dollars = 0
		end
    end,
}

SMODS.ObjectType({
    key = "Krypton_AIFuel",
    default = "j_splash", -- this is what it should give when you have all of them and showman
    cards = {
        ["j_splash"] = true,
		["j_Krypton_Ryu_Ishigori"] = true,
    },
})

SMODS.Joker {
	key = 'JokerGPT',
	loc_txt = {
		name = "JokerGPT",
		text = {
			"If {C:blue}Splash{} is present at {C:attention}End of Round{},",
			"This Joker {C:attention}Destroys{} it and creates",
			" a Random {C:dark_edition}Negative{} {C:attention}Common{} Joker",
			"{C:inactive,s:0.7}Filthy Clanker{}",
		}
	},

	config = { extra = {} },
	loc_vars = function(self, info_queue, card)	
        info_queue[#info_queue+1] = G.P_CENTERS.j_splash		
		return { vars = { card.ability.extra.Xmoney } }
	end,
	rarity = 2,
	atlas = 'Modtest',
	pos = { x = 14, y = 1},
	cost = 6,
	calculate = function(self, card, context)
		if context.end_of_round and context.main_eval then
			local AIFuel = {}
			for k, v in pairs(G.jokers.cards) do 
				if G.jokers.cards[k].config.center.pools and G.jokers.cards[k].config.center.pools.Krypton_AIFuel then
					table.insert(AIFuel, v)
				end
			end
			if #AIFuel > 0 then
				local AIFuelWinner =
					pseudorandom_element(AIFuel, pseudoseed("AIFuel"))
				SMODS.destroy_cards(AIFuelWinner)
				G.E_MANAGER:add_event(Event({
					trigger = 'after',
					delay = 0.4,
					func = function()
						play_sound('timpani')
						SMODS.add_card({ set = 'Joker', rarity = 'Common' , edition = 'e_negative' })
						card:juice_up(0.3, 0.5)
						message = 'Generated!'
						return true
					end
				}))
			end
		end
    end
}

SMODS.Joker {
	key = 'Event_Horizon',
	loc_txt = {
		name = 'Event Horizon',
		text = {
			'A {C:attention}Random{} Joker is Destroyed at {C:attention}Round end{},',
			'and {C:attention}another{} gains {X:mult,C:white}X#1#{} {C:Krypton_stats}Stats{}',
			'{C:inactive}(Cannot affect itself){}',
		}
	},
	config = { extra = { increase = 1.15 } },
	rarity = 3,
	eternal_compat = false,
	cost = 11,
	atlas = 'Modtest',
	pos = { x = 0, y = 2},
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.increase } }
	end,
	calculate = function(self, card, context)
		if context.end_of_round and context.main_eval then
			local BlackHoleTable = {}			
			for k, v in pairs(G.jokers.cards) do					
				if G.jokers.cards[k].ability.name ~= card.ability.name then
					table.insert(BlackHoleTable, v)
				end	
			end
			if #BlackHoleTable > 0 then
				local IncreasedJoker =
					pseudorandom_element(BlackHoleTable, pseudoseed("BlackHoleTable"))
				if IncreasedJoker ~= card then
					if not Card.no(IncreasedJoker, "immutable", true) or self.key then
						KryptonacidPack.manipulate(IncreasedJoker, { value = card.ability.extra.increase })
						check = true
					end
				end
				local AbsorbedJoker =
					pseudorandom_element(BlackHoleTable, pseudoseed("Spagehttification"))
				SMODS.destroy_cards(AbsorbedJoker)
			end
			local check = false
			if check then
				card_eval_status_text(
					card,
					"extra",
					nil,
					nil,
					nil,
					{ message = localize("k_upgrade_ex"), colour = G.C.GREEN }
				)
			end
		end
	end,
}

SMODS.Joker {
	key = 'JewPiter',
	loc_txt = {
		name = 'Jewpiter',
		text = {
			'If {C:attention}Poker Hand{} Is a {C:attention}Flush,{}',
			'Earn {C:money}$#1#{} And increase payout by {C:money}$#2#{}',
			'{C:attention}Increase{} by {C:money}$#3#{} If {C:attention}Poker hand{} is a',
			'{C:attention}Straight Flush{} Instead, And Payout {X:money,C:white}#4#X{}',
			'{C:inactive}(Resets on Non-Flush Containing Hand){}'
		}
	},
	config = { extra = { Dollars = 1, FlushIncrease = 1, StraightFlushIncrease = 2, XDollars = 2 } },
	rarity = 2,
	cost = 7,
	atlas = 'Modtest',
	pos = { x = 1, y = 2},
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.Dollars, card.ability.extra.FlushIncrease, card.ability.extra.StraightFlushIncrease, card.ability.extra.XDollars } }
	end,
	calculate = function(self, card, context)
		if context.before and (context.scoring_name == 'Flush') then
			card.ability.extra.Dollars = card.ability.extra.Dollars + card.ability.extra.FlushIncrease
			return {
				message = 'Upgrade!',
				color = G.C.MONEY,
			}
		end
		if context.joker_main and (context.scoring_name == 'Flush') then
			return {
				dollars = card.ability.extra.Dollars,
			}
		end
		if context.before and (context.scoring_name == 'Straight Flush') then
			card.ability.extra.Dollars = card.ability.extra.Dollars + card.ability.extra.StraightFlushIncrease
			return {
				message = 'Upgrade!',
				color = G.C.MONEY,
			}
		end
		if context.joker_main and (context.scoring_name == 'Straight Flush' or context.scoring_name == 'Flush House') then
			return {
				dollars = (card.ability.extra.Dollars * card.ability.extra.XDollars),
			}
		end
		if context.final_scoring_step and not (context.scoring_name == 'Flush' or context.scoring_name == 'Straight Flush' or context.scoring_name == 'Flush Five' or context.scoring_name == 'Flush House') and card.ability.extra.Dollars > 1 then
		    card.ability.extra.Dollars = 1
			return {	
				message = 'Reset',
				color = G.C.MONEY,
			}
		end
	end,
}

SMODS.Joker {
	key = 'Idle_Transfiguration',
	loc_txt = {
		name = 'Idle Transfiguration',
		text = {
			'After {C:attention}#2#{} Round(s), {C:attention}Sell{} this Joker',
			'To remove {C:mult}ALL{} {C:attention}stickers{} and',
			'{C:attention}Shuffle{} {C:mult}ALL{} editions on Jokers',
			'{C:inactive}(Currently {C:attention}#1#{}{C:inactive}/#2#){}',
			'{C:purple,s:0.8}"Mui Tenten."{}',
		}
	},
	config = { extra = { Rounds = 0, RoundsTotal = 0 } },
	rarity = 2,
	cost = 5,
	atlas = 'Modtest',
	pos = { x = 2, y = 2},
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.Rounds, card.ability.extra.RoundsTotal } }
	end,
	calculate = function(self, card, context)
		if context.selling_self and card.ability.extra.Rounds >= card.ability.extra.RoundsTotal and not context.blueprint  then
			local modifiers = {}
			for k, v in pairs(G.jokers.cards) do
				if v.edition then
					table.insert(modifiers, {edition = true, key = v.edition.key})
					v:set_edition(nil, true, true)
				end
				for kk, vv in pairs(SMODS.Stickers) do
					if v.ability[vv.key] then
						v:remove_sticker(vv.key)
					end
				end
			end
			pseudoshuffle(modifiers, 'seed')
			for k, v in pairs(modifiers) do
				local RandomJonkler = {}
				for kk, vv in pairs(G.jokers.cards) do
					if (v.edition and not vv.edition) and G.jokers.cards[kk].ability.name ~= card.ability.name then
						table.insert(RandomJonkler, vv)
					end
				end
				if next(RandomJonkler)then 
					local joker = pseudorandom_element(RandomJonkler)
					if v.edition then 
						joker:set_edition(v.key)
					end
				end
			end
		end
		if context.end_of_round and context.main_eval and card.ability.extra.Rounds < card.ability.extra.RoundsTotal and not context.blueprint then
			card.ability.extra.Rounds = card.ability.extra.Rounds + 1
			return {
				message = (card.ability.extra.Rounds .. '/' .. card.ability.extra.RoundsTotal),
				colour = G.C.PURPLE,
			}	
		end
		if context.end_of_round and context.main_eval and card.ability.extra.Rounds >= card.ability.extra.RoundsTotal and not context.blueprint then
			return { 
				message = 'Active!',
				colour = G.C.PURPLE,
			}
		end
	end,
}
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
        love.graphics.setColor(1, 1, 1, 0.725) 
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
