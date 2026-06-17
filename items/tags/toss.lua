SMODS.Tag {
    key = "toss",
    hide_ability = false,
    config = {
        extra = {
            give = true
        }
    },
    atlas = 'bld_tag',
    pos = {x = 0, y = 1},
        in_pool = function(self, args)
            if G.GAME.selected_back.effect.center.config.extra then
                if not G.GAME.selected_back.effect.center.config.extra.blindside then return false end
                return true
            else
            return false
            end
        end,
    apply = function(self, tag, context)
        if context.type == 'self_tag_added' then
            G.hand:change_size(1)
            --print("+1 Handsize")
        end
        if context.type == 'self_tag_removed' then
             G.hand:change_size(-1)
        end
        if context.type == 'shop_start' and not BLINDSIDE.taglock_active() then
            --print("-1 Handsize")
            G.hand:change_size(-1)
            tag:yep('+', G.C.GREEN, function() 
                return true end)
            tag.triggered = true
        end
    end,
}