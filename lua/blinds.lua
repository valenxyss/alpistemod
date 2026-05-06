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