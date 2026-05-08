SMODS.Atlas{
    key = "chachisello1",
    path = "Chachisello1.png",
    px = 71,
    py = 95
}
 SMODS.Seal{
    key = "chachisello1",
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
    atlas = "bomba",
    pos = {x = 0, y = 0},
    badge_colour = HEX("2A2A2A"),
    calculate = function (self, card, context)
        if context.main_scoring and context.cardarea == G.play then
            return {Xmult = 0, func = function ()
                card:start_dissolve()
            end}
        end
    end
}