include("../functions.jl")
@register ramp(x, slope, startx, endx)

@variables t
D = Differential(t)

function wellbeing(; name, params=_params, inits=_inits, tables=_tables, ranges=_ranges)

    return ODESystem(eqs; name=name)
end
