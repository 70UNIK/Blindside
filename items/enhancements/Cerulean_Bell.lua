    BLINDSIDE.Blind({
        key = 'cerulean_bell',
        atlas = 'bld_blindrank',
        pos = {x = 3, y = 12},
        config = {
            extra = {
                value = 1,
                chips = 1000,
                chipsup = 1000,
                give = false,
            }
        },
        hues = {"Blue"},
        hidden = true,
        legendary = true,
        calculate = function(self, card, context)
            if context.cardarea == G.play and context.main_scoring then
                return {
                    chips = card.ability.extra.chips
                }
            end

            if tableContains(card, G.hand.cards) and not tableContains(card, G.hand.highlighted) and G.STATE ~= G.STATES.SMODS_BOOSTER_OPENED then
                card.ability.forced_selection = true
                G.hand:add_to_highlighted(card, true)
            end

            if context.after then
                card.ability.forced_selection = false
            end
            --besides, you're already forced to select it so its fine to implement as such
             if tableContains(card, G.hand.highlighted) and not card.ability.extra.added_selection_limit and G.STATE ~= G.STATES.SMODS_BOOSTER_OPENED then
                G.E_MANAGER:add_event(Event({
                        trigger = 'before',
                        func = function()
                            
                            if not  card.ability.extra.added_selection_limit then
                                card.ability.extra.added_selection_limit = true
                                print("add")
                                SMODS.change_play_limit(1)
                                SMODS.change_discard_limit(1)
                            end
                            
                            return true
                        end
                    }))
                
                
            end
            if not tableContains(card, G.hand.highlighted) and card.ability.extra.added_selection_limit and G.STATE ~= G.STATES.SMODS_BOOSTER_OPENED then
                

                G.E_MANAGER:add_event(Event({
                    trigger = 'before',
                    func = function()
                        
                        if card.ability.extra.added_selection_limit then
                            card.ability.extra.added_selection_limit = nil
                            print("remove")
                            SMODS.change_play_limit(-1)
                            SMODS.change_discard_limit(-1)
                        end
                        
                        return true
                    end
                }))
            end
        end,
        loc_vars = function(self, info_queue, card)
            return {
                vars = {
                    card.ability.extra.chips
                }
            }
        end,
        -- highlight = function(self, card, is_highlighted)
        --     if is_highlighted and not card.ability.extra.give then
        --         print(is_highlighted)
        --         card.ability.extra.give = true
        --         SMODS.change_play_limit(1)
        --         SMODS.change_discard_limit(1)
        --     else
        --         if card.ability.extra.give then
        --             print(is_highlighted)
        --             card.ability.extra.give = false
        --             SMODS.change_play_limit(-1)
        --             SMODS.change_discard_limit(-1)
        --         end
        --     end
        -- end,
        upgrade = function(card) 
            if not card.ability.extra.upgraded then
            card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chipsup
            card.ability.extra.upgraded = true
            end
        end
    })
----------------------------------------------
------------MOD CODE END----------------------
-----duplicating the bell
local add_to_deck_hook = Card.add_to_deck
function Card:add_to_deck(from_debuff)
    if self.ability and self.ability.extra and type(self.ability.extra) == 'table' and self.ability.extra.added_selection_limit then
        self.ability.extra.added_selection_limit = nil
        print("niller")
    end
    add_to_deck_hook(self,from_debuff)
    
end