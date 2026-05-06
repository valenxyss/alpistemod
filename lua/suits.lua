SMODS.Atlas{
    key = "popotestsuit",
    path = "pooposuit.png",
    px = 71,
    py = 95
}

SMODS.Atlas{
    key = "hc_popotestsuit",
    path = "pooposuit2.png",
    px = 71,
    py = 95
}

SMODS.Atlas{
    key = "hc_popotestsuit",
    path = "pooposuit2.png",
    px = 71,
    py = 95
}


SMODS.Suit{
    key = "pooposuit",
    card_key = "popo",
    pos = {y = 0},
    ui_pos = {x = 0, y = 0},
    loc_txt = {
        singular = "Popos",
        plural = "Popo"
    },
    lc_atlas = "popotestsuit",
    hc_atlas = "hc_popotestsuit",
    in_pool = function(self,args)
        if G.GAME.selected_back_key and G.GAME.selected_back_key.key == "b_checkered" then
            return not args.initial_deck
        end
        return true
    end
}