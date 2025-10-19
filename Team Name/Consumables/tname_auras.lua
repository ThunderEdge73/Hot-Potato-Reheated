SMODS.ConsumableType({
	key = "Aura",
	collection_rows = { 4, 4 },
	primary_colour = G.C.GREY,
	secondary_colour = G.C.GREY,
	shop_rate = nil,
})

SMODS.Atlas { key = "tname_auras", path = "Team Name/tname_auras.png", px = 71, py = 95 }

SMODS.Consumable({
	key = "justice",
	set = "Aura",
	atlas = "tname_auras",
	pos = {
		x = 0,
		y = 0
	},
	hotpot_credits = {
		art = { "GoldenLeaf" },
		idea = { "GoldenLeaf" },
		code = { "GoldenLeaf" },
		team = { "Team Name" },
	},
	config = {
		extra = {
			credits = 70
		},
	},
	loc_vars = function(self, info_queue, card)
		local key
		local fucking = G.GAME.seeded and "_budget" or ""
		key = (self.key .. fucking)
		local hpt = card.ability.extra
		return {
			vars = { hpt.credits },
			key = key
		}
	end,
	can_use = function(self, card)
		return G.jokers and #G.jokers.cards < G.jokers.config.card_limit
	end,
	use = function(self, card, area, copier)
		local hpt = card.ability.extra
		G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('timpani')
                local added = SMODS.add_card({ set = 'Joker' })
				added:set_eternal(true);
                card:juice_up(0.3, 0.5)
                return true
            end
        }))
        delay(0.6)
		G.E_MANAGER:add_event(Event({
			func = function()
				HPTN.ease_credits(hpt.credits, false)
				return true
			end,
		}))
	end,
})

SMODS.Consumable({
	key = "fear",
	set = "Aura",
	atlas = "tname_auras",
	pos = {
		x = 1,
		y = 0
	},
	hotpot_credits = {
		art = { "GoldenLeaf" },
		idea = { "GoldenLeaf" },
		code = { "GoldenLeaf" },
		team = { "Team Name" },
	},
	config = {
		extra = {
			credits = 30
		},
	},
	loc_vars = function(self, info_queue, card)
		local key
		local fucking = G.GAME.seeded and "_budget" or ""
		key = (self.key .. fucking)
		local hpt = card.ability.extra
		return {
			vars = { hpt.credits },
			key = key
		}
	end,
	can_use = function(self, card)
		return true
	end,
	use = function(self, card, area, copier)
		local hpt = card.ability.extra
		local badstickers = {
			"eternal",
			"perishable",
			"rental",
			"hpot_cfour",
			"hpot_spinning",
			"hpot_uranium",
			"hpot_nuke",
			"hpot_spores",
			"hpot_rage"
		}
		local function g(joker)
			local appliedsticker = pseudorandom_element(badstickers, "fuck")
			if joker.ability[appliedsticker] then
				return g(joker)
			else
				return appliedsticker
			end
		end
		for k, v in ipairs(G.jokers.cards) do
			G.E_MANAGER:add_event(Event({
				trigger = 'after',
				delay = 0.2,
				func = function()
					SMODS.Stickers[g(v)]:apply(v, true)
					v:juice_up()
					play_sound('card1')
					HPTN.ease_credits(hpt.credits)
					return true
				end
			}))
		end
	end,
})

SMODS.Consumable({
	key = "perception",
	set = "Aura",
	atlas = "tname_auras",
	pos = {
		x = 2,
		y = 0
	},
	hotpot_credits = {
		art = { "GoldenLeaf" },
		idea = { "GoldenLeaf" },
		code = { "GoldenLeaf" },
		team = { "Team Name" },
	},
	config = {
		extra = {
			leavinghands = 1,
			credits = 30
		},
	},
	loc_vars = function(self, info_queue, card)
		local key
		local fucking = G.GAME.seeded and "_budget" or ""
		key = (self.key .. fucking)
		local hpt = card.ability.extra
		return {
			vars = { hpt.leavinghands, hpt.credits, hpt.leavinghands > 1 and "s" or ""},
			key = key
		}
	end,
	can_use = function(self, card)
		if G.GAME.round_resets.hands <= card.ability.extra.leavinghands then
			return false
		else
			return true
		end
	end,
	use = function(self, card, area, copier)
		local hpt = card.ability.extra
		G.E_MANAGER:add_event(Event({
			func = function()
				G.GAME.round_resets.hands = G.GAME.round_resets.hands - hpt.leavinghands
				ease_hands_played(- hpt.leavinghands)
				return true
			end,
		}))
		G.E_MANAGER:add_event(Event({
			func = function()
				HPTN.ease_credits(hpt.leavinghands * hpt.credits, false)
				return true
			end,
		}))
	end,
})

SMODS.Consumable({
	key = "greatness",
	set = "Aura",
	atlas = "tname_auras",
	pos = {
		x = 3,
		y = 0
	},
	hotpot_credits = {
		art = { "GoldenLeaf" },
		idea = { "GoldenLeaf" },
		code = { "GoldenLeaf" },
		team = { "Team Name" },
	},
	config = {
		extra = {
			credits = 3
		},
	},
	loc_vars = function(self, info_queue, card)
		local key
		local fucking = G.GAME.seeded and "_budget" or ""
		key = (self.key .. fucking)
		local hpt = card.ability.extra
		return {
			vars = { hpt.credits },
			key = key
		}
	end,
	can_use = function(self, card)
		return G.GAME.dollars ~= 0
	end,
	use = function(self, card, area, copier)
		local hpt = card.ability.extra
		local g = G.GAME.dollars
		ease_dollars(-G.GAME.dollars, true)
		HPTN.ease_credits(math.floor(hpt.credits * g), false)
	end,
})

SMODS.Consumable({
	key = "clairvoyance",
	set = "Aura",
	atlas = "tname_auras",
	pos = {
		x = 0,
		y = 1
	},
	hotpot_credits = {
		art = { "GoldenLeaf" },
		idea = { "GoldenLeaf" },
		code = { "GoldenLeaf" },
		team = { "Team Name" },
	},
	config = {
		extra = {
			slots = 1,
			credits = 40
		},
	},
	loc_vars = function(self, info_queue, card)
		local key
		local fucking = G.GAME.seeded and "_budget" or ""
		key = (self.key .. fucking)
		local hpt = card.ability.extra
		return {
			vars = { hpt.slots, hpt.credits },
			key = key
		}
	end,
	can_use = function(self, card)
		return G.consumeables.config.card_limit - card.ability.extra.slots >= 0
	end,
	use = function(self, card, area, copier)
		local hpt = card.ability.extra
		G.E_MANAGER:add_event(Event({
			func = function()
				if G.consumeables then
					G.consumeables.config.card_limit = G.consumeables.config.card_limit - card.ability.extra.slots
				end
				HPTN.ease_credits(hpt.slots * hpt.credits)
				return true
			end,
		}))
	end,
})

SMODS.Consumable({
	key = "tenacity",
	set = "Aura",
	atlas = "tname_auras",
	pos = {
		x = 1,
		y = 1
	},
	hotpot_credits = {
		art = { "GoldenLeaf" },
		idea = { "GoldenLeaf" },
		code = { "GoldenLeaf" },
		team = { "Team Name" },
	},
	config = {
		extra = {
			max = 250,
			credits = 2
		},
	},
	loc_vars = function(self, info_queue, card)
		local key
		local fucking = G.GAME.seeded and "_budget" or ""
		key = (self.key .. fucking)
		local hpt = card.ability.extra
		return {
			vars = { hpt.max, hpt.credits },
			key = key
		}
	end,
	can_use = function(self, card)
		return #G.jokers.cards > 0
	end,
	use = function(self, card, area, copier) 
		for i = 1, #G.jokers.cards do
			SMODS.Stickers.hpot_overclock:apply(G.jokers.cards[i], true)   
        end
		local hpt = card.ability.extra
		local retval = math.min(hpt.max, (hpt.credits - 1) * (G.GAME.seeded and G.GAME.budget or G.PROFILES[G.SETTINGS.profile].TNameCredits))
		HPTN.ease_credits(retval, false)
	end,
})

SMODS.Consumable({
	key = "lunacy",
	set = "Aura",
	atlas = "tname_auras",
	pos = {
		x = 2,
		y = 1
	},
	hotpot_credits = {
		art = { "GoldenLeaf" },
		idea = { "GoldenLeaf" },
		code = { "GoldenLeaf" },
		team = { "Team Name" },
	},
	config = {
		extra = {
			credits = 1
		},
	},
	loc_vars = function(self, info_queue, card)
		local key
		local fucking = G.GAME.seeded and "_budget" or ""
		key = (self.key .. fucking)
		local hpt = card.ability.extra
		return {
			vars = { hpt.credits },
			key = key
		}
	end,
	can_use = function(self, card)
		return true
	end,
	use = function(self, card, area, copier)
		local hpt = card.ability.extra
		HPTN.ease_credits(hpt.credits, false)
	end,
})
		local calc_amount_increased = function(amount, initial, scaling)
			if amount < initial then
				return 0
			end
			local alpha = initial
			for i = 1, math.ceil(amount/initial) do
				alpha = alpha + initial + scaling * i
				if alpha > amount then
					return i
				end
			end
			return 1
		end
SMODS.Consumable({
	key = "power",
	set = "Spectral",
	atlas = "tname_auras",
	pos = {
		x = 3,
		y = 1
	},
    soul_set = 'Aura',
	soul_pos = { x = 4, y = 1 },
	config = {
		extra = {
			credits = 150,
			increment = 30,
			maximum = 15
		},
	},
	loc_vars = function(self, info_queue, card)
		local key
		local fucking = G.GAME.seeded and "_budget" or ""
		key = (self.key .. fucking)
		local hpt = card.ability.extra
		return {
			vars = {
				hpt.credits,
				math.min(math.max(0, calc_amount_increased(tonumber((G.GAME.seeded and G.GAME.budget or G.PROFILES[G.SETTINGS.profile].TNameCredits)), hpt.credits, hpt.increment)), hpt.maximum),
				((math.floor((G.GAME.seeded and G.GAME.budget or G.PROFILES[G.SETTINGS.profile].TNameCredits) / hpt.credits) < 0) and "") or "+",
				hpt.increment,
				hpt.maximum,
			},
			key = key
		}
	end,
	hotpot_credits = {
		art = { "GoldenLeaf" },
		idea = { "GoldenLeaf" },
		code = { "GoldenLeaf" },
		team = { "Team Name" },
	},
	can_use = function(self, card)
		local hpt = card.ability.extra
		return ((#G.jokers.cards > 0) and (calc_amount_increased(tonumber((G.GAME.seeded and G.GAME.budget or G.PROFILES[G.SETTINGS.profile].TNameCredits)), hpt.credits, hpt.increment) > 0))
            and G.jokers.cards[1] and G.jokers.cards[1].config and G.jokers.cards[1].config.center_key ~= "j_hpot_child"
	end,
	use = function(self, card, area, copier)
		local hpt = card.ability.extra
		local a = math.min(math.max(0, calc_amount_increased(tonumber((G.GAME.seeded and G.GAME.budget or G.PROFILES[G.SETTINGS.profile].TNameCredits)), hpt.credits, hpt.increment)), hpt.maximum)
		HPTN.ease_credits(-(G.GAME.seeded and G.GAME.budget or G.PROFILES[G.SETTINGS.profile].TNameCredits), false)
		local target_card_key = G.jokers.cards[1].config.center_key
		if target_card_key ~= nil and target_card_key ~= "j_hpot_child" then
			for i = 1, a do
				SMODS.add_card {
					key = target_card_key,
					edition = "e_negative"
				}
			end
		end
	end,
})
