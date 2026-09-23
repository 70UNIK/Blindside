
    SMODS.Joker({
        key = 'canvas',
        atlas = 'bld_trinkets',
        pos = {x = 2, y = 0},
        rarity = 'bld_trinket',
        config = {
            extra = {
                mult_mod = 8
            }
        },
        cost = 7,
        blueprint_compat = false,
        eternal_compat = true,
        loc_vars = function (self, info_queue, card)
            info_queue[#info_queue + 1] = G.P_SEALS["bld_wild"]
        end,
        credit = {
            art = "AstraLuna",
            code = "AstraLuna",
            concept = "AstraLuna"
        },
        in_pool = function(self, args)
            if G.GAME.selected_back.effect.center.config.extra then
                if not G.GAME.selected_back.effect.center.config.extra.blindside then return false end
                return true
            else
            return false
            end
        end,
    })
function BLINDSIDE.has_canvas(context)
    if context and context.scoring_hand and #context.scoring_hand > 0 then
        for i = 1, #context.scoring_hand do
            if (context.scoring_hand[i].seal == "bld_wild" or #context.scoring_hand[i].ability.extra.hues >= 2) and context.scoring_hand[i].facing ~= "back" and next(SMODS.find_card('j_bld_canvas')) then
                return true
            end
        end
        
    end
    return false
end
function BLINDSIDE.mod_canvas_val(old,new,context)
    if BLINDSIDE.has_canvas(context) then
        return new
    end
    return old
end