    BLINDSIDE.Blind({
        key = 'blank',
        atlas = 'bld_blindrank',
        pos = {x = 0, y = 0},
        config = {
            rescore = 0,
            extra = {
                value = 1,
                rescore = 1,
                repetitions = 1,
                repetitions_up = 1,
            }},
        replace_base_card = true,
        no_rank = true,
        no_suit = true,
        hues = {"Faded"},
        basic = true,
        always_scores = true,
        overrides_base_rank = true,
        in_pool = function(self, args)
            if G.GAME.selected_back.effect.center.config.extra then
                if not G.GAME.selected_back.effect.center.config.extra.blindside then return false end
                return true
            else
            return false
            end
        end,
        calculate = function(self, card, context)
            -- if context.repetition and card.facing ~= 'back' and context.other_card.ability.extra.rescore ~= 1 then

            --     return {
            --         repetitions = card.ability.extra.retriggers
            --     }
            -- end
            if context.repetition and context.cardarea == G.play and card.area == G.play and context.other_card.ability.extra.rescore ~= 1 then
                print("checkadjacent")
                local self_pos = nil
                local areacards = context.scoring_hand or card.area.cards
                for i=1, #areacards do
                    if areacards[i] == card then
                        self_pos = i
                    end
                end
                if areacards[self_pos-1] == context.other_card then
                    return {
                        repetitions = card.ability.extra.repetitions
                    }
                end
                if areacards[self_pos+1] == context.other_card then
                    return {
                        repetitions = card.ability.extra.repetitions
                    }
                end
            end
            -- if context.cardarea == G.play and context.main_scoring and context.scoring_hand then
            --     return {
            --             func = function()
            --                 local self_pos = nil
            --                 local area = context.scoring_hand
            --                 local currCard = context.blueprint_card or card
            --                 if card.area ~= G.play then
            --                     area = card.area
            --                 end
            --                 local retrigger_cards = {}
            --                 for i=1, #area do
            --                     if area[i] == currCard  then
            --                         self_pos = i
            --                     end
            --                 end
            --                 if area[self_pos-1] then
            --                     table.insert(retrigger_cards, area[self_pos-1])
            --                 end
            --                 if area[self_pos+1] then
            --                     table.insert(retrigger_cards, area[self_pos+1])
            --                 end
            --                 for streak_index = 1, #retrigger_cards do
            --                     local streak_card = retrigger_cards[streak_index]
            --                     for _, play_card in ipairs(G.play.cards) do
            --                         if play_card == streak_card and streak_card.ability.extra.rescore ~= 1 then
            --                             card:juice_up()
            --                             local passed_context = context
            --                             card_eval_status_text(play_card, 'extra', nil, nil, nil, {message = localize('k_again_ex'),colour = G.C.DARK_EDITION})
            --                             BLINDSIDE.rescore_card(play_card, passed_context)
            --                             if card.ability.extra.upgraded then
            --                                 BLINDSIDE.rescore_card(play_card, passed_context)
            --                             end
            --                         end
            --                     end
            --                 end
            --                 SMODS.calculate_context({rescore_cards = retrigger_cards})
            --                 return true
            --             end,
            --         }
            -- end
        end,
        loc_vars = function(self, info_queue, card)
            return {
                key = card.ability.extra.upgraded and 'm_bld_blank_upgraded' or 'm_bld_blank',vars={card.ability.extra.repetitions}
            }
        end,
        upgrade = function(card) 
            if not card.ability.extra.upgraded then
            card.ability.extra.upgraded = true
            card.ability.extra.repetitions = card.ability.extra.repetitions + card.ability.extra.repetitions_up
            end
        end
    })
----------------------------------------------
------------MOD CODE END----------------------
