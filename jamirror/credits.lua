function ease_credits(amount, instant) -- DONT USE THIS OUTSIDE OF A RUN (maybe i should have just embedded this into aura of powers use function but oh well)
    amount = to_big(amount or 0)
    if ExtraCredit and (to_big(amount) > 0) then
        amount = amount * to_big(3)
    end
    local function _mod(mod) -- Taken from ease_plincoins()
        local dollar_UI = G.HUD:get_UIE_by_ID('dollar_text_UI')
        mod = mod or 0
        local text = '+c.'
        local col = G.C.PURPLE
        if mod < 0 then
            text = '-c.'
            col = G.C.RED
        end

        G.PROFILES[G.SETTINGS.profile].TNameCredits = to_big(G.PROFILES[G.SETTINGS.profile].TNameCredits) + to_big(amount)

        if amount ~= 0 then
            attention_text({
                text = text .. tostring(math.abs(mod)),
                scale = 0.8,
                hold = 0.7,
                cover = dollar_UI.parent,
                cover_colour = col,
                align = 'cm',
            })
            --Play a chip sound
            if amount > 0 then
                play_sound("hpot_tname_gaincred")
            else
                play_sound("hpot_tname_losecred")
            end
        end
    end

    if instant then
        _mod(amount)
    else
        G.E_MANAGER:add_event(Event({
            trigger = 'immediate',
            func = function()
                _mod(amount)
                return true
            end
        }))
    end

    G:save_progress()
end

function G.UIDEF.RUN_SETUP_credit(e)
    return UIBox{
        definition = {n=G.UIT.ROOT, config={align = "cm", colour = G.C.CLEAR}, nodes={
            {n=G.UIT.O, config={id = G.GAME.viewed_back.name, func = 'RUN_SETUP_check_back_name', object = DynaText {
                string = localize{type = 'variable', key = 'hpot_creinterest_colonless', vars = {G.viewed_stake, 5}},
                colours = { G.C.PURPLE },
                shadow = true,
                spacing = 2,
                bump = true,
                scale = 0.3
            }}},
        }}, 
        config = {offset = {x=0,y=0}, align = 'cm', parent = e}
    }
end

function G.FUNCS.RUN_SETUP_credit(e)
    e.config.object:remove()
    e.config.object = G.UIDEF.RUN_SETUP_credit(e)
end
