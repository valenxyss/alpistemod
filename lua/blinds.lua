SMODS.Atlas { key = "tino", path = 'Tino.png', px = 34, py = 34, frames = 21, atlas_table = 'ANIMATION_ATLAS' }
G.bombaplayed = false
SMODS.Blind{
    key = "tino",
    atlas = 'tino',
    pos = { x = 0, y = 0 },
    boss = { showdown = true },
    boss_colour = G.C.RED,
    set_blind = function (self)
        G.eltino = true
        G.alreadyflipped = false
        for _,cards in ipairs(G.deck.cards) do
            local roll = pseudorandom("eltino", 1, 10)
            if roll == 1 then
                cards:set_seal("prb_bomba", true)
            end
        end
    end,
    calculate = function (self, blind, context)
        if not blind.disabled then
            if context.stay_flipped and context.to_area == G.hand and not G.alreadyflipped then
                return {stay_flipped = true}
            end
            if context.individual and context.cardarea == G.play then
                if context.other_card.seal == "prb_bomba" then
                    G.bombaplayed = true
                end
            end
            if context.after and G.bombaplayed then
                G.E_MANAGER:add_event(Event{
                    delay = 0.1,
                    func = function ()
                        SMODS.juice_up_blind()
                        ease_chips(G.GAME.chips - (G.GAME.chips / 3))
                        play_sound("tarot1")
                        return true
                    end
                })
                if not G.alreadyflipped then
                    delay(0.2)
                    G.E_MANAGER:add_event(Event{
                        delay = 0.1,
                        func = function ()
                            for i = 1, #G.hand.cards do
                                G.hand.cards[i]:flip()
                            end
                            play_sound('card1', percent)
                            G.alreadyflipped = true
                            return true
                        end})
                end
            end
        end
    end
}

SMODS.Atlas { key = "eta", path = 'ETA.png', px = 34, py = 34, frames = 21, atlas_table = 'ANIMATION_ATLAS' }
G.eta = false
SMODS.Blind{
    key = "eta",
    atlas = 'eta',
    pos = { x = 0, y = 0 },
    boss = { showdown = true },
    boss_colour = G.C.WHITE,
    set_blind = function (self)
        G.eta = true
        local etajoker = create_card("Joker", G.jokers, nil, nil, nil, nil, "j_prb_etajoker", "eta")
        etajoker:add_to_deck()
        G.jokers:emplace(etajoker)
        etajoker:start_materialize()
    end,
    defeat = function (self)
        G.eta = false
    end,
    calculate = function (self, blind, context)
        if blind.disabled then
            for _,cards in ipairs(G.jokers) do
                if cards == next(SMODS.find_card("j_prb_etajoker", true)) then
                    cards:start_dissolve()
                end
            end
        end
    end
}

SMODS.Atlas { key = "pollon", path = 'pollon.png', px = 34, py = 34, frames = 21, atlas_table = 'ANIMATION_ATLAS' }

SMODS.Blind{
    key = "pollon",
    loc_txt = {
        name = "Pollon",
        text = {
            "Divide el mult y fichas",
            "entre 5. Baja el divisor",
            "por cada mano sacada."
        }
    },
    atlas = 'pollon',
    pos = { x = 0, y = 0 },
    boss = { showdown = true },
    boss_colour = G.C.BLACK,
    config = {extra = {multmod = 0.2, chipsmod = 0.2}},
    loc_vars = function (self)
        return {vars = {self.config.multmod, self.config.chipsmod}}
    end,
    calculate = function(self, blind, context)
        if not blind.disabled then
            if context.modify_hand then
                blind.triggered = true 
                mult = mod_mult(math.max(math.floor(mult * self.config.extra.multmod + self.config.extra.multmod), 1))
                hand_chips = mod_chips(math.max(math.floor(hand_chips * self.config.extra.chipsmod + self.config.extra.chipsmod), 0))
                update_hand_text({ sound = 'chips2', modded = true }, { chips = hand_chips, mult = mult })
            end
            if context.after then
                self.config.extra.chipsmod = self.config.extra.chipsmod + 0.1
                self.config.extra.multmod = self.config.extra.multmod + 0.1
            end
        end
    end
}
SMODS.Atlas { key = "abunda", path = 'abundalacaca.png', px = 34, py = 34, frames = 21, atlas_table = 'ANIMATION_ATLAS' }
SMODS.Blind{
    key = "abundalacaca",
    loc_txt = {
        name = "Abunda La Caca",
        text = {
            "Se desabilitan",
            "cartas popo"
        }
    },
    atlas = 'pollon',
    pos = { x = 0, y = 0 },
    boss = { showdown = true },
    boss_colour = G.C.BLUE,
    debuff = {suit = "prb_pooposuit"}
}