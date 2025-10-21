
-- currecntly hanafuda cards cannot apply to both jokers and hand cards

function highlight_jokers_hand(val, jokers_only, hand_only)
	local joker_check, hand_check, check = nil, nil, nil

	local ret = false

	if G.jokers and G.jokers.highlighted and (#G.jokers.highlighted <= val and #G.jokers.highlighted > 0) then
		joker_check = true
		check = true
	end

	if G.hand and G.hand.highlighted and (#G.hand.highlighted <= val and #G.hand.highlighted > 0) then
		hand_check = true
		check = true
	end

	if jokers_only then
		if joker_check then
			ret = true
		end
	elseif hand_only then
		if hand_check then
			ret = true
		end
	elseif check then
		ret = true
	end

	return ret
end

function unhighlight_hj()
	G.jokers:unhighlight_all()
	G.hand:unhighlight_all()
end

function apply_remove_sticker(card, sticker)
	if card[sticker] or card.ability[sticker] then
		SMODS.Stickers[sticker]:apply(card, false)
	else
		SMODS.Stickers[sticker]:apply(card, true)
	end
end

-- joyous :3
function joy_hanafuda_score(types, context)
    if JoyousSpring then
        if context.individual and context.cardarea == G.play then
            local _, key = JoyousSpring.get_hanafuda(context.other_card)

			for _, hanafuda_type in ipairs(types) do
				if key == hanafuda_type then
					return {
						xchips = 1.5
					}
				end
			end
		end
	end
end

-- Chrysanthemum

SMODS.Consumable({
	key = "chrysanthemum_1",
	pos = {x = 8, y = 0},
	atlas = "tname_hanafuda",
	set = "Hanafuda",
	hotpot_credits = {
		art = { "GhostSalt" },
		idea = { "Corobo" },
		code = { "Revo" },
		team = { "Team Name" },
	},

	config = {
		extra = {
			high = 3,
		},
	},
	loc_vars = function(self, info_queue, card)
		local hpt = card.ability.extra
		return {
			vars = { hpt.high },
		}
	end,
	can_use = function(self, card)
		local hpt = card.ability.extra
		return highlight_jokers_hand(hpt.high, true)
	end,
	use = function(self, card, area, copier)
		for i = 1, #G.jokers.highlighted do
			apply_modification(G.jokers.highlighted[i], random_modif("GOOD", card).key)
		end
        play_sound("hpot_tname_reforge")
		unhighlight_hj()
    end,
	calculate = function (self, card, context)
		return joy_hanafuda_score({"Chrysanthemum with Sake"}, context)
	end
})

SMODS.Consumable({
	key = "chrysanthemum_2",
	pos = {x = 8, y = 1},
	atlas = "tname_hanafuda",
	set = "Hanafuda",
	hotpot_credits = {
		art = { "GhostSalt" },
		idea = { "Corobo" },
		code = { "Revo" },
		team = { "Team Name" },
	},

	config = {
		extra = {
			high = 2,
		},
	},
	loc_vars = function(self, info_queue, card)
		local hpt = card.ability.extra
		return {
			vars = { hpt.high },
		}
	end,
	can_use = function(self, card)
		local hpt = card.ability.extra
		return highlight_jokers_hand(hpt.high, true)
	end,
	use = function(self, card, area, copier)
		for i = 1, #G.jokers.highlighted do
			apply_modification(G.jokers.highlighted[i], random_modif("GOOD", card).key)
		end
        play_sound("hpot_tname_reforge")
		unhighlight_hj()
    end,
	calculate = function (self, card, context)
		return joy_hanafuda_score({"Chrysanthemum with Ribbon"}, context)
	end
})

SMODS.Consumable({
	key = "chrysanthemum_3",
	pos = {x = 8, y = 2},
	atlas = "tname_hanafuda",
	set = "Hanafuda",
	hotpot_credits = {
		art = { "GhostSalt" },
		idea = { "Corobo" },
		code = { "Revo" },
		team = { "Team Name" },
	},

	config = {
		extra = {
			high = 1,
		},
	},
	loc_vars = function(self, info_queue, card)
		local hpt = card.ability.extra
		return {
			vars = { hpt.high },
		}
	end,
	can_use = function(self, card)
		local hpt = card.ability.extra
		return highlight_jokers_hand(hpt.high, true)
	end,
	use = function(self, card, area, copier)
		for i = 1, #G.jokers.highlighted do
			apply_modification(G.jokers.highlighted[i], random_modif("GOOD", card).key)
		end
        play_sound("hpot_tname_reforge")
		unhighlight_hj()
    end,
	calculate = function (self, card, context)
		return joy_hanafuda_score({"Chrysanthemum", "Chrysanthemum_2"}, context)
	end
})

SMODS.Consumable({
	key = "chrysanthemum_4",
	pos = {x = 8, y = 3},
	atlas = "tname_hanafuda",
	set = "Hanafuda",
	hotpot_credits = {
		art = { "GhostSalt" },
		idea = { "Corobo" },
		code = { "Revo" },
		team = { "Team Name" },
	},

	config = {
		extra = {
			high = 1,
		},
	},
	loc_vars = function(self, info_queue, card)
		local hpt = card.ability.extra
		return {
			vars = { hpt.high },
		}
	end,
	can_use = function(self, card)
		local hpt = card.ability.extra
		return highlight_jokers_hand(hpt.high, true)
	end,
	use = function(self, card, area, copier)
		for i = 1, #G.jokers.highlighted do
			apply_modification(G.jokers.highlighted[i], random_modif("GOOD", card).key)
		end
        play_sound("hpot_tname_reforge")
		unhighlight_hj()
    end,
	calculate = function (self, card, context)
		return joy_hanafuda_score({"Chrysanthemum", "Chrysanthemum_2"}, context)
	end
})

-- SUSUKI

SMODS.Consumable({
	key = "susuki_1",
	pos = {x = 7, y = 0},
	atlas = "tname_hanafuda",
	set = "Hanafuda",
	hotpot_credits = {
		art = { "GhostSalt" },
		idea = { "Corobo" },
		code = { "Revo" },
		team = { "Team Name" },
	},

	config = {
		extra = {
			high = 3,
		},
	},
	loc_vars = function(self, info_queue, card)
		local hpt = card.ability.extra
		return {
			vars = { hpt.high },
		}
	end,
	can_use = function(self, card)
		local hpt = card.ability.extra
		return highlight_jokers_hand(hpt.high)
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
	calculate = function (self, card, context)
		return joy_hanafuda_score({"Zebra Grass with Moon"}, context)
	end
})

SMODS.Consumable({
	key = "susuki_2",
	pos = {x = 7, y = 1},
	atlas = "tname_hanafuda",
	set = "Hanafuda",
	hotpot_credits = {
		art = { "GhostSalt" },
		idea = { "Corobo" },
		code = { "Revo" },
		team = { "Team Name" },
	},

	config = {
		extra = {
			high = 2,
		},
	},
	loc_vars = function(self, info_queue, card)
		local hpt = card.ability.extra
		return {
			vars = { hpt.high },
		}
	end,
	can_use = function(self, card)
		local hpt = card.ability.extra
		return highlight_jokers_hand(hpt.high)
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
	calculate = function (self, card, context)
		return joy_hanafuda_score({"Zebra Grass with Geese"}, context)
	end
})

SMODS.Consumable({
	key = "susuki_3",
	pos = {x = 7, y = 2},
	atlas = "tname_hanafuda",
	set = "Hanafuda",
	hotpot_credits = {
		art = { "GhostSalt" },
		idea = { "Corobo" },
		code = { "Revo" },
		team = { "Team Name" },
	},

	config = {
		extra = {
			high = 1,
		},
	},
	loc_vars = function(self, info_queue, card)
		local hpt = card.ability.extra
		return {
			vars = { hpt.high },
		}
	end,
	can_use = function(self, card)
		local hpt = card.ability.extra
		return highlight_jokers_hand(hpt.high)
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
	calculate = function (self, card, context)
		return joy_hanafuda_score({"Zebra Grass", "Zebra Grass_2"}, context)
	end
})

SMODS.Consumable({
	key = "susuki_4",
	pos = {x = 7, y = 3},
	atlas = "tname_hanafuda",
	set = "Hanafuda",
	hotpot_credits = {
		art = { "GhostSalt" },
		idea = { "Corobo" },
		code = { "Revo" },
		team = { "Team Name" },
	},

	config = {
		extra = {
			high = 1,
		},
	},
	loc_vars = function(self, info_queue, card)
		local hpt = card.ability.extra
		return {
			vars = { hpt.high },
		}
	end,
	can_use = function(self, card)
		local hpt = card.ability.extra
		return highlight_jokers_hand(hpt.high)
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
	calculate = function (self, card, context)
		return joy_hanafuda_score({"Zebra Grass", "Zebra Grass_2"}, context)
	end
})

-- IRIS

SMODS.Consumable({
	key = "iris_1",
	pos = {x = 4, y = 0},
	atlas = "tname_hanafuda",
	set = "Hanafuda",
	hotpot_credits = {
		art = { "GhostSalt" },
		idea = { "Corobo" },
		code = { "Revo" },
		team = { "Team Name" },
	},

	config = {
		extra = {
			high = 3,
		},
	},
	loc_vars = function(self, info_queue, card)
		local hpt = card.ability.extra
		return {
			vars = { hpt.high },
		}
	end,
	can_use = function(self, card)
		local hpt = card.ability.extra
		return false
	end,
	calculate = function(self, card, context)
		local hpt = card.ability.extra
        if context.end_of_round and context.main_eval then
            card.ability.extra_value = (card.ability.extra_value or 0) + hpt.high 
            card:set_cost()
			card_eval_status_text(card, "extra", nil, nil, nil, { message = localize("k_val_up") })
        end
		return joy_hanafuda_score({"Water Iris with Bridge"}, context)
	end,
})

SMODS.Consumable({
	key = "iris_2",
	pos = {x = 4, y = 1},
	atlas = "tname_hanafuda",
	set = "Hanafuda",
	hotpot_credits = {
		art = { "GhostSalt" },
		idea = { "Corobo" },
		code = { "Revo" },
		team = { "Team Name" },
	},

	config = {
		extra = {
			high = 2,
		},
	},
	loc_vars = function(self, info_queue, card)
		local hpt = card.ability.extra
		return {
			vars = { hpt.high },
		}
	end,
	can_use = function(self, card)
		local hpt = card.ability.extra
		return false
	end,
	calculate = function(self, card, context)
		local hpt = card.ability.extra
        if context.end_of_round and context.main_eval then
            card.ability.extra_value = (card.ability.extra_value or 0) + hpt.high 
            card:set_cost()
			card_eval_status_text(card, "extra", nil, nil, nil, { message = localize("k_val_up") })
        end
		return joy_hanafuda_score({"Water Iris with Ribbon"}, context)
	end,
})

SMODS.Consumable({
	key = "iris_3",
	pos = {x = 4, y = 2},
	atlas = "tname_hanafuda",
	set = "Hanafuda",
	hotpot_credits = {
		art = { "GhostSalt" },
		idea = { "Corobo" },
		code = { "Revo" },
		team = { "Team Name" },
	},

	config = {
		extra = {
			high = 1,
		},
	},
	loc_vars = function(self, info_queue, card)
		local hpt = card.ability.extra
		return {
			vars = { hpt.high },
		}
	end,
	can_use = function(self, card)
		local hpt = card.ability.extra
		return false
	end,
	calculate = function(self, card, context)
		local hpt = card.ability.extra
        if context.end_of_round and context.main_eval then
            card.ability.extra_value = (card.ability.extra_value or 0) + hpt.high 
            card:set_cost()
			card_eval_status_text(card, "extra", nil, nil, nil, { message = localize("k_val_up") })
        end
		return joy_hanafuda_score({"Water Iris", "Water Iris_2"}, context)
	end,
})

SMODS.Consumable({
	key = "iris_4",
	pos = {x = 4, y = 3},
	atlas = "tname_hanafuda",
	set = "Hanafuda",
	hotpot_credits = {
		art = { "GhostSalt" },
		idea = { "Corobo" },
		code = { "Revo" },
		team = { "Team Name" },
	},

	config = {
		extra = {
			high = 1,
		},
	},
	loc_vars = function(self, info_queue, card)
		local hpt = card.ability.extra
		return {
			vars = { hpt.high },
		}
	end,
	can_use = function(self, card)
		local hpt = card.ability.extra
		return false
	end,
	calculate = function(self, card, context)
		local hpt = card.ability.extra
		if context.end_of_round and context.main_eval then
			card.ability.extra_value = (card.ability.extra_value or 0) + hpt.high 
			card:set_cost()
			card_eval_status_text(card, "extra", nil, nil, nil, { message = localize("k_val_up") })
		end
		return joy_hanafuda_score({"Water Iris", "Water Iris_2"}, context)
	end,
})

-- WISTERIA

SMODS.Consumable({
	key = "wisteria_1",
	pos = {x = 3, y = 0},
	atlas = "tname_hanafuda",
	set = "Hanafuda",
	hotpot_credits = {
		art = { "GhostSalt" },
		idea = { "Corobo" },
		code = { "Revo" },
		team = { "Team Name" },
	},

	config = {
		extra = {
			high = 3,
		},
	},
	loc_vars = function(self, info_queue, card)
		local hpt = card.ability.extra
		return {
			vars = { hpt.high },
		}
	end,
	can_use = function(self, card)
		local hpt = card.ability.extra
		return highlight_jokers_hand(hpt.high, true)
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
	calculate = function (self, card, context)
		return joy_hanafuda_score({"Wisteria with Cuckoo"}, context)
	end
})

SMODS.Consumable({
	key = "wisteria_2",
	pos = {x = 3, y = 1},
	atlas = "tname_hanafuda",
	set = "Hanafuda",
	hotpot_credits = {
		art = { "GhostSalt" },
		idea = { "Corobo" },
		code = { "Revo" },
		team = { "Team Name" },
	},

	config = {
		extra = {
			high = 2,
		},
	},
	loc_vars = function(self, info_queue, card)
		local hpt = card.ability.extra
		return {
			vars = { hpt.high },
		}
	end,
	can_use = function(self, card)
		local hpt = card.ability.extra
		return highlight_jokers_hand(hpt.high, true)
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
	calculate = function (self, card, context)
		return joy_hanafuda_score({"Wisteria with Ribbon"}, context)
	end
})

SMODS.Consumable({
	key = "wisteria_3",
	pos = {x = 3, y = 2},
	atlas = "tname_hanafuda",
	set = "Hanafuda",
	hotpot_credits = {
		art = { "GhostSalt" },
		idea = { "Corobo" },
		code = { "Revo" },
		team = { "Team Name" },
	},

	config = {
		extra = {
			high = 1,
		},
	},
	loc_vars = function(self, info_queue, card)
		local hpt = card.ability.extra
		return {
			vars = { hpt.high },
		}
	end,
	can_use = function(self, card)
		local hpt = card.ability.extra
		return highlight_jokers_hand(hpt.high, true)
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
	calculate = function (self, card, context)
		return joy_hanafuda_score({"Wisteria", "Wisteria_2"}, context)
	end
})

SMODS.Consumable({
	key = "wisteria_4",
	pos = {x = 3, y = 3},
	atlas = "tname_hanafuda",
	set = "Hanafuda",
	hotpot_credits = {
		art = { "GhostSalt" },
		idea = { "Corobo" },
		code = { "Revo" },
		team = { "Team Name" },
	},

	config = {
		extra = {
			high = 1,
		},
	},
	loc_vars = function(self, info_queue, card)
		local hpt = card.ability.extra
		return {
			vars = { hpt.high },
		}
	end,
	can_use = function(self, card)
		local hpt = card.ability.extra
		return highlight_jokers_hand(hpt.high, true)
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
	calculate = function (self, card, context)
		return joy_hanafuda_score({"Wisteria", "Wisteria_2"}, context)
	end
})

-- BUSH CLOVER

SMODS.Consumable({
	key = "bush_clover_1",
	pos = {x = 6, y = 0},
	atlas = "tname_hanafuda",
	set = "Hanafuda",
	hotpot_credits = {
		art = { "GhostSalt" },
		idea = { "Corobo" },
		code = { "Revo" },
		team = { "Team Name" },
	},

	config = {
		extra = {
			high = 3,
		},
	},
	loc_vars = function(self, info_queue, card)
		local hpt = card.ability.extra
		return {
			vars = { hpt.high },
		}
	end,
	can_use = function(self, card)
		local hpt = card.ability.extra
		return true
	end,
	use = function(self, card, area, copier)
		local hpt = card.ability.extra
		for i = 1, hpt.high do
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
	calculate = function (self, card, context)
		return joy_hanafuda_score({"Clover with Boar"}, context)
	end
})
SMODS.Consumable({
	key = "bush_clover_2",
	pos = {x = 6, y = 1},
	atlas = "tname_hanafuda",
	set = "Hanafuda",
	hotpot_credits = {
		art = { "GhostSalt" },
		idea = { "Corobo" },
		code = { "Revo" },
		team = { "Team Name" },
	},

	config = {
		extra = {
			high = 2,
		},
	},
	loc_vars = function(self, info_queue, card)
		local hpt = card.ability.extra
		return {
			vars = { hpt.high },
		}
	end,
	can_use = function(self, card)
		local hpt = card.ability.extra
		return true
	end,
	use = function(self, card, area, copier)
		local hpt = card.ability.extra
		for i = 1, hpt.high do
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
	calculate = function (self, card, context)
		return joy_hanafuda_score({"Clover with Ribbon"}, context)
	end
})
SMODS.Consumable({
	key = "bush_clover_3",
	pos = {x = 6, y = 2},
	atlas = "tname_hanafuda",
	set = "Hanafuda",
	hotpot_credits = {
		art = { "GhostSalt" },
		idea = { "Corobo" },
		code = { "Revo" },
		team = { "Team Name" },
	},

	config = {
		extra = {
			high = 1,
		},
	},
	loc_vars = function(self, info_queue, card)
		local hpt = card.ability.extra
		return {
			vars = { hpt.high },
		}
	end,
	can_use = function(self, card)
		local hpt = card.ability.extra
		return true
	end,
	use = function(self, card, area, copier)
		local hpt = card.ability.extra
		for i = 1, hpt.high do
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
	calculate = function (self, card, context)
		return joy_hanafuda_score({"Clover", "Clover_2"}, context)
	end
})
SMODS.Consumable({
	key = "bush_clover_4",
	pos = {x = 6, y = 3},
	atlas = "tname_hanafuda",
	set = "Hanafuda",
	hotpot_credits = {
		art = { "GhostSalt" },
		idea = { "Corobo" },
		code = { "Revo" },
		team = { "Team Name" },
	},

	config = {
		extra = {
			high = 1,
		},
	},
	loc_vars = function(self, info_queue, card)
		local hpt = card.ability.extra
		return {
			vars = { hpt.high },
		}
	end,
	can_use = function(self, card)
		local hpt = card.ability.extra
		return true
	end,
	use = function(self, card, area, copier)
        local result
		local hpt = card.ability.extra
		for i = 1, hpt.high do
            G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay = 0.4,
                func = function()
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
                    return true
                end,
            }))
		end
    end,
	calculate = function (self, card, context)
		return joy_hanafuda_score({"Clover", "Clover_2"}, context)
	end
})

