SMODS.Sound{
    key = "goop",
    path = "goop.ogg"
}

SMODS.Sound{
    key = "goop1",
    path = "goop1.ogg"
}

SMODS.Sound{
    key = "goop2",
    path = "goop2.ogg"
}

SMODS.Sound{
    key = "mainmenu_music", 
    path = "alpistemain.ogg",
    pitch = 1.3,
    select_music_track = function(self)
        if G.STAGE == G.STAGES.MAIN_MENU then
            return 99999999
        end
    end
}