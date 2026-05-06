SMODS.current_mod.menu_cards = function()
    return { -- This takes any SMODS.create_card parameters
        key = "c_prb_alpiste",
        remove_original = true -- This removes the vanilla Ace
    }
end

local game_main_menu_ref = Game.main_menu
    function Game:main_menu(...)
        local ret = game_main_menu_ref(self, ...)

        G.SPLASH_BACK:define_draw_steps({
        {
            shader = "splash",
            send = {
                { name = "time",       ref_table = G.TIMERS, ref_value = "REAL_SHADER" },
                { name = "vort_speed", val = 1 },
                { name = "colour_1",   ref_table = G.C,  ref_value = "EDITION" },
                { name = "colour_2",   ref_table = G.C,  ref_value = "DARK_EDITION" },
            },
        },
    })

    return ret
end