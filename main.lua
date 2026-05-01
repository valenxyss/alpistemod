
local faithful_destroyed = false
local burnt_sold = false
--- mainmenu
SMODS.current_mod.menu_cards = function()
    return { -- This takes any SMODS.create_card parameters
        key = "j_prb_adif",
        remove_original = true -- This removes the vanilla Ace
    }
end

--- sounds 
local goop = SMODS.Sound{
    key = "goop",
    path = "goop.ogg"
}

local goop1 = SMODS.Sound{
    key = "goop1",
    path = "goop1.ogg"
}

local goop2 = SMODS.Sound{
    key = "goop2",
    path = "goop2.ogg"
}
--- rarities
local malditorarity = SMODS.Rarity{
    key = "maldito",
    loc_txt = { name = "Maldito" },
    badge_colour = HEX("341362")
}
--- --seals

SMODS.Atlas{
    key = "chachisello1",
    path = "Chachisello1.png",
    px = 71,
    py = 95
}

local chachisello1 = SMODS.Seal{
    key = "chachisello1",
    loc_txt = {
        name = "Chachisello 1",
        label = "Chachisello 1",
        text = {
            "No hace nada. (Todavia)"
        }
    },
    atlas = "chachisello1",
    pos = {x = 0, y = 0},
    badge_colour = HEX("B40000")
}

SMODS.Atlas{
    key = "chachisello2",
    path = "Chachisello2.png",
    px = 71,
    py = 95
}

local chachisello2 = SMODS.Seal{
    key = "chachisello2",
    loc_txt = {
        name = "Chachisello 2",
        label = "Chachisello 2",
        text = {
            "{C:green}1 de #1#{} de generar un joker {C:common}comun{}",
            "{C:dark_edition}negativo{} al jugar la carta,",
            "la probabilidad {C:green}sube{}",
            "si el joker se genera",
            "satisfactoriamente."
        }
    },
    atlas = "chachisello2",
    pos = {x = 0, y = 0},
    badge_colour = HEX("B43400"),
    config = { denominator = 10 },
    loc_vars = function(self,info_queue)
        return {vars = {self.config.denominator}}
    end,
    calculate = function(self,card,context)
        if context.cardarea == G.play and context.main_scoring then
            local roll = math.floor(pseudorandom("chachisello2", 1) * self.config.denominator)
            if roll == 0 then
                local new_joker = create_card('Joker', G.jokers, nil, 0, nil, nil, nil, 'car')
                new_joker:add_to_deck()
                G.jokers:emplace(new_joker)
                new_joker:start_materialize()
                G.GAME.joker_buffer = 0
                new_joker:set_edition({negative = true}, true)
                self.config.denominator = self.config.denominator - 1
                return {
                    message = "CHACHI"
                }
            end
            if self.config.denominator == 0 then
                self.config.denominator = 1
            end
        end
    end
}

SMODS.Atlas{
    key = "chachisello3",
    path = "Chachisello3.png",
    px = 71,
    py = 95
}
local chachisello3 = SMODS.Seal{
    key = "chachisello3",
    loc_txt = {
        name = "Chachisello 3",
        label = "Chachisello 3",
        text = {
            "{C:green}1 de #1#{} de generar un joker {C:uncommon}poco comun{}",
            "{C:dark_edition}negativo{} al jugar la carta,",
            "la probabilidad {C:green}sube{}",
            "si el joker se genera",
            "satisfactoriamente."
        }
    },
    atlas = "chachisello3",
    pos = {x = 0, y = 0},
    badge_colour = HEX("C5B900"),
    config = { denominator = 15 },
    loc_vars = function(self,info_queue)
        return {vars = {self.config.denominator}}
    end,
    calculate = function(self,card,context)
        if context.cardarea == G.play and context.main_scoring then
            local roll = math.floor(pseudorandom("chachisello3", 1) * self.config.denominator)
            if roll == 0 then
                local new_joker = create_card('Joker', G.jokers, nil, 0.71, nil, nil, nil, 'car')
                new_joker:add_to_deck()
                G.jokers:emplace(new_joker)
                new_joker:start_materialize()
                G.GAME.joker_buffer = 0
                new_joker:set_edition({negative = true}, true)
                self.config.denominator = self.config.denominator - 1
                return {
                    message = "CHACHI"
                }
            end
            if self.config.denominator == 0 then
                self.config.denominator = 1
            end
        end
    end
}

SMODS.Atlas{
    key = "chachisello4",
    path = "Chachisello4.png",
    px = 71,
    py = 95
}

local chachisello4 = SMODS.Seal{
    key = "chachisello4",
    loc_txt = {
        name = "Chachisello 4",
        label = "Chachisello 4",
        text = {
            "{C:green}1 de #1#{} de generar un joker {C:rare}raro{}",
            "{C:dark_edition}negativo{} al jugar la carta,",
            "la probabilidad {C:green}sube{}",
            "si el joker se genera",
            "satisfactoriamente."
        }
    },
    atlas = "chachisello4",
    pos = {x = 0, y = 0},
    badge_colour = HEX("17008C"),
    config = { denominator = 20 },
    loc_vars = function(self,info_queue)
        return {vars = {self.config.denominator}}
    end,
    calculate = function(self,card,context)
        if context.cardarea == G.play and context.main_scoring then
            local roll = math.floor(pseudorandom("chachisello4", 1) * self.config.denominator)
            if roll == 0 then
                local new_joker = create_card('Joker', G.jokers, nil, 1, nil, nil, nil, 'car')
                new_joker:add_to_deck()
                G.jokers:emplace(new_joker)
                new_joker:start_materialize()
                G.GAME.joker_buffer = 0
                new_joker:set_edition({negative = true}, true)
                self.config.denominator = self.config.denominator - 1
                return {
                    message = "CHACHI"
                }
            end
            if self.config.denominator == 0 then
                self.config.denominator = 1
            end
        end
    end
}

SMODS.Atlas{
    key = "chachisello5",
    path = "Chachisello5.png",
    px = 71,
    py = 95
}

local chachisello5 = SMODS.Seal{
    key = "chachisello5",
    loc_txt = {
        name = "Chachisello 5",
        label = "Chachisello 5",
        text = {
            "{C:green}1 de #1#{} de generar un joker {C:legendary}legendario{}",
            "al jugar la carta,",
            "la probabilidad {C:green}sube{}",
            "si el joker se genera",
            "satisfactoriamente."
        }
    },
    atlas = "chachisello5",
    pos = {x = 0, y = 0},
    badge_colour = HEX("2F0146"),
    config = { denominator = 30 },
    loc_vars = function(self,info_queue)
        return {vars = {self.config.denominator}}
    end,
    calculate = function(self,card,context)
        if context.cardarea == G.play and context.main_scoring then
            local roll = math.floor(pseudorandom("chachisello4", 1) * self.config.denominator)
            if roll == 0 and #G.jokers.cards < G.jokers.config.card_limit then
                local new_joker = create_card('Joker', G.jokers, true, nil, nil, nil, nil, 'car')
                new_joker:add_to_deck()
                G.jokers:emplace(new_joker)
                new_joker:start_materialize()
                G.GAME.joker_buffer = 0
                self.config.denominator = self.config.denominator - 1
                return {
                    message = "CHACHI"
                }
            end
            if self.config.denominator == 0 then
                self.config.denominator = 1
            end
        end
    end
}

-- sticker

SMODS.Atlas{
    key = "soundgoodizer",
    path = "soundgoodizdr.png",
    px = 71,
    py = 95
}
local soundgoodizer = SMODS.Sticker{
    key = "soundgoodizer",
    loc_txt = {
        name = "Soundgoodizer",
        label = "Soundgoodizer",
        text = {
            "Las cartas con este sticker,",
            "no se pueden rerollear"
        }
    },
    atlas = "soundgoodizer",
    pos = {x = 0, y = 0},
    badge_colour = HEX("424242"),
}


-- JOKERS Y POPO SUIT 
-- JOKERS Y POPO SUIT 
-- JOKERS Y POPO SUIT 
-- JOKERS Y POPO SUIT 
-- JOKERS Y POPO SUIT 
-- JOKERS Y POPO SUIT 
-- JOKERS Y POPO SUIT 
-- JOKERS Y POPO SUIT 



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
    key = "popoui",
    path = "ui_assets.png",
    px = 18,
    py = 18
}

SMODS.Atlas{
    key = "hc_popoui",
    path = "ui_assets_opt2.png",
    px = 18,
    py = 18
}

SMODS.Atlas{
    key = "Jokers",
    path = "QuantumJokerPrototipo.png",
    px = 71,
    py = 95
}

local poposuit = SMODS.Suit{
    key = "pooposuit",
    card_key = "popo",
    pos = {y = 0},
    ui_pos = {x = 0, y = 0},
    loc_txt = {
        singular = "Popos",
        plural = "Popo"
    },
    lc_atlas = "popotestsuit",
    hc_atlas = "hc_popotestsuit"
}

SMODS.Joker{
    key = "quantumjoker",
    loc_txt = {
            name = "Quantum Joker",
            text = {
                "{X:mult,C:white}X#1#{} de Multi",
                "porque a valencia",
                "le flipan las de 12"
            },
    },
    rarity = 1,
    cost = 4,
    atlas = "Jokers",
    pos = {x = 0, y = 0},
    config = { extra = {
        Xmult = 1.234590967
    }
    },
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

SMODS.Atlas{
    key="faithful",
    path="sherriffpeanut.png",
    px = 71,
    py = 95
}

SMODS.Joker{
    key = "faithful",
    loc_txt = {
        name = "Faithful Sheriff",
        text = {
            "{X:mult,C:white}X#1#{} Mult",
            "por cada {C:attention}consumible{}",
            "usada en esta partida",
            "baja {X:red,C:white}X1{} Mult",
        }
    },
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
    loc_txt = {
        name = "Burnt Peanut",
        text = {
            "{X:mult,C:white}X#1#{} Mult",
            "Cada que compres un {C:attention}consumible{}",
            "existe una {C:attention}probabilidad{} de que",
            "el mult suba {X:red,C:white}X0.20{}",
            "dependiendo del {C:attention}consumible{}",
            "que uses."
        }
    },
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
                    play_sound(goop.key)
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
                    play_sound(goop1.key)
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
                    play_sound(goop2.key)
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
    loc_txt = {
        name = "Northern Sausage",
        text = {
            "Al usar {C:attention}cualquier consumible{}",
            "te otorga {X:mult,C:white}0.5X{} Mult.",
            "{C:inactive}Mult actual:{} {X:mult,C:white}X#1#{} {C:inactive}Mult{}"
        }
    },
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
    loc_txt = {
        name = "La Cuqui",
        text = {
            "Vende a este {C:attention}Joker",
            "para {E:2,X:dark_edition,C:white,s:1.2}Rerollear{}",
            "a los {C:attentionjokers{} que",
            "tengas {C:gold}en tu mazo"
        }
    },
    rarity = 3,
    cost = 10,
    atlas = "lacuqui",
    config = { extra = { rarity = 0, number = 1 }},
    loc_vars = function(self,info_queue,center)
        return {vars = {center.ability.extra.rarity, center.ability.extra.number}}
    end,
    pos = {x = 0, y = 0},
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
    loc_txt = {
        name = "Sebas el Gato",
        text = {
            "No hace nada de por si.",
            "Al obtener una {C:attention}copia de este joker{},",
            "este y la copia daran {C:chips}+#1#{} fichas.",
            "Cada copia otorgara {C:chips}+50{} fichas",
            "a la cantidad.",
            "Copias actuales: #2#"
        }
    },
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
    loc_txt = {
        name = "Enzo",
        text = {
            "+#1#{} de {C:attention}dinero{}",
            "por cada ciega",
            "{C:green}1 de 2{} de que la cantidad",
            "suba 1 unidad mas",
            "si no es asi, baja 1 unidad"
        }
    },
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
    loc_txt = {
        name = "Adif",
        text = {
            "{C:red}+#1#{} de mult",
            "por cada ciega",
            "{C:green}33%{} de que al tirar mano o descarte",
            "la cantidad de mult actual suba 5",
            "{C:red}33%{} de que al tirar mano o descarte",
            "la cantidad de mult actual baje 1",
            "{C:grey}34%{} de que no pase nada"
        }
    },
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
    loc_txt = {
        name = "Guitar",
        text = {
            "{X:red,C:white}X0.5{} Mult por cada",
            "carta que no este debajo del 5",
            "{X:red,C:white}X1.5{} Mult por cada",
            "carta que este debajo del 5"
        }
    },
    rarity = 2,
    cost = 5,
    atlas = "guitar",
    pos = {x = 0, y = 0},
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
    loc_txt = {
        name = "Pollos TicTac",
        text = {
            "Si compras una carta {C:tarot}Tarot{} o {C:planet}Planeta{}",
            "hay una probabilidad de {C:green}1 en 5{}",
            "que se genere una carta {C:spectral}Espectral{} {C:dark_edition}negativa{}",
            "junto al tarot comprado.",
            "Si compras una carta {C:spectral}Espectral{}",
            "{s:0.9,C:inactive}(solo posible en baraja espectral){}",
            "hay una probabilidad de {C:green}1 en 20{}",
            "que se genere una carta {C:legendary,s:1.2}Legendaria{}",
            "junto a la espectral comprada."
        }
    },

    rarity = 3,
    cost = 10,
    atlas = "pollostictac",
    pos = {x = 0, y = 0},
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
    loc_txt = {
        name = "Wally",
        text = {
            "{C:red}+5{} de Mult por cada",
            "carta {C:inactive}Popo{} usada"
        }
    },

    rarity = 1,
    cost = 3,
    atlas = "wally",
    pos = {x = 0, y = 0},
    calculate = function (self,card,context)
        if context.individual and context.cardarea == G.play then
            if context.other_card:is_suit(poposuit.key) then
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
    loc_txt = {
        name = "Gus",
        text = {
            "{C:green}1 de 2{} posibilidades de que",
            "te otorgue {C:money}+2${} por cada",
            "carta {C:inactive}Popo{} usada"
        }
    },

    rarity = 2,
    cost = 6,
    atlas = "gus",
    pos = {x = 0, y = 0},
    calculate = function (self,card,context)
        if context.individual and context.cardarea == G.play then
            local roll = math.floor(pseudorandom("popo") * 2)
            if context.other_card:is_suit(poposuit.key) then
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
    loc_txt = {
        name = "YAY-OK",
        text = {
            "{C:chips}+25{} fichas cuando",
            "Se juega una carta {C:inactive}Popo{}"
        }
    },

    rarity = 1,
    cost = 3,
    atlas = "yayok",
    pos = {x = 0, y = 0},
    calculate = function (self,card,context)
        if context.individual and context.cardarea == G.play then
            if context.other_card:is_suit(poposuit.key) then
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
    loc_txt = {
        name = "Watersports T4T Scat Eyacula Cristales Dylan X Callum",
        text = {
            "Al jugarse una carta {C:black}Popo{}, otorga:",
            "{C:money}#1#${} dolar,",
            "{C:chips}#2#{} chips",
            "{C:mult}#3#{} mult o",
            "{X:mult,C:white}X#4#{} mult"
        }
    },
    rarity = 3,
    cost = 10,
    atlas = "cristal",
    pos = {x = 0, y = 0},
    config = { extra = {dollars = 1, chips = 50, mult = 8, Xmult = 1.5}},
    loc_vars = function (self, info_queue, center)
        return {vars = {center.ability.extra.dollars, center.ability.extra.chips, center.ability.extra.mult, center.ability.extra.Xmult}}
    end,
    calculate = function(self,card,context)
        if context.individual and context.cardarea == G.play then
            if context.other_card:is_suit(poposuit.key) then
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
    loc_txt = {
        name = "Masturbador",
        text = {
            "Si terminas la ronda,",
            "en {C:attention}una sola mano{},",
            "te otorga {C:attention}7 de dinero{}"
        }
    },

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
    loc_txt = {
        name = "Nametag",
        text = {
            "Si tu {C:attention}numero de manos{} es",
            "mayor que el de tu {C:attention}numero de descartes{},",
            "te otorgara {C:blue}+150 fichas{}.",
            "Si tu {C:attention}numero de descartes{} es",
            "mayor que el de tu {C:attention}numero de manos{},",
            "te otorgara {C:red}+15{} de Mult",
            "Si ambos numeros son iguales,",
            "te otorgara {X:red,C:white}X4{} de Mult"
        }
    },

    rarity = 2,
    cost = 6,
    atlas = "nametag",
    pos = {x = 0, y = 0},
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




-- DYLAN PALOMO

SMODS.Atlas{
    key = "dylanpalomo",
    path = "DylanPalomo.png",
    px = 71,
    py = 95
}

SMODS.Joker{
    key = "dylanpalomo",
    loc_txt = {
        name = "Dylan Palomo",
        text = {
            "Al selecionarse la {C:attention}ciega{}",
            "te otorga el {C:attention}25%{} de",
            "las fichas necesarias para pasar de nivel,",
            "redondeando {C:attention}hacia abajo{}"
        }
    },

    rarity = 3,
    cost = 9,
    atlas = "dylanpalomo",
    pos = {x = 0, y = 0},
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
    loc_txt = {
        name = "Abuela yoyo",
        text = {
            "{C:red}+#1#{} de Mult",
            "Baja {C:red}-5{} de Mult",
            "cuando se añade una {C:attention}carta{}",
            "a tu baraja"
        }
    },

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
    loc_txt = {
        name = "Adrian La Torre",
        text = {
            "Te da un {X:mult,C:white}X#1#{} base.",
            "Por cada vez que el {C:money}dinero{} se altere",
            "el mult sube un {X:mult,C:white}X0.1{}",
            "al final de la ciega."
        }
    },

    rarity = 3,
    cost = 9,
    atlas = "adrianlatorre",
    pos = {x = 0, y = 0},
    config = { extra = {mult = 1,stacks = 0}},
    loc_vars = function(self, info_queue, center)
        return {vars = {center.ability.extra.mult, center.ability.extra.stacks}}
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
    loc_txt = {
        name = "Bart Derpresivo",
        text = {
            "Te otorga {X:red,C:white}X0.9{} Mult",
            "por cada joker que tengas en tu mazo,",
            "que no sea este {C:attention}mismo joker{}.",
            "Por cada {C:attention}joker{} que tengas en {C:attention}tu mazo{},",
            "te dara {X:mult,C:white}X1{}de Mult.",
            "{C:inactive}Mult actual:{}{X:mult,C:white}X#1#{}"
        }
    },

    rarity = 2,
    cost = 5,
    atlas = "bart",
    pos = {x = 0, y = 0},
    config = { extra = {jokernumber = 1, Xmult = 1}},
    loc_vars = function (self, info_queue, center)
        vars = {center.ability.extra.Xmult}
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
    loc_txt = {
        name = "Bfdi Rule 34",
        text = {
            "Si no compras nada en la tienda",
            "te otorga {hacesX:red,C:white}X3{} de Mult.",
            "Se reinicia al pasar a la",
            "siguente tienda"
        }
    },

    rarity = 2,
    cost = 5,
    atlas = "bfdi",
    pos = {x = 0, y = 0},
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
    loc_txt = {
        name = "ChachiJoker",
        text = {
            "Al empezar una {C:attention}ronda{},",
            "otorga una {C:carta jugable con",
            "cualquier tipo de chachisello."
        }
    },

    rarity = 2,
    cost = 6,
    atlas = "chachipoints",
    pos = {x = 0, y = 0},
    calculate = function (self, card, context)
        if context.setting_blind then
            G.E_MANAGER:add_event(Event({
                    func = function() 
                        local _card = create_playing_card({
                            front = pseudorandom_element(G.P_CARDS, pseudoseed('chachijoker')), 
                            center = G.P_CENTERS.c_base},G.hand, nil, nil, {G.C.SECONDARY_SET.Enhanced})
                        local seal_type = pseudorandom("chachisellos")
                        if seal_type > 0.5 then _card:set_seal(chachisello2.key, true)
                        elseif seal_type > 0.25 then _card:set_seal(chachisello3.key, true)
                        elseif seal_type > 0.125 then _card:set_seal(chachisello4.key, true)
                        else _card:set_seal(chachisello5.key, true)
                        end
                        G.GAME.blind:debuff_card(_card)
                        G.hand:sort()
                        if context.blueprint_card then context.blueprint_card:juice_up() else card:juice_up() end
                        card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "hola popa", colour = G.C.RED})
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
    loc_txt = {
        name = "Franex",
        text = {
            "Al venderse, este joker",
            "destruye a todos los comodines en tu mazo",
            "y te da {C:attention}3 comodines de rareza mayor{} dependiendo de,",
            "cuantos comodines hayas destruido.",
            "{s:0.6}si destruiste 1 comodin, te dara 1 comodin comun{}",
            "{s:0.6}si destruiste 2 comodines, te dara 1 comodin inusual{}",
            "{s:0.6}si destruiste 3 comodines, te dara 1 comodin raro{}",
            "{s:0.6}si destruiste 4 comodines, te dara 1 comodin legendario{}",
            "{s:0.6}pero dejandote el dinero a 0{}",
            "Hay un {C:attention}20%{} de que,",
            "al destruir los comodines, este joker",
            "se regenere a si mismo.",
            "Si se tiene mas de 5 comodines en el mazo,",
            "Franex al venderse se autodestruye",
            "sin darte ningun comodin a cambio.",
            "{s:2,C:red}hola franex{}"
        }
    },

    rarity = 3,
    cost = 10,
    atlas = "franex",
    pos = {x = 0, y = 0},
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

--latin teacher

SMODS.Atlas{
    key = "latin",
    path = "LatinTeacher.png",
    px = 71,
    py = 95
}

SMODS.Joker{
    key = "latin",
    loc_txt = {
        name = "Latin Teacher",
        text = {
            "{C:green}1 de 3{} de posibilidades",
            "de generarte un {C:attention}consumible negativo{}",
            "al salir de la tienda",
            "Si no, te quita {C:attention}1 dolar{}"
        }
    },

    rarity = 3,
    cost = 10,
    atlas = "latin",
    pos = {x = 0, y = 0},
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
    loc_txt = {
        name = "Tomoko",
        text = {
            "{C:attention}Larpea{} (copia) a cualquier",
            "comodin en tu mazo.",
            "Si es en la tienda, al finalizarla",
            "tienes un {C:attention}50%{} de que se añada a tu mazo",
            "y un {C:attention}50%{} de tomoko que se destruya",
            "quitandote 10 de dinero"
        }
    },
    rarity = 3,
    cost = 10,
    atlas = "tomoko",
    pos = {x = 0, y = 0},
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

SMODS.Atlas{
    key = "tungsahur",
    path = "TungSahur.png",
    px = 71,
    py = 95
}

SMODS.Joker{
    key = "tungsahur",
    loc_txt = {
        name = "Tung Tung Tung Sahur",
        text = {
            "Al seleccionar la ciega",
            "hay 1 de 4 posibilidades",
            "de que pase algo con el poder de",
            "{s:2,C:red}sahur.{}"
        }
    },

    rarity = 4,
    cost = 20,
    atlas = "tungsahur",
    pos = {x = 0, y = 0},
    soul_pos = {x = 1, y = 0},
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
    loc_txt = {
        name = "San Cristobal",
        text = {
            "Al seleccionar la ciega, te roban la {C:attention}mitad{}",
            "de tu dinero redondeado {C:red}hacia abajo.{}",
            "Cada vez que compras un {C:attention}comodin comun{}",
            "hay un {C:attention}75%{} de que el comodin",
            "se {C:attention}autodestruya{} y, a cambio",
            "te de un comodin de {C:attention}rareza mayor.{}",
            "Si compras un {C:attention}comodin inusual{},",
            "Hay un {C:attention}75%{} de que se {C:attention}autodestruya{} y",
            "te de un comodin de {C:attention}rareza mayor.{}",
            "{s:2,C:red}NO PISEIS SANCRIS{}"
        }
    },

    rarity = 4,
    cost = 20,
    atlas = "sancristobal",
    pos = {x = 0, y = 0},
    soul_pos = {x = 1, y = 0},
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
    loc_txt = {
        name = "Getafe Grim Reaper",
        text = {
            "{X:mult,C:white}X#1#{} de Mult base.",
            "Si se hacen todas las {C:attention}rondas{}",
            "de un ante en una {C:attention}sola mano{},",
            "el {C:attention}multiplicador asciende a",
            "5, y te da un joker",
            "{C:attention}raro{} negativo",
            "{s:2,C:red}QUE TE METO JERMA"
        }
    },

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
    loc_txt = {
        name = "Mikecrack",
        text = {
            "Al terminar la {C:attention}ronda{},",
            "te otorga #1# {C:edition}Vouchers{} en la tienda,",
            "y te otorga {C:money}#4#${} al terminar la ronda.",
            "Ambas cantidades van {C:attention}aumentando,",
            "por cada {C:enhanced}ante que te pases",
            "ganando cada ronda con {C:rare}una sola mano.{}",
            "{s:1.5,E:1,X:dark_edition,C:white}CUANDO{} {s:2,E:1,X:dark_edition,C:white}NO{} {s:2,E:1,X:dark_edition,C:white}TE{} {s:2,E:1,X:dark_edition,C:white}DEJAN{},",
            "{s:1.5,E:1,X:dark_edition,C:white}NALGUEAR{} {s:2,E:1,X:dark_edition,C:white}POLLOS{} {s:2,E:1,X:dark_edition,C:white}EN{} {s:2,E:1,X:dark_edition,C:white}LA{} {s:2,E:1,X:dark_edition,C:white}TIENDA...{}"
        }
    },

    rarity = 4,
    cost = 20,
    atlas = "mikecrack",
    pos = {x = 0, y = 0},
    soul_pos = {x = 1, y = 0},
    config = { extra = {number = 1, doneinone = true, blinds = 0, money = 1, hands = 0}},
    loc_vars = function(self,info_queue,center)
        return {vars = {center.ability.extra.number, center.ability.extra.doneinone, center.ability.extra.blinds, center.ability.extra.money, center.ability.extra.hands}}
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
    loc_txt = {
        name = "Usera",
        text = {
            "Añade al {X:red,C:white}XMult{}",
            "el numero de {C:attention}los habitantes{}",
            "{C:attention}dignos y respetados{} de la nación que hay en",
            "{s:3,E:1,X:edition,C:white}USERA.{}",
            "{s:0.5,C:inactive}vaya puta mierda de barrio{}"
        }
    },

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
    loc_txt = {
        name = "Bbno$",
        text = {
            "Otorga {X:purple,C:white,E:2,s:2}^#2#{} Mult,",
            "sube un {X:purple,C:white,E:2,s:2}^1{} Mult por cada",
            "joker en tu baraja.",
            "A cambio, hay una probabilidad de {C:green}1 entre 1000{} de",
            "{C:red}perder el juego{} por cada {C:attention}segundo que pasa.{}",
            "#1#"
        }
    },
    config = {extra = {counter = 0, emult = 1}},
    loc_vars = function (self, info_queue, center)
        return {vars = {center.ability.extra.counter, center.ability.extra.emult}}
    end,
    update = function(self,card,dt)
        if G.STAGE == 2 and card.area == G.jokers then
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

--consumibles

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
            cardtoset:set_seal(chachisello2.key, false, false)
        elseif roll < 50 then
            if roll >= 25 then
                cardtoset:set_seal(chachisello3.key, false, false)
            elseif roll < 25 then
                if roll >= 10 then
                    cardtoset:set_seal(chachisello4.key, false, false)
                elseif roll < 10 then
                    cardtoset:set_seal(chachisello5.key, false, false)
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
        cardtoset:add_sticker(soundgoodizer.key, true)
    end
}

-- decks

SMODS.Atlas{
    key = "bbtrikz",
    path = "BbtrickDeck.png",
    px = 71,
    py = 95
}

SMODS.Back{
    key = "bbtrikz",
    loc_txt = {
        name = "Deck de Bbtrickz",
        text = {
            "Empiezas solo",
            "con cartas de",
            "{C:attention}Popo{}"
        }
    },
    atlas = "bbtrikz",
    pos = { x = 0, y = 0 },
    apply = function(self,back)
        G.E_MANAGER:add_event(Event({
            func = function()
                for k, v in pairs(G.playing_cards) do
                    if v.base.suit == 'Clubs' then 
                        v:change_suit(poposuit.key)
                    end
                    if v.base.suit == 'Diamonds' then 
                        v:change_suit(poposuit.key)
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
    loc_txt = {
        name = "Deck de Spicy cheebohs",
        text = {
            "Solo puedes jugar con {C:red}1 mano.{}",
            "Todas tus {C:attention}cartas{} tienen",
            "{C:red}sello rojo{}"
        }
    },
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
    loc_txt = {
        name = "Deck Camarada",
        text = {
            "Al entrar a una ciega,",
            "no podras ver tus jokers.",
            "se barajan por cada mano que saques."
        }
    },
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

-- boss blinds

SMODS.Atlas { key = "tino", path = 'Tino.png', px = 34, py = 34, frames = 21, atlas_table = 'ANIMATION_ATLAS' }

local tino = SMODS.Blind{
    key = "tino",
    loc_txt = {
        name = "El Tino",
        text = {
            "Destruye 25 cartas de tu mazo,",
            "Y crea 25 cartas con sello de bomba.",
            "Si se juega una carta con sello de bomba,",
            "Tus fichas actuales se restaran por 25000.",
            "No puedes ver las cartas con",
            "sello de bomba."
        }
    },
    atlas = 'tino',
    pos = { x = 0, y = 0 },
    boss = { showdown = true },
    boss_colour = G.C.RED
}

SMODS.Atlas { key = "eta", path = 'ETA.png', px = 34, py = 34, frames = 21, atlas_table = 'ANIMATION_ATLAS' }

local eta = SMODS.Blind{
    key = "eta",
    loc_txt = {
        name = "ETA",
        text = {
            "placeholder"
        }
    },
    atlas = 'eta',
    pos = { x = 0, y = 0 },
    boss = { showdown = true },
    boss_colour = G.C.RED
}

SMODS.Atlas { key = "pollon", path = 'pollon.png', px = 34, py = 34, frames = 21, atlas_table = 'ANIMATION_ATLAS' }

local pollon = SMODS.Blind{
    key = "pollon",
    loc_txt = {
        name = "Pollon",
        text = {
            "placeholder"
        }
    },
    atlas = 'pollon',
    pos = { x = 0, y = 0 },
    boss = { showdown = true },
    boss_colour = G.C.RED
}