include("../functions.jl")
@register ramp(x, slope, startx, endx)


@variables t
D = Differential(t)

function demand(; name, params=_params, inits=_inits, tables=_tables, ranges=_ranges)
    @variables GDPP(t)
    @variables POP(t)
    @variables IPP(t)
    @variables WSO(t)
    @variables NI(t)
    @variables ECTAF2022(t)
    @variables GBC(t)
    @variables WBC(t)
    @variables WF(t)
    @variables EGDPP(t)


    @parameters GITRO = params[:GITRO] [description = "Goal for income tax rate owners"]
    @parameters ITRO2022 = params[:ITRO2022] [description = "Income tax rate owners in 2022"]
    @parameters ITRO1980 = params[:ITRO1980] [description = "Income tax rate owners in 1980"]

    @variables BITRO(t) [description = "Basic income tax rate owners"]

    
    eqs = []

    add_equation!(eqs, BITRO ~ min(1, ITRO1980) + ramp(t, (ITRO2022 - ITRO1980) / 42, 1980, 2022) + ramp(t, (GITRO - ITRO2022) / 78, 2022, 2100))
    
    return ODESystem(eqs; name=name)
end

function demand_support(; name, params=_params, inits=_inits, tables=_tables, ranges=_ranges)
    @variables GDPP(t) [description = "GDP per person kDollar/p/y"] 
    @variables POP(t) [description = "Population Mp"]
    @variables IPP(t) [description = "Introduction period for policy y"]
    @variables WSO(t) [description = "Worker share output "]
    @variables NI(t) [description = "National income GDollar/y"]
    @variables ECTAF2022(t) [description = "Extra Cost of TAs from 2022"]
    @variables GBC(t) [description = "Government borrowing cost 1/y"]
    @variables WBC(t) [description = "Worker borrowing cost 1/y"]
    @variables WF(t) [description = "Work force Mp"]
    @variables EGDPP(t) [description = "Effective GDP per person kDollar/p/y"]

    
    eqs = []

    add_equation!(eqs, GDPP ~ WorldDynamics.interpolate(t, tables[:GDPP], ranges[:GDPP]))
    add_equation!(eqs, POP ~ WorldDynamics.interpolate(t, tables[:POP], ranges[:POP]))
    add_equation!(eqs, IPP ~ WorldDynamics.interpolate(t, tables[:IPP], ranges[:IPP]))
    add_equation!(eqs, WSO ~ WorldDynamics.interpolate(t, tables[:WSO], ranges[:WSO]))
    add_equation!(eqs, NI ~ WorldDynamics.interpolate(t, tables[:NI], ranges[:NI]))
    add_equation!(eqs, ECTAF2022 ~ WorldDynamics.interpolate(t, tables[:ECTAF2022], ranges[:ECTAF2022]))
    add_equation!(eqs, GBC ~ WorldDynamics.interpolate(t, tables[:GBC], ranges[:GBC]))
    add_equation!(eqs, WBC ~ WorldDynamics.interpolate(t, tables[:WBC], ranges[:WBC]))
    add_equation!(eqs, WF ~ WorldDynamics.interpolate(t, tables[:WF], ranges[:WF]))
    add_equation!(eqs, EGDPP ~ WorldDynamics.interpolate(t, tables[:EGDPP], ranges[:EGDPP]))
    
    return ODESystem(eqs; name=name)
end

