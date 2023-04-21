include("../functions.jl")
@register ramp(x, slope, startx, endx)

@variables t
D = Differential(t)

function energy(; name, params=_params, inits=_inits, tables=_tables, ranges=_ranges)
    @variables GDPP(t)

    @parameters TEGR = params[:TEGR] [description = "Time to establish growth rate y"]

   
    @variables PGDPP(t) = inits[:PGDPP] [description = "Past GDP per person kDollar/y"]
    @variables RGGDPP(t) [description = "Rate og growth in GDP per person 1/y"]

    eqs = []

    add_equation!(eqs, RGGDPP ~ ((GDPP - PGDPP) / PGDPP) / TEGR)

    smooth!(eqs, PGDPP, GDPP, TEGR)

    return ODESystem(eqs; name=name)
end

function energy_support(; name, params=_params, inits=_inits, tables=_tables, ranges=_ranges)
    @variables GDPP(t) [description = "GDP per person kDollar/p/y"] 
    @variables POP(t) [description = "Population Mp"]
    
    eqs = []

    add_equation!(eqs, GDPP ~ interpolate(t, tables[:GDPP], ranges[:GDPP]))
    add_equation!(eqs, POP ~ interpolate(t, tables[:POP], ranges[:POP]))
    
    return ODESystem(eqs; name=name)
end