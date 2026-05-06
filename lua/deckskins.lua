local rubi = SMODS.Atlas{
    key = "popotestrubi",
    path = "poposuitruby.png",
    px = 71,
    py = 95
}

local hcrubi = SMODS.Atlas{
    key = "hc_popotestrubi",
    path = "poposuitruby2.png",
    px = 71,
    py = 95
}

local ui = SMODS.Atlas{
    key = "popoui",
    path = "ui_assets.png",
    px = 18,
    py = 18
}

local hcui = SMODS.Atlas{
    key = "hc_popoui",
    path = "ui_assets_opt2.png",
    px = 18,
    py = 18
}

SMODS.DeckSkin {
	key = "poporubi",
	suit = "prb_pooposuit",
	loc_txt = "Example",
	palettes = {
		{
			key = 'lc',
			ranks = {'2', '3', '4', '5', '6', '7', '8', '9', '10', 'Jack', 'Queen', "King", "Ace",},
			display_ranks = {"King", "Queen", "Jack"},
			atlas = rubi.key,
			pos_style = 'suit',
			suit_icon = {
				atlas = ui.key,
			},
		},
		{
			key = 'hc',
			ranks = {'2', '3', '4', '5', '6', '7', '8', '9', '10', 'Jack', 'Queen', "King", "Ace",},
			display_ranks = {"King", "Queen", "Jack"},
			atlas = hcrubi.key,
			pos_style = 'suit',
			colour = HEX("451003"),
			suit_icon = {
				atlas = hcui.key
			},
		},
	},
}