SMODS.Atlas{
    key = "chachisello1",
    path = "Chachisello1.png",
    px = 71,
    py = 95
}
 SMODS.Seal{
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
SMODS.Seal{
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
SMODS.Seal{
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

 SMODS.Seal{
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

SMODS.Seal{
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
--sello bomba
G.eltino = false
SMODS.Atlas{
    key = "bomba",
    path = "SelloBomba.png",
    px = 71,
    py = 95
}
SMODS.Seal{
    key = "bomba",
    loc_txt = {
        name = "Sello Bomba",
        label = "Sello Bomba",
        text = {
            "{X:mult,C:white}X0{} de Mult",
            "La {C:attention}carta{} se destruye al jugarse"
        }
    },
    atlas = "bomba",
    pos = {x = 0, y = 0},
    badge_colour = HEX("2A2A2A"),
    calculate = function (self, card, context)
        if not G.eltino then
            self.pos = {x = 0, y = 1}
        end
        if context.cardarea == G.play and context.main_scoring then
            card:start_dissolve()
            return {card = card, Xmult = 0, message = "YA NO ESTOY"}
        end

    end
}