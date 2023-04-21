include("../functions.jl")
@register ramp(x, slope, startx, endx)

@variables t
D = Differential(t)

function energy(; name, params=_params, inits=_inits, tables=_tables, ranges=_ranges)
    @variables GDPP(t)
    @variables POP(t)
    @variables IPP(t)

    @parameters MNFCO2PP = params[:MNFCO2PP] [description = "Max non-fossil CO2 per person tCO2/p/y"]
    @parameters FCO2SCCS2022 = params[:FCO2SCCS2022] [description = "Fraction of CO2-sources with CCS in 2022"]
    @parameters GFCO2SCCS = params[:GFCO2SCCS] [description = "Goal fraction of CO2-sources with CCS"]
    @parameters CCCSt = params[:CCCSt] [description = "Cost of CCS $/tCO2"]
    @parameters ROCTCO2PT = params[:ROCTCO2PT] [description = "ROC in tCO2 per toe 1/y"]
    @parameters EROCEPA2022 = params[:EROCEPA2022] [description = "Extra ROC in energy productivity after 2022 1/y"]
   

   
    @variables NFCO2PP(t) [description = "Non-fossil CO2 per person tCO2/p/y"]
    @variables CO2NFIP(t) [description = "CO2 from non-fossil industrial processes GtCO2/y"]
    @variables FCO2SCCS(t) [description = "Fraction of CO2-sources with CCS"]
    @variables CO2EI(t) [description = "CO2 from energy and industry GtCO2/y"]
    @variables CO2EP(t) [description = "CO2 from energy production GtCO2/y"]
    @variables CO2EMPP(t) [description = "CO2 EMissions per person tCO2/p/y"]
    @variables CCCSG(t) [description = "Cost of CCS G$/y"]
    @variables ICCSC(t) [description = "Installed CCS capacity GtCO2/y"]
    @variables TCO2PT(t) [description = "tCO2 per toe"]
    @variables EEPI2022(t) = inits[:EEPI2022] [description = "Extra energy productivity index in 2022"]
    @variables IEEPI(t) [description = "Increase in extra energy productivity index 1/y"]

    eqs = []

    add_equation!(eqs, NFCO2PP ~ MNFCO2PP * (1 - exp(-(GDPP / 10))))
    add_equation!(eqs, CO2NFIP ~ (NFCO2PP / 1000) * POP * (1 - FCO2SCCS))
    add_equation!(eqs, FCO2SCCS ~ FCO2SCCS2022 + ramp(t, (GFCO2SCCS - FCO2SCCS2022) / IPP, 2022, 2022 +IPP))
    add_equation!(eqs, CO2EI ~ CO2EP + CO2NFIP)
    add_equation!(eqs, CO2EP ~ UFF * (TCO2PT / 1000) * (1 - FCO2SCCS))
    add_equation!(eqs, CO2EMPP ~ (CO2EI / POP) * 1000)
    add_equation!(eqs, CCCSG ~ CCCSt * ICCSC)
    add_equation!(eqs, ICCSC ~ FCO2SCSS * ( CO2NFIP + CO2EP) / (1 - FCO2SCCS))
    add_equation!(eqs, TCO2PT ~ 2.8 * exp(ROCTCO2PT * t - 1980))
    add_equations!(eqs, D(EEPI2022) ~ IEEPI)
    add_equation!(eqs, IEEPI ~ EROCEPA2022 * 0 + step(t, EROCEPA2022, 2022))

    return ODESystem(eqs; name=name)
end

function energy_support(; name, params=_params, inits=_inits, tables=_tables, ranges=_ranges)
    @variables GDPP(t) [description = "GDP per person kDollar/p/y"] 
    @variables POP(t) [description = "Population Mp"]
    @variables IPP(t) [description = "Introduction period for policy y"]
    
    eqs = []

    add_equation!(eqs, GDPP ~ interpolate(t, tables[:GDPP], ranges[:GDPP]))
    add_equation!(eqs, POP ~ interpolate(t, tables[:POP], ranges[:POP]))
    add_equation!(eqs, IPP ~ interpolate(t, tables[:IPP], ranges[:IPP]))
    
    return ODESystem(eqs; name=name)
end