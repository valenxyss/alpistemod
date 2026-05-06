SMODS.PokerHand{
    key = "pedrada",
    mult = 15,
    chips = 50,
    l_mult = 5,
    l_chips = 50,
    example = {
        {"K_S", true, enhancement = "m_stone"},
        {"K_S", true, enhancement = "m_stone"},
        {"K_S", true, enhancement = "m_stone"},
        {"K_S", true, enhancement = "m_stone"},
        {"K_S", true, enhancement = "m_stone"},
    },
    evaluate = function (parts, hand)
        local has_yaoi = #SMODS.find_card("j_prb_yaoi") > 0
        if #hand == 5 and has_yaoi then
            local all_stone = true
            for _, card in ipairs(hand) do
                if not SMODS.has_enhancement(card, 'm_stone') then
                    all_stone = false
                    break
                end
            end
            if all_stone then
                return { hand }
            end
        end
        return {}
    end,
    loc_txt = {
        name = "Pedrada",
        description = {
            "Se necesitan 5 cartas de piedra.",
            "Solo se puede jugar con el joker {C:attention}Yaoi{}"
        }
    }
}