include("../functions.jl")
@register ramp(x, slope, startx, endx)

@variables t
D = Differential(t)

function other1(; name, params=_params, inits=_inits, tables=_tables, ranges=_ranges)
    @variables GDPP(t)

    @parameters TEGR = params[:TEGR] [description = "Time to establish growth rate y"]

   
    @variables PGDPP(t) = inits[:PGDPP] [description = "Past GDP per person kDollar/y"]
    @variables RGGDPP(t) [description = "Rate og growth in GDP per person 1/y"]

    eqs = []

    add_equation!(eqs, RGGDPP ~ ((GDPP - PGDPP) / PGDPP) / TEGR)

    smooth!(eqs, PGDPP, GDPP, TEGR)

    return ODESystem(eqs; name=name)
end

function other1_support(; name, params=_params, inits=_inits, tables=_tables, ranges=_ranges)
    @variables GDPP(t) [description = "GDP per person kDollar/p/y"] 
    
    eqs = []

    add_equation!(eqs, GDPP ~ WorldDynamics.interpolate(t, tables[:GDPP], ranges[:GDPP]))
    
    return ODESystem(eqs; name=name)
end

function other2(; name, params=_params, inits=_inits, tables=_tables, ranges=_ranges)
    @variables CE(t)
    @variables CF(t)

    @variables CFETA(t) [description = "Cost of food and energy TAs GDollar/y"]
    @variables CTA(t) [description = "Cost of TAs GDollar/y"]

    eqs = []

   
    add_equation!(eqs, CFETA ~ CF + CE)
    add_equation!(eqs, CTA ~ CFETA)
    
    return ODESystem(eqs; name=name)
end

function other2_support(; name, params=_params, inits=_inits, tables=_tables, ranges=_ranges)
    @variables CF(t) [description = "Cost of food GDollar/y"]
    @variables CE(t) [description = "Cost of energy GDollar/y"]
    
    eqs = []

    add_equation!(eqs, CF ~ WorldDynamics.interpolate(t, tables[:CF], ranges[:CF]))
    add_equation!(eqs, CE ~ WorldDynamics.interpolate(t, tables[:CE], ranges[:CE]))
    
    return ODESystem(eqs; name=name)
end

function other3(; name, params=_params, inits=_inits, tables=_tables, ranges=_ranges)
    @variables INEQ(t)
    @variables GDPP(t)
    @variables POP(t)
    
    @parameters INELOK = params[:INELOK] [description = "sINEeoLOK<0"]
    @parameters NK = params[:NK] [description = "Normal k"]
   
    @variables IEL(t) [description = "Inequity effect on logistic k"]
    @variables LK(t) [description = "Logistic k"]
    @variables FB15(t) [description= "Fraction below 15 kDollar/p/y"]
    @variables PB15(t) [description= "Population below 15 kDollar/p/y Mp"]

    eqs = []

   
    add_equation!(eqs, IEL ~ 1 + INELOK * (INEQ / 0.5 - 1))
    add_equation!(eqs, LK ~ NK * IEL)
    add_equation!(eqs, FB15 ~ 1 - (1 / (1 + exp(-LK * (GDPP -14)))))
    add_equation!(eqs, PB15 ~ POP * FB15)

    return ODESystem(eqs; name=name)
end

function other3_support(; name, params=_params, inits=_inits, tables=_tables, ranges=_ranges)
    @variables INEQ(t) [description = "Inequality"]
    @variables GDPP(t) [description = "GDP per person kDollar/p/y"] 
    @variables POP(t) [description = "Population Mp"]
    
    eqs = []

    add_equation!(eqs, INEQ ~ WorldDynamics.interpolate(t, tables[:INEQ], ranges[:INEQ]))
    add_equation!(eqs, GDPP ~ WorldDynamics.interpolate(t, tables[:GDPP], ranges[:GDPP]))
    add_equation!(eqs, POP ~ WorldDynamics.interpolate(t, tables[:POP], ranges[:POP]))
    
    return ODESystem(eqs; name=name)
end