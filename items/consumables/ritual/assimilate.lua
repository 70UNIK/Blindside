SMODS.Consumable {
    key = 'assimilate',
    set = 'bld_obj_ritual',
    atlas = 'bld_consumable',
    pos = {x=3, y=4},
    config = {
        min_highlighted = 2,
        max_highlighted = 2,
    },
    can_use = function (self, card)
        if #G.hand.highlighted == 2 then
            local hues = {}
            for key, value in pairs(G.hand.highlighted[1].ability.extra.hues) do
                if not tableContains(value, hues) then
                    table.insert(hues, value)
                end
            end
            for key, value in pairs(G.hand.highlighted[2].ability.extra.hues) do
                if not tableContains(value, hues) then
                    table.insert(hues, value)
                end
            end

            if #hues == 2 then
                return true
            end
        else
            return false
        end
    end,
    use = function(self, card, area)
        local hues = {}
        for key, value in pairs(G.hand.highlighted[1].ability.extra.hues) do
            if not tableContains(value, hues) then
                table.insert(hues, value)
            end
        end
        for key, value in pairs(G.hand.highlighted[2].ability.extra.hues) do
            if not tableContains(value, hues) then
                table.insert(hues, value)
            end
        end

        local enhancement = BLINDSIDE.get_first_enhancement_with_exact_colors(hues)
        local rand = pseudorandom(pseudoseed('assimilate'))

        local card
        if rand > 0.5 then
            card = copy_card(G.hand.highlighted[1], nil, nil, G.playing_card)
            card:remove_sticker('bld_upgrade')
            card:set_ability(enhancement)
            if G.hand.highlighted[1].ability.extra.upgraded then
                upgrade_blinds({card}, nil, true)
            end
        else
            card = copy_card(G.hand.highlighted[2], nil, nil, G.playing_card)
            card:remove_sticker('bld_upgrade')
            card:set_ability(enhancement)
            if G.hand.highlighted[2].ability.extra.upgraded then
                upgrade_blinds({card}, nil, true)
            end
        end
        
        G.hand:emplace(card)
        table.insert(G.playing_cards, card)
        destroy_blinds_and_calc(G.hand.highlighted, card)
        card:start_materialize()

        delay(0.5)
    end,
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.max_highlighted
            }
        }
    end
}

function BLINDSIDE.get_enhancements_with_exact_colors(colors,args)
    local enhancements = {}
    local final = {}
    for key, value in pairs(G.P_CENTER_POOLS.bld_obj_blindcard_generate) do
        -- basically checks table equality
        local good = true
        if not ancient and (value.unik_ancient or value.legendary or value.unik_exotic) then
            good = false
        end
        
        if not args.cursed and value.cursed then
            good = false
        end
        for key, color in pairs(colors) do
            if not tableContains(color, value.config.extra.hues) then
                good = false
                break
            end
        end
        if good then
            for key, color in pairs(value.config.extra.hues) do
                if not tableContains(color, colors) then
                    good = false
                    break
                end
            end
            if good and G.P_CENTERS[value.key] then
                enhancements[value.key] = true
            end
        end
    end
    --convert to list
    for i,v in pairs(enhancements) do
        final[#final+1] = i
    end
    table.sort(final)
    return final

end