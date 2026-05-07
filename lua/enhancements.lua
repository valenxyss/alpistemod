SMODS.Atlas{
    key = "cartameneillo",
    path = "MeneilloCarta.png",
    px = 71,
    py = 95
}
SMODS.Enhancement{
    key = "cartameneillo",
    loc_txt = {
        name = "Carta Meneillo",
        text = {
            "{C:green}51%{} de que te de {C:money}#1#${}.",
            "{C:green}25%{} de dar {X:mult,C:white}X#2#{} Mult",
            "{C:green}15%{} de dar una {C:attention,E:1}skip tag.{}",
        }
    },
    atlas = "cartameneillo",
    pos = {x=0, y=0},
    replace_base_card = true,
    no_rank = true,
    no_suit = true,
    always_scores = true,
    config = { extra = {
        money = 3,
        Xmult = 2,
    }},
    loc_vars = function (self, info_queue, card)
        return {vars = {card.ability.extra.money, card.ability.extra.Xmult}}
    end,
    calculate = function (self, card, context)
        if context.main_scoring and context.cardarea == G.play then
            local roll = math.floor(pseudorandom("cartameneillo1", 1, 100))
            local returntable = {}
            if roll >= 50 then
                returntable = {
                    dollars = card.ability.extra.money,
                    card = card,
                    message = "QUE PASA CARACARTUNER"
                }
            elseif roll >= 25 then
                returntable = {
                    Xmult = card.ability.extra.Xmult,
                    card = card,
                    message = "POTINGUE CHALLENGE"
                }
            elseif roll >= 10 then
                returntable = {
                    card = card,
                    message = "HAZ EL MENEILLO",
                    func = function (self, card)
                        local tags = {
                        "tag_uncommon",
                        "tag_rare",
                        "tag_negative",
                        "tag_foil",
                        "tag_holo",
                        "tag_polychrome",
                        "tag_investment",
                        "tag_voucher",
                        "tag_boss",
                        "tag_standard",
                        "tag_charm",
                        "tag_meteor",
                        "tag_buffoon",
                        "tag_handy",
                        "tag_garbage",
                        "tag_ethereal",
                        "tag_coupon",
                        "tag_double",
                        "tag_juggle",
                        "tag_d_six",
                        "tag_top_up",
                        "tag_orbital",
                        "tag_economy",
                        "tag_skip"
                        }
                        local tagroll = pseudorandom("meneillotag", 1, #tags)
                        add_tag({ key = tags[tagroll] })
                    end
                }
            end
            return returntable
        end
    end
}