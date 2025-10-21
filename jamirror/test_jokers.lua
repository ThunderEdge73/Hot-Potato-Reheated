SMODS.Joker {
    key = "hanafuda_value_mod",
    rarity = 3,
    blueprint_compat = true,
    cost = 7,
    atlas = "smiley_jokers",
    pos = {x=2,y=0},
    hotpot_credits = {
        idea = {"jamirror"},
        code = {"jamirror"},
        team = {"Nonemongus"}
    },
    calculate = function(self, card, context)
        if context.hanafuda_mod_value then
            return {
                value = context.value + 1
            }
        end
    end
}
SMODS.Joker {
    key = "hanafuda_value_set",
    rarity = 3,
    blueprint_compat = true,
    cost = 7,
    atlas = "smiley_jokers",
    pos = {x=2,y=0},
    hotpot_credits = {
        idea = {"jamirror"},
        code = {"jamirror"},
        team = {"Nonemongus"}
    },
    calculate = function(self, card, context)
        if context.hanafuda_set_value then
            return {
                value = 0
            }
        end
    end
}
SMODS.Joker {
    key = "hanafuda_range_mod",
    rarity = 3,
    blueprint_compat = true,
    cost = 7,
    atlas = "smiley_jokers",
    pos = {x=2,y=0},
    hotpot_credits = {
        idea = {"jamirror"},
        code = {"jamirror"},
        team = {"Nonemongus"}
    },
    calculate = function(self, card, context)
        if context.hanafuda_mod_value_range then
            return {
                max = context.max + 1,
                min = context.min - 1
            }
        end
    end
}
SMODS.Joker {
    key = "hanafuda_range_set",
    rarity = 3,
    blueprint_compat = true,
    cost = 7,
    atlas = "smiley_jokers",
    pos = {x=2,y=0},
    hotpot_credits = {
        idea = {"jamirror"},
        code = {"jamirror"},
        team = {"Nonemongus"}
    },
    calculate = function(self, card, context)
        if context.hanafuda_set_value_range then
            return {
                min = 3,
                max = 7,
            }
        end
    end
}