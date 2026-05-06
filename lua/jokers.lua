G.add_hacienda = function ()
    if G.GAME.dollars >= 100 and not G.hacienda_spawned then
        if math.floor(pseudorandom("hacienda_spawn", 1, 10)) == 1 then
            local newjoker = create_card("Joker", G.jokers, nil, nil, nil, nil, "j_prb_m_hacienda", "haciendaspawn")
            newjoker:add_to_deck()
            G.jokers:emplace(newjoker)
            newjoker:start_materialize()
            G.hacienda_spawned = true
        end
    end
end
G.hacienda_spawned = false
SMODS.Atlas{
    key = "Jokers",
    path = "QuantumJokerPrototipo.png",
    px = 71,
    py = 95
}

SMODS.Joker{
    key = "quantumjoker",
    rarity = 1,
    cost = 4,
    atlas = "Jokers",
    pos = {x = 0, y = 0},
    config = { extra = {
        Xmult = 1.234590967
    }
    },
    add_to_deck = function (self, card, from_debuff)
        G.add_hacienda()
    end,
    loc_vars = function(self,info_queue,center)
        return {vars = {center.ability.extra.Xmult}}
    end,
    calculate = function(self,card,context)
        if context.joker_main then
            return {
                card = card,
                Xmult = card.ability.extra.Xmult,
            }
        end
    end
}

-- P CLUB

SMODS.Atlas{
    key="pclub",
    path="Pclub.png",
    px = 71,
    py = 95
}

SMODS.Joker{
    key = "pclub",
    rarity = 1,
    cost = 3,
    atlas = "pclub",
    pos = {x=0,y=0},
    config = {extra = {mult = 4}},
    loc_txt = {
        name = "P Club",
        text = {
            "{C:red}+#1#{} de Mult.",
            "Sube {C:red}+4{} si se añade",
            "una carta con una {C:edition}edicion o mejora.{}"
        }
    },
    loc_vars = function (self, info_queue, card)
        return {vars = {card.ability.extra.mult}}
    end,
    add_to_deck = function (self, card, from_debuff)
        G.add_hacienda()
        for _, cards in ipairs(G.deck.cards) do
            if cards.edition or next(SMODS.get_enhancements(cards)) then
                card.ability.extra.mult = card.ability.extra.mult + 4
            end
        end
    end,
    calculate = function (self, card, context)
        if context.playing_card_added then
            for _, cards in ipairs(context.cards) do
                if cards.edition or next(SMODS.get_enhancements(cards)) then
                    card.ability.extra.mult = card.ability.extra.mult + 4
                    card_eval_status_text(card, 'extra', nil, nil, nil, {message = "AÑADAN P CLUB EN ADULT SWIM WE._.XD", colour = G.C.RED, card = card})
                end
            end
        end
        if context.joker_main then
            return {
                card = card,
                mult = card.ability.extra.mult
            }
        end
    end
}

SMODS.Atlas{
    key="guillermo",
    path="GuillermoPapoi.png",
    px = 71,
    py = 95
}

SMODS.Joker{
    key = "guillermo",
    rarity = 1,
    cost = 3,
    atlas = "guillermo",
    pos = {x=0,y=0},
    loc_txt = {
        name = "Guillermo Papoi",
        text = {
            "{E:1,C:blue}Copia al joker mas a la derecha,{}",
            "solo si el {C:attention}joker{} es {C:common}comun."
        }
    },
    add_to_deck = function (self, card, from_debuff)
        G.add_hacienda()
    end,
    calculate = function(self, card, context)
    -- This is an implementation of Brainstorm
    local other_joker = G.jokers.cards[#G.jokers.cards]
    local other_joker_ret = SMODS.blueprint_effect(card, other_joker, context)

    if other_joker_ret and other_joker.config.center.rarity == 1 then
        return other_joker_ret
    end
end
}

-- ii te chingue
SMODS.Atlas{
    key="ii",
    path="TeChingue.png",
    px = 71,
    py = 95
}

SMODS.Joker{
    key = "ii",
    rarity = 1,
    cost = 3,
    atlas = "ii",
    pos = {x=0,y=0},
    loc_txt = {
        name = "II Te chingue",
        text = {
            "{C:red}+#1#{} de Mult.",
            "al ganar una {C:attention,E:1}ciega jefe{}",
            "{C:red}-5{} de Mult"
        }
    },
    config = {extra = {mult = 20}},
    loc_vars = function (self, info_queue, card)
        return {vars = {card.ability.extra.mult}}
    end,
    calculate = function (self, card, context)
        if context.round_eval and G.GAME.last_blind and G.GAME.last_blind.boss then
            card.ability.extra.mult = card.ability.extra.mult + -4
            card_eval_status_text(card, 'extra', nil, nil, nil, {message = "II TE CHINGUE", colour = G.C.GREEN, card = card})
        end
        if context.joker_main then
            return {
                card = card,
                mult = card.ability.extra.mult
            }
        end
    end
}

-- john pollon
SMODS.Atlas{
    key="johnpollon",
    path="JohnPollon.png",
    px = 71,
    py = 95
}
SMODS.Joker{
    key = "johnpollon",
    rarity = 1,
    cost = 3,
    atlas = "johnpollon",
    pos = {x=0,y=0},
    loc_txt = {
        name = "John Pollon",
        text = {
            "Al vender este joker,",
            "convierte a todos tus {C:attention}jokers{}",
            "en el {C:blue}joker del huevo.{}"
        }
    },
    calculate = function(self, card, context)
        if context.selling_card and context.card == card then
            card_eval_status_text(card, 'extra', nil, nil, nil, {message = "JOHN POLLON TE HA ENCONTRADO", colour = G.C.BLUE, card = card})
            for _, joker in ipairs(G.jokers.cards) do
                joker:start_dissolve()
            end
            G.E_MANAGER:add_event(Event({
                    delay = 0.1,
                    func = function()
                        for i = 1, G.jokers.config.card_limit do
                            local new_card = create_card('Joker', G.jokers, true, nil, nil, nil, "j_egg", 'johnpollon')
                            new_card:add_to_deck()
                            G.jokers:emplace(new_card)
                        end
                        return true
                end
            }))
        end
    end
}
-- ay muchacho
SMODS.Atlas{
    key="aymuchacho",
    path="AyMuchacho.png",
    px = 71,
    py = 95
}

SMODS.Joker{
    key = "aymuchacho",
    rarity = 1,
    cost = 3,
    atlas = "aymuchacho",
    pos = {x=0,y=0},
    loc_txt = {
        name = "Ay Muchacho",
        text = {
            "{X:mult,C:white}X#1#{} Mult.",
            "{C:green}1 entre 6{} de que la carta se {C:red}autodestruya{}",
            "al terminar la {C:attention}ronda{}. Si esto pasa,",
            "genera la {C:purple,E:1,s:1.2}Maldicion Muchacho.{}"
        }
    },
    config = {extra = {Xmult = 3}},
    loc_vars = function (self, info_queue, card)
        return {vars = {card.ability.extra.Xmult}}
    end,
    calculate = function (self, card, context)
        if context.blind_defeated then
            local roll = math.floor(pseudorandom("aymuchacho", 1) * 6)
            if roll == 0 then
                card_eval_status_text(card, 'extra', nil, nil, nil, {message = "DIO JUSTO EN EL CLAVO", colour = G.C.RED, card = card})
                G.E_MANAGER:add_event(Event({
                    delay = 0.5,
                    func = function()
                        card:start_dissolve()
                        local maldicion_card = create_card('Joker', G.jokers, nil, nil, nil, nil, "j_prb_m_muchacho", 'aymuchacho')
                        maldicion_card:add_to_deck()
                        G.jokers:emplace(maldicion_card)
                        return true
                    end
                }))
            else
                card_eval_status_text(card, 'extra', nil, nil, nil, {message = "ERES MI JUGO PAPI", colour = G.C.GREEN, card = card})
            end
        end
        if context.joker_main then
            return {
                card = card,
                Xmult = card.ability.extra.Xmult
            }
        end
    end
}

--gato bubu
SMODS.Atlas{
    key="gatobubu",
    path="GatoBubu.png",
    px = 71,
    py = 95
}

SMODS.Joker{
    key = "gatobubu",
    rarity = 1,
    cost = 3,
    atlas = "gatobubu",
    pos = {x=0,y=0},
    loc_txt = {
        name = "Gato Bubu",
        text = {
            "{C:money}#1#${} al terminar la ronda.",
            "{C:red}Baja -1${} por cada ronda superada.",
            "Al pasar la segunda ronda, se te otoga",
            "la {C:purple,E:1,s:1.2}Maldicion Bubu.{}"
        }
    },
    config = {extra = {money = 10}},
    loc_vars = function (self, info_queue, card)
        return {vars = {card.ability.extra.money}}
    end,
    add_to_deck = function (self, card, from_debuff)
        G.add_hacienda()
    end,
    calc_dollar_bonus = function(self, card)
        return math.max(0, card.ability.extra.money)
    end,
    calculate = function (self, card, context)
        if context.starting_shop then
            card.ability.extra.money = card.ability.extra.money - 1
            if card.ability.extra.money == 9 or card.ability.extra.money <= 7 then
                card_eval_status_text(card, 'extra', nil, nil, nil, {message = "SOY NARANJA", colour = G.C.MONEY, card = card})
            elseif card.ability.extra.money == 8 then
                G.E_MANAGER:add_event(Event({
                    delay = 0.5,
                    func = function()
                        card_eval_status_text(card, 'extra', nil, nil, nil, {message = "SOY MALO Y TE VOY A MATAR", colour = G.C.MONEY, card = card})
                        local maldicion_card = create_card('Joker', G.jokers, nil, nil, nil, nil, "j_prb_m_bubu", 'gatobubu')
                        maldicion_card:add_to_deck()
                        G.jokers:emplace(maldicion_card)
                        return true
                    end
                }))
            elseif card.ability.extra.money == 0 then
                card_eval_status_text(card, 'extra', nil, nil, nil, {message = "ADIOS POCHORNO", colour = G.C.MONEY, card = card})
                G.E_MANAGER:add_event(Event({
                    delay = 0.5,
                    func = function()
                        card:start_dissolve()
                        return true
                    end
                }))
            end
        end
    end

}
-- donttouchmypizza

SMODS.Atlas{
    key = "pizza",
    path = "Gubby.png",
    px = 71,
    py = 95
}

SMODS.Joker{
    key = "pizza",
    rarity = 1,
    cost = 3,
    atlas = "pizza",
    pos = {x=0,y=0},
    loc_txt = {
        name = "Don't Touch My Pizza",
        text = {
            "{C:green}1 entre 2{} de que se repita",
            "una {C:attention}carta jugada.{}",
            "Las cartas pueden repetirse hasta 3 veces."
        }
    },
    add_to_deck = function (self, card, from_debuff)
        G.add_hacienda()
    end,
    calculate = function(self, card, context)
        card.ability.roll = pseudorandom("donttouchmypizza", 1, 2)
        if card.ability.roll == 1 then
            card.ability.secondroll = pseudorandom("donttouchmypizza2", 1, 2)
            if card.ability.secondroll == 1 then
                card.ability.thirdroll = pseudorandom("donttouchmypizza3", 1, 2)
                if card.ability.thirdroll == 1 then
                    card.ability.timesrepeated = 3
                else
                    card.ability.timesrepeated = 2
                end
            else
                card.ability.thirdroll = 2
            end
        else
            card.ability.timesrepeated = 1
        end
        if context.repetition and context.cardarea == G.play then
            return {
                repetitions = card.ability.timesrepeated
            }
        end

    end
}



SMODS.Atlas{
    key="faithful",
    path="sherriffpeanut.png",
    px = 71,
    py = 95
}

SMODS.Joker{
    key = "faithful",
    rarity = 2,
    cost = 6,
    atlas = "faithful",
    pos = {x = 0, y = 0},
    config = {  extra = {
            Xmult = 4
    }
    },
    loc_vars = function(self,info_queue,center)
        return {vars = {center.ability.extra.Xmult}}
    end,
    add_to_deck = function (self, card, from_debuff)
        G.add_hacienda()
    end,
    calculate = function(self,card,context)
        if context.joker_main then
            return{
            card = card,
            Xmult = card.ability.extra.Xmult
            }
        end
        if context.using_consumeable then
            if card.ability.extra.Xmult > 1 then
                card.ability.extra.Xmult = card.ability.extra.Xmult - 1
                if card.ability.extra.Xmult == 1 then
                    G.GAME.pool_flags.faithful_destroyed = true
                    return {
                        message = "I TALK TO MINORS AL THE TIME",
                        colour = G.C.XMULT,
                        func = function()
                            G.E_MANAGER:add_event(Event({
                                trigger = 'after',
                                delay = 0.5,
                                func = function()
                                    card:start_dissolve()
                                    return true
                                end
                            }))
                        end,
                    }
                else
                    return {
                        message = "-1X Mult",
                        colour = G.C.XMULT
                    }
                end
            end
        end
    end,
    in_pool = function (self, args)
        return not G.GAME.pool_flags.faithful_destroyed
    end
}

SMODS.Atlas{
    key="goop",
    path="BurntPeanut.png",
    px = 71,
    py = 95
}

SMODS.Joker{
    key="goop",
    rarity = 3,
    cost = 10,
    atlas = "goop",
    pos = {x = 0, y = 0},
    config = { extra = {
        Xmult = 1
    }
    },
    in_pool = function(self, args)
        return G.GAME.pool_flags.faithful_destroyed
    end,
    loc_vars = function(self,info_queue,center)
        return {vars = {center.ability.extra.Xmult}}
    end,
    add_to_deck = function (self, card, from_debuff)
        G.add_hacienda()
    end,
    calculate = function(self,card,context)
        if context.joker_main then
            return{
                card = card,
                Xmult = card.ability.extra.Xmult
            }
        end
        if context.using_consumeable then
            if context.consumeable.config.center.set == "Spectral" then
                card.ability.extra.Xmult = card.ability.extra.Xmult + 0.20
                return {
                    message = "SPECTRAL GOOP",
                    colour = G.C.SECONDARY_SET.Spectral,
                    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                    play_sound("prb_goop")
                    return true end }))
                }
            elseif context.consumeable.config.center.set == "Tarot" then
                local roll = math.floor(pseudorandom("tarotburnt", 1) * 2)
                if roll == 1 then
                    card.ability.extra.Xmult = card.ability.extra.Xmult + 0.20
                return {
                    message = "TAROT GOOP",
                    colour = G.C.SECONDARY_SET.Tarot,
                    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                    play_sound("prb_goop1")
                    return true end }))
                }
                end
            elseif context.consumeable.config.center.set == "Planet" then
                local roll = math.floor(pseudorandom("planetburnt", 1) * 4)
                if roll == 1 then
                    card.ability.extra.Xmult = card.ability.extra.Xmult + 0.20
                return {
                    message = "PLANET GOOP",
                    colour = G.C.SECONDARY_SET.Planet,
                    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                    play_sound("prb_goop2")
                    return true end }))
                }
                end
            end
        end
        if context.selling_card and context.card == card then
            G.GAME.pool_flags.burnt_sold = true
        end
    end
}

-- sausage

SMODS.Atlas{
    key="northernsausage",
    path="NorthernSausage.png",
    px = 71,
    py = 95
}

SMODS.Joker{
    key="northernsausage",
    rarity = 3,
    cost = 10,
    atlas = "northernsausage",
    pos = {x = 0, y = 0},
    config = { extra = {
        Xmult = 1
    }},
    loc_vars = function(self,info_queue,center)
        return {vars = {center.ability.extra.Xmult}}
    end,
    in_pool = function(self, args)
        return G.GAME.pool_flags.burnt_sold
    end,
    add_to_deck = function (self, card, from_debuff)
        G.add_hacienda()
    end,
    calculate = function(self,card,context)
        if context.using_consumeable then
            card.ability.extra.Xmult = card.ability.extra.Xmult + 0.5
            return {
                message = "NO SE QUIEN ES ESTE TIO"
            }
        end
        if context.joker_main then
            return{
                card = card,
                Xmult = card.ability.extra.Xmult
            }
        end
    end
}

-- la cuqui


SMODS.Atlas{
    key="lacuqui",
    path="LaCuqui.png",
    px = 71,
    py = 95
}

SMODS.Joker{
    key="lacuqui",
    rarity = 3,
    cost = 10,
    atlas = "lacuqui",
    config = { extra = { rarity = 0, number = 1 }},
    loc_vars = function(self,info_queue,center)
        return {vars = {center.ability.extra.rarity, center.ability.extra.number}}
    end,
    pos = {x = 0, y = 0},
    add_to_deck = function (self, card, from_debuff)
        G.add_hacienda()
    end,
    calculate = function(self, card, context)
        if context.selling_card and not context.blueprint and context.card == card then
            local jokers_to_reroll = {}
            for i, joker in ipairs(G.jokers.cards) do
                local is_sound = joker.ability.soundgoodizer
                if not joker.ability.eternal and not is_sound then
                    table.insert(jokers_to_reroll, {card = joker, slot = i})
                end
            end
            local function get_rarity_roll(rarity)
                if rarity == 1 then
                    return pseudorandom('reroll') * 0.69
                elseif rarity == 2 then
                    return 0.70 + pseudorandom('reroll') * 0.25
                elseif rarity == 3 then
                    return 0.95 + pseudorandom('reroll') * 0.05
                end
            end
            for _, data in ipairs(jokers_to_reroll) do
                local joker = data.card
                local slot = data.slot
                local rarity = joker.config.center.rarity
                local old_key = joker.config.center_key
                local edition = joker.edition
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.1,
                    func = function()
                        joker:start_dissolve()
                        local new_joker
                        repeat
                            if rarity == 4 then
                                new_joker = create_card('Joker',G.jokers,true,nil,nil,nil, nil,'legendary')
                            else
                                local roll = get_rarity_roll(rarity)
                                new_joker = create_card(
                                    'Joker',
                                    G.jokers,
                                    nil,
                                    roll,
                                    nil,
                                    nil,
                                    nil,
                                    'reroll_all'
                                )
                            end
                        until new_joker.config.center_key ~= old_key
                        new_joker:add_to_deck()
                        -- mantener edición
                        if edition then
                            new_joker:set_edition(edition, true)
                        end
                        -- insertar en mismo slot
                        table.insert(G.jokers.cards, slot, new_joker)
                        new_joker:set_card_area(G.jokers)
                        return true
                    end
                }))
            end
        end
    end
}

-- sebas el grumer

SMODS.Atlas{
    key="sebas",
    path="Sebas.png",
    px = 71,
    py = 95
}

SMODS.Joker{
    key= "sebas",
    rarity = 1,
    cost = 3,
    atlas = "sebas",
    pos = {x = 0, y = 0},
    config = { extra = {
        chips = 50,
        sebasnumber = 1,
        moresebas = false
    }},
    loc_vars = function(self,info_queue,center)
        return {vars = {center.ability.extra.chips, center.ability.extra.sebasnumber, center.ability.extra.moresebas}}
    end,
    add_to_deck = function (self, card, from_debuff)
        G.add_hacienda()
    end,
    calculate = function(self,card,context)
        if context.card_added and context.card.config.center_key == "j_prb_sebas" then
            card.ability.extra.sebasnumber = card.ability.extra.sebasnumber + 1
            card.ability.extra.moresebas = true
            card.ability.extra.chips = card.ability.extra.chips + 50
            return {
                message = "hola sebota"
            }
        end
        if context.joker_type_destroyed or context.selling_card and context.card.config.center_key == "j_prb_sebas" then
            card.ability.extra.sebasnumber = card.ability.extra.sebasnumber - 1
            card.ability.extra.chips = card.ability.extra.chips - 50
            return {
                message = "adios sebota"
            }
        end
        if context.joker_main and card.ability.extra.moresebas == true then
            return {
                card = card,
                chips = card.ability.extra.chips
            }
        end
    end

}

SMODS.Atlas{
    key="enzo",
    path="Enzo.png",
    px = 71,
    py = 95
}

SMODS.Joker{
    key="enzo",
    rarity = 2,
    cost = 5,
    atlas = "enzo",
    pos = {x = 0, y = 0},
    config = { extra = {
        money = 5
    }
    },
    loc_vars = function(self,info_queue,center)
        return {vars = {center.ability.extra.money}}
    end,
    add_to_deck = function (self, card, from_debuff)
        G.add_hacienda()
    end,
    calc_dollar_bonus = function(self,card)
        local money_gained = card.ability.extra.money
        if pseudorandom('enzo') > 0.5 then
            card.ability.extra.money = card.ability.extra.money + 1
        else
            card.ability.extra.money = math.max(0, card.ability.extra.money - 1)
        end
        return money_gained
    end,
    calculate = function(self,card,context)
        if context.buying_card and not context.blueprint and (context.card.config.center_key == "j_prb_enzo" or context.card.config.center_key == "j_prb_adif") then
            local adif_card
            if context.card.config.center_key == "j_prb_adif" then
                adif_card = context.card
            else
                for _, joker in ipairs(G.jokers.cards) do
                    if joker.config.center_key == "j_prb_adif" then
                        adif_card = joker
                        break
                    end
                end
            end
            if adif_card then
                -- Quitar todo el dinero
                card_eval_status_text(card, 'extra', nil, nil, nil, {message = "OH NO ES ADIF", colour = G.C.RED, card = card})
                -- Destruir Enzo (si no es la card comprada)
                if context.card.config.center_key ~= "j_prb_enzo" then
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        delay = 0.5,
                        func = function()
                            card:start_dissolve()
                            return true
                        end
                    }))
                end
                -- Destruir Adif
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.5,
                    func = function()
                        adif_card:start_dissolve()
                        return true
                    end
                }))
                return nil, true
            end
        end
    end
}

SMODS.Atlas{
    key = "adif",
    path = "Adif.png",
    px = 71,
    py = 95
}

SMODS.Joker{
    key="adif",
    rarity = 2,
    cost = 6,
    atlas = "adif",
    pos = {x = 0, y = 0},
    config = { extra = {
        mult = 5
    }
    },
    loc_vars = function(self,info_queue,center)
        return {vars = {center.ability.extra.mult}}
    end,
    add_to_deck = function (self, card, from_debuff)
        G.add_hacienda()
    end,
    calculate = function(self,card,context)
        if context.buying_card and not context.blueprint and (context.card.config.center_key == "j_prb_adif" or context.card.config.center_key == "j_prb_enzo") then
            local enzo_card
            if context.card.config.center_key == "j_prb_enzo" then
                enzo_card = context.card
            else
                for _, joker in ipairs(G.jokers.cards) do
                    if joker.config.center_key == "j_prb_enzo" then
                        enzo_card = joker
                        break
                    end
                end
            end
            if enzo_card then
                -- Quitar todo el dinero
                ease_dollars(0)
                card_eval_status_text(card, 'extra', nil, nil, nil, {message = "CRUZAVIAS!", colour = G.C.RED, card = card})
                -- Destruir Adif (si no es la card comprada)
                if context.card.config.center_key ~= "j_prb_adif" then
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        delay = 0.5,
                        func = function()
                            card:start_dissolve()
                            return true
                        end
                    }))
                end
                -- Destruir Enzo
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.5,
                    func = function()
                        enzo_card:start_dissolve()
                        return true
                    end
                }))
                return nil, true
            end
        end
        if (context.hand_drawn or context.discard) and not context.blueprint then
            local roll = math.floor(pseudorandom('adif') * 3)
            if roll == 0 then
                card.ability.extra.mult = card.ability.extra.mult + 5
                card_eval_status_text(card, 'extra', nil, nil, nil, {message = "+5 Mult", colour = G.C.GREEN, card = card})
            elseif roll == 1 then
                local old_mult = card.ability.extra.mult
                card.ability.extra.mult = math.max(1, card.ability.extra.mult - 1)
                if card.ability.extra.mult < old_mult then
                    card_eval_status_text(card, 'extra', nil, nil, nil, {message = "-1 Mult", colour = G.C.RED, card = card})
                else
                    card_eval_status_text(card, 'extra', nil, nil, nil, {message = "Mínimo alcanzado", colour = G.C.FILTER, card = card})
                end
            else
                card_eval_status_text(card, 'extra', nil, nil, nil, {message = "Nada", colour = G.C.FILTER, card = card})
            end
            return nil, true
        end
        if context.joker_main then
            return {
                card = card,
                mult_mod = card.ability.extra.mult,
                message = "+" .. card.ability.extra.mult .. " Mult",
                colour = G.C.MULT
            }
        end
    end
}

SMODS.Atlas{
    key = "guitar",
    path = "Guitar.png",
    px = 71,
    py = 95
}

SMODS.Joker{
    key = "guitar",
    rarity = 2,
    cost = 5,
    atlas = "guitar",
    pos = {x = 0, y = 0},
    add_to_deck = function (self, card, from_debuff)
        G.add_hacienda()
    end,
    calculate = function(self, card, context)
        if context.individual then
            if context.cardarea == G.play then
                if context.other_card:get_id() >= 5 then
                    return{
                        Xmult = 0.5,
                        card = card
                    }
                else
                    return{
                        Xmult = 1.5,
                        card = card
                    }
                end
            end
        end
    end
}

SMODS.Atlas{
    key = "pollostictac",
    path = "PollosTicTac.png",
    px = 71,
    py = 95
}

SMODS.Joker{
    key = "pollostictac",

    rarity = 3,
    cost = 10,
    atlas = "pollostictac",
    pos = {x = 0, y = 0},
    add_to_deck = function (self, card, from_debuff)
        G.add_hacienda()
    end,
    calculate = function(self,card,context)
        if context.buying_card and context.card.area == G.consumeables then
            local boughtconsumeable = G.consumeables.cards[#G.consumeables.cards]
            if boughtconsumeable.config.center.set == "Tarot" or boughtconsumeable.config.center.set == "Planet" then
                local roll = math.floor(pseudorandom("TicTac") * 5)
                if roll == 1 then
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            local card = create_card('Spectral',G.consumeables, nil, nil, nil, nil, nil, 'car')
                            card:set_edition({negative = true}, true)
                            card:add_to_deck()
                            G.consumeables:emplace(card)
                            return true
                        end}))
                    card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "EN POLLOS TICTAC"})
                else
                    return{
                        message = "NO HAY POLLO :C",
                        colour = G.C.EDITION
                    }
                end
            elseif boughtconsumeable.config.center.set == "Spectral" then
                local roll = math.floor(pseudorandom("Pollos") * 12)
                if roll == 1 then
                    if #G.jokers.cards ~= G.jokers.config.card_limit then
                    local new_card = create_card('Joker', G.jokers, true, nil, nil, nil, nil, 'car')
                    new_card:add_to_deck()
                    G.jokers:emplace(new_card)
                    new_card:start_materialize()
                    else
                        return {
                            message = "no hay espacio",
                            colour = G.C.EDITION
                        }
                    end
                else
                    return{
                        message = "NO HAY POLLO :C",
                        colour = G.C.EDITION
                    }
                end

            end
        end
    end
}

SMODS.Atlas{
    key = "wally",
    path = "Wally.png",
    px = 71,
    py = 95
}

SMODS.Joker{
    key = "wally",
    rarity = 1,
    cost = 3,
    atlas = "wally",
    pos = {x = 0, y = 0},
    add_to_deck = function (self, card, from_debuff)
        G.add_hacienda()
    end,
    calculate = function (self,card,context)
        if context.individual and context.cardarea == G.play then
            if context.other_card:is_suit("prb_pooposuit") then
                return {
                    card = card,
                    mult = 5
                }
            end
        end
    end
}

--GUS

SMODS.Atlas{
    key = "gus",
    path = "Gus.png",
    px = 71,
    py = 95
}

SMODS.Joker{
    key = "gus",
    rarity = 2,
    cost = 6,
    atlas = "gus",
    pos = {x = 0, y = 0},
    add_to_deck = function (self, card, from_debuff)
        G.add_hacienda()
    end,
    calculate = function (self,card,context)
        if context.individual and context.cardarea == G.play then
            local roll = math.floor(pseudorandom("popo") * 2)
            if context.other_card:is_suit("prb_pooposuit") then
                if roll == 1 then
                    return {
                        card = card,
                        dollars = 2,
                    }
                else
                    return {
                        message = "POPO TEST"
                    }
                end
            end
        end
    end
}

--YAYOK

SMODS.Atlas{
    key = "yayok",
    path = "YAYOK.png",
    px = 71,
    py = 95
}


SMODS.Joker{
    key = "yayok",
    rarity = 1,
    cost = 3,
    atlas = "yayok",
    pos = {x = 0, y = 0},
    add_to_deck = function (self, card, from_debuff)
        G.add_hacienda()
    end,
    calculate = function (self,card,context)
        if context.individual and context.cardarea == G.play then
            if context.other_card:is_suit("prb_pooposuit") then
                return {
                    card = card,
                    chips = 25
                }
            end
        end
    end
}

SMODS.Atlas{
    key = "cristal",
    path = "CristalMierdaCulo.png",
    px = 71,
    py = 95
}


SMODS.Joker{
    key = "cristal",
    rarity = 3,
    cost = 10,
    atlas = "cristal",
    pos = {x = 0, y = 0},
    config = { extra = {dollars = 1, chips = 50, mult = 8, Xmult = 1.5}},
    loc_vars = function (self, info_queue, center)
        return {vars = {center.ability.extra.dollars, center.ability.extra.chips, center.ability.extra.mult, center.ability.extra.Xmult}}
    end,
    add_to_deck = function (self, card, from_debuff)
        G.add_hacienda()
    end,
    calculate = function(self,card,context)
        if context.individual and context.cardarea == G.play then
            if context.other_card:is_suit("prb_pooposuit") then
                local roll = math.floor(pseudorandom("cristal", 1, 4))
                if roll == 1 then
                    return {
                        message = "DYLAN X CALUM CANON",
                        colour = G.C.MONEY,
                        dollars = card.ability.extra.dollars
                    }
                elseif roll == 2 then
                    return {
                        card = card,
                        chips = card.ability.extra.chips
                    }
                elseif roll == 3 then
                    return {
                        card = card,
                        mult = card.ability.extra.mult
                    }
                elseif roll == 4 then
                    return {
                        card = card,
                        Xmult = card.ability.extra.Xmult
                    }
                end
            end
        end
    end
}


-- masturbador

SMODS.Atlas{
    key = "masturbador",
    path = "Masturbator.png",
    px = 71,
    py = 95
}

SMODS.Joker{
    key = "masturbador",
    rarity = 2,
    cost = 6,
    atlas = "masturbador",
    pos = {x = 0, y = 0},
    config = { extra = {
        money = 7
    }
    },
    loc_vars = function(self,info_queue,center)
        return {vars = {center.ability.extra.money}}
    end,
    add_to_deck = function (self, card, from_debuff)
        G.add_hacienda()
    end,
    calc_dollar_bonus = function(self,card)
        local money_gained = card.ability.extra.money
        if G.GAME.current_round.hands_played ~= 1 then
            card.ability.extra.money = 0
        end
        return money_gained
    end,

}

-- nametag

SMODS.Atlas{
    key = "nametag",
    path = "Nametag.png",
    px = 71,
    py = 95
}


SMODS.Joker{
    key = "nametag",
    rarity = 2,
    cost = 6,
    atlas = "nametag",
    pos = {x = 0, y = 0},
    add_to_deck = function (self, card, from_debuff)
        G.add_hacienda()
    end,
    calculate = function (self,card,context)
        if context.joker_main then
            local hands = G.GAME.current_round.hands_left + 1
            local discards = G.GAME.current_round.discards_left
            if hands > discards then
                return{
                    card = card,
                    chips = 150,
                }
            elseif hands < discards then
                return{
                    card = card,
                    mult = 15,
                }
            elseif hands == discards then
                return {
                    card = card,
                    Xmult = 4,
                }
            end
        end
    end
}

--santiago segura
SMODS.Atlas{
    key = "santi",
    path = "SantiagoSegura.png",
    px = 71,
    py = 95
}

SMODS.Joker{
    key = "santi",
    rarity = 3,
    cost = 10,
    atlas = "santi",
    pos = {x=0,y=0},
    loc_txt = {
        name = "Santiago Segura",
        text = {
            "{X:dark_edition,C:white,E:1,s:1.2}Equilibra{}",
            "las {C:chips}fichas{} y el {C:mult}mult{} que tienes.",
        }
    },
    add_to_deck = function (self, card, from_debuff)
        G.add_hacienda()
    end,
    calculate = function (self, card, context)
        if context.final_scoring_step then
            return {
                balance = true,
                card = card,
                message = "TRABAJO NO HAY MAS QUE 0"
            }
        end
    end
}

--hemmy

SMODS.Atlas{
    key = "hemmy",
    path = "HemmyBoi.png",
    px = 71,
    py = 95
}

SMODS.Joker{
    key = "hemmy",
    atlas = "hemmy",
    rarity = 2,
    cost = 6,
    pos = {x=0,y=0},
    loc_txt = {
        name = "Hemmy",
        text = {
            "{C:red}#1#{} Mult, {X:mult,C:white}X#2#{} Mult.",
            "Hay una probabilidad de {C:green}1 entre 2",
            "de que este joker {C:attention,E:1}cree un comun negativo.{}",
            "Si se repite {C:blue}4 veces{}, suma {X:mult,C:white}X#3#{}",
            "al Mult total.",
            "{C:inactive}Repeticiones restantes: #4#{}"
        }
    },
    config = {extra = {
        mult = 15,
        Xmult = 1,
        sum = 0.5,
        repetitions = 4,
        rolled = 1,
    }},
    loc_vars = function (self, info_queue, center)
        return {
            vars = {
                center.ability.extra.mult,
                center.ability.extra.Xmult,
                center.ability.extra.sum,
                center.ability.extra.repetitions,
            }
        }
    end,
    add_to_deck = function (self, card, from_debuff)
        G.add_hacienda()
    end,
    calculate = function (self, card, context)
        if context.joker_main then
            local roll = math.floor(pseudorandom("hemmy", 1, 2))
            if roll == 1 then
                card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "WHERE YOU GOING HEMMY", colour = G.C.RED})
                delay(0.2)
                local _card = create_card("Joker", G.jokers, nil, 0, nil, nil, nil, "hemmy")
                _card:set_edition({negative = true}, true)
                _card:start_materialize()
                _card:add_to_deck()
                G.jokers:emplace(_card)
                card.ability.extra.repetitions = card.ability.extra.repetitions - 1
                if card.ability.extra.repetitions == 0 then
                    card.ability.extra.Xmult = card.ability.extra.Xmult + card.ability.extra.sum
                    card.ability.extra.repetitions = 4
                end
            else
                card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "no hemmy", colour = G.C.RED})
            end
            return {
                mult = card.ability.extra.mult,
                Xmult = card.ability.extra.Xmult
            }
        end
    end
}

--polar montes

SMODS.Atlas{
    key = "omar",
    path = "OmarMontes.png",
    px = 71,
    py = 95
}

SMODS.Joker{
    key = "omar",
    rarity = 2,
    cost = 5,
    atlas = "omar",
    pos = {x=0,y=0},
    loc_txt = {
        name = "Omar Montes",
        text = {
            "Te otorga el la cantidad de,",
            "{C:money}dinero{} en posesion {C:attention}actualmente{}",
            "dividido entre {C:red}2{}",
            "como {X:mult,C:white}XMult.{}",
            "hay una posibilidad de {C:green}1 entre 6{}",
            "de convertir algunas de tus",
            "{C:attention}cartas sacadas{}",
            "en {C:money}cartas de oro.{}",
            "{C:inactive}XMult actual:{} {X:mult,C:white}X#1#{}"
        }
    },
    config = {extra = {
        Xmult = 1
    }},
    loc_vars = function (self, info_queue, center)
        return {vars = {center.ability.extra.Xmult}}
    end,
    calculate = function (self, card, context)
        card.ability.extra.Xmult = math.floor(G.GAME.dollars / 10)
        if G.GAME.dollars < 10 then
            card.ability.extra.Xmult = 1
        end
        if context.joker_main then
            return {
                card = card,
                Xmult = card.ability.extra.Xmult
            }
        end
        if context.individual and context.cardarea == G.play then
            local roll = math.floor(pseudorandom("omar", 1, 6))
            if roll == 6 then 
                context.other_card:set_ability(G.P_CENTERS.m_gold)
                card:juice_up(0.3,0.5)
            else
                card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "mi nuevo aifon ekisese", colour = G.C.RED})
            end
        end
    end

}

-- manolito gafotas SIN TERMINAR
SMODS.Atlas{
    key = "manolo",
    path = "ManolitoGafotas.png",
    px = 71,
    py = 95
}

SMODS.Joker{
    key = "manolo",
    rarity = 2,
    cost = 5,
    atlas = "manolo",
    pos = {x=0,y=0},
    loc_txt = {
        name = "Manolito Gafotas",
        text = {
            "{C:green}1 entre 2{} posibilidades que,",
            "al abrir un {C:attention}booster{},",
            "se genere una {C:attention}carta mas{}",
            "para {C:blue}elegir{}.",
            "{C:green}1 entre 10{} posibilidades que,",
            "te deje {E:2,C:dark_edition}elegir 2 opciones{}"
        }
    },
    calculate = function (self, card, context)
        if context.open_booster then
            local roll = math.floor(pseudorandom("manolito", 1, 2))
            if roll == 1 then
                G.GAME.modifiers.booster_size_mod = (G.GAME.modifiers.booster_size_mod or 0) + 1
                card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "MANOLITO", colour = G.C.RED})
            else
                card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "no manolito", colour = G.C.RED})
            end
            local roll2 = math.floor(pseudorandom("manolito", 1, 10))
            if roll2 == 1 then
                G.GAME.modifiers.booster_choice_mod = (G.GAME.modifiers.booster_choice_mod or 0) + 1
                card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "MANOLITO SUPER", colour = G.C.RED})
            end
        elseif context.ending_booster then
            G.GAME.modifiers.booster_size_mod = 0
            G.GAME.modifiers.booster_choice_mod = 0
        end
    end
}

-- rey chimpa

SMODS.Atlas{
    key = "reychimpa",
    path = "ReyChimpa.png",
    px = 71,
    py = 95
}


SMODS.Joker{
    key = "reychimpa",
    rarity = 2,
    cost = 5,
    atlas = "reychimpa",
    pos = {x=0,y=0},
    loc_txt = {
        name = "Rey Chimpa",
        text = {
            "Al vender este {C:attention}joker{},",
            "un joker que tengas sera {C:dark_edition,E:1}negativo.{}",
            "A cambio, te otorgara la {C:legendary}Maldicion Chimpa.{}"
        }
    },
    add_to_deck = function (self, card, from_debuff)
        G.add_hacienda()
    end,
    calculate = function (self, card, context)
        if context.selling_card and context.card == card then
            G.E_MANAGER:add_event(Event({
                delay = 0.1,
                func = function()
                    card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "CHIMPA", colour = G.C.RED})
                    if #G.jokers.cards > 0 then
                        local valid_jokers = {}
                        for i, j in ipairs(G.jokers.cards) do
                            if j ~= card then
                                table.insert(valid_jokers, j)
                            end
                        end

                        if #valid_jokers > 0 then
                            local jokerroll = pseudorandom("reychimpa", 1, #valid_jokers)
                            valid_jokers[jokerroll]:set_edition({negative = true}, true)
                        end
                    end
                    local mchimpa = {
                        set = "Joker",
                        area = G.jokers,
                        key = "j_prb_m_chimpa"
                    }
                    local maldito = SMODS.create_card(mchimpa)
                    G.jokers:emplace(maldito)
                    maldito:start_materialize()
                    maldito:add_to_deck()
                    return true
                end}))
        end
    end
}
--roberto bosoi
SMODS.Atlas{
    key = "roberto",
    path = "RobertoBosoi.png",
    px = 71,
    py = 95
}

SMODS.Joker{
    key = "roberto",
    rarity = 2,
    cost = 5,
    atlas = "roberto",
    pos = {x = 0, y = 0},
    config = {extra = {Xmult = 1}},
    loc_vars = function (self, info_queue, card)
        return {vars = {card.ability.extra.Xmult}}
    end,
    loc_txt = {
        name = "Roberto Bosoi",
        text = {
            "Al final de {C:attention}sacar una mano,{}",
            "{C:attention,E:1}vorea{} {C:inactive}(destruye){} una carta al azar.",
            "Por cada carta destruida, ganas {X:mult,C:white}X0.2{} Mult.",
            "Dara {X:mult,C:white}X0.5{} Mult si {C:attention}la carta destruida{}",
            "tiene algun tipo de {C:edition}edicion{}",
            "{C:inactive}Mult actual:{} {X:mult,C:white}X#1#{}"
        }
    },
    calculate = function (self, card, context)
        if context.joker_main then
            return {
                card = card,
                Xmult = card.ability.extra.Xmult
            }
        end
        if context.final_scoring_step then
            G.E_MANAGER:add_event(Event({
                delay = 0.1,
                func = function()
                    if #G.hand.cards > 0 then
                        local cardroll = pseudorandom("roberto", 1, #G.hand.cards)
                        local destroyed = G.hand.cards[cardroll]
                        destroyed:start_dissolve()
                        if destroyed.edition then
                            card.ability.extra.Xmult = card.ability.extra.Xmult + 0.5
                            card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "VOREADO PLUS", colour = G.C.RED})
                        else
                            card.ability.extra.Xmult = card.ability.extra.Xmult + 0.2
                            card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "VOREADO", colour = G.C.RED})
                        end
                    else
                        card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "no puedo lo siento", colour = G.C.RED})
                    end
                    return true
            end}))
        end
    end
}

--yaoi
SMODS.Atlas{
    key = "yaoi",
    path = "Yaoi.png",
    px = 71,
    py = 95
}

SMODS.Joker{
    key = "yaoi",
    rarity = 2,
    cost = 5,
    atlas = "yaoi",
    pos = {x = 0, y = 0},
    config = {extra = {Xmult = 2}},
    loc_vars = function (self, info_queue, card)
        return {vars = {card.ability.extra.Xmult}}
    end,
    loc_txt = {
        name = "Yaoi",
        text = {
            "Crea una {C:red,s:1.2,E:1}nueva mano de poker{}",
            "que se activa cuando juegas {C:attention}5 cartas de piedra.{}",
            "{X:mult,C:white}X2{} Mult por cada {C:inactive}carta de piedra jugada.{}"
        }
    },
    calculate = function(self,card,context)
        if context.individual and context.cardarea == G.play then
            if context.other_card.config.center_key == "m_stone" then
                return {
                    card = card,
                    Xmult = card.ability.extra.Xmult
                }
            end
        end
    end
}
-- meganacho

SMODS.Atlas{
    key = "meganacho",
    path = "MegaNacho.png",
    px = 71,
    py = 95
}

SMODS.Joker{
    key = "meganacho",
    rarity = 2,
    cost = 5,
    atlas = "meganacho",
    pos = {x = 0, y = 0},
    config = {extra = {Xmult = 1}},
    loc_vars = function (self, info_queue, card)
        return {vars = {card.ability.extra.Xmult}}
    end,
    loc_txt = {
        name = "Meganacho",
        text = {
            "{X:mult,C:white}X#1#{} Mult",
            "Sube {X:mult,C:white}X1{} de Mult por cada",
            "cada carta de rareza {C:legendary,E:1}maldita{} presente"
        }
    },
    add_to_deck = function (self, card, from_debuff)
        G.add_hacienda()
        for _, j in ipairs(G.jokers.cards) do
            if j.config.center.rarity == "prb_maldito" then
                card.ability.extra.Xmult = card.ability.extra.Xmult + 1
            end
        end
    end,
    calculate = function(self, card, context)
        card.ability.hascursed = false
        if context.card_added and context.card.config.center.rarity == "prb_maldito" then
            card.ability.extra.Xmult = card.ability.extra.Xmult + 1
        end
        if context.joker_main then
            return {
                Xmult = card.ability.extra.Xmult
            }
        end
    end
}

-- julieta

local smods_smeared_check_ref = SMODS.smeared_check
function SMODS.smeared_check(card, suit)
    if next(SMODS.find_card("j_prb_julieta")) then
        if ((card.base.suit == 'Hearts' or card.base.suit == 'prb_pooposuit') and (suit == 'Hearts' or suit == 'prb_pooposuit')) then
            return true
        end
    end
    return smods_smeared_check_ref(card, suit)
end


SMODS.Atlas{
    key = "julieta",
    path = "RetroGassy.png",
    px = 71,
    py = 95
}

SMODS.Joker{
    key = "julieta",
    rarity = 2,
    cost = 5,
    atlas = "julieta",
    pos = {x = 0, y = 0},
    loc_txt = {
        name = "Julieta Pedorreta",
        text = {
            "Las cartas {C:black}Popo{} y",
            "las cartas de {C:hearts}Corazones{}",
            "cuentan como {C:attention}el mismo palo.{}"
        }
    },
    add_to_deck = function (self, card, from_debuff)
        G.add_hacienda()
    end,
}

-- rod wave

SMODS.Atlas{
    key = "rod",
    path = "RodWave.png",
    px = 71,
    py = 95
}

SMODS.Joker{
    key = "rod",
    rarity = 2,
    cost = 5,
    atlas = "rod",
    pos = {x = 0, y = 0},
    config = {extra = {timesleft = 4}},
    loc_vars = function (self, info_queue, card)
        return {vars = {card.ability.extra.timesleft}}
    end,
    loc_txt = {
        name = "Rod Wave" ,
        text = {
            "{C:green}1 en 2{} de posibilidades que cuando",
            "salgas de la {C:attention}tienda{}, se",
            "{C:red}destruya un joker aleatorio.{}",
            "Al destruir {C:attention}4 jokers,",
            "te genera un {s:1.2,C:dark_edition}joker aleatorio.{}",
            "{C:inactive}El joker generado no puede ser un legendario.{}",
            "{C:inactive}Jokers restantes: #1#"
        }
    },
    add_to_deck = function (self, card, from_debuff)
        G.add_hacienda()
    end,
    calculate = function (self, card, context)
        if context.ending_shop then
            local roll = pseudorandom("rodwave", 1, 2)
            if roll == 1 and #G.jokers.cards > 0 then
                local valid_jokers = {}
                for i, j in ipairs(G.jokers.cards) do
                    if j ~= card then
                        table.insert(valid_jokers, j)
                    end
                end
                if #valid_jokers > 0 then
                    local jokerroll = pseudorandom("RodWave", 1, #valid_jokers)
                    valid_jokers[jokerroll]:start_dissolve()
                    card.ability.extra.timesleft = card.ability.extra.timesleft - 1
                    card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "IF I WAS ROD WAVE I WOULD SURF THE WORLD", colour = G.C.RED})
                end
            end
            if card.ability.extra.timesleft == 0 then
                local newjoker = {
                        set = "Joker",
                        area = G.jokers,
                    }
                local new = SMODS.create_card(newjoker)
                G.jokers:emplace(new)
                new:start_materialize()
                new:add_to_deck()
                card.ability.extra.timesleft = 4
            end
        end
    end
}


-- DYLAN PALOMO

SMODS.Atlas{
    key = "dylanpalomo",
    path = "DylanPalomo.png",
    px = 71,
    py = 95
}

SMODS.Joker{
    key = "dylanpalomo",
    rarity = 3,
    cost = 9,
    atlas = "dylanpalomo",
    pos = {x = 0, y = 0},
    add_to_deck = function (self, card, from_debuff)
        G.add_hacienda()
    end,
    calculate = function(self, card, context)
        if context.setting_blind then
            return {
                message = "feliz navidad",
                colour = G.C.GREEN,
                func = function()
                    G.E_MANAGER:add_event(Event({
                        trigger = "ease",
                        delay = 5,
                        ref_table = G.GAME,
                        ref_value = "chips",
                        ease_to = G.GAME.chips + math.ceil(G.GAME.blind.chips * 0.25),
                    }))
                end
            }
        end
    end
}

--ABUELAYOYO

SMODS.Atlas{
    key = "abuelayoyo",
    path = "AbuelaYoyo.png",
    px = 71,
    py = 95
}

SMODS.Joker{
    key = "abuelayoyo",
    rarity = 1,
    cost = 3,
    atlas = "abuelayoyo",
    pos = {x = 0, y = 0},
    config = { extra = {
        mult = 20
    }
    },
    loc_vars = function(self,info_queue,center)
        return {vars = {center.ability.extra.mult}}
    end,
    add_to_deck = function (self, card, from_debuff)
        G.add_hacienda()
    end,
    calculate = function(self,card,context)
        if context.joker_main then
            return{
                card = card,
                mult = card.ability.extra.mult,
            }
        end
        if context.card_added then
            card.ability.extra.mult = card.ability.extra.mult - 5
            return {
                message = "guarra que haces",
            }
        end
            if card.ability.extra.mult == 0 then
                    return {
                        message = "adios GUARRILLO",
                        colour = G.C.XMULT,
                        func = function()
                            G.E_MANAGER:add_event(Event({
                                trigger = 'after',
                                delay = 0.5,
                                func = function()
                                    card:start_dissolve()
                                    return true
                                end
                            }))
                        end
                    }
           end
    end
}

--ADRIANLATORRE

SMODS.Atlas{
    key = "adrianlatorre",
    path = "AdrianLaTorre.png",
    px = 71,
    py = 95
}

SMODS.Joker{
    key = "adrianlatorre",
    rarity = 3,
    cost = 9,
    atlas = "adrianlatorre",
    pos = {x = 0, y = 0},
    config = { extra = {mult = 1,stacks = 0}},
    loc_vars = function(self, info_queue, center)
        return {vars = {center.ability.extra.mult, center.ability.extra.stacks}}
    end,
    add_to_deck = function (self, card, from_debuff)
        G.add_hacienda()
    end,
    calculate = function(self, card, context)
        if context.money_altered then
            card.ability.extra.stacks = card.ability.extra.stacks + 0.10
            card.ability.extra.mult = 1 + card.ability.extra.stacks
            return {
                card = card,
                message = "QUE TE METO UN 200"
            }
        end
        if context.joker_main then
            return {
                Xmult = card.ability.extra.mult
            }
        end
    end
}

--Bartdepre

SMODS.Atlas{
    key = "bart",
    path = "BartDepre.png",
    px = 71,
    py = 95
}

SMODS.Joker{
    key = "bart",
    rarity = 2,
    cost = 5,
    atlas = "bart",
    pos = {x = 0, y = 0},
    config = { extra = {jokernumber = 1, Xmult = 1}},
    loc_vars = function (self, info_queue, center)
        vars = {center.ability.extra.Xmult}
    end,
    add_to_deck = function (self, card, from_debuff)
        G.add_hacienda()
    end,
    calculate = function (self, card, context)
        card.ability.extra.jokernumber = #G.jokers.cards
        if context.card_added then
            card.ability.extra.jokernumber = card.ability.extra.jokernumber + 1
            card.ability.extra.Xmult = card.ability.extra.jokernumber
            return { message = "BART BASH" }
        end
        if context.other_joker and context.other_joker ~= card then
            return {
                Xmult = 0.9,
                card = card,
            }
        end
        if context.joker_main then
            return {
                Xmult = card.ability.extra.Xmult,
                card = card
            }
        end
    end
}

--Bfdi r34

SMODS.Atlas{
    key = "bfdi",
    path = "Bfdi34.png",
    px = 71,
    py = 95
}

SMODS.Joker{
    key = "bfdi",
    rarity = 2,
    cost = 5,
    atlas = "bfdi",
    pos = {x = 0, y = 0},
    add_to_deck = function (self, card, from_debuff)
        G.add_hacienda()
    end,
    calculate = function(self, card, context)
        if card.ability.shop_inactive == nil then
            card.ability.shop_inactive = true
        end

        if (context.buying_card or context.using_consumeable or context.selling_card or context.reroll_shop) and not context.blueprint then
            card.ability.shop_inactive = false
            return {
                message = "NO ME TOQUES",
                colour = G.C.RED
            }
        end
        if context.ending_shop and card.ability.shop_inactive then
            return {
                message = "muy bien gud boy",
                colour = G.C.GREEN
            }
        end
        if context.joker_main then
            if card.ability.shop_inactive then
                return {
                    card = card,
                    Xmult = 3,
                }
            else
                card.ability.shop_inactive = true
            end
        end
    end
}

--chachipoints

SMODS.Atlas{
    key = "chachipoints",
    path = "ChachiPoints.png",
    px = 71,
    py = 95
}

SMODS.Joker{
    key = "chachipoints",
    rarity = 2,
    cost = 6,
    atlas = "chachipoints",
    pos = {x = 0, y = 0},
    add_to_deck = function (self, card, from_debuff)
        G.add_hacienda()
    end,
    calculate = function (self, card, context)
        if context.setting_blind then
            G.E_MANAGER:add_event(Event({
                    func = function()
                        local _card = create_playing_card({
                            front = pseudorandom_element(G.P_CARDS, pseudoseed('chachijoker')),
                            center = G.P_CENTERS.c_base},G.hand, nil, nil, {G.C.SECONDARY_SET.Enhanced})
                        local seal_type = pseudorandom("chachisellos")
                        if seal_type > 0.5 then _card:set_seal("prb_chachisello2", true)
                        elseif seal_type > 0.25 then _card:set_seal("prb_chachisello3", true)
                        elseif seal_type > 0.125 then _card:set_seal("prb_chachisello4", true)
                        else _card:set_seal("prb_chachisello5", true)
                        end
                        G.GAME.blind:debuff_card(_card)
                        G.hand:sort()
                        if context.blueprint_card then context.blueprint_card:juice_up() else card:juice_up() end
                        card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "CHACHIPOINT DETECTADO", colour = G.C.RED})
                        return true
                    end}))
                playing_card_joker_effects({true})
        end
    end
}

--franex 

SMODS.Atlas{
    key = "franex",
    path = "Franex.png",
    px = 71,
    py = 95
}

SMODS.Joker{
    key = "franex",
    rarity = 3,
    cost = 10,
    atlas = "franex",
    pos = {x = 0, y = 0},
    add_to_deck = function (self, card, from_debuff)
        G.add_hacienda()
    end,
    calculate = function(self, card, context)
        local rarity_to_give = #G.jokers.cards
        if context.joker_main then
            return {
                message = ".." ..  rarity_to_give .. "comodines por destruir",
                colour = G.C.GREEN
            }
        end
        if context.selling_card and not context.blueprint and context.card == card then
            for _, joker in ipairs(G.jokers.cards) do
                if joker ~= card then
                    joker:start_dissolve()
                end
            end
            if rarity_to_give == 2 then
                local new_card = create_card('Joker', G.jokers, nil, 0, nil, nil, nil, 'car')
                new_card:add_to_deck()
                G.jokers:emplace(new_card)
                new_card:start_materialize()
            elseif rarity_to_give == 3 then
                local new_card = create_card('Joker', G.jokers, nil, 0.75, nil, nil, nil, 'car')
                new_card:add_to_deck()
                G.jokers:emplace(new_card)
                new_card:start_materialize()
            elseif rarity_to_give == 4 then
                local new_card = create_card('Joker', G.jokers, nil, 1, nil, nil, nil, 'car')
                new_card:add_to_deck()
                G.jokers:emplace(new_card)
                new_card:start_materialize()
            elseif rarity_to_give > 5 then
                local new_card = create_card('Joker', G.jokers, true, nil, nil, nil, nil, 'car')
                new_card:add_to_deck()
                G.jokers:emplace(new_card)
                new_card:start_materialize()
            end
            if math.floor(pseudorandom('franex') * 5) == 1 then
                card:start_dissolve()
                local new_card = copy_card(card, nil)
                new_card:add_to_deck()
                G.jokers:emplace(new_card)
                new_card:start_materialize()
                return {
                    message = "MENTIRA NO ME VOY A IR",
                    colour = G.C.GREEN,
                    func = function() return true end
                }
            end
        end
    end
}


SMODS.Atlas{
    key = "narvals",
    path = "narvals.png",
    px = 64,
    py = 85,
    frames = 41,
    atlas_table = 'ANIMATION_ATLAS'
}

SMODS.Joker{
    key = "narvales",
    atlas = 'narvals',
    pos = { x = 0, y = 0 },
    rarity = 2,
    cost = 6,
    blueprint_compat = false,
    add_to_deck = function (self, card, from_debuff)
        G.add_hacienda()
    end,
    calculate = function (self,card,context)
        if context.individual and context.cardarea == G.play then
            if context.other_card:get_id() <= 5 then
                context.other_card:set_ability(G.P_CENTERS.m_wild)
                card:juice_up(0.3,0.5)
                card_eval_status_text(card, 'extra', nil, nil, nil, {message = "NARVALS NARVALS"})
            end
        end
    end
}
--latin teacher

SMODS.Atlas{
    key = "latin",
    path = "LatinTeacher.png",
    px = 71,
    py = 95
}

SMODS.Joker{
    key = "latin",
    rarity = 3,
    cost = 10,
    atlas = "latin",
    pos = {x = 0, y = 0},
    add_to_deck = function (self, card, from_debuff)
        G.add_hacienda()
    end,
    calculate = function(self,card,context)
        if context.ending_shop then
            local roll = math.floor(pseudorandom("latin") * 3)
            if roll == 1 then
                 if G.consumeables.cards[1] then
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            local card = copy_card(pseudorandom_element(G.consumeables.cards, pseudoseed('perkeo')), nil)
                            card:set_edition({negative = true}, true)
                            card:add_to_deck()
                            G.consumeables:emplace(card)
                            return true
                        end}))
                    card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "oye para hacer tanto frio te veo muy rojo"})
                end
            else
                return {
                    message = "IMPUESTOS PARA TERMINAR TOMATE Y ZANAHORIA",
                    dollars = G.GAME.dollars - 1
                }
            end
        end
    end

}

--rubi

SMODS.Atlas{
    key = "rubi",
    path = "Rubi.png",
    px = 71,
    py = 95
}

SMODS.Joker{
    key = "rubi",
    loc_txt = {
        name = "Rubi Fumon",
        text = {
            "Al vender este joker,",
            "te sube {C:attention}+1{} el Ante,",
            "pero te multiplica el {C:money}dinero{}",
            "con un maximo de {C:money}100${}"
        }
    },

    rarity = 2,
    cost = 6,
    atlas = "rubi",
    pos = {x = 0, y = 0},
    calculate = function (self, card, context)
        if context.selling_card and context.card == card then
            ease_ante(1)
            if G.GAME.dollars < 100 then
                ease_dollars(G.GAME.dollars)
            elseif G.GAME.dollars >= 100 then
                ease_dollars(100)
            end
        end
    end

}

--larp

SMODS.Atlas{
    key = "tomoko",
    path = "Tomoko.png",
    px = 71,
    py = 95
}

SMODS.Joker{
    key = "tomoko",
    rarity = 3,
    cost = 10,
    atlas = "tomoko",
    pos = {x = 0, y = 0},
    add_to_deck = function (self, card, from_debuff)
        G.add_hacienda()
    end,
    calculate = function(self, card, context)
        local roll = math.floor(pseudorandom("tomoko") * #G.jokers.cards)
        local other_joker = G.jokers.cards[roll]
 		local other_joker_ret = SMODS.blueprint_effect(card, other_joker, context)
 		if other_joker_ret then
            roll = math.floor(pseudorandom("tomoko") * #G.jokers.cards)
            return other_joker_ret
        end
        if context.ending_shop then
            local roll2 = math.floor(pseudorandom("larpeo") * 2)
            if roll2 == 1 then
                if other_joker == card then
                    for _, joker in ipairs(G.jokers.cards) do
                    if joker.config.center_key == "j_prb_tomoko" then
                        joker:start_dissolve()
                        break
                    end
                end
                return {
                    message = "boi u cant larp tomoko"
                }
                end
                roll = math.floor(pseudorandom("tomoko") * #G.jokers.cards)
                local card = copy_card(other_joker, nil)
                card:set_edition({negative = true}, true)
                card:add_to_deck()
                G.jokers:emplace(card)
                card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "larped", colour = G.C.GREEN})
            else
                for _, joker in ipairs(G.jokers.cards) do
                    if joker.config.center_key == "j_prb_tomoko" then
                        joker:start_dissolve()
                        break
                    end
                end
                card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "LARPEO FALLIDO", colour = G.C.RED})
                return {
                    dollars = G.GAME.dollars - 10
                }
            end
        end
    end
}

-- 2slimey

SMODS.Atlas{
    key = "2slimey",
    path = "2Slimey.png",
    px = 71,
    py = 95
}

SMODS.Joker{
    key = "2slimey",
    rarity = 3,
    cost = 9,
    atlas = "2slimey",
    pos = {x=0,y=0},
    calculate = function (self, card, context)
        card.ability.rolled = false
        if context.before then
            local roll = math.floor(pseudorandom("2slimey", 1, 2))
            if roll == 1 then
                local editionroll = math.floor(pseudorandom("rolled", 1, 3))
                if editionroll == 1 then
                    G.play.cards[1]:set_edition({polychrome = true}, true)
                    return {
                        card = card,
                        message = "SHAWTY IN LOVE WIT DA MEAT"
                    }
                elseif editionroll == 2 then
                    G.play.cards[1]:set_edition({foil = true}, true)
                    return {
                        card = card,
                        message = "2SLIMEY STARE"
                    }
                elseif editionroll == 3 then
                    G.play.cards[1]:set_edition({holographic = true}, true)
                    return {
                        card = card,
                        message = "HIGH ANXIETY IS TOP 1 UDG"
                    }
                end
            else
                return {
                    card = card,
                    message = "no 2slimey"
                }
            end
        end
    end,
    add_to_deck = function (self, card, from_debuff)
        G.add_hacienda()
        ease_discard(-1)
    end
}

--percatric

SMODS.Atlas{
    key = "percatric",
    path = "Percatric.png",
    px = 71,
    py = 95
}

SMODS.Joker{
    key = "percatric",
    rarity = 2,
    cost = 5,
    atlas = "percatric",
    loc_txt = {
        name = "Percatric",
        text = {
            "Si tienes a {C:attention}este joker,{}",
            "los jokers {C:purple,E:1,s:1.2}malditos{} se eliminan",
            "al añadirse a la {C:attention}baraja{}"
        }
    },
    pos = {x = 0, y = 0},
    calculate = function(self, card, context)
        if context.card_added and context.card.config.center.rarity == "prb_maldito" then
            context.card:start_dissolve()
            return {
                card = card,
                message = "PERCATRIC TE PROTEGE",
                colour = G.C.GREEN
            }
        end
    end
}

--hounddog

SMODS.Atlas{
    key = "elvis",
    path = "HoundDog.png",
    px = 71,
    py = 95
}

SMODS.Joker{
    key = "elvis",
    loc_txt = {
        name = "Elvis Presley",
        text = {
            "{X:mult,C:white}X#1#{} Mult.",
            " Suma {X:mult,C:white}X1{} al Mult al",
            "usarse {C:attention}10 consumibles{} en",
            "esta partida.",
            "{C:inactive}Consumibles restantes: #2#{}"
        }
    },
    rarity = 2,
    cost = 6,
    atlas = "elvis",
    pos = {x=0,y=0},
    config = {extra = {Xmult = 1, left = 10}},
    loc_vars = function (self, info_queue, center)
        return {vars = {center.ability.extra.Xmult, center.ability.extra.left}}
    end,
    add_to_deck = function (self, card, from_debuff)
        G.add_hacienda()
    end,
    calculate = function (self, card, context)
        if context.using_consumeable then
            card.ability.extra.left = card.ability.extra.left - 1
        end
        if context.using_consumeable and card.ability.extra.left == 0 then
            card.ability.extra.Xmult = card.ability.extra.Xmult + 1
            card.ability.extra.left = 10
            return {
                message = "NOTHING BUT A HOUND DOG",
                colour = G.C.BLUE
            }
        end
        if context.joker_main then
            return {
                card = card,
                Xmult = card.ability.extra.Xmult
            }
        end
    end
}

--sneakers

local sneakersbase = SMODS.Atlas {
    key = "sneakersotoole",
    path = "SneakersBase.png",
    px = 71,
    py = 95
}

local sneakerspies = SMODS.Atlas {
    key = "sneakersopies",
    path = "SneakersPies.png",
    px = 71,
    py = 95
}

SMODS.Joker{
    key = "sneakers",
    rarity = 3,
    cost = 10,
    atlas = sneakersbase.key,
    pos = {x=0,y=0},
    config = {
        sneakertext = "CON ZAPATILLAS",
        pies = false,
        extra = {
            sneakersphase = 1,
            sub = 1,
            mult = 12,
            dollars = 2,
            chips = 150,
            Xmult = 4,
            sneakertext = "CON ZAPATILLAS"
            }
        },
    loc_vars = function (self, info_queue, card)
        return {
            vars = {
                card.ability.extra.sneakersphase,
                card.ability.extra.mult,
                card.ability.extra.dollars,
                card.ability.extra.chips,
                card.ability.extra.Xmult,
                self.config.sneakertext
        }}
    end,
    add_to_deck = function (self, card, from_debuff)
        G.add_hacienda()
    end,
    calculate = function(self,card,context)
        local normalhands = G.hand.config.card_limit
        if context.setting_blind then
            card.ability.extra.sneakersphase = card.ability.extra.sneakersphase + 1
        end
        if context.ending_shop and card.ability.extra.sneakersphase == 2 then
            G.hand.config.card_limit = normalhands - card.ability.extra.sub
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                    play_sound('tarot1')
                    card:juice_up(0.3, 0.5)
                    self.atlas = sneakerspies.key
                    return true
                end
            }))
            delay(0.9)
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.15,
                func = function()
                    card:flip()
                    play_sound('card1')
                    card:juice_up(0.3, 0.3)
                    return true
                end
            }))
            delay(0.9)
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.1,
                func = function()
                    card:start_dissolve()
                    return true
            end
            }))
            delay (0.9)
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.1,
                func = function()
                    local new_card = copy_card(card, nil)
                    new_card:add_to_deck()
                    G.jokers:emplace(new_card)
                    new_card:start_materialize()
                    self.config.pies = true
                    self.config.sneakertext = "SIN ZAPATILLAS"
                    card_eval_status_text(new_card, 'extra', nil, nil, nil, {message = "IM TAKING THEM OFF", colour = G.C.GREEN, card = new_card})
                return true
            end
            }))
        elseif context.ending_shop and card.ability.extra.sneakersphase == 3 then
            G.hand.config.card_limit = normalhands + 2
            card.ability.extra.sneakersphase = 1
            card.ability.extra.sub = 2
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                    play_sound('tarot1')
                    card:juice_up(0.3, 0.5)
                    self.atlas = sneakersbase.key
                    return true
                end
            }))
            delay(0.9)
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.15,
                func = function()
                    card:flip()
                    play_sound('card1')
                    card:juice_up(0.3, 0.3)
                    return true
                end
            }))
            delay(0.9)
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.1,
                func = function()
                    card:start_dissolve()
                    return true
            end
            }))
            delay (0.9)
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.1,
                func = function()
                    local new_card = copy_card(card, nil)
                    new_card:add_to_deck()
                    G.jokers:emplace(new_card)
                    new_card:start_materialize()
                    card.ability.pies = false
                    self.config.sneakertext = "CON ZAPATILLAS"
                    card_eval_status_text(new_card, 'extra', nil, nil, nil, {message = "IM NOT TAKING THEM OFF", colour = G.C.GREEN, card = new_card})

                return true
            end
            }))
        end
        if context.joker_main and self.config.pies then
            return {
                chips = card.ability.extra.chips,
                Xmult = card.ability.extra.Xmult
            }
        elseif context.joker_main and self.config.pies == false then
            return {
                mult = card.ability.extra.mult
            }
        end
        if (context.individual and context.cardarea == G.play) and self.config.pies == false then
            if context.other_card.seal == "prb_chachisello2" then
                return {
                    dollars = card.ability.extra.dollars
                }
            else
                return {
                    message = "im not taking my sneakers off",
                    card = card
                }
            end
        end
    end
}

--watersports

SMODS.Atlas{
    key = "watersports",
    path = "Watersports.png",
    px = 71,
    py = 95
}

SMODS.Joker{
    key = "watersports",
    loc_txt = {
        name = "Watersports",
        text = {
            "Vende a este {C:attention}joker{},",
            "para {C:dark_edition,E:1}duplicar{} las {C:attention}double tags{}",
            "en tu {C:blue}inventario"
        }
    },
    rarity = 3,
    cost = 10,
    atlas = "watersports",
    pos = {x=0,y=0},
    calculate = function (self, card, context)
        if context.selling_self then
            G.E_MANAGER:add_event(Event({
                card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "YOUR SILLYNESS", colour = G.C.GREEN, card = card}),
                delay(0.2),
                func = (function()
                    for i = 1, #G.GAME.tags do
                        add_tag({ key = 'tag_double' })
                        play_sound('generic1', 0.9 + math.random() * 0.1, 0.8)
                        play_sound('holo1', 1.2 + math.random() * 0.1, 0.4)
                    end
                    return true
                end)
            }))
            return nil, true
        end
    end
}
-- pavars

SMODS.Atlas{
    key = "povers",
    path = "Povers.png",
    px = 71,
    py = 95
}



SMODS.Joker{
    key = "povers",
    rarity = 3,
    cost = 10,
    atlas = "povers",
    blueprint_compat = false,
    loc_txt = {
        name = "Povers",
        text = {
            "Te da un {X:dark_edition,C:white,E:2,s:1.2}beneficio{} {X:dark_edition,C:white,E:2,s:1.2}aleatorio{}",
            "Dependiendo de la baraja que estes jugando.",
            "{s:1.2,E:1,C:attention}Siempre es eterno y no puedes tener copias de este joker.{}",
            "{C:inactive}baraja actual: #1#{}",
        }
    },
    pos = {x=0,y=0},
    config = {
        stake = "Nada",
        extra = {
            erraticnumber = 0,
            voucher = false,
            ghostroll = 0,
            isspade = false
        }},
    loc_vars = function (self, info_queue, center)
        return {vars = {
            self.config.stake,
        }}
    end,
    add_to_deck = function (self, card, from_debuff)
        G.add_hacienda()
        local backs = {
        b_abandoned = "Abandonada", -- HECHO, FUNCIONA
        b_anaglyph = "Anaglifo", -- HECHO, FUNCIONA
        b_black = "Negra", -- HECHO, FUNCIONA
        b_blue = "Azul", -- HECHO, FUNCIONA
        b_checkered = "Cuadrada", -- HECHO, FUNCIONA
        b_erratic = "Erratico", --HECHO
        b_ghost = "Fantasma",-- HECHO, FUNCIONA
        b_green = "Verde", -- HECHO, FUNCIONA
        b_magic = "Magica", -- HECHO, FUNCIONA
        b_nebula = "Nebulosa", -- HECHO
        b_painted = "Pintado", -- HECHO
        b_plasma = "Plasmatica", -- HECHO, FUNCIONA
        b_red = "Roja", -- HECHO, FUNCIONA
        b_yellow = "Amarilla", -- HECHO, FUNCIONA
        b_zodiac = "Zodiaca", -- HECHO, FUNCIONA
        b_prb_spicy = "Spicy", --  HECHO, FUNCIONA
        b_prb_bbtrikz = "Bbtrikz", -- HECHO, FUNCIONA
        b_prb_camarada = "Camarada"
        }
        local key = G.GAME.selected_back_key.key
        if backs[key] then
            self.config.stake = backs[key]
        end
        card:add_sticker("eternal", true)
        card.ability.extra.ghostroll = math.floor(pseudorandom("cuadrada", 1,2))
        if self.config.stake == "Erratico" then
            for k, v in pairs (G.playing_cards) do
                if v:get_id() == 2 or v:get_id() == 3 or v:get_id() == 4 or v:get_id() == 5 then
                    v:start_dissolve()
                    card.ability.extra.erraticnumber = card.ability.extra.erraticnumber + 1
                end
            end
            for i = 1, card.ability.extra.erraticnumber do
                local chosenrank = "King"
                local roll = math.floor(pseudorandom("abandoned", 1,3))
                if roll == 1 then
                    chosenrank = "Jack"
                elseif roll == 2 then
                    chosenrank = "Queen"
                else
                    chosenrank = "King"
                end
                local newcard = {
                    set = "Playing Card",
                    area = G.deck,
                    rank = chosenrank
                }
                local new = SMODS.create_card(newcard)
                G.deck:emplace(new)
                new:start_materialize()
                new:add_to_deck()
            end
        elseif self.config.stake == "Cuadrada" then
            if card.ability.extra.ghostroll == 1 then
                    for k, v in pairs(G.playing_cards) do
                        if v.base.suit == 'Spades' then
                            G.E_MANAGER:add_event(Event({
                                trigger = 'after',
                                delay = 0.1,
                                func = function()
                                    SMODS.change_base(v, "Hearts")
                                    return true
                                end
                            }))
                        end
                    end
                else
                    for k, v in pairs(G.playing_cards) do
                        if v.base.suit == 'Hearts' then
                            G.E_MANAGER:add_event(Event({
                                trigger = 'after',
                                delay = 0.1,
                                func = function()
                                    SMODS.change_base(v, "Spades")
                                    return true
                                end
                            }))
                        end
                    end
                end
                card_eval_status_text(card, 'extra', nil, nil, nil, {message = "povers", colour = G.C.GREEN, card = card})
        elseif self.config.stake == "Magica" then
            for i = 1, 2 do
                local fools = create_card("Spectral", G.consumeables, nil, nil, nil, nil, "c_fool", "poversmagic")
                fools:set_edition({negative = true}, true)
                fools:add_to_deck()
                G.consumeables:emplace(fools)
            end
            local judge = create_card("Spectral", G.consumeables, nil, nil, nil, nil, "c_judgement", "poversmagic2")
            judge:set_edition({negative = true}, true)
            judge:add_to_deck()
            G.consumeables:emplace(judge)
            card_eval_status_text(card, 'extra', nil, nil, nil, {message = "povers", colour = G.C.GREEN, card = card})
        elseif self.config.stake == "Nebulosa" then
            G.consumeables.config.card_limit = G.consumeables.config.card_limit + 1
            card_eval_status_text(card, 'extra', nil, nil, nil, {message = "povers", colour = G.C.GREEN, card = card})
        elseif self.config.stake == "Pintado" then
            local oldenegativegetweight = G.P_CENTERS.e_negative.get_weight
            SMODS.Edition:take_ownership('e_negative', {
                get_weight = function(self)
                    local weight = oldenegativegetweight(self)
                    weight = weight * 5
                    return weight
                end
            }, true)
            card_eval_status_text(card, 'extra', nil, nil, nil, {message = "povers", colour = G.C.GREEN, card = card})
        elseif self.config.stake == "Zodiaca" then
            G.consumeables.config.card_limit = G.consumeables.config.card_limit + 1
            G.GAME.spectral_rate = 2.5
            card_eval_status_text(card, 'extra', nil, nil, nil, {message = "povers", colour = G.C.GREEN, card = card})
        elseif self.config.stake == "Bbtrikz" then
            for i = 1, 13 do
                local popos = {
                    set = "Playing Card",
                    suit = "prb_pooposuit",
                    area = G.deck
                }
                local new = SMODS.create_card(popos)
                G.deck:emplace(new)
                new:start_materialize()
                new:add_to_deck()
                SMODS.add_card(popos)
            end
            G.P_CENTERS.c_jupiter.freq = 2
        end
    end,
    calculate = function (self, card, context)
        if context.round_eval and G.GAME.last_blind and G.GAME.last_blind.boss then
            if self.config.stake == "Anaglifo" then
                add_tag({ key = 'tag_double' })
                play_sound('generic1', 0.9 + math.random() * 0.1, 0.8)
                play_sound('holo1', 1.2 + math.random() * 0.1, 0.4)
                card_eval_status_text(card, 'extra', nil, nil, nil, {message = "povers", colour = G.C.GREEN, card = card})
            end
        end
        if context.setting_blind then
            if self.config.stake == "Negra" or self.config.stake == "Spicy" then
                ease_hands_played(1)
            elseif self.config.stake == "Azul" or self.config.stake == "Roja" then
                ease_hands_played(1)
                ease_discard(1)
            elseif self.config.stake == "Fantasma" and card.ability.extra.voucher == false then

                card.ability.extra.voucher = true
            end
        end
        if context.create_booster_card and context.booster.config.center.kind == "Arcana" then
            if self.config.stake == "Fantasma" then
                if pseudorandom('poversbooster') > 0.8 then
                return {
                    booster_create_flags = {
                        set = "Spectral",
                        area = G.pack_cards,
                        skip_materialize = true,
                        soulable = true,
                        key_append = "prb_ar2"
                    }
                }
                end
            end
        end
        if context.starting_shop then
            if self.config.stake == "Verde" and card.ability.extra.voucher == false then
                SMODS.add_voucher_to_shop("v_liquidation")
                card_eval_status_text(card, 'extra', nil, nil, nil, {message = "povers", colour = G.C.GREEN, card = card})
                card.ability.extra.voucher = true
            elseif self.config.stake == "Amarilla" and card.ability.extra.voucher == false then
                SMODS.add_voucher_to_shop("v_seed_money")
                card_eval_status_text(card, 'extra', nil, nil, nil, {message = "povers", colour = G.C.GREEN, card = card})
                card.ability.extra.voucher = true
            end
        end
        if context.joker_main then
            if self.config.stake == "Plasmatica" then
                return {
                    Xmult = 3,
                    card = card
                }
            end
        end
        if context.first_hand_drawn then
            if self.config.stake == "Abandonada" then
                for i = 1,3 do
                    local chosenrank = "King"
                    local roll = math.floor(pseudorandom("abandoned", 1,3))
                    if roll == 1 then
                        chosenrank = "Jack"
                    elseif roll == 2 then
                        chosenrank = "Queen"
                    else
                        chosenrank = "King"
                    end
                    local newcard = {
                        set = "Playing Card",
                        area = G.deck,
                        rank = chosenrank
                    }
                    local new = SMODS.create_card(newcard)
                    G.deck:emplace(new)
                    new:start_materialize()
                    new:add_to_deck()
                    SMODS.add_card(newcard)
                end
            end
        end
    end
}

SMODS.Atlas{
    key = "tungsahur",
    path = "TungSahur.png",
    px = 71,
    py = 95
}

SMODS.Joker{
    key = "tungsahur",
    rarity = 4,
    cost = 20,
    atlas = "tungsahur",
    pos = {x = 0, y = 0},
    soul_pos = {x = 1, y = 0},
    add_to_deck = function (self, card, from_debuff)
        G.add_hacienda()
    end,
    calculate = function(self, card, context)
        if context.setting_blind then
            if math.floor(pseudorandom("tungsahur") * 4) == 0 then
                return {
                    message = "BENDIGO ESTA BLIND CON EL PODER DE MINICHACHO",
                    colour = G.C.GREEN,
                    func = function()
                        G.E_MANAGER:add_event(Event({
                            trigger = "ease",
                            delay = 5,
                            ref_table = G.GAME,
                            ref_value = "chips",
                            ease_to = G.GAME.chips + 10^308,
                        }))
                    end
                }
            else
                return {
                    message = "jaque tonto",
                    colour = G.C.RED
                }
            end
        end
    end
}

SMODS.Atlas{
    key = "sancristobal",
    path = "SanCristobal.png",
    px = 71,
    py = 95
}

SMODS.Joker{
    key = "sancristobal",
    rarity = 4,
    cost = 20,
    atlas = "sancristobal",
    pos = {x = 0, y = 0},
    soul_pos = {x = 1, y = 0},
    add_to_deck = function (self, card, from_debuff)
        G.add_hacienda()
    end,
    calculate = function(self, card, context)
        if context.setting_blind then
            local stolen = math.floor(G.GAME.dollars / 2)
            return {
                message = "ROBADO POR MORO",
                colour = G.C.RED,
                dollars = G.GAME.dollars - stolen
            }
        end
        if context.buying_card and not context.blueprint then
            local roll = math.floor(pseudorandom("sancristobal") * 4)
            if roll < 3 then
                local jokerbought = G.jokers.cards[#G.jokers.cards]
                if jokerbought.config.center.rarity == 1 then
                    jokerbought:start_dissolve()
                    local new_joker = create_card('Joker', G.jokers, nil, math.min(pseudorandom("rarity 1", 0.71, 1), 1),nil, nil, nil, 'car')
                    new_joker:add_to_deck()
                    G.jokers:emplace(new_joker)
                    new_joker:start_materialize()
                    G.GAME.joker_buffer = 0
                    new_joker:set_edition({negative = true}, true)
                    card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "FUERA MOROS DE SANCRIS", colour = G.C.GREEN, card = card})
                elseif jokerbought.config.center.rarity == 2 then
                    jokerbought:start_dissolve()
                    local new_joker = create_card('Joker', G.jokers, nil, 1, nil, nil, nil, 'car')
                    new_joker:add_to_deck()
                    G.jokers:emplace(new_joker)
                    new_joker:start_materialize()
                    G.GAME.joker_buffer = 0
                    new_joker:set_edition({negative = true}, true)
                    card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "FUERA GITANOS DE SANCRIS", colour = G.C.GREEN, card = card})
                end
            else
                return {
                    message = "no",
                    colour = G.C.GREEN
                }
            end
        end
    end
}
SMODS.Atlas{
    key = "getafe",
    path = "GetafeGrimReaper.png",
    px = 71,
    py = 95
}

SMODS.Joker{
    key = "getafe",
    rarity = 4,
    cost = 20,
    atlas = "getafe",
    pos = {x = 0, y = 0},
    soul_pos = {x = 1, y = 0},
    config = {  extra = {
            Xmult = 5
    }
    },
    loc_vars = function(self,info_queue,center)
        return {vars = {center.ability.extra.Xmult}}
    end,

    add_to_deck = function (self, card, from_debuff)
        G.add_hacienda()
    end,
    calculate = function (self,card,context)
        if context.joker_main then
            return{
                Xmult = card.ability.extra.Xmult,
                card = card
            }
        end
        if card.ability.doneinone == nil then
            card.ability.doneinone = true
        end
        if G.GAME.current_round.hands_played == 2 then
            card.ability.doneinone = false
        end
        if context.blind_defeated then
            if card.ability.doneinone == false then
                return {
                    message = "fuera jerma que te meto cuchillo",
                    card = card
                }
            end
        end
        if context.ante_change then
            if card.ability.doneinone then
                local newjoker = create_card("Joker", G.jokers, nil, 1, nil, nil, nil, nil)
                newjoker:add_to_deck()
                G.jokers:emplace(newjoker)
                newjoker:start_materialize()
                newjoker:set_edition({negative = true}, true)
                G.GAME.hands_played = 0
                card.ability.extra.Xmult = card.ability.extra.Xmult + 5
            else
                return{
                    message = "tejodes illo",
                    colour = G.C.GOLD
                }
            end
        end
    end
}

SMODS.Atlas{
    key = "kaicenat",
    path = "KaiCenat.png",
    px = 71,
    py = 95
}

SMODS.Joker{
    key = "kaicenat",
    loc_txt = {
        name = "La Llave A Todas Las Habitaciones",
        text = {
            "Te otorga {s:2,X:purple,C:white,E:1}^#1#{} Mult,",
            "Al sacar una mano, cada carta tiene",
            "una {C:green}probabilidad del 20%{} de",
            "subir ese valor por {s:2,X:purple,C:white,E:1}+0.25{}"
        }
    },

    rarity = 4,
    cost = 20,
    atlas = "kaicenat",
    pos = {x = 0, y = 0},
    soul_pos = {x = 1, y = 0},
    config = {  extra = {
            Pmult = 1
    }
    },
    loc_vars = function(self,info_queue,center)
        return {
            vars = {
                center.ability.extra.Pmult
            }
        }
    end,
    add_to_deck = function (self, card, from_debuff)
        G.add_hacienda()
    end,
    calculate = function(self,card,context)
        if context.cardarea == G.play and context.individual then
            if math.floor(pseudorandom("kaicenat") * 5) == 1 then
                card.ability.extra.Pmult = card.ability.extra.Pmult + 0.25
                return {
                    card = card,
                    message = "KAI CENAT SPEED ROFL",
                    colour = G.C.PURPLE
                }
            else
                return {
                    card = card,
                    message = "no kai cenat",
                    colour = G.C.RED
                }
            end
        end
        if context.joker_main then
            return {
                card = card,
                Emult_mod = card.ability.extra.Pmult,
                message = "^" .. card.ability.extra.Pmult ..  "Mult",
                colour = G.C.PURPLE
            }
        end
    end

}

SMODS.Atlas{
    key = "mikecrack",
    path = "Mikecrack.png",
    px = 71,
    py = 95
}

SMODS.Joker{
    key = "mikecrack",
    rarity = 4,
    cost = 20,
    atlas = "mikecrack",
    pos = {x = 0, y = 0},
    soul_pos = {x = 1, y = 0},
    config = { extra = {number = 1, doneinone = true, blinds = 0, money = 1, hands = 0}},
    loc_vars = function(self,info_queue,center)
        return {vars = {center.ability.extra.number, center.ability.extra.doneinone, center.ability.extra.blinds, center.ability.extra.money, center.ability.extra.hands}}
    end,
    add_to_deck = function (self, card, from_debuff)
        G.add_hacienda()
    end,
    calc_dollar_bonus = function(self,card)
        card.ability.extra.money = card.ability.extra.number * 5
        local money_gained = card.ability.extra.money
        return money_gained
    end,
    calculate = function(self,card,context)
        if context.hand_drawn then
            card.ability.extra.hands = card.ability.extra.hands + 1
            if card.ability.extra.hands == 3 then
                card.ability.extra.doneinone = false
                return {
                    message = "ya no hay diamantito",
                    colour = G.C.BLUE
                }
            end
        end
        if (context.blind_defeated or context.skip_blind) and card.ability.extra.doneinone then
            card.ability.extra.hands = 0
            card.ability.extra.blinds = card.ability.extra.blinds + 1
            return {
                message = "" .. card.ability.extra.blinds, "ronda hecha"
            }
        end
        if context.starting_shop and card.ability.extra.blinds == 3 and card.ability.extra.doneinone then
            for i = 1, card.ability.extra.number do
                G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                SMODS.add_voucher_to_shop()
                return true end }))
            end
            card.ability.extra.number = card.ability.extra.number + 1
            card.ability.extra.blinds = 0
            return {
                message = "TOMA DIAMANTITO PERRA",
                colour = G.C.BLUE
            }
        end
    end
}

SMODS.Atlas{
    key = "usera",
    path = "Usera.png",
    px = 71,
    py = 95
}

SMODS.Joker{
    key = "usera",
    rarity = 4,
    cost = 20,
    atlas = "usera",
    pos = {x = 0, y = 0},
    soul_pos = {x = 1, y = 0},
    config = { extra = {
        Xmult = 1
    }
    },
    loc_vars = function(self,info_queue,center)
        return {vars = {center.ability.extra.Xmult}}
    end,
    add_to_deck = function (self, card, from_debuff)
        G.add_hacienda()
    end,
    calculate = function(self, card, context)
    if context.before and next(context.poker_hands['High Card']) then
        card.ability.extra.Xmult = card.ability.extra.Xmult + math.floor(pseudorandom("highcard", 5, 50))
        return {
            message = 'HIGHCARD USERIANA',
            colour = G.C.RED
        }
    elseif context.before and next(context.poker_hands['Flush'])  then
        card.ability.extra.Xmult = card.ability.extra.Xmult + math.floor(pseudorandom("flush", 2, 35))
        return {
            message = 'COLOR USERIANO',
            colour = G.C.RED
        }
    elseif context.before and next(context.poker_hands['Pair'])  then
        card.ability.extra.Xmult = card.ability.extra.Xmult + math.floor(pseudorandom("pair", 2, 40))
        return {
            message = 'PAREJA USERIANA',
            colour = G.C.RED
        }
    elseif context.before and next(context.poker_hands['Two Pair'])  then
        card.ability.extra.Xmult = card.ability.extra.Xmult + math.floor(pseudorandom("twopair", 2, 45))
        return {
            message = 'PAREJA USERIANA',
            colour = G.C.RED
        }
    elseif context.before and next(context.poker_hands['Three of a Kind'])  then
        card.ability.extra.Xmult = card.ability.extra.Xmult + math.floor(pseudorandom("three", 2, 40))
        return {
            message = 'TRIO USERIANO',
            colour = G.C.RED
        }
    elseif context.before and next(context.poker_hands['Straight'])  then
        card.ability.extra.Xmult = card.ability.extra.Xmult + math.floor(pseudorandom("straight", 2, 50))
        return {
            message = 'ESCALERA USERIANA',
            colour = G.C.RED
        }
    elseif context.before and next(context.poker_hands['Full House'])  then
        card.ability.extra.Xmult = card.ability.extra.Xmult + math.floor(pseudorandom("fullhouse", 2, 40))
        return {
            message = 'CASA USERIANA',
            colour = G.C.RED
        }
    elseif context.before and next(context.poker_hands['Four of a Kind'])  then
        card.ability.extra.Xmult = card.ability.extra.Xmult + math.floor(pseudorandom("four", 3, 45))
        return {
            message = 'POKER USERIANO',
            colour = G.C.RED
        }
    elseif context.before and next(context.poker_hands['Straight Flush']) then
        card.ability.extra.Xmult = card.ability.extra.Xmult + math.floor(pseudorandom("coloresca", 4, 40))
        return {
            message = 'ESCALERA COLORIDA USERIANA',
            colour = G.C.RED
        }
    elseif context.before and next(context.poker_hands['Five of a Kind']) then
        card.ability.extra.Xmult = card.ability.extra.Xmult + math.floor(pseudorandom("five", 2, 30))
        return {
            message = 'REPOQUER USERIANO',
            colour = G.C.RED
        }
    elseif context.before and next(context.poker_hands['Flush House']) then
        card.ability.extra.Xmult = card.ability.extra.Xmult + math.floor(pseudorandom("flushouse", 3, 35))
        return {
            message = 'FULL DE COLOR USERIANO',
            colour = G.C.RED
        }
    elseif context.before and next(context.poker_hands['Flush Five']) then
        card.ability.extra.Xmult = card.ability.extra.Xmult + math.floor(pseudorandom("flushfive", 3, 35))
        return {
            message = 'CINCO DE COLOR USERIANO',
            colour = G.C.RED
        }
    end
    if context.joker_main then
        return {
            Xmult = card.ability.extra.Xmult
        }
    end
    if context.final_scoring_step then
        card.ability.extra.Xmult = 1
        return{
            message = "USERA RESET",
            colour = G.C.BLUE
        }
    end
end
}

SMODS.Atlas{
    key = "bbnos",
    path = "Bbno.png",
    px = 71,
    py = 95
}


SMODS.Joker{
    key = "bbnos",
    rarity = 4,
    cost = 20,
    atlas = "bbnos",
    pos = {x = 0, y = 0},
    soul_pos = {x = 1, y = 0},
    config = {extra = {counter = 0, emult = 1}},
    loc_vars = function (self, info_queue, center)
        return {vars = {center.ability.extra.counter, center.ability.extra.emult}}
    end,
    add_to_deck = function (self, card, from_debuff)
        G.add_hacienda()
    end,
    update = function(self,card,dt)
        if G.STAGE == 2 and card.added_to_deck then
        card.ability.extra.counter = card.ability.extra.counter + 1
        end
        if card.ability.extra.counter == 120 then
            card.ability.extra.counter = 0
            local chance = math.floor(pseudorandom("bbnos", 1 ,1000))
            if chance == 67 then
                G.STATE = G.STATES.GAME_OVER
                if not G.GAME.won and not G.GAME.seeded and not G.GAME.challenge then
                    G.PROFILES[G.SETTINGS.profile].high_scores.current_streak.amt = 0
                end
                G:save_settings()
                G.FILE_HANDLER.force = true
                G.STATE_COMPLETE = false
            end
        end
    end,
    calculate = function (self, card, context)
        card.ability.extra.emult = #G.jokers.cards
        if (context.buying_card or context.card_added) and context.card.area == G.jokers then
            return {
                card = card,
                message = "COME COME TO ISRAEL",
                colour = G.C.EDITION
            }
        end
        if context.joker_main then
            return {
                card = card,
                Emult_mod = card.ability.extra.emult,
                message = "^" .. card.ability.extra.emult ..  " Mult",
                colour = G.C.PURPLE
            }
        end
    end
}


-- edward skeletrix

SMODS.Atlas{
    key = "skeletrix",
    path = "Skeletrix.png",
    px = 71,
    py = 95
}

SMODS.Joker{
    key = "skeletrix",
    rarity = 4,
    cost = 20,
    atlas = "skeletrix",
    pos = {x = 0, y = 0},
    soul_pos = {x = 1, y = 0},
    add_to_deck = function (self, card, from_debuff)
        G.add_hacienda()
    end,
    loc_txt = {
        name = "Edward Skeletrix",
        text = {
            "Copia al {C:attention}joker{} que este {C:blue}mas a la izquierda.{}",
            "Al salir de {C:attention}la tienda{},",
            "Hay una probabilidad de {C:green}1 entre 2{} de que",
            "Haga una {C:attention}copia exacta{} del {C:attention}joker{},",
            "que este {C:red}mas a la derecha{}.",
            "{C:inactive,s:0.9}No pueden hacerse copias de jokers legendarios.{}",
            "{C:dark_edition,s:2,E:1}BILLETE GRATIS A LA ISLA DE SKELETRIX{}"
        }
    },
    calculate = function(self, card, context)
        local other_joker = G.jokers.cards[1]
        local other_joker_ret = SMODS.blueprint_effect(card, other_joker, context)
        if other_joker_ret then
            return other_joker_ret
        end
        local rightmost_joker = G.jokers.cards[#G.jokers.cards]
        if context.ending_shop and rightmost_joker and rightmost_joker ~= card and rightmost_joker.config.center.rarity ~= 4 then
            if math.floor(pseudorandom("skeletrix", 1, 2)) == 1 then
                local copy = copy_card(rightmost_joker, nil)
                copy:add_to_deck()
                G.jokers:emplace(copy)
                copy:start_materialize()
                card_eval_status_text(card, 'extra', nil, nil, nil, {message = "HIZO EL JOKER A LOS 13 BTW", colour = G.C.GREEN, card = card})
            else
                card_eval_status_text(card, 'extra', nil, nil, nil, {message = "NO HIZO EL JOKER A LOS 13 BTW...", colour = G.C.RED, card = card})
            end
        end
    end
}
--heldepa
SMODS.Atlas{
    key = "heldepa",
    path = "Heldepa.png",
    px = 71,
    py = 95
}
SMODS.Joker{
    key = "heldepa",
    rarity = 4,
    cost = 20,
    atlas = "heldepa",
    pos = {x = 0, y = 0},
    soul_pos = {x = 1, y = 0},
    add_to_deck = function (self, card, from_debuff)
        G.add_hacienda()
    end,
    loc_txt = {
        name = "Heldepa",
        text = {
            "Aumenta las C:chips}fichas{} actuales",
            "de la {C:attention}ciega{} al",
            "requerimiento de fichas requeridos en {C:red}esta ciega{}.",
            "dividido entre 2, {C:attention}redondeado hacia abajo{}.",
            "{C:mult,s:2,E:1}NUEVA COMPETENCIA A YEAT{}"
        }
    },
    calculate = function(self, card, context)
        if context.setting_blind  then
            G.E_MANAGER:add_event(Event({
                trigger = "ease",
                delay = 5,
                ref_table = G.GAME,
                ref_value = "chips",
                ease_to = G.GAME.chips + math.ceil(G.GAME.blind.chips * 0.5),
            }))
            return {
                message = "UNA LEIDIIIBOI",
                colour = G.C.GREEN
            }
        end
    end
}
-- netanyahu
SMODS.Atlas{
    key = "netanyahu",
    path = "Netanyahu.png",
    px = 71,
    py = 95
}

SMODS.Joker{
    key = "netanyahu",
    rarity = 4,
    cost = 20,
    atlas = "netanyahu",
    pos = {x = 0, y = 0},
    add_to_deck = function (self, card, from_debuff)
        G.add_hacienda()
    end,
    loc_txt = {
        name = "Netanyahu",
        text = {
            "{X:mult,C:white}X#1#{} Mult.",
            "El {X:mult,C:white}XMult{} sera igual a la cantidad de",
            "{C:money}dinero{} que tengas actualmente.",
            "Al entrar {C:attention}a la tienda{}, tu dinero",
            "se multiplicara por {X:money,C:white}X1.5{}, redondeado hacia abajo.",
            "{X:edition,C:white,E:1,s:2}BENJAMIN{} {X:edition,C:white,E:1,s:2}BIG YAHU{}",
            "{X:edition,C:white,E:1,s:2}PONME{} {X:edition,C:white,E:1,s:2}LOS{} {X:edition,C:white,E:1,s:2}FILIPINOS{} {X:edition,C:white,E:1,s:2}A{}",
            "{X:edition,C:white,E:1,s:2}MENOS{} {X:edition,C:white,E:1,s:2}DE{} {X:edition,C:white,E:1,s:2}90{} {X:edition,C:white,E:1,s:2}CENTIMOS{}"
        }
    },
    config = { extra = {Xmult = 1}},
    loc_vars = function(self,info_queue,center)
        return {vars = {center.ability.extra.Xmult}}
    end,
    calculate = function(self, card, context)
        card.ability.extra.Xmult = G.GAME.dollars
        if context.joker_main then
            return {
                card = card,
                Xmult = card.ability.extra.Xmult
            }
        end
        if context.setting_blind then
            local new_dollars = math.floor(G.GAME.dollars * 1.5)
            ease_dollars(new_dollars)
            return {
                message = "YAHU TE HA MULTIPLICADO EL DINERO POR 1.5",
                colour = G.C.GREEN
            }
        end
    end
}
-- hazbin hotel
SMODS.Atlas{
    key = "hazbin",
    path = "HazbinHotel.png",
    px = 71,
    py = 95
}

SMODS.Joker{
    key = "hazbin",
    rarity = 4,
    cost = 20,
    atlas = "hazbin",
    pos = {x = 0, y = 0},
    soul_pos = {x = 1, y = 0},
    add_to_deck = function (self, card, from_debuff)
        G.add_hacienda()
    end,
    loc_txt = {
        name = "Hazbin Hotel",
        text = {
            "{X:purple,C:white,E:2,s:2}^#1#{} Mult.",
            "Vender un {C:attention}consumible{} sumara un {X:purple,C:white,E:2,s:2}^0.5{} Mult.",
            "Esto se reseteara al {C:attention}final del ante{}.",
            "Al vender 12 {C:attention}consumibles{}, se creara un",
            "{C:attention}Joker{} {C:rare}raro{} {C:blue}perecedero{} aleatorio en tu {C:attention}mazo{}.",
            "{C:red,s:1.2,E:1}porque me haceis esto{}"
        }
    },
    config = { extra = {Emult = 1}},
    loc_vars = function(self,info_queue,center)
        return {vars = {center.ability.extra.Emult}}
    end,
    calculate = function(self, card, context)
        if context.selling_card and context.card.area == G.consumeables then
            card.ability.extra.Emult = (card.ability.extra.Emult or 1) + 0.5
            if card.ability.extra.Emult >= 6 then
                local new_joker = create_card('Joker', G.jokers, nil, math.min(pseudorandom("hazbin", 0.71, 1), 1),nil, nil, nil, 'car')
                new_joker:add_to_deck()
                G.jokers:emplace(new_joker)
                new_joker:start_materialize()
                new_joker:set_edition({negative = true}, true)
                new_joker:add_sticker("perishable", true)
                card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "HAS VENDIDO 12 CONSUMIBLES", colour = G.C.GREEN, card = card})
                card.ability.extra.Emult = 1
            else
                card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "CONSUMIBLE VENDIDO", colour = G.C.GREEN, card = card})
            end
        end
        if context.ante_change then
            card.ability.extra.Emult = 1
            return {
                message = "MULTIPLICADOR RESETEADO",
                colour = G.C.BLUE,
                card = card
            }
        end
        if context.joker_main then
            return {
                card = card,
                Emult_mod = card.ability.extra.Emult,
                message = "^" .. card.ability.extra.Emult ..  " Mult",
                colour = G.C.PURPLE
            }
        end
    end
}

-- maldicion chimpa

SMODS.Atlas {
    key = "m_chimpa",
    path = "MaldicionChimpa.png",
    px = 71,
    py = 95
}

SMODS.Joker{
    key = "m_chimpa",
    rarity = "prb_maldito",
    cost = 20,
    atlas = "m_chimpa",
    pos = {x = 0, y = 0},
    soul_pos = {x = 1, y = 0},
    loc_txt = {
        name = "Maldicion Chimpa",
        text = {
            "{X:mult,C:white}X#1#{} Mult. Se destruye en {C:attention}3 rondas.{}",
            "{C:red}No se puede vender.{}"
        }
    },
    config = { extra = {Xmult = 0.5, left = 3}},
    loc_vars = function(self,info_queue,center)
        return {vars = {center.ability.extra.Xmult, center.ability.extra.left}}
    end,
    add_to_deck = function (self, card, from_debuff)
        card:add_sticker("eternal", true)
        card:set_edition('e_negative')
    end,
    calculate = function (self, card, context)
        if context.blind_defeated then
            card.ability.extra.left = card.ability.extra.left - 1
        end
        if context.blind_defeated and card.ability.extra.left == 0 then
            card:add_sticker(nil)
            card:start_dissolve()
        end
        if context.joker_main then
            return {
                card = card,
                Xmult = card.ability.extra.Xmult
            }
        end
    end,
    in_pool = function (self, args)
        return false
    end
}

-- maldicionmuchacho

SMODS.Atlas {
    key = "m_muchacho",
    path = "MaldicionMuchacho.png",
    px = 71,
    py = 95
}

SMODS.Joker{
    key = "m_muchacho",
    rarity = "prb_maldito",
    cost = 20,
    atlas = "m_muchacho",
    pos = {x = 0, y = 0},
    soul_pos = {x = 1, y = 0},
    loc_txt = {
        name = "Maldicion Muchacho",
        text = {
            "{C:green}1 entre 2{} de que",
            "una {C:attention}carta aleatoria{} en tu mano,",
            "este {C:attention}volteada{}.",
            "{C:red}No se puede vender.{}",
            "{C:attention}Se destruye en 5 rondas.{}"
        }
    },
    add_to_deck = function (self, card, from_debuff)
        G.add_hacienda()
        card:add_sticker("eternal", true)
        card:set_edition('e_negative')
    end,
    in_pool = function (self, args)
        return false
    end,
    config = { extra = {left = 5}},
    calculate = function (self, card, context)
        if context.stay_flipped and context.to_area == G.hand and
                SMODS.pseudorandom_probability(card, 'prb_m_muchacho', 1, 2) then
                return {
                    stay_flipped = true
            }
        end
        if context.blind_defeated then
            card.ability.extra.left = (card.ability.extra.left or 5) - 1
            if card.ability.extra.left == 0 then
                card:add_sticker(nil)
                card:start_dissolve()
            end
        end
    end
}

-- maldicion bubu 

SMODS.Atlas {
    key = "m_bubu",
    path = "MaldicionBubu.png",
    px = 71,
    py = 95
}

SMODS.Joker{
    key = "m_bubu",
    rarity = "prb_maldito",
    cost = 20,
    atlas = "m_bubu",
    pos = {x = 0, y = 0},
    soul_pos = {x = 1, y = 0},
    loc_txt = {
        name = "Maldicion Bubu",
        text = {
            "Si sacas una mano con {C:attention}menos de 5 cartas{},",
            "La siguente {C:blue}carta{} dara un",
            "{X:mult,C:white}X0{} Mult.",
            "{C:red}No se puede vender.{}",
            "se destruye en {C:attention}5 rondas.{}"
        }
    },
    config = { extra = {Xmult = 1}},
    loc_vars = function(self,info_queue,center)
        return {vars = {center.ability.extra.Xmult}}
    end,
    add_to_deck = function (self, card, from_debuff)
        G.add_hacienda()
        card:add_sticker("eternal", true)
        card:set_edition('e_negative')
    end,
    in_pool = function (self, args)
        return false
    end,
    calculate = function (self, card, context)
        if context.final_scoring_step then
            if #G.play.cards < 5 then
                card_eval_status_text(card, 'extra', nil, nil, nil, {message = "BUBU ENOJADO", colour = G.C.RED, card = card})
                card.ability.extra.Xmult = 0
            else
                card_eval_status_text(card, 'extra', nil, nil, nil, {message = "BUBU FELIZ", colour = G.C.GREEN, card = card})
                card.ability.extra.Xmult = 1
            end
        end
        if context.starting_shop then
            card.ability.extra.left = (card.ability.extra.left or 5) - 1
            if card.ability.extra.left == 0 then
                card:add_sticker(nil)
                card:start_dissolve()
            end
        end
        if context.joker_main then
            return {
                card = card,
                Xmult_mod = card.ability.extra.Xmult,
                message = "X" .. card.ability.extra.Xmult .. " Mult",
                colour = G.C.RED
            }
        end
    end
}
--maldicion hacienda
SMODS.Atlas {
    key = "m_hacienda",
    path = "MaldicionHacienda.png",
    px = 71,
    py = 95
}

SMODS.Joker{
    key = "m_hacienda",
    rarity = "prb_maldito",
    cost = 20,
    atlas = "m_hacienda",
    pos = {x = 0, y = 0},
    soul_pos = {x = 1, y = 0},
    loc_txt = {
        name = "Maldicion Hacienda",
        text = {
            "Cada {C:attention}carta{} tiene una probabilidad de",
            "{C:green}1 entre 2{} de quitarte {C:money}-1${}",
            "{C:red}No se puede vender.{}",
            "Se destruye en {C:attention}2 rondas.{}",
            "Hay una probabilidad de que spawnee",
            "de {C:green}1 entre 10{} que spawnee si",
            "añades un joker del {C:attention}Alpiste Mod{} a tu mazo teniendo",
            "mas de {C:money}100${}."
        }
    },
    add_to_deck = function (self, card, from_debuff)
        card:add_sticker("eternal", true)
        card:set_edition('e_negative')
    end,
    in_pool = function (self, args)
        return false
    end,
    calculate = function (self, card, context)
        if context.cardarea == G.play and context.individual then
            if SMODS.pseudorandom_probability(card, 'prb_m_hacienda', 1, 2) then
                return {
                    card = card,
                    dollars = -1,
                    message = "PAGA IMPUESTOS MAKARRA",
                    colour = G.C.RED
                }
            end
        end
        if context.starting_shop then
            card.ability.left = (card.ability.left or 2) - 1
            if card.ability.left == 0 then
                card:add_sticker(nil)
                card:start_dissolve()
            end
        end
    end

}

