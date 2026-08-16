BLINDSIDE.Blind({
    key = 'tablet',
    atlas = 'bld_blindrank',
    pos = {x = 3, y = 7},
    config = {
        extra = {
            chips = 50,
            value = 4,
            retain = true,
            chips_up = 50,
        }},
    hues = {"Faded"},
    replace_base_card = true,
    no_rank = true,
    no_suit = true,
    hidden = true,
    always_scores = true,
    overrides_base_rank = true,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {key = 'bld_retain', set = "Other"}
        return {
            vars = {
                card.ability.extra.chips
            }
        }
    end,
    in_pool = function(self, args)
        return false
    end,
    calculate = function(self, card, context)
        if context.main_scoring and context.cardarea == G.play then
            return {
                chips = card.ability.extra.chips
            }
        end         
        if context.end_of_round then
            card:start_dissolve()
        end   
    end,
    upgrade = function(card) 
        if not card.ability.extra.upgraded then
            card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chips_up
            card.ability.extra.upgraded = true
        end
    end,
    
})
    
----------------------------------------------
------------MOD CODE END----------------------
