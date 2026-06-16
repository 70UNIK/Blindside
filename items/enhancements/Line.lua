    BLINDSIDE.Blind({
        key = 'line',
        atlas = 'bld_blindrank',
        pos = {x = 6, y = 6}, -- replace with actual sprite
        config = {
            extra = {
                xmult = 1,
                xmult_gain = 0.25,
                xmult_gainup = 0.25,
                value = 11,
            }},
        hues = {"Purple"},
        rare = true,
        calculate = function(self, card, context)
            if context.modify_hand and context.scoring_hand and not context.blueprint then
                local i_scored = false
                for key, value in pairs(context.scoring_hand) do
                    if value == card then
                        i_scored = true
                    end
                end

                if not i_scored then
                    return
                end

                if G.GAME.current_round.discards_left > 0  then
                    SMODS.scale_card(card, {
                                ref_table =card.ability.extra,
                                ref_value = "xmult",
                                scalar_value = "custom_scaler",
                                scalar_table = {
                                    custom_scaler = G.GAME.current_round.discards_left * card.ability.extra.xmult_gain,
                                },
                                message_key = "a_xmult",
                                message_colour = G.C.MULT,
                            })
                            --ease_discard(-G.GAME.current_round.discards_left)
                    return {
                        message = localize('k_upgrade_ex'),
                        func = function ()
                            ease_discard(-G.GAME.current_round.discards_left)
                        
                        end
                    }
                end
            end

            if context.main_scoring and context.cardarea == G.play and card.ability.extra.xmult > 1 then
                return {
                    xmult = card.ability.extra.xmult
                }
            end
        end,
        loc_vars = function(self, info_queue, card)
            return {
                vars = {
                    card.ability.extra.xmult,
                    card.ability.extra.xmult_gain
                }
            }
        end,
        upgrade = function(card) 
            if not card.ability.extra.upgraded then
            card.ability.extra.xmult_gain = card.ability.extra.xmult_gain + card.ability.extra.xmult_gainup
            card.ability.extra.upgraded = true
            end
        end
    })
----------------------------------------------
------------MOD CODE END----------------------
