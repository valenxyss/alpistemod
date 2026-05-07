SMODS.Atlas { key = "tino", path = 'Tino.png', px = 34, py = 34, frames = 21, atlas_table = 'ANIMATION_ATLAS' }
SMODS.Blind{
    key = "tino",
    loc_txt = {
        name = "El Tino",
        text = {
            "Destruye 25 cartas de tu mazo,",
            "Y crea 25 cartas con sello de bomba.",
            "Si se juega una carta con sello de bomba,",
            "las chips se restaran -25000",
            "No puedes ver las cartas."
        }
    },
    atlas = 'tino',
    pos = { x = 0, y = 0 },
    boss = { showdown = true },
    boss_colour = G.C.RED,
    set_blind = function (self)
        G.eltino = true
        for _,cards in ipairs(G.deck.cards) do
            local roll = pseudorandom("eltino", 1, 4)
            if roll == 1 then
                cards:set_seal("prb_bomba", true)
            end
        end
    end,
    calculate = function (self, card, context)
        if context.individual and context.cardarea == G.play then
            if context.other_card.seal == "prb_bomba" then
                return {
                colour = G.C.GREEN,
                func = function()
                    G.E_MANAGER:add_event(Event({
                        trigger = "ease",
                        delay = 5,
                        ref_table = G.GAME,
                        ref_value = "chips",
                        ease_to = G.GAME.chips - 25000,
                    }))
                end
            }
            end
        end
    end
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