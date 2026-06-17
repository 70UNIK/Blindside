
    SMODS.Joker({
        key = 'marble',
        atlas = 'bld_trinkets',
        pos = {x = 0, y = 4},
        rarity = 'bld_trinket',
        config = {
            extra = {
                retriggers = 1,
            }
        },
        cost = 10,
        blueprint_compat = true,
        eternal_compat = true,
        loc_vars = function (self, info_queue, card)
            return {
                vars = {
                card.ability.extra.retriggers,
            }
        }
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
        calculate = function(self, card, context)
            if context.repetition and context.cardarea == G.play and context.other_card and 
            context.other_card.facing ~= "back" and context.other_card.ability.extra.rescore ~= 1 then
                if (#context.other_card.config.center.config.extra.hues > 1 or context.other_card.seal == "bld_wild")  then
                    return {
                        message = localize('k_again_ex'),
                        repetitions = card.ability.extra.retriggers,
                        card = card
                    }
                else
                    --in case someone does shennanigans like patches
                    local colours = {"Red","Yellow","Green","Blue","Purple","Faded"}
                    local hues = 0
                    for i = 1, #colours do
                        if context.other_card:is_color(colours[i],true,false) then
                            hues = hues + 1
                        end
                        if hues > 1 then
                            return {
                                message = localize('k_again_ex'),
                                repetitions = card.ability.extra.retriggers,
                                card = card
                            }
                        end
                    end
                end
                
            end
        end
    })