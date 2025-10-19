SMODS.Atlas({key = "chequeatlas", path = "PerkeoCards/checks.png", px = 71, py = 95, atlas_table = "ASSET_ATLAS"}):register()
-- Jokers
-- Bottlecaps
-- Bottlecap Booster

SMODS.Atlas({key = "perkycardatlas", path = "PerkeoCards/perkycardatlas.png", px = 71, py = 95, atlas_table = "ASSET_ATLAS"}):register()
SMODS.Atlas({key = "perkeocoinjokers", path = "PerkeoCards/PerkeocoinJokers.png", px = 71, py = 95, atlas_table = "ASSET_ATLAS"}):register()
SMODS.Atlas({key = "PerkeocoinBoosters", path = "PerkeoCards/perkeocoin_boosters.png", px = 71, py = 95, atlas_table = "ASSET_ATLAS"}):register()
-- PLEASE FIX THIS
SMODS.Atlas({key = "PerkeocoinVouchers", path = "PerkeoCards/PerkeocoinVouchers.png", px = 71, py = 95, atlas_table = "ASSET_ATLAS"}):register()
SMODS.Atlas({key = "PerkeocoinCredits", path = "PerkeoCards/PerkeocoinCreditsCards.png", px = 71, py = 95, atlas_table = "ASSET_ATLAS"}):register()

-- Gradients have been moved because I needed them earlier

SMODS.Sound {
  key = "music_czech",
  path = "music_czech.ogg",
  select_music_track = function (self)
    if not G.screenwipe and G.STATE == G.STATES.SMODS_BOOSTER_OPENED and SMODS.OPENED_BOOSTER and string.find(SMODS.OPENED_BOOSTER.config.center.key, "czech", 0, true) ~= nil then
      return 1339
    end
  end,
  hpot_title = "Cheque Booster Theme (OST Mix)",
  hpot_purpose = {
    "Music that plays while selecting",
    "a cheque in a Cheque Pack"
  },
  hotpot_credits = {
    team = { "Perkeocoin" }
  }
}

-- SPEEN
SMODS.DrawStep {
    key = 'spinning_sprite',
    order = 69,
    func = function(self)
        if self.hpot_extra and self.hpot_extra.spin then
            local scale_mod = 0.33
            local rotate_mod = (G.TIMERS.REAL * 1.5) % (2 * math.pi)

            self.children.floating_sprite:draw_shader('dissolve', 0, nil, nil, self.children.center, scale_mod,
                rotate_mod, nil, 0.05 + 0.1 + 0.03 * math.sin(1.8 * G.TIMERS.REAL), nil, 0.6)
            self.children.floating_sprite:draw_shader('dissolve', nil, nil, nil, self.children.center, scale_mod, rotate_mod, nil, 0.05, nil, 0.6)
        end
    end,
    conditions = { vortex = false, facing = 'front' },
}

SMODS.Joker{ --19 plincoin fortnite card
    name = "19 Plincoin Fortnite Card",
    key = "fortnite",
    config = {
        extra = {
            fortnite = 19,
            bosses = 3
        }
    },
    pos = {x = 0, y = 0},
    cost = 4,
    rarity = 1,
    blueprint_compat = false,
    eternal_compat = false,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'perkeocoinjokers',

    hotpot_credits = {
        art = {'dottykitty'},
        code = {'CampfireCollective'},
        team = {'Perkeocoin'}
    },

    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.fortnite, card.ability.extra.bosses}}
    end,

    calculate = function(self, card, context)
        if context.end_of_round and not context.blueprint and not context.repetition and not context.individual then
            if G.GAME.blind.boss then
                card.ability.extra.bosses = card.ability.extra.bosses - 1
                if card.ability.extra.bosses <= 0 then
                    --[[ease_plincoins(card.ability.extra.fortnite)
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            play_sound('tarot1')
                            card:start_dissolve()
                            return true
                        end
                    }))]]--
                    return {
                        message = localize("hotpot_perkeocoin_fortnite"),
                        colour = G.C.GREEN
                    }
                end
                return {
                    message = localize{type='variable',key='a_remaining',vars={card.ability.extra.bosses}},
                    colour = G.C.GREEN
                }
            end
        end
    end,
    calc_plincoin_bonus = function(self, card)
        if card.ability.extra.bosses <= 0 then
            G.E_MANAGER:add_event(Event({
                func = function()
                    play_sound('tarot1')
                    card:start_dissolve()
                    return true
                end
            }))
            return card.ability.extra.fortnite
        end
        return nil
    end
}

SMODS.Joker{ --Plink
    name = "Plink",
    key = "plink",
    config = {
        extra = {
            mult = 2
        }
    },
    pos = { x = 1, y = 2 },
    cost = 6,
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = false,
    unlocked = true,
    discovered = true,
    atlas = 'perkeocoinjokers',

    hotpot_credits = {
        art = {'dottykitty'},
        code = {'CampfireCollective'},
        team = {'Perkeocoin'}
    },

    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.mult, card.ability.extra.mult * (G.GAME.balls_dropped or 0)}}
    end,

    calculate = function(self, card, context)
        if context.joker_main then
            if G.GAME.balls_dropped > 0 then
                return{
                    mult = card.ability.extra.mult * G.GAME.balls_dropped
                }
            end
        end
    end

}

SMODS.Joker{ --Metal Detector
    name = "Metal Detector",
    key = "metal_detector",
    config = {
        extra = {
            skipped = 0,
            needs = 2
        }
    },
    pos = { x = 4, y = 2 },
    cost = 6,
    rarity = 1,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = false,
    unlocked = true,
    discovered = true,
    atlas = 'perkeocoinjokers',

    hotpot_credits = {
        art = {'dottykitty'},
        code = {'CampfireCollective'},
        team = {'Perkeocoin'}
    },

    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.skipped, card.ability.extra.needs}}
    end,

    calculate = function(self, card, context)
        if context.skipping_booster and not context.blueprint then
            card.ability.extra.skipped = card.ability.extra.skipped + 1
            card_eval_status_text(card, 'jokers', nil, nil, nil, {message = card.ability.extra.skipped.."/"..card.ability.extra.needs , colour = G.C.FILTER})
            if card.ability.extra.skipped >= card.ability.extra.needs then
                if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                    G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                    local rarity = pseudorandom_element({'Bad','Common','Common','Common','Uncommon','Uncommon','Rare'}, pseudoseed('detected'))
                    G.E_MANAGER:add_event(Event({
                    func = (function()
                        G.E_MANAGER:add_event(Event({
                            func = function() 
                                local _card = SMODS.create_card{set = 'bottlecap_'..rarity,area = G.consumeables, key_append = 'detected'}
                                _card.ability.extra.chosen = rarity
                                if rarity == "Bad" then
                                    _card.ability.eternal = true
                                end
                                _card:add_to_deck()
                                G.consumeables:emplace(_card)
                                G.GAME.consumeable_buffer = 0
                                return true
                            end}))                         
                        return true
                    end)}))
                end
                card.ability.extra.skipped = 0
                card_eval_status_text(card, 'jokers', nil, nil, nil, {message = localize("k_hotpot_metal_detected"), colour = G.C.FILTER})
            end
        end
    end

}

SMODS.Joker{ --Tribcoin
    name = "Tribcoin",
    key = "tribcoin",
    config = {
        extra = {
            Xmult = 0.2
        }
    },
    pos = { x = 3, y = 0 },
    cost = 7,
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'perkeocoinjokers',

    hotpot_credits = {
        art = {'Omegaflowey18'}, 
        code = {'CampfireCollective'},
        team = {'Perkeocoin'}
    },

    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.Xmult,G.GAME.plincoins and (1 + math.max(0, G.GAME.plincoins * card.ability.extra.Xmult)) or 1}}
    end,

    calculate = function(self, card, context)
        if context.joker_main then
            if G.GAME.plincoins > 0 then
                return {
                    xmult = 1 + math.max(0, G.GAME.plincoins * card.ability.extra.Xmult)
                }
            end
        end
    end

}

SMODS.Joker{ --Adspace
    name = "Adspace",
    key = "adspace",
    config = {
        extra = {
            chips = 15
        }
    },
    pos = { x = 3, y = 1 },
    cost = 5,
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'perkeocoinjokers',

    hotpot_credits = {
        art = {'dottykitty'},
        code = {'CampfireCollective'},
        team = {'Perkeocoin'}
    },

    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.chips, #G.GAME.hotpot_ads * card.ability.extra.chips}}
    end,

    calculate = function(self, card, context)
        if context.joker_main then
            if #G.GAME.hotpot_ads > 0 then
                return{
                    chips = card.ability.extra.chips * #G.GAME.hotpot_ads
                }
            end
        end
    end

}

SMODS.Joker{ -- Kitchen Gun
    key = 'kitchen_gun',
    config = { extra = { odds = 3, xmult = 1, xmult_mod = 0.1 }},
    cost = 7,
    rarity = 2,
    atlas = 'perkeocoinjokers',
    pos = { x = 1 , y = 0 },
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = false,
    unlocked = true,
    discovered = true,

    hotpot_credits = {
        art = {'dottykitty'},
        code = {'Opal'},
        team = {'Perkeocoin'}
    },

    loc_vars = function(self, info_queue, card)
        local n, d = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'hpot_kitchen_gun')
        return{vars = {n, d, card.ability.extra.xmult_mod, card.ability.extra.xmult}}
    end,
    calculate = function(self, card, context)
        if context.ending_shop and context.cardarea == G.jokers and not context.blueprint then
            local adsRemoved = 0
            for _, ad in ipairs(G.GAME.hotpot_ads) do
                if SMODS.pseudorandom_probability(card, 'hpot_kg_kill_ad', 1, card.ability.extra.odds) then

                    G.E_MANAGER:add_event(Event {delay = 1, blockable = true, blocking = true, trigger = "before", func = function ()
                        
                        play_sound('tarot1')
                        ad:juice_up(0.3,0.5)
                        card:juice_up(0.3,0.5)
                        
                        G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        delay = 0.65,
                        blockable = false,
                        blocking = false,
                        func = function()
                            G.FUNCS.remove_ad({config = {adnum = ad.config.id}})
                            return true
                        
                        end}))
                        return true
                    end})

                    adsRemoved = adsRemoved+1
                end
            end
            SMODS.scale_card(card, {
                ref_table = card.ability.extra,
                ref_value = "xmult",
                scalar_value = "xmult_mod",
                operation = function(ref_table, ref_value, initial, change)
                    ref_table[ref_value] = initial + adsRemoved*change
                end,
                message_key = "a_xmult",
                message_colour = G.C.RED
            })
        end
        if context.joker_main and card.ability.extra.xmult > 1 then
            return{
                    Xmult = card.ability.extra.xmult
                }
        end
    end
}

SMODS.Joker{ --TV Dinner
    name = "TV Dinner",
    key = "tv_dinner",
    config = {
        extra = {
            mult = 20,
            mult_mod = 4
        }
    },
    pos = { x = 0, y = 3 },
    hpot_anim = {
        { xrange = { first = 0, last = 9 }, y = 3, t = 0.1 }
    },
    pos_extra = { x = 0, y = 4 },
    hpot_anim_extra = {
        { x = 0, y = 4, t = 0.075 },
        { x = 1, y = 4, t = 0.125 },
        { x = 2, y = 4, t = 0.175 },
        { x = 3, y = 4, t = 0.3 },
        { x = 2, y = 4, t = 0.175 },
        { x = 1, y = 4, t = 0.125 },
        { x = 0, y = 4, t = 0.075 },
        { x = 4, y = 4, t = 0.125 },
        { x = 5, y = 4, t = 0.175 },
        { x = 6, y = 4, t = 0.3 },
        { x = 5, y = 4, t = 0.175 },
        { x = 4, y = 4, t = 0.125 }
    },
    cost = 6,
    rarity = 1,
    pools = { Food = true },
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = "TeamNameAnims1",

    hotpot_credits = {
        art = {'Omegaflowey18'},
        code = {'CampfireCollective'},
        team = {'Perkeocoin'}
    },

    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.mult, card.ability.extra.mult_mod}}
    end,

    calculate = function(self, card, context)
        if context.joker_main then
            if card.ability.extra.mult > 0 then
                return{
                    mult = card.ability.extra.mult
                }
            end
        elseif context.close_ad and not context.blueprint then
            if card.ability.extra.mult - card.ability.extra.mult_mod <= 0 then 
                SMODS.destroy_cards(card, nil, nil, true)
                return {
                    message = localize('k_eaten_ex'),
                    colour = G.C.FILTER
                }
            else
                SMODS.scale_card(card, {
                    ref_table = card.ability.extra,
                    ref_value = "mult",
                    scalar_value = "mult_mod",
                    operation = "-",
                    message_key = 'a_mult_minus'
                })
            end
        end
    end,
    in_pool = function (self, args)
        return not G.GAME.pool_flags.tv_dinner_eaten
    end

}

SMODS.Joker{ --Free To Use
    name = "Free To Use",
    key = "free_to_use",
    config = {
        extra = {
            reps = 1,
            num = 1,
            den = 3
        }
    },
    pos = { x = 1, y = 1 },
    cost = 6,
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'perkeocoinjokers',

    hotpot_credits = {
        art = {'Omegaflowey18'},
        code = {'CampfireCollective'},
        team = {'Perkeocoin'}
    },

    loc_vars = function(self, info_queue, card)
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, card.ability.extra.num, card.ability.extra.den, 'wheel_of_plinko')
        return {vars = {card.ability.extra.reps, new_numerator, new_denominator}}
    end,

    calculate = function(self, card, context)
        if context.cardarea == G.play and context.repetition then
            if SMODS.pseudorandom_probability(card, 'perky_free!', card.ability.extra.num, card.ability.extra.den, 'free_to_use') then
                create_ads(card.ability.extra.reps)
                return {
                    repetitions = 1,
                    card = card
                }
            end
        end
    end

}

SMODS.Joker{ --Direct Deposit
    name = "Direct Deposit",
    key = "direct_deposit",
    config = {
        extra = {
            dollars = 5,
            plincoins = 1,
            so_far = 0
        }
    },
    pos = { x = 3, y = 2 },
    cost = 7,
    rarity = 2,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'perkeocoinjokers',

    hotpot_credits = {
        art = {'dottykitty'},
        code = {'CampfireCollective'},
        team = {'Perkeocoin'}
    },

    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.dollars, card.ability.extra.plincoins, card.ability.extra.so_far}}
    end,

    calculate = function(self, card, context)
        if context.pk_cashout_row and not context.blueprint then
            local new_config = context.pk_cashout_row
            if new_config.name == 'bottom' and new_config.dollars > 0 then
                new_config.dollars = 0
            end
            return {
                new_config = new_config
            }
        elseif context.ending_shop and not context.blueprint then
            card.ability.extra.earnings = 0
        end
    end,
    calc_plincoin_bonus_delayed = function(self, card, dollars)
        local earnings = nil
        card.ability.extra.so_far = card.ability.extra.so_far + dollars
        if card.ability.extra.so_far >= card.ability.extra.dollars then
            earnings = math.floor(card.ability.extra.so_far / card.ability.extra.dollars)
            card.ability.extra.so_far = card.ability.extra.so_far % card.ability.extra.dollars
        else
            card_eval_status_text(card, 'jokers', nil, nil, nil, {message = tostring(card.ability.extra.so_far).."/"..tostring(card.ability.extra.dollars), colour = G.C.FILTER})
        end
        if earnings then return earnings end
    end

}

SMODS.Joker{ --Bank Teller
    name = "Bank Teller",
    key = "bank_teller",
    config = {
        extra = {
            compare = 10,
            cards = 1
        }
    },
    pos = { x = 2, y = 0 },
    cost = 5,
    rarity = 1,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'perkeocoinjokers',

    hotpot_credits = {
        art = {'dottykitty'},
        code = {'CampfireCollective'},
        team = {'Perkeocoin'}
    },

    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.compare, card.ability.extra.cards, localize('k_czech')..(card.ability.extra.cards > 1 and "s" or "")}}
    end,

    calculate = function(self, card, context)
        if context.pk_cashout_row_but_just_looking and not context.blueprint then
            if context.pk_cashout_row_but_just_looking.name == 'bottom' and context.pk_cashout_row_but_just_looking.dollars >= card.ability.extra.compare then
                if G.consumeables and #G.consumeables.cards < G.consumeables.config.card_limit then
                    local amount = math.min(card.ability.extra.cards, (G.consumeables.config.card_limit - #G.consumeables.cards))
                    for i = 1, amount do
                        G.E_MANAGER:add_event(Event({
                            trigger = 'after', delay = 0.4, func = function()
                                play_sound('timpani')
                                local new_czech = create_card('Czech', G.consumeables, nil, nil, nil, nil, nil, 'czech_republic')
                                new_czech:add_to_deck()
                                G.consumeables:emplace(new_czech)
                                card:juice_up(0.3, 0.5)
                                check_for_unlock({type = 'jonceler'})
                            return true end}))
                    end
                    card_eval_status_text(card, 'jokers', nil, nil, nil, {message = "+"..amount.." "..localize('k_czech')..(amount > 1 and "s" or ""), colour = HEX("D2B48C")})
                end
            end
        end
    end

}

SMODS.Joker{ --Balatro **PREMIUM**
    name = "Balatro **PREMIUM**",
    key = "balatro_premium",
    config = {
        extra = {
            dollars = 5,
            sofar = 0
        }
    },
    pos = { x = 4, y = 0 },
    cost = 1,
    rarity = 1,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'perkeocoinjokers',

    hotpot_credits = {
        art = {'Omegaflowey18'},
        code = {'CampfireCollective'},
        team = {'Perkeocoin'}
    },

    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.dollars}}
    end,

    add_to_deck = function(self, card, from_debuff)
        for k, v in ipairs(G.GAME.hotpot_ads) do
            G.E_MANAGER:add_event(Event({
                delay = 0.3, func = function()
                    play_sound('tarot1')
                    v:juice_up(0.3,0.5)
                    G.FUNCS.remove_ad(v.config.id)
                return true end
            }))
        end
    end,

    calculate = function(self, card, context)
        if context.end_of_round and G.GAME.blind.boss and not context.repetition and not context.individual and not context.blueprint then
            ease_dollars(-card.ability.extra.dollars)
            card.ability.extra.sofar = card.ability.extra.sofar + 1
            check_for_unlock({type = 'paytowin', conditions = card.ability.extra.sofar})
            return {
                message = "-"..localize("$")..card.ability.extra.dollars,
                colour = G.C.MONEY
            }

        elseif context.close_ad and not context.blueprint then
            card_eval_status_text(card, 'jokers', nil, nil, nil, {message = localize("hotpot_perkeocoin_ad_removed"), colour = G.C.FILTER})
        end
   
    end

}

SMODS.Joker{ --Skimming
    name = "Skimming",
    key = "skimming",
    config = {
        extra = {
            dollars = 0,
            dollars_mod = 2
        }
    },
    pos = { x = 2, y = 2 },
    cost = 4,
    rarity = 1,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'perkeocoinjokers',

    hotpot_credits = {
        art = {'dottykitty'},
        code = {'CampfireCollective'},
        team = {'Perkeocoin'}
    },

    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.dollars, card.ability.extra.dollars_mod}}
    end,

    calc_dollar_bonus = function(self, card)
        local thunk = card.ability.extra.dollars
        if G.GAME.blind.boss then
            card.ability.extra.dollars = 0
            card_eval_status_text(card, 'jokers', nil, nil, nil, {message = localize('k_reset'), colour = G.C.FILTER})
        end
        if thunk > 0 then
            return thunk
        end
    end,

    calculate = function(self, card, context)
        if context.close_ad and not context.blueprint then
            SMODS.scale_card(card, {
                ref_table = card.ability.extra,
                ref_value = "dollars",
                scalar_value = "dollars_mod",
                scaling_message = {
                    localize("$")..number_format(card.ability.extra.dollars), 
                    colour = G.C.MONEY
                }
            })
        end
    end

}

SMODS.Joker{ --Recycling
    name = "Recycling",
    key = "recycling",
    config = {
        extra = {
            dollars = 5
        }
    },
    pos = { x = 2, y = 1 },
    cost = 6,
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'perkeocoinjokers',

    hotpot_credits = {
        art = {'dottykitty'},
        code = {'CampfireCollective'},
        team = {'Perkeocoin'}
    },

    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.dollars}}
    end,

    calculate = function(self, card, context)
        if context.using_consumeable then
            if context.consumeable.ability.set == 'bottlecap' then
                ease_dollars(card.ability.extra.dollars)
                card:juice_up(0.5,0.5)
            end
        end
    end

}

SMODS.Joker{ --Don't Touch That Dial!
    name = "Don\'t Touch That Dial!",
    key = "dont_touch_that_dial",
    config = {
        extra = {
            dial = 1
        }
    },
    pos = { x = 0, y = 2 },
    cost = 6,
    rarity = 3,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'perkeocoinjokers',

    hotpot_credits = {
        art = {'Omegaflowey18'},
        code = {'CampfireCollective'},
        team = {'Perkeocoin'}
    },

    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.dial}}
    end,

    calculate = function(self, card, context)
        if context.end_of_round and G.GAME.current_round.discards_left > 0 and not (context.blueprint or context.individual or context.repetition) then
            --ease_plincoins(G.GAME.current_round.discards_left)
            create_ads(G.GAME.current_round.discards_left)
            card_eval_status_text(card, 'jokers', nil, nil, nil, {message = localize("hotpot_perkeocoin_stay_tuned"), colour = G.C.MONEY})
        end
    end,
    calc_plincoin_bonus = function(self, card)
        if G.GAME.current_round.discards_left > 0 then
            return G.GAME.current_round.discards_left
        end
    end
}

SMODS.Joker{ --Tipping Point
    name = "Tipping Point",
    key = "tipping_point",
    config = {
        extra = {
            tipping = 1
        }
    },
    pos = { x = 4, y = 1 },
    cost = 4,
    rarity = 1,
    blueprint_compat = false,
    
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'perkeocoinjokers',

    hotpot_credits = {
        art = {'Omegaflowey18'},
        code = {'stupid'},
        team = {'Perkeocoin'}
    },

    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.tipping}}
    end,

    calculate = function(self, card, context)
    end

}


-- Czechs

SMODS.ConsumableType { --Czech
    key = "Czech",
    primary_colour = HEX("EEEEEE"),
    secondary_colour = HEX("D2B48C"),
    collection_row = {6, 6},
    shop_rate = 1,
    default = "c_hpot_charity",
}

SMODS.Consumable { --Cash Exchange
    name = 'Cash Exchange',
    key = 'cashexchange',
    set = 'Czech',
    atlas = 'chequeatlas',
    pos = { x = 0, y = 0 },
    config = {
        extra = {
            dollars = 8,
            credits = 15
        }
    },
    unlocked = true,
    discovered = true,
    cost = 3,
    pools = {
        ['Czech'] = true
    },
    hotpot_credits = {
        art = {'dottykitty'},
        code = {'CampfireCollective'},
        team = {'Perkeocoin'}
    },
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.dollars, card.ability.extra.credits}}
    end,

    can_use = function(self, card)
        return G.GAME.dollars >= card.ability.extra.dollars
    end,

    use = function(self, card, area, copier)
        ease_dollars(-card.ability.extra.dollars)
        HPTN.ease_credits(card.ability.extra.credits)
    end
}


local function sac_czech()
    if G.jokers and G.jokers.highlighted and #G.jokers.highlighted > 0 then
        local thunk = G.jokers.highlighted[1].config.center.rarity
        if thunk == 1 then
            thunk = 'Common'
        elseif thunk == 2 then
            thunk = 'Uncommon'
        elseif thunk == 3 then
            thunk = 'Rare'
        else
            thunk = 'Legendary'
        end
        local weight = SMODS.Rarities[thunk].default_weight or 0;
        if weight == 0 then -- LEGENDARY
            return 50 --2
        elseif weight <= 0.005 then
            return 45
        elseif weight <= 0.01 then
            return 40
        elseif weight <= 0.05 then -- RARE
            return 35
        elseif weight <= 0.10 then 
            return 30
        elseif weight <= 0.20 then 
            return 25
        elseif weight <= 0.25 then -- UNCOMMON
            return 20
        elseif weight <= 0.7 then -- COMMON
            return 15
        elseif weight <= 0.9 then 
            return 10
        else
            return 5 -- default weight must be really high for whatever reason and is probably trash
        end
    end
    return 0
end

SMODS.Consumable { --Sacrifice
    name = 'Sacrifice',
    key = 'sacrifice',
    set = 'Czech',
    atlas = 'chequeatlas',
    pos = { x = 1, y = 0 },
    config = {
        extra = {
        }
    },
    unlocked = true,
    discovered = true,
    cost = 3,
    pools = {
        ['Czech'] = true
    },
    hotpot_credits = {
        art = {'dottykitty'},
        code = {'CampfireCollective'},
        team = {'Perkeocoin'}
    },
    loc_vars = function(self, info_queue, card)
        return {vars = {sac_czech()}}
    end,

    can_use = function(self, card)
        if #G.jokers.highlighted == 1 then
            if not SMODS.is_eternal(G.jokers.highlighted[1], card) then
                return true
            end
        end
        return false
    end,

    use = function(self, card, area, copier)
        check_for_unlock({ type = "fuck_soul", conditions = G.jokers.highlighted[1].config.center.rarity })
        HPTN.ease_credits(sac_czech())
        G.jokers.highlighted[1].getting_sliced = true
        G.E_MANAGER:add_event(Event({func = function()
            card:juice_up(0.8, 0.8)
            SMODS.destroy_cards({ G.jokers.highlighted[1] }, true)
        return true end }))
    end
}

SMODS.Consumable { --Wheel of Plinko
    name = 'Wheel of Plinko',
    key = 'wheel_of_plinko',
    set = 'Czech',
    atlas = 'chequeatlas',
    pos = { x = 2, y = 0 },
    config = {
        extra = {
            plincoinsdown = 2,
            plincoinsup = 5,
            num = 1,
            den = 2
        }
    },
    unlocked = true,
    discovered = true,
    cost = 3,
    pools = {
        ['Czech'] = true
    },
    hotpot_credits = {
        art = {'Omegaflowey18'},
        code = {'CampfireCollective'},
        team = {'Perkeocoin'}
    },
    loc_vars = function(self, info_queue, card)
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, card.ability.extra.num, card.ability.extra.den, 'wheel_of_plinko')
        return {vars = {card.ability.extra.plincoinsdown, card.ability.extra.plincoinsup, new_numerator, new_denominator}}
    end,

    can_use = function(self, card)
        return true
    end,

    use = function(self, card, area, copier)
        ease_plincoins(-card.ability.extra.plincoinsdown)
        if SMODS.pseudorandom_probability(card, 'czech_wheel_of_plinko', card.ability.extra.num, card.ability.extra.den, 'wheel_of_plinko') then
            ease_plincoins(card.ability.extra.plincoinsup)
        else
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
            attention_text({
                text = localize('k_nope_ex'),
                scale = 1.3, 
                hold = 1.4,
                major = card,
                backdrop_colour = G.C.SECONDARY_SET.Tarot,
                align = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK) and 'tm' or 'cm',
                offset = {x = 0, y = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK) and -0.2 or 0},
                silent = true
                })
                G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.06*G.SETTINGS.GAMESPEED, blockable = false, blocking = false, func = function()
                    play_sound('tarot2', 0.76, 0.4);return true end}))
                play_sound('tarot2', 1, 0.4)
                card:juice_up(0.3, 0.5)
            return true end }))
        end
    end
}

SMODS.Consumable { --Charity
    name = 'Charity',
    key = 'charity',
    set = 'Czech',
    atlas = 'chequeatlas',
    pos = { x = 3, y = 0 },
    config = {
        extra = {
            plincoins = 1
        }
    },
    unlocked = true,
    discovered = true,
    cost = 3,
    pools = {
        ['Czech'] = true
    },
    hotpot_credits = {
        art = {'Omegaflowey18'},
        code = {'CampfireCollective'},
        team = {'Perkeocoin'}
    },
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.plincoins}}
    end,

    can_use = function(self, card)
        return true
    end,

    use = function(self, card, area, copier)
        ease_plincoins(card.ability.extra.plincoins)
    end
}

SMODS.Consumable { --Collateral 
    name = 'Collateral',
    key = 'collateral',
    set = 'Czech',
    atlas = 'chequeatlas',
    pos = { x = 0, y = 1 },
    config = {
        extra = {
            credits = 15
        }
    },
    unlocked = true,
    discovered = true,
    cost = 3,
    pools = {
        ['Czech'] = true
    },
    hotpot_credits = {
        art = {'Kitty & Omega'},
        code = {'CampfireCollective'},
        team = {'Perkeocoin'}
    },
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.credits}}
    end,

    can_use = function(self, card)
        if #G.jokers.highlighted == 1 then
            local v = G.jokers.highlighted[1]
            if not v.ability.perishable and v.config.center.perishable_compat and not v.ability.eternal then
                return true
            end
        end
        return false
    end,

    use = function(self, card, area, copier)
        local then_perish = G.jokers.highlighted[1]
        then_perish:set_perishable(true)
        then_perish:juice_up(0.5,0.5)
        HPTN.ease_credits(card.ability.extra.credits)
    end
}

SMODS.Consumable { --CoD Account
    name = 'CoD Account',
    key = 'cod_account',
    set = 'Czech',
    atlas = 'chequeatlas',
    pos = { x = 1, y = 1 },
    config = {
        extra = {
            credits = 15
        }
    },
    unlocked = true,
    discovered = true,
    cost = 3,
    pools = {
        ['Czech'] = true
    },
    hotpot_credits = {
        art = {'Kitty & Omega'},
        code = {'CampfireCollective'},
        team = {'Perkeocoin'}
    },
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.credits}}
    end,

    can_use = function(self, card)
        if #G.jokers.highlighted == 1 then
            local v = G.jokers.highlighted[1]
            if not v.ability.eternal and v.config.center.eternal_compat and not v.ability.perishable then
                return true
            end
        end
        return false
    end,

    use = function(self, card, area, copier)
        local deposit = G.jokers.highlighted[1]
        deposit:set_eternal(true)
        deposit:juice_up(0.5,0.5)
        HPTN.ease_credits(card.ability.extra.credits)
    end
}

SMODS.Consumable { --Subscription
    name = 'Subscription',
    key = 'subscription',
    set = 'Czech',
    atlas = 'chequeatlas',
    pos = { x = 2, y = 1 },
    config = {
        extra = {
            credits = 15
        }
    },
    unlocked = true,
    discovered = true,
    cost = 3,
    pools = {
        ['Czech'] = true
    },
    hotpot_credits = {
        art = {'Kitty & Omega'},
        code = {'CampfireCollective'},
        team = {'Perkeocoin'}
    },
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.credits}}
    end,

    can_use = function(self, card)
        if #G.jokers.highlighted == 1 then
            local v = G.jokers.highlighted[1]
            if not v.ability.rental then
                return true
            end
        end
        return false
    end,

    use = function(self, card, area, copier)
        local rent = G.jokers.highlighted[1]
        rent:set_rental(true)
        rent:juice_up(0.5,0.5)
        HPTN.ease_credits(card.ability.extra.credits)
    end
}

SMODS.Consumable { --Handful
    name = 'Handful',
    key = 'handful',
    set = 'Czech',
    atlas = 'chequeatlas',
    pos = { x = 3, y = 1 },
    config = {
        extra = {
            plincoins = 10,
            hands = 1
        }
    },
    unlocked = true,
    discovered = true,
    cost = 3,
    pools = {
        ['Czech'] = true
    },
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.plincoins, card.ability.extra.hands}}
    end,
    hotpot_credits = {
        art = {'Omegaflowey18'},
        code = {'CampfireCollective'},
        team = {'Perkeocoin'}
    },

    can_use = function(self, card)
        return true
    end,

    use = function(self, card, area, copier)
        G.GAME.round_bonus.next_hands = G.GAME.round_bonus.next_hands - card.ability.extra.hands
        ease_hands_played(-card.ability.extra.hands)
        ease_plincoins(card.ability.extra.plincoins)
    end
}

SMODS.Consumable { --Czech Republic
    name = 'Czech Republic',
    key = 'czech_republic',
    set = 'Czech',
    atlas = 'chequeatlas',
    pos = { x = 0, y = 2 },
    config = { extra = { cards = 2 }},
    unlocked = true,
    discovered = true,
    cost = 3,
    pools = {
        ['Czech'] = true
    },
    hotpot_credits = {
        art = {'Omegaflowey18'},
        code = {'Opal'},
        team = {'Perkeocoin'}
    },
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.cards}}
    end,

    can_use = function(self, card)
        if G.consumeables and #G.consumeables.cards < G.consumeables.config.card_limit then
            return true
        end
        return false
    end,

    use = function(self, card, area, copier)
        for i = 1, math.min(card.ability.extra.cards, (G.consumeables.config.card_limit - #G.consumeables.cards)) do
            G.E_MANAGER:add_event(Event({
                trigger = 'after', delay = 0.4, func = function()
                    play_sound('timpani')
                    local new_czech = create_card('Czech', G.consumeables, nil, nil, nil, nil, nil, 'czech_republic')
                    new_czech:add_to_deck()
                    G.consumeables:emplace(new_czech)
                    card:juice_up(0.3, 0.5)
                return true end}))
        end
    end
}

local function mostplayedhand()
    local _handname, _played, _order = 'High Card', -1, 1000
    for k, v in pairs(G.GAME.hands) do
        if v.visible and ((v.played > _played) or ((v.played == _played) and (v.order < _order))) then
            _played = v.played
            _order = v.order
            _handname = k
        end
    end
    return _handname
end
SMODS.Consumable { --Meteor
    name = 'Meteor',
    key = 'meteor',
    set = 'Czech',
    atlas = 'chequeatlas',
    pos = { x = 1, y = 2 },
    config = {
        extra = {
            plincoins = 5,
            levels = 1
        }
    },
    unlocked = true,
    discovered = true,
    cost = 3,
    pools = {
        ['Czech'] = true
    },
    hotpot_credits = {
        art = {'dottykitty'},
        code = {'CampfireCollective'},
        team = {'Perkeocoin'}
    },
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.plincoins, card.ability.extra.levels, mostplayedhand()}}
    end,

    can_use = function(self, card)
        local thunk = mostplayedhand()
        return G.GAME.hands[thunk].level > 0
    end,

    use = function(self, card, area, copier)
        local thunk = mostplayedhand()
        update_hand_text({sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3}, {handname=localize(thunk, 'poker_hands'),chips = G.GAME.hands[thunk].chips, mult = G.GAME.hands[thunk].mult, level=G.GAME.hands[thunk].level})
        level_up_hand(card, thunk, nil, -card.ability.extra.levels)
        update_hand_text({sound = 'button', volume = 0.7, pitch = 1.1, delay = 0}, {mult = 0, chips = 0, handname = '', level = ''})
        ease_plincoins(card.ability.extra.plincoins)
    end
}

SMODS.Consumable { --Yard Sale
    name = 'Yard Sale',
    key = 'yard_sale',
    set = 'Czech',
    atlas = 'chequeatlas',
    pos = { x = 2, y = 2 },
    config = {
        extra = {
            plincoins = 3,
            cards = 4
        }
    },
    unlocked = true,
    discovered = true,
    cost = 3,
    pools = {
        ['Czech'] = true
    },
    hotpot_credits = {
        art = {'Omegaflowey18'},
        code = {'CampfireCollective'},
        team = {'Perkeocoin'}
    },
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.plincoins, card.ability.extra.cards}}
    end,

    can_use = function(self, card)
        return true
    end,

    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.7,
                func = function() 
                    local cards = {}
                    for i=1, card.ability.extra.cards do
                        cards[i] = true
                        local _suit, _rank = nil, nil
                            _rank = pseudorandom_element(SMODS.Ranks, pseudoseed('yardsale'))
                            _suit = pseudorandom_element(SMODS.Suits, pseudoseed('yardsale'))
                        _suit = _suit or 'S'; _rank = _rank or 'A'
                        
                        create_playing_card({front = G.P_CARDS[_suit.card_key..'_'.._rank.card_key], center = G.P_CENTERS.c_base}, G.deck, nil, i ~= 1, {HEX("D2B48C")})
                        G.deck.config.card_limit = G.deck.config.card_limit + 1
                    end
                    playing_card_joker_effects(cards)
                    return true end }))
        ease_plincoins(card.ability.extra.plincoins)
    end
}

SMODS.Consumable { --Mystery Box
    name = 'Mystery Box',
    key = 'mystery_box',
    set = 'Czech',
    atlas = 'chequeatlas',
    pos = { x = 3, y = 2 },
    config = {
        extra = {
            plincoins = 2,
            facedowns = 2
        }
    },
    unlocked = true,
    discovered = true,
    cost = 3,
    pools = {
        ['Czech'] = true
    },
    hotpot_credits = {
        art = {'Omegaflowey18'},
        code = {'CampfireCollective'},
        team = {'Perkeocoin'}
    },
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.plincoins, card.ability.extra.facedowns}}
    end,

    can_use = function(self, card)
        if #G.jokers.cards > 0 then
            local thunk = 0
            for k, v in ipairs(G.jokers.cards) do
                if v.facing == 'front' then
                    thunk = thunk + 1
                    if thunk >= card.ability.extra.facedowns then return true end
                end
            end
        end
        return false
    end,

    use = function(self, card, area, copier)
        local flippers = {}
        for k, v in ipairs(G.jokers.cards) do
            if v.facing == 'front' then
                flippers[#flippers+1] = v
            end
        end
        local flipped = pseudorandom_element(flippers, pseudoseed('yardsale'))
        flipped:flip()
        flipped.forever_flipped = true
        flippers = {}
        for k, v in ipairs(G.jokers.cards) do
            if v.facing == 'front' then
                flippers[#flippers+1] = v
            end
        end
        local flipped = pseudorandom_element(flippers, pseudoseed('yardsale'))
        flipped:flip()
        flipped.forever_flipped = true

        G.E_MANAGER:add_event(Event({ trigger = 'after', delay = 0.2, func = function() 
            G.E_MANAGER:add_event(Event({ func = function() G.jokers:shuffle('mystery_box'); play_sound('cardSlide1', 0.85);return true end })) 
            delay(0.15)
            G.E_MANAGER:add_event(Event({ func = function() G.jokers:shuffle('mystery_box'); play_sound('cardSlide1', 1.15);return true end })) 
            delay(0.15)
            G.E_MANAGER:add_event(Event({ func = function() G.jokers:shuffle('mystery_box'); play_sound('cardSlide1', 1);return true end })) 
            delay(0.5)
        return true end })) 

        ease_plincoins(card.ability.extra.plincoins)
    end
}


G.STATES.CZECH_PACK = 5734985

-- Czech Boosters
SMODS.Booster {
    name = 'Czech Pack',
    key = 'czech_normal_1',
    atlas = 'PerkeocoinBoosters', pos = {x=0,y=0},
    config = { choose = 1, extra = 3 },
    discovered = true,
    cost = 4,
    weight = 0.4,
    kind = 'hpot_czech',
    group_key = 'k_hpot_czech_pack',
    hotpot_credits = {
        art = {'Omegaflowey18'},
        code = {'Opal'},
        team = {'Perkeocoin'}
    },

    loc_vars = function(self, info_queue, card)
        return{vars={card.ability.choose, card.ability.extra}, key = self.key:sub(1, -3)}
    end,
    create_card = function(self, card, i)
        local newCard = create_card('Czech', G.pack_cards, nil, nil, true, true, nil, 'czech_pack')
        return newCard
    end,
    ease_background_colour = function(self)
        ease_background_colour_blind(G.STATES.CZECH_PACK)
    end,
}

SMODS.Booster {
    name = 'Czech Pack',
    key = 'czech_normal_2',
    atlas = 'PerkeocoinBoosters', pos = {x=0,y=0},
    config = { choose = 1, extra = 3 },
    discovered = true,
    cost = 4,
    weight = 0.4,
    kind = 'hpot_czech',
    group_key = 'k_hpot_czech_pack',
    hotpot_credits = {
        art = {'Omegaflowey18'},
        code = {'Opal'},
        team = {'Perkeocoin'}
    },

    loc_vars = function(self, info_queue, card)
        return{vars={card.ability.choose, card.ability.extra}, key = self.key:sub(1, -3)}
    end,
    create_card = function(self, card, i)
        local newCard = create_card('Czech', G.pack_cards, nil, nil, true, true, nil, 'czech_pack')
        return newCard
    end,
    ease_background_colour = function(self)
        ease_background_colour_blind(G.STATES.CZECH_PACK)
    end,
}

SMODS.Booster {
    name = 'Jumbo Czech Pack',
    key = 'czech_jumbo',
    atlas = 'PerkeocoinBoosters', pos = {x=1,y=0},
    config = { choose = 1, extra = 5 },
    discovered = true,
    cost = 6,
    weight = 0.4,
    kind = 'hpot_czech',
    group_key = 'k_hpot_czech_pack',
    hotpot_credits = {
        art = {'Omegaflowey18'},
        code = {'Opal'},
        team = {'Perkeocoin'}
    },

    loc_vars = function(self, info_queue, card)
        return{vars={card.ability.choose, card.ability.extra}}
    end,
    create_card = function(self, card, i)
        local newCard = create_card('Czech', G.pack_cards, nil, nil, true, true, nil, 'czech_pack')
        return newCard
    end,
    ease_background_colour = function(self)
        ease_background_colour_blind(G.STATES.CZECH_PACK)
    end,
}

SMODS.Booster {
    name = 'Mega Czech Pack',
    key = 'czech_mega',
    atlas = 'PerkeocoinBoosters', pos = {x=2,y=0},
    config = { choose = 2, extra = 5 },
    discovered = true,
    cost = 8,
    weight = 0.1,
    kind = 'hpot_czech',
    group_key = 'k_hpot_czech_pack',
    hotpot_credits = {
        art = {'Omegaflowey18'},
        code = {'Opal'},
        team = {'Perkeocoin'}
    },

    loc_vars = function(self, info_queue, card)
        return{vars={card.ability.choose, card.ability.extra}}
    end,
    create_card = function(self, card, i)
        local newCard = create_card('Czech', G.pack_cards, nil, nil, true, true, nil, 'czech_pack')
        return newCard
    end,
    ease_background_colour = function(self)
        ease_background_colour_blind(G.STATES.CZECH_PACK)
    end,
}

-- tname compat stuff yee

SMODS.Atlas{key = "tname_boosters_sharp", path = "Team Name/tname_boosters.png", px = 71, py = 95}
SMODS.Booster {
    name = 'Ultra Czech Pack',
    key = 'czech_ultra_1',
    atlas = 'tname_boosters_sharp', pos = {x=0,y=2},
    config = { choose = 3, extra = 7 },
    discovered = true,
    cost = 0,
    credits = 100,
    weight = 0.4,
    kind = 'hpot_czech',
    group_key = 'k_hpot_czech_pack',
    hotpot_credits = {
        art = {'GoldenLeaf'},
        code = {'Revo'},
        team = {"Team Name"}
    },
    create_card = function(self, card)
        return SMODS.create_card{
			set = "Czech",
			skip_materialize = true
		}
    end,
    ease_background_colour = function(self)
        ease_background_colour_blind(G.STATES.CZECH_PACK)
    end,
}


-- VOUCHERS

SMODS.Voucher {
    key = "currency_exchange",
    config = { dollar_cost = 5, },
    unlocked = true,
    atlas = "PerkeocoinVouchers",
    pos = { x = 0, y = 0 },
    loc_vars = function(self, info_queue, card)
        return{vars={card.ability.dollar_cost}}
    end,
    hotpot_credits = {
        art = {'Omegaflowey18'},
        code = {'stupid'},
        team = {'Perkeocoin'}
    },
    redeem = function (self, card)
        G.GAME.plinko_dollars_cost = card.ability.dollar_cost

        -- Update dollar cost
        PlinkoLogic.f.change_roll_cost(G.GAME.current_round.plinko_roll_cost)

        if G.plinko then
            G.plinko:recalculate()
        end
    end
}

SMODS.Voucher {
    key = "currency_exchange2",
    atlas = "PerkeocoinVouchers",
    pos = { x = 1, y = 0 },
    config = {  },
    loc_vars = function(self, info_queue, card)
        return{vars={}}
    end,
    unlocked = true,
    hotpot_credits = {
        art = {'dottykitty'},
        code = {'stupid'},
        team = {'Perkeocoin'}
    },
    requires = {'v_hpot_currency_exchange'},
    redeem = function (self, card)
        if G.plinko then
            G.plinko:recalculate()
        end
    end
}