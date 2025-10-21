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
        self.pos = self.positions[1]
        SMODS.Consumable.register(self)
    end,
    update = function(self, card)
        if not ((card.area and card.area.config.collection) or (card.ability.immutable.selected)) then -- do not decide on values if its a collection card or values have already been set
            self:calculate_values(card)
            local values = self:value_range()
            local min = values[1]
            local max = values[2]
            local percentage = ((to_big(card.ability.extra.value) - to_big(min)) / (to_big(max) - to_big(min)));
            if percentage > to_big(0.9) then
                card.ability.immutable.selected = 1
            elseif percentage < to_big(0.1) then
                card.ability.immutable.selected = pseudorandom(pseudoseed(self.key..'_selected'), 3, 4)
            else
                card.ability.immutable.selected = 2
            end
            card:set_sprites(card.config.center)
        end
    end,
    range = {1, 3},
    value_range = function (self, card)
        return Hanafuda.calculate_value_range(card, Hanafuda.calculate_value_modification(card, self.range[1]), Hanafuda.calculate_value_modification(card, self.range[2]))
    end,
    calculate_values = function (self, card)
        local values = self:value_range()
        local min = values[1]
        local max = values[2]
        card.ability.extra.value = math.floor(to_big(pseudorandom(pseudoseed(self.key..'_value'))) * (to_big(max) - to_big(min) + 1)) + to_big(min)
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
        if card.area and (not card.area.config.collection) then
            card.children.center:set_sprite_pos(self.positions[((card.ability or {}).immutable or {}).selected or 1])
        end
    end,
	calculate = function (self, card, context)
		return joy_hanafuda_score(self.joyousspring[card.ability.immutable.selected], context)
	end
}
Hanafuda.Sticker = Hanafuda.Generic:extend {
    calculate_values = function (self, card, selected)
        Hanafuda.Generic.calculate_values(self, card, selected)
        card.ability.immutable.sticker = pseudorandom_element(self.stickers, pseudoseed(self.key..'_sticker'))
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
		return highlight_jokers_hand(HotPotato.sanity_check(hpt.value))
	end,
    use = function(self, card, area, copier)
		local hpt = card.ability.extra
		if #G.jokers.highlighted > 0 then
			for i = 1, #G.jokers.highlighted do
				apply_remove_sticker(G.jokers.highlighted[i], card.ability.immutable.sticker)
			end
		else
			for i = 1, #G.hand.highlighted do
				apply_remove_sticker(G.hand.highlighted[i], card.ability.immutable.sticker)
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
    range = {1, 5},
	can_use = function(self, card)
		local hpt = card.ability.extra
		if G.jokers and #G.jokers.cards > 0 then
			return true
		end
		return false
	end,
	use = function(self, card, area, copier)
		local hpt = card.ability.extra
		ease_dollars(hpt.value * to_big(#G.jokers.cards))
    end,
    hotpot_credits = {
		art = { "GhostSalt" },
		idea = { "Corobo" },
		code = { "Revo" },
		team = { "Team Name" },
	}
})

Hanafuda.Generic({
    key = "chrysanthemum",
    atlas = "tname_hanafuda",
    positions = {
        { x = 8, y = 0 },
        { x = 8, y = 1 },
        { x = 8, y = 2 },
        { x = 8, y = 3 },
    },
    joyousspring = {
        {"Chrysanthemum with Sake"},
        {"Chrysanthemum with Ribbon"},
        {"Chrysanthemum", "Chrysanthemum_2"},
        {"Chrysanthemum", "Chrysanthemum_2"}
    },
	can_use = function(self, card)
		local hpt = card.ability.extra
		return highlight_jokers_hand(HotPotato.sanity_check(hpt.value), true)
	end,
	use = function(self, card, area, copier)
		for i = 1, #G.jokers.highlighted do
			apply_modification(G.jokers.highlighted[i], random_modif("GOOD", card).key)
		end
        play_sound("hpot_tname_reforge")
		unhighlight_hj()
    end,
    hotpot_credits = {
		art = { "GhostSalt" },
		idea = { "Corobo" },
		code = { "Revo" },
		team = { "Team Name" },
	}
})

Hanafuda.Generic({
    key = "susuki",
    atlas = "tname_hanafuda",
    positions = {
        { x = 7, y = 0 },
        { x = 7, y = 1 },
        { x = 7, y = 2 },
        { x = 7, y = 3 },
    },
    joyousspring = {
        {"Zebra Grass with Moon"},
        {"Zebra Grass with Geese"},
        {"Zebra Grass", "Zebra Grass_2"},
        {"Zebra Grass", "Zebra Grass_2"}
    },
	can_use = function(self, card)
		local hpt = card.ability.extra
		return highlight_jokers_hand(HotPotato.sanity_check(hpt.value))
	end,
	use = function(self, card, area, copier)
		if #G.jokers.highlighted > 0 then
			for i = 1, #G.jokers.highlighted do
				local key = poll_sticker(true, G.jokers.highlighted[i])
				SMODS.Stickers[key]:apply(G.jokers.highlighted[i], true)
			end
		else
			for i = 1, #G.hand.highlighted do
				local key = poll_sticker(true, G.hand.highlighted[i])
				SMODS.Stickers[key]:apply(G.hand.highlighted[i], true)
			end
		end
        play_sound('gold_seal', 1.2, 0.4)
		unhighlight_hj()
    end,
    hotpot_credits = {
		art = { "GhostSalt" },
		idea = { "Corobo" },
		code = { "Revo" },
		team = { "Team Name" },
	}
})

Hanafuda.Generic({
    key = "iris",
    atlas = "tname_hanafuda",
    positions = {
        { x = 4, y = 0 },
        { x = 4, y = 1 },
        { x = 4, y = 2 },
        { x = 4, y = 3 },
    },
    joyousspring = {
        {"Water Iris with Bridge"},
        {"Water Iris with Ribbon"},
        {"Water Iris", "Water Iris_2"},
        {"Water Iris", "Water Iris_2"}
    },
	can_use = function(self, card)
		return false
	end,
	calculate = function(self, card, context)
		local hpt = card.ability.extra
		if context.end_of_round and context.main_eval then
			card.ability.extra_value = HotPotato.sanity_check((card.ability.extra_value or 0) + to_number(hpt.value))
			card:set_cost()
			card_eval_status_text(card, "extra", nil, nil, nil, { message = localize("k_val_up") })
		end
		return Hanafuda.Generic.calculate(self, card, context)
	end,
    hotpot_credits = {
		art = { "GhostSalt" },
		idea = { "Corobo" },
		code = { "Revo" },
		team = { "Team Name" },
	}
})

Hanafuda.Generic({
    key = "wisteria",
    atlas = "tname_hanafuda",
    positions = {
        { x = 3, y = 0 },
        { x = 3, y = 1 },
        { x = 3, y = 2 },
        { x = 3, y = 3 },
    },
    joyousspring = {
        {"Wisteria with Cuckoo"},
        {"Wisteria with Ribbon"},
        {"Wisteria", "Wisteria_2"},
        {"Wisteria", "Wisteria_2"}
    },
	can_use = function(self, card)
		local hpt = card.ability.extra
		return highlight_jokers_hand(HotPotato.sanity_check(hpt.value), true)
	end,
    use = function(self, card, area, copier)
        local is_activated = false
		for i = 1, #G.jokers.highlighted do
            local modif = get_modification(G.jokers.highlighted[i])
            if modif and HPTN.Modifications[modif].morality == "BAD" then
                is_activated = true
                HPTN.Modifications[modif]:apply(G.jokers.highlighted[i], false)
                G.jokers.highlighted[i]:juice_up()
            end
		end
        if is_activated then
            play_sound("hpot_tname_reforge")
        end
        unhighlight_hj()
    end,
    hotpot_credits = {
		art = { "GhostSalt" },
		idea = { "Corobo" },
		code = { "Revo" },
		team = { "Team Name" },
	}
})

Hanafuda.Generic({
    key = "bush_clover",
    atlas = "tname_hanafuda",
    positions = {
        { x = 6, y = 0 },
        { x = 6, y = 1 },
        { x = 6, y = 2 },
        { x = 6, y = 3 },
    },
    joyousspring = {
        {"Clover with Boar"},
        {"Clover with Ribbon"},
        {"Clover", "Clover_2"},
        {"Clover", "Clover_2"}
    },
	can_use = function(self, card)
		local hpt = card.ability.extra
		return true
	end,
	use = function(self, card, area, copier)
		local hpt = card.ability.extra
		for i = 1, HotPotato.sanity_check(hpt.value) do
			result = SMODS.add_card({
				set = "Hanafuda",
				area = G.consumeables,
				edition = "e_negative",
			})
			if result.config.center_key:find('bush_clover') then
				if tonumber(result.config.center_key:sub(-1)) < tonumber(card.config.center_key:sub(-1)) and tonumber(result.config.center_key:sub(-1)) < 3 then
					check_for_unlock({type = 'whoppers'})
				end
			end
		end
    end,
    hotpot_credits = {
		art = { "GhostSalt" },
		idea = { "Corobo" },
		code = { "Revo" },
		team = { "Team Name" },
	}
})
