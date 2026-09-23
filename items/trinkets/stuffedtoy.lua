
    SMODS.Joker({
        key = 'stuffedtoy',
        atlas = 'bld_trinkets',
        pos = {x = 6, y = 2},
        rarity = 'bld_trinket',
        config = {
            extra = {
                --chipsreduc = 0.15,
                xchips = 0.85,
            }
        },
        cost = 8,
        blueprint_compat = true,
        eternal_compat = true,
        loc_vars = function (self, info_queue, card)
            return {
                vars = {
                card.ability.extra.xchips
            }
        }
        end,
        in_pool = function(self, args)
            if G.GAME.selected_back.effect.center.config.extra then
                if not G.GAME.selected_back.effect.center.config.extra.blindside then return false end
                return true
            else
            return false
            end
        end,
        credit = {
            art = "AstraLuna",
            code = "AstraLuna",
            concept = "AstraLuna"
        },
        calculate = function(self, card, context)
            if context.joker_main then
                if #context.full_hand <= 3 then
                   -- BLINDSIDE.chipsmodify(0, -((G.GAME.blind.basechips*(card.ability.extra.chipsreduc))), 0, 0, true)
                    BLINDSIDE.chipsmodifyV2({x_chips = card.ability.extra.xchips})
                     return {
                        message = "X" .. card.ability.extra.xchips .. localize("bld_jchips"),
                        colour = G.C.BLACK,
                        card = card
                      }   
                    -- return {
                    --     extra = {focus = card, message = localize{type='variable',key='a_pchips',vars={card.ability.extra.chipsreduc*100}}, 
                    --     colour = G.C.DARK_EDITION, func = function()
                    --         G.E_MANAGER:add_event(Event({
                    --             trigger = 'before',
                    --             delay = 0.3,
                    --             func = (function()
                    --                 return true
                    --             end)}))
                    --     end},
                    --     colour = G.C.DARK_EDITION,
                    --     card = card
                    -- }
                end
            end
        end
    })