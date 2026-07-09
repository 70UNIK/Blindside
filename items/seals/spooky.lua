SMODS.Seal {
    key = "spooky",
    atlas = 'bld_enhance', 
    pos = { x = 1, y = 0 },
    config = { 
        extra = { 
            chipsreduc = 0.02,
            xchips = 0.98,
        } 
    },
    badge_colour = HEX('757CDC'),
    in_pool = function(self, args)
        if G.GAME.selected_back.effect.center.config.extra then
            if not G.GAME.selected_back.effect.center.config.extra.blindside then return false end
            return true
        else
        return false
        end
    end,
    pools = {
        ["bld_obj_enhancements"] = true,
    },
    calculate = function(self, card, context)
        if context.main_scoring and context.cardarea == G.play and card.facing ~= 'back' then
            local sharing = {}
            for key, value in pairs(context.scoring_hand) do
                local shares = false
                for key, color in pairs(value.ability.extra.hues) do
                    if tableContains(color, card.ability.extra.hues) then
                        shares = true
                        break
                    end
                end

                if shares then
                    table.insert(sharing, value)
                end
            end
            local p = (card.ability.seal.extra.chipsreduc*#sharing*(1))
            --one major problem is due to the chip buffer, it can set chips to 1. By doing this, it doesnt do that, albeit reducing its effectivnesss. I believe that it should still be like that
           -- local chipsReduc = -(G.GAME.blind.basechips)*p -- #SMODS.find_card("j_bld_pumpkin")
            local chipsReduc = 1 - p
            --G.GAME.chips_buffer = G.GAME.chips_buffer + chipsReduc
            return {
                extra = {focus = card, message = "X" .. chipsReduc .. localize("bld_jchips"),
                colour = G.C.BLACK,},
                colour = G.C.BLACK,
                func = function()
                    BLINDSIDE.chipsmodifyV2({x_chips = chipsReduc})
                    --BLINDSIDE.chipsmodify(0, chipsReduc, 0, 0, true)
                end,
                card = card
            }
        end
    end,
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.seal.extra.xchips,card.ability.seal.extra.chipsreduc
            }
        }
    end
}