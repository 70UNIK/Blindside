local gameMainMenuRef = Game.main_menu
function Game:main_menu(change_context)
    gameMainMenuRef(self, change_context)
    UIBox({
        definition = {
            n = G.UIT.ROOT,
            config = {
                align = "cm",
                colour = G.C.UI.TRANSPARENT_DARK
            },
            nodes = {
                {
                    n = G.UIT.T,
                    config = {
                        scale = 0.3,
                        text = "Blindside BETA v0.2.2-PLAYTEST",
                        colour = G.C.UI.TEXT_LIGHT
                    }
                }
            }
        },
        config = {
            align = "tri",
            bond = "Weak",
            offset = {
                x = 0,
                y = 0.6
            },
            major = G.ROOM_ATTACH
        }
    })
    G.SETTINGS.tutorial_complete = true
end

local card_highlight_ref = Card.highlight
function Card:highlight(is_higlighted)
    card_highlight_ref(self, is_higlighted)
    local obj = self.config.center
    if obj.highlight and type(obj.highlight) == 'function' then
        obj:highlight(self, is_higlighted)
    end
end

--quips

-- flippy quips
for i=1,5 do
    SMODS.JimboQuip{
        key = "blindside_flippy_win"..tostring(i),
        type = 'bld_win',
        extra = {center = "m_bld_flip",googly = true},
        filter = function(quip, type) 
            if type == "bld_win" then return true, {override_base_checks = true} end
        end
    }
end
--losing in general
for i=1,8 do
    SMODS.JimboQuip{
        key = "blindside_flippy_lose"..tostring(i),
        type = 'bld_loss',
        extra = {center = "m_bld_flip",googly = true},
        filter = function(quip, type) 
            if type == "bld_loss" and not G.GAME.blind.config.blind.cursed then return true, {override_base_checks = true} end
        end
    }
end

local googlychar = Card_Character.init
function Card_Character:init(args)

        if args.googly then

            self.googly = true
        end
    local ret = googlychar(self,args)
    if args.googly then

            self.googly = true
        end
    return ret
end