SMODS.ConsumableType({
	key = "Hanafuda",
	collection_rows = { 4, 4, 4 },
	primary_colour = G.C.RED,
	secondary_colour = G.C.RED,
	shop_rate = 0.09,
})

Hanafuda = {}
function Hanafuda.calculate_value_range(card, min, max)
    return {min, max} -- don't do anything with this now this is just a hook point
end
function Hanafuda.calculate_value_modification(card, initial_value)
    return initial_value -- don't do anything with this now this is just a hook point
end
Hanafuda.Generic = SMODS.Consumable:extend {
    config = {
        extra = {},
        immutable = {}
    },
    set = "Hanafuda",
    register = function(self)
        self.pos = self.positions[#self.positions]
        SMODS.Consumable.register(self)
    end,
    add_to_deck = function(self, card, from_debuff)
        if not ((card.area and card.area.config.collection) or (card.ability.immutable.selected)) then -- do not decide on values if its a collection card or values have already been set
            self:calculate_values(card)
            local values = self:value_range()
            local min = values[1]
            local max = values[2]
            local percentage = ((card.ability.extra.value - min) / (max - min));
            local value = math.floor((percentage * 2) + 1)
            if value == 1 then
                card.ability.immutable.selected = pseudorandom(pseudoseed(card.key..'_selected'), 1, 2)
            elseif value == 2 then
                card.ability.immutable.selected = 3
            else
                card.ability.immutable.selected = 4
            end
            card:set_sprites(card.config.center)
        end
    end,
    value_range = function (self, card)
        return Hanafuda.calculate_value_range(card, Hanafuda.calculate_value_modification(card, 1), Hanafuda.calculate_value_modification(card, 3))
    end,
    calculate_values = function (self, card)
        local values = self:value_range()
        local min = values[1]
        local max = values[2]
        card.ability.extra.value = pseudorandom(pseudoseed(card.key..'_value'), min, max)
    end,
    loc_vars = function (self, info_queue, card)
        local value = card.ability.extra.value;
        if not value then -- value will not be set if its a collection card
            value = self:value_range()
            value = value[1] .. '-' .. value[2]
        end
        return {
            key = self.key .. '_' .. (card.ability.immutable.selected or 'generic'),
            vars = {
                value
            }
        }
    end,
    set_sprites = function (self, card, front)
        card.children.center:set_sprite_pos(self.positions[((card.ability or {}).immutable or {}).selected or 1])
    end,
	calculate = function (self, card, context)
		return joy_hanafuda_score(self.joyousspring[card.ability.immutable.selected], context)
	end
}
Hanafuda.Sticker = Hanafuda.Generic:extend {
    calculate_values = function (self, card, selected)
        Hanafuda.Generic.calculate_values(self, card, selected)
        card.ability.immutable.sticker = pseudorandom_element(self.stickers, pspseudoseed(card.key..'_sticker'))
    end,
    loc_vars = function (self, info_queue, card)
        if card.ability.immutable.sticker then
            local config = {}
            if SMODS.Stickers[card.ability.immutable.sticker].loc_vars then
                config = SMODS.Stickers[card.ability.immutable.sticker]:loc_vars(info_queue, card)
            end
            config.key = config.key or card.ability.immutable.sticker;
            config.set = config.set or "Other"
            config.vars = config.vars or {}
            info_queue[#info_queue + 1] = config
        else
            -- this is generic case;
            local stickers = {}
            for i, sticker in ipairs(self.stickers) do
                if (not stickers[sticker]) then
                    local config = {}
                    if SMODS.Stickers[sticker].loc_vars then
                        config = SMODS.Stickers[sticker]:loc_vars(info_queue, card)
                    end
                    config.key = config.key or sticker;
                    config.set = config.set or "Other"
                    config.vars = config.vars or {}
                    info_queue[#info_queue + 1] = config
                    stickers[sticker] = true
                end
            end
        end
        return Hanafuda.Generic.loc_vars(self, info_queue, card)
    end,
	can_use = function(self, card)
		local hpt = card.ability.extra
		return highlight_jokers_hand(hpt.value)
	end,
    use = function(self, card, area, copier)
		local hpt = card.ability.extra
		if #G.jokers.highlighted > 0 then
			for i = 1, #G.jokers.highlighted do
				apply_remove_sticker(G.jokers.highlighted[i], "hpot_uranium")
			end
		else
			for i = 1, #G.hand.highlighted do
				apply_remove_sticker(G.hand.highlighted[i], "hpot_uranium")
			end
		end
        play_sound('gold_seal', 1.2, 0.4)
		unhighlight_hj()
	end,
}

Hanafuda.Sticker({
    key = "pine",
    atlas = "tname_hanafuda",
    positions = {
        { x = 0, y = 0 },
        { x = 0, y = 1 },
        { x = 0, y = 2 },
        { x = 0, y = 3 },
    },
    joyousspring = {
        {"Pine with Crane"},
        {"Pine with Ribbon"},
        {"Pine", "Pine_2"},
        {"Pine", "Pine_2"}
    },
    stickers = {
        "hpot_fragile",
        "hpot_fragile",
        "hpot_uranium",
        "hpot_uranium",
    },
    hotpot_credits = {
        art = { "GhostSalt" },
        idea = { "Corobo" },
        code = { "Revo" },
        team = { "Team Name" },
    }
})

Hanafuda.Sticker({
    key = "willow",
    atlas = "tname_hanafuda",
    positions = {
        { x = 10, y = 0 },
        { x = 10, y = 1 },
        { x = 10, y = 2 },
        { x = 10, y = 3 },
    },
    stickers = {
        "hpot_redirect",
        "hpot_redirect",
        "hpot_cannibal",
        "hpot_cannibal",
    },
    joyousspring = {
        {"Willow with Calligrapher"},
        {"Willow with Swallow"},
        {"Willow with Ribbon"},
        {"Willow"}
    },
    hotpot_credits = {
		art = { "GhostSalt" },
		idea = { "Corobo" },
		code = { "Revo" },
		team = { "Team Name" },
	}
})

Hanafuda.Sticker({
    key = "sakura",
    atlas = "tname_hanafuda",
    positions = {
        { x = 2, y = 0 },
        { x = 2, y = 1 },
        { x = 2, y = 2 },
        { x = 2, y = 3 },
    },
    stickers = {
        "hpot_cfour",
        "hpot_cfour",
        "hpot_overclock",
        "hpot_overclock",
    },
    joyousspring = {
        {"Cherry Blossom with Curtain"},
        {"Cherry Blossom with Ribbon"},
        {"Cherry Blossom", "Cherry Blossom_2"},
        {"Cherry Blossom", "Cherry Blossom_2"}
    },
    hotpot_credits = {
		art = { "GhostSalt" },
		idea = { "Corobo" },
		code = { "Revo" },
		team = { "Team Name" },
	}
})

Hanafuda.Sticker({
    key = "paulownia",
    atlas = "tname_hanafuda",
    positions = {
        { x = 11, y = 0 },
        { x = 11, y = 1 },
        { x = 11, y = 2 },
        { x = 11, y = 3 },
    },
    stickers = {
        "hpot_overclock",
        "hpot_overclock",
        "hpot_rage",
        "hpot_rage",
    },
    joyousspring = {
        {"Paulownia with Phoenix"},
        {"Paulownia", "Paulownia_2", "Paulownia_3"},
        {"Paulownia", "Paulownia_2", "Paulownia_3"},
        {"Paulownia", "Paulownia_2", "Paulownia_3"}
    },
    hotpot_credits = {
		art = { "GhostSalt" },
		idea = { "Corobo" },
		code = { "Revo" },
		team = { "Team Name" },
	}
})

Hanafuda.Sticker({
    key = "peony",
    atlas = "tname_hanafuda",
    positions = {
        { x = 5, y = 0 },
        { x = 5, y = 1 },
        { x = 5, y = 2 },
        { x = 5, y = 3 },
    },
    stickers = {
        "hpot_spinning",
        "hpot_spinning",
        "hpot_binary",
        "hpot_binary",
    },
    joyousspring = {
        {"Peony with Butterfly"},
        {"Peony with Ribbon"},
        {"Peony", "Peony_2"},
        {"Peony", "Peony_2"}
    },
    hotpot_credits = {
		art = { "GhostSalt" },
		idea = { "Corobo" },
		code = { "Revo" },
		team = { "Team Name" },
	}
})


Hanafuda.Generic({
    key = "maple",
    atlas = "tname_hanafuda",
    positions = {
        { x = 9, y = 0 },
        { x = 9, y = 1 },
        { x = 9, y = 2 },
        { x = 9, y = 3 },
    },
    joyousspring = {
        {"Maple with Deer"},
        {"Maple with Ribbon"},
        {"Maple", "Maple_2"},
        {"Maple", "Maple_2"}
    },
	can_use = function(self, card)
		local hpt = card.ability.extra
		if G.jokers and #G.jokers.cards > 0 then
			return true
		end
		return false
	end,
	use = function(self, card, area, copier)
		local hpt = card.ability.extra
		ease_dollars(hpt.value * #G.jokers.cards)
    end,
    hotpot_credits = {
		art = { "GhostSalt" },
		idea = { "Corobo" },
		code = { "Revo" },
		team = { "Team Name" },
	}
})
