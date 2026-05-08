SMODS.Atlas{
    key = "bbtrikz",
    path = "BbtrickDeck.png",
    px = 71,
    py = 95
}

SMODS.Back{
    key = "bbtrikz",
    atlas = "bbtrikz",
    pos = { x = 0, y = 0 },
    apply = function(self,back)
        G.E_MANAGER:add_event(Event({
            func = function()
                for k, v in pairs(G.playing_cards) do
                    if v.base.suit == 'Clubs' then 
                        v:change_suit("prb_pooposuit")
                    end
                    if v.base.suit == 'Diamonds' then 
                        v:change_suit("prb_pooposuit")
                    end
                    if v.base.suit == 'Spades' then 
                        v:start_dissolve()
                    end
                    if v.base.suit == 'Hearts' then 
                        v:start_dissolve()
                    end
                end
            return true
            end}))
    end
}

SMODS.Atlas{
    key = "spicy",
    path = "spicydeck.png",
    px = 71,
    py = 95
}

SMODS.Back{
    key = "spicy",
    atlas = "spicy",
    pos = { x = 0, y = 0 },
    apply = function (self,back)
        G.E_MANAGER:add_event(Event({
            func = function()
                for k, v in pairs(G.playing_cards) do
                    v:set_seal("Red", true, true)
                end
            return true
            end}))
    end,
    calculate = function (self,back,context)
        if context.setting_blind then  
            ease_hands_played(-G.GAME.current_round.hands_left + 1, true)
        end
    end
}

SMODS.Atlas{
    key = "camarada",
    path = "camaradadeck.png",
    px = 71,
    py = 95
}

SMODS.Back{
    key = "camarada",
    atlas = "camarada",
    pos = {x=0,y=0},
    calculate = function(self,back,context)
        if context.setting_blind then
            if #G.jokers.cards == 1 then
                G.jokers:unhighlight_all()
            end
            for k, v in ipairs(G.jokers.cards) do
                v:flip()
            end
            if #G.jokers.cards > 1 then 
                G.E_MANAGER:add_event(Event({ trigger = 'after', delay = 0.2, func = function() 
                    G.E_MANAGER:add_event(Event({ func = function() G.jokers:shuffle('aajk'); play_sound('cardSlide1', 0.85);return true end })) 
                    delay(0.15)
                    G.E_MANAGER:add_event(Event({ func = function() G.jokers:shuffle('aajk'); play_sound('cardSlide1', 1.15);return true end })) 
                    delay(0.15)
                    G.E_MANAGER:add_event(Event({ func = function() G.jokers:shuffle('aajk'); play_sound('cardSlide1', 1);return true end })) 
                    delay(0.5)
                return true end })) 
            end
        end
        if context.hand_drawn then
            G.E_MANAGER:add_event(Event({ trigger = 'after', delay = 0.2, func = function() 
                    G.E_MANAGER:add_event(Event({ func = function() G.jokers:shuffle('aajk'); play_sound('cardSlide1', 0.85);return true end })) 
                    delay(0.15)
                    G.E_MANAGER:add_event(Event({ func = function() G.jokers:shuffle('aajk'); play_sound('cardSlide1', 1.15);return true end })) 
                    delay(0.15)
                    G.E_MANAGER:add_event(Event({ func = function() G.jokers:shuffle('aajk'); play_sound('cardSlide1', 1);return true end })) 
                    delay(0.5)
            return true end })) 
        end
    end
}
--iradeck
SMODS.Atlas{
    key = "ira",
    path = "IraDeck.png",
    px = 71,
    py = 95
}
SMODS.Back{
    key = "ira",
    atlas = "ira",
    pos = {x=0,y=0},
    calculate = function (self, back, context)
        if context.setting_blind then
            for i = 1, 67 do
                local tung = create_card("Joker", G.jokers, nil, nil, nil, nil, "j_prb_tungsahur", "ira")
                tung:add_to_deck()
                G.jokers:emplace(tung)
                tung:start_materialize()
                tung:set_edition('e_negative')
                tung:add_sticker("eternal", true)
            end
        end
    end
}
