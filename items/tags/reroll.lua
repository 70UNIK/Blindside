SMODS.Tag {
    key = "reroll",
    hide_ability = false,
    atlas = 'bld_tag',
    pos = {x = 2, y = 3},
        in_pool = function(self, args)
            if G.GAME.selected_back.effect.center.config.extra then
                if not G.GAME.selected_back.effect.center.config.extra.blindside then return false end
                return true
            else
            return false
            end
        end,
apply = function(self, tag, context)
        -- if context.type == 'shop_start'  then
        --     calculate_blindreroll_cost(true)
        -- end
        if context.type == 'after_reroll'  and not G.GAME.rerolled then
            --SMODS.change_free_rerolls(-1)
            --print("-1 Free rerolls")
            -- G.GAME.blindside_reroll_tags_consumed = G.GAME.blindside_reroll_tags_consumed or 0
            -- G.GAME.blindside_reroll_tags_consumed = G.GAME.blindside_reroll_tags_consumed + 1
            G.GAME.rerolled = true
            tag:yep('+', G.C.GREEN, function() 
                return true end)
            tag.triggered = true
        end
        if context.type == 'self_tag_removed' then
            G.GAME.blindside_reroll_tags_consumed = G.GAME.blindside_reroll_tags_consumed or 0
            G.GAME.blindside_reroll_tags_consumed = G.GAME.blindside_reroll_tags_consumed + 1
        end
        if context.type == 'self_tag_added' then
            SMODS.change_free_rerolls(1)
            --print("+1 Free rerolls")
        end
    end,
}