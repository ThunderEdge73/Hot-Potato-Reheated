function UTIL_calculate_context(context) -- calculate context, trigger any effects, and returns the effect list for further processing
    local effects = {}
    SMODS.calculate_context(context, effects)
    SMODS.trigger_effects(effects)
    return effects
end