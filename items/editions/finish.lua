SMODS.Shader({key = 'finish', path = "finish.fs"})

SMODS.Edition {
    key = 'finish',
    discovered = false,
    unlocked = true,
    shader = 'finish',
    atlas = 'bld_blindrank',
    pos = {x = 3, y = 0},
    config = {
 		extra = {retriggers = 1}
    },
    weight = 0.5,
    in_shop = false,
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.edition and card.edition.extra.retriggers or nil
            }
        }
    end,
    credit = {
        art = "70UNIK",
    },
    calculate = function(self, card, context)
        if context.repetition and card.facing ~= 'back' and context.other_card and context.other_card == card and context.other_card.ability.extra.rescore ~= 1 and not card.ability.extra.blindside_suppress_double_up then
            if context.other_card == card then
                --why this? because finish on held blinds cause blinds to retrigger a WHOPPING 3 intead of 2 times!!!!!!!! and its not intended
                card.ability.extra.blindside_suppress_double_up = true
                return {
                    repetitions = card.ability.extra.retriggers,
                    func = function ()
                        
                       card.ability.extra.blindside_suppress_double_up = nil
                    end
                }
            end
        end
        --trinket specific
        if (context.retrigger_joker_check) and context.other_card and context.other_card == card and card.area == G.jokers then
			if card.edition and card.edition.key == 'e_bld_finish' then
				return {
					message = localize("k_again_ex"),
					repetitions = 1,
					card = card,
				}
			else
				return nil, true
			end
		end
    end
    
}