include("../tables.jl")
include("../functions.jl")
@register ramp(x, slope, startx, endx)

@variables t
D = Differential(t)

function other(; name, params=_params, inits=_inits, tables=_tables, ranges=_ranges)
    @parameters INELOK = params[:INELOK] [description = "sINEeoLOK<0: INequity Effect on LOgistic K"]
    @parameters NK = params[:NK] [description = "Normal K"]
    @parameters TEGR = params[:TEGR] [description = "Time to Establish Growth Rate y"]

    @variables CFETA(t) [description = "Cost of Food and Energy TAs GDollar/y"]
    @variables CTA(t) [description = "Cost of TAs GDollar/y"]
    @variables FB15(t) [description = "Fraction Below 15 kDollar/p/y (1)"]
    @variables IEL(t) [description = "Inequity Effect on Logistic k (1)"]
    @variables LK(t) [description = "Logistic K (1)"]
    @variables PB15(t) [description = "Population Below 15 kDollar/p/y Mp"]
    @variables PGDPP(t) = inits[:PGDPP] [description = "Past GDP per Person kDollar/y"]
    @variables RGGDPP(t) [description = "Rate of Growth in GDP per Person 1/y"]

    @variables CE(t)
    @variables COFO(t)
    @variables GDPP(t)
    @variables INEQ(t)
    @variables POP(t)

    eqs = []

    add_equation!(eqs, CFETA ~ COFO + CE)
    add_equation!(eqs, CTA ~ CFETA)
    add_equation!(eqs, FB15 ~ 1 - (1 / (1 + exp(-LK * (GDPP - 14)))))
    add_equation!(eqs, IEL ~ 1 + INELOK * (INEQ / 0.5 - 1))
    add_equation!(eqs, LK ~ NK * IEL)
    add_equation!(eqs, PB15 ~ POP * FB15)
    add_equation!(eqs, RGGDPP ~ ((GDPP - PGDPP) / PGDPP) / TEGR)
    smooth!(eqs, PGDPP, GDPP, TEGR)

    return ODESystem(eqs; name=name)
end

function other_full_support(; name, params=_params, inits=_inits, tables=_tables, ranges=_ranges)
    @variables CE(t) [description = "Energy.Cost of Energy GDollar/y"]
    @variables COFO(t) [description = "Food and land.Cost of Food GDollar/y"]
    @variables GDPP(t) [description = "Population.GDP per Person kDollar/p/y"]
    @variables INEQ(t) [description = "Demand.Inequality"]
    @variables POP(t) [description = "Population.Population Mp"]

    eqs = []

    add_equation!(eqs, CE ~ WorldDynamics.interpolate(t, tables[:CE], ranges[:CE]))
    add_equation!(eqs, COFO ~ WorldDynamics.interpolate(t, tables[:COFO], ranges[:COFO]))
    add_equation!(eqs, GDPP ~ WorldDynamics.interpolate(t, tables[:GDPP], ranges[:GDPP]))
    add_equation!(eqs, INEQ ~ WorldDynamics.interpolate(t, tables[:INEQ], ranges[:INEQ]))
    add_equation!(eqs, POP ~ WorldDynamics.interpolate(t, tables[:POP], ranges[:POP]))

    return ODESystem(eqs; name=name)
end

function other_partial_support(; name, params=_params, inits=_inits, tables=_tables, ranges=_ranges)
    @variables CE(t) [description = "Energy.Cost of Energy GDollar/y"]
    @variables COFO(t) [description = "Food and land.Cost of Food GDollar/y"]
    # @variables GDPP(t) [description = "Population.GDP per Person kDollar/p/y"]
    # @variables INEQ(t) [description = "Demand.Inequality"]
    # @variables POP(t) [description = "Population.Population Mp"]

    eqs = []

    add_equation!(eqs, CE ~ WorldDynamics.interpolate(t, tables[:CE], ranges[:CE]))
    add_equation!(eqs, COFO ~ WorldDynamics.interpolate(t, tables[:COFO], ranges[:COFO]))
    # add_equation!(eqs, GDPP ~ WorldDynamics.interpolate(t, tables[:GDPP], ranges[:GDPP]))
    # add_equation!(eqs, INEQ ~ WorldDynamics.interpolate(t, tables[:INEQ], ranges[:INEQ]))
    # add_equation!(eqs, POP ~ WorldDynamics.interpolate(t, tables[:POP], ranges[:POP]))

    return ODESystem(eqs; name=name)
end
