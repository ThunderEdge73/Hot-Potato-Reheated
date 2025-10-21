
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