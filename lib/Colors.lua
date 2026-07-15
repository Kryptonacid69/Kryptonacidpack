G.C.HEX = { 
    BLADETRAILLIGHT = HEX("36CAF2"),
	BLADETRAILDARK = HEX("0068E0"),
	GREENLIGHT = HEX("74B72E"),
	GREENDARK = HEX("028A0F"),
	BLOOMDARK = HEX("B77714"),
	BLOOMLIGHT = HEX("FFE714"),
}

SMODS.Gradient({
    key = "stats",
    colours = { G.C.CHIPS, G.C.MULT },
    cycle = 4,
})

SMODS.Gradient({
    key = "bladetrail",
    colours = { G.C.HEX.BLADETRAILDARK, G.C.HEX.BLADETRAILLIGHT },
    cycle = 5,
})

SMODS.Gradient({
    key = "green",
    colours = { G.C.HEX.GREENLIGHT, G.C.HEX.GREENDARK },
    cycle = 5,
})

SMODS.Gradient({
    key = "bloom",
    colours = { G.C.HEX.BLOOMDARK, G.C.HEX.BLOOMLIGHT },
    cycle = 6,
})

G.C.HEX.STATS = SMODS.Gradients.Krypton_stats
G.C.HEX.BLADETRAIL = SMODS.Gradients.Krypton_bladetrail
G.C.HEX.GREEN = SMODS.Gradients.Krypton_green
G.C.HEX.BLOOM = SMODS.Gradients.Krypton_bloom

local loc_colour_ref = loc_colour
function loc_colour(_c, _default)
    if not G.ARGS.LOC_COLOURS then
        loc_colour_ref()
    end
   
   G.ARGS.LOC_COLOURS.Krypton_stats = G.C.HEX.STATS
   G.ARGS.LOC_COLOURS.Krypton_bladetrail = G.C.HEX.BLADETRAIL
   G.ARGS.LOC_COLOURS.Krypton_green = G.C.HEX.GREEN
   G.ARGS.LOC_COLOURS.Krypton_bloom = G.C.HEX.BLOOM

    return loc_colour_ref(_c, _default)
end