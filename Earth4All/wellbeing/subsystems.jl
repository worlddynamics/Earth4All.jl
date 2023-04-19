include("../functions.jl")
@register ramp(x, slope, startx, endx)

@variables t
D = Differential(t)

function wellbeing(; name, params=_params, inits=_inits, tables=_tables, ranges=_ranges)

    @variables GDPP(t)

    return ODESystem(eqs; name=name)
end

function wellbeing_support(; name, params=_params, inits=_inits, tables=_tables, ranges=_ranges)
    @variables GDPP(t)
    @variables INEQ(t)
    @variables LBR(t)
    @variables PSP(t)
    @variables PW(t)
    @variables WDI(t)

    eqs = [
        GDPP ~ interpolate(t, tables[:GDPP], ranges[:GDPP])
        INEQ ~ interpolate(t, tables[:INEQ], ranges[:INEQ])
        LBR ~ interpolate(t, tables[:LBR], ranges[:LBR])
        PSP ~ interpolate(t, tables[:PSP], ranges[:PSP])
        PW ~ interpolate(t, tables[:PW], ranges[:PW])
        WDI ~ interpolate(t, tables[:WDI], ranges[:WDI])
    ]

    return ODESystem(eqs; name=name)
end
