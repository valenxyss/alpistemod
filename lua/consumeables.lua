SMODS.Atlas{
    key = "torrija",
    path = "Torrija.png",
    px = 71,
    py = 95
}


SMODS.Consumable{
    key = "torrija",
    set = "Spectral",
    loc_txt = {
        name = "Torrija",
        text = {
            "Agarra {C:attention}3 cartas{}",
            "elegidas a tu gusto,",
            "y les pone {C:attention}un sello, encantamiento",
            "{C:attencion}edicion{}",
            "aleatorias.",
            "No da chachisellos",
            "Deja el {C:money}dinero{} a 0",
        }
    } ,
    atlas = "torrija",
    pos = {x = 0, y = 0},
    cost = 3,
    can_use = function (self,card)
        if G and G.hand then
            if #G.hand.highlighted ~= 0 and #G.hand.highlighted <= 3 then
                return true
            end
            return false
        end
    end,
    use = function (self, card, area, copier)
        ease_dollars(-G.GAME.dollars)
        for i = 1, #G.hand.highlighted do
            local sealroll = math.floor(pseudorandom("torrija") * 3)
            if sealroll == 0 then
                G.hand.highlighted[i]:set_seal("Red", true)
            elseif sealroll == 1 then
                G.hand.highlighted[i]:set_seal("Blue", true)
            elseif sealroll == 2 then
                G.hand.highlighted[i]:set_seal("Gold", true)
            elseif sealroll == 3 then
                G.hand.highlighted[i]:set_seal("Purple", true)
            end
            local editionroll = math.floor(pseudorandom("torrijaedition") * 2)
            if editionroll == 0 then
                G.hand.highlighted[i]:set_edition({polychrome = true}, true)
            elseif editionroll == 1 then
                G.hand.highlighted[i]:set_edition({foil = true}, true)
            elseif editionroll == 2 then
                G.hand.highlighted[i]:set_edition({holographic = true}, true)
            end
            local enhancedroll = math.floor(pseudorandom("torrijaenhanced") * 7)
            if enhancedroll == 0 then
                G.hand.highlighted[i]:set_ability(G.P_CENTERS.m_gold, nil, true)
            elseif enhancedroll == 1 then
                G.hand.highlighted[i]:set_ability(G.P_CENTERS.m_bonus, nil, true)
            elseif enhancedroll == 2 then
                G.hand.highlighted[i]:set_ability(G.P_CENTERS.m_glass, nil, true)
            elseif enhancedroll == 3 then
                G.hand.highlighted[i]:set_ability(G.P_CENTERS.m_lucky, nil, true)
            elseif enhancedroll == 4 then
                G.hand.highlighted[i]:set_ability(G.P_CENTERS.m_mult, nil, true)
            elseif enhancedroll == 5 then
                G.hand.highlighted[i]:set_ability(G.P_CENTERS.m_steel, nil, true)
            elseif enhancedroll == 6 then
                G.hand.highlighted[i]:set_ability(G.P_CENTERS.m_stone, nil, true)
            elseif enhancedroll == 7 then
                G.hand.highlighted[i]:set_ability(G.P_CENTERS.m_wild, nil, true)
            end
        end
    end
}

SMODS.Atlas{
    key = "polvoron",
    path = "Polvoron.png",
    px = 71,
    py = 95
}

SMODS.Consumable{
    key = "polvoron",
    set = "Spectral",
    loc_txt = {
        name = "Polvoron",
        text = {
            "Elige a un {C:attention}joker{}",
            "cuando uses el {C:spectral}Polvoron{},",
            "todos los {C:attention}jokers que",
            "tengas {C:attention}actualmente",
            "se {C:red}eliminaran{}, y",
            "generara la misma",
            "cantidad de jokers que",
            "tenias antes, pero",
            "ahora todos tienen",
            "la {C:edition}rareza{} del",
            "joker que has {C:attention}seleccionado{}"
        }
    } ,
    atlas = "polvoron",
    pos = {x = 0, y = 0},
    cost = 3,
    can_use = function (self,card)
        if G and G.jokers then
            if #G.jokers.highlighted ~= 0 and #G.jokers <= 3 then
                return true
            end
            return false
        end
    end,
    use = function (self, card, area, copier)
        local jokernumber = #G.jokers.cards
        if #G.jokers.cards > 5 then
            jokernumber = 5
        end
        local rarity_to_give = G.jokers.highlighted[1]
        for i = 1, #G.jokers.cards do
            local jokers_destroyed = G.jokers.cards[i]
            jokers_destroyed:start_dissolve()
        end
        if rarity_to_give.config.center.rarity == 1 then
            for i = 1, jokernumber do
                local card = create_card('Joker', G.jokers, nil, 0, nil, nil, nil, 'rif')
                card:add_to_deck()
                G.jokers:emplace(card)
                card:start_materialize()
                G.GAME.joker_buffer = 0
            end
        elseif rarity_to_give.config.center.rarity == 2 then
            for i = 1, jokernumber do
                local card = create_card('Joker', G.jokers, nil, 0.71, nil, nil, nil, 'rif')
                card:add_to_deck()
                G.jokers:emplace(card)
                card:start_materialize()
                G.GAME.joker_buffer = 0
            end
        elseif rarity_to_give.config.center.rarity == 3 then
            for i = 1, jokernumber do
                local card = create_card('Joker', G.jokers, nil, 1, nil, nil, nil, 'rif')
                card:add_to_deck()
                G.jokers:emplace(card)
                card:start_materialize()
                G.GAME.joker_buffer = 0
            end
        elseif rarity_to_give.config.center.rarity > 3 then
            for i = 1, jokernumber do
                local card = create_card('Joker', G.jokers, true, nil, nil, nil, nil, 'rif')
                card:add_to_deck()
                G.jokers:emplace(card)
                card:start_materialize()
                G.GAME.joker_buffer = 0
            end
        end
    end
}

SMODS.Atlas{
    key = "alpiste",
    path = "AlpisteTarot.png",
    px = 71,
    py = 95
}

SMODS.Consumable {
    set = "Tarot",
    key = "alpiste",
    loc_txt = {
        name = 'Alpiste',
        text = {
            "Seleciona {C:attention}1{} carta para",
            "aplicar cualquier tipo de",
            "{s:2,X:edition,C:white}Chachisello{}.",
            "cuando mas nivel tenga,",
            "mas raro sera de conseguir.",
        }
    },
    cost = 4,
    atlas = "alpiste",
    pos = {x=0, y=0},
    config = { number = 0, chachisello = "Chachisello 1" },
    loc_vars = function (self, info_queue, card)
        return {vars = {self.config.number, self.config.chachisello}}
    end,
    can_use = function (self,card)
        if G and G.hand then
            if #G.hand.highlighted ~= 0 and #G.hand.highlighted <= 1 then
                return true
            end
            return false
        end
    end,
    use = function(self, card, area, copier)
        local cardtoset = G.hand.highlighted[1]
        local roll = math.floor(pseudorandom("alpiste", 0, 100))
        if roll >= 50 then
            cardtoset:set_seal("prb_chachisello2", false, false)
        elseif roll < 50 then
            if roll >= 25 then
                cardtoset:set_seal("prb_chachisello3", false, false)
            elseif roll < 25 then
                if roll >= 10 then
                    cardtoset:set_seal("prb_chachisello4", false, false)
                elseif roll < 10 then
                    cardtoset:set_seal("prb_chachisello5", false, false)
                end
            end
        end
    end
}

SMODS.Atlas{
    key = "osamason",
    path = "Osamason.png",
    px = 71,
    py = 99
}

SMODS.Consumable{
    set = "Tarot",
    key = "osamason",
    loc_txt = {
        name = 'Osamason',
        text = {
            "Seleciona {C:attention}1{} carta para",
            "aplicar un soundgoodizer"
        }
    },
    cost = 4,
    atlas = "osamason",
    can_use = function (self,card)
        if G and G.hand then
            if #G.jokers.highlighted ~= 0 and #G.jokers.highlighted <= 1 then
                return true
            end
            return false
        end
    end,
    use = function(self, card, area, copier)
        local cardtoset = G.jokers.highlighted[1]
        cardtoset:add_sticker("prb_soundgoodizer", true)
    end
}