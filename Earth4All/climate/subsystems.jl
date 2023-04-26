include("../functions.jl")
@register ramp(x, slope, startx, endx)

@variables t
D = Differential(t)

function climate(; name, params=_params, inits=_inits, tables=_tables, ranges=_ranges)
    @variables GDPP(t)

    @parameters TEGR = params[:TEGR] [description = "Time to establish growth rate y"]

   
    @variables PGDPP(t) = inits[:PGDPP] [description = "Past GDP per person kDollar/y"]
    @variables RGGDPP(t) [description = "Rate og growth in GDP per person 1/y"]

    eqs = []

    add_equation!(eqs, RGGDPP ~ ((GDPP - PGDPP) / PGDPP) / TEGR)

    smooth!(eqs, PGDPP, GDPP, TEGR)

    return ODESystem(eqs; name=name)
end

function climate_support(; name, params=_params, inits=_inits, tables=_tables, ranges=_ranges)
    @variables GDP(t) [description = "GDP GDollar/y"]
    @variables IPP(t) [description = "Introduction period for policy y"] 
    @variables FEUS(t) [description = "Fertilizer use Mt/y"]
    @variables CRSU(t) [description = "Crop supply (after 20% waste) Mt-crop/y"]
    @variables CO2EI(t) [description = "CO2 from energy and industry GtCO2/y"]
    @variables CCCSt(t) [description = "Cost of CCS Dollar/tCO2"]
    @variables CO2ELULUC(t) [description = "CO2 emissions from LULUC GtCO2/y"]
    
    eqs = []

    add_equation!(eqs, GDP ~ WorldDynamics.interpolate(t, tables[:GDP], ranges[:GDP]))
    add_equation!(eqs, IPP ~ WorldDynamics.interpolate(t, tables[:IPP], ranges[:IPP]))
    add_equation!(eqs, FEUS ~ WorldDynamics.interpolate(t, tables[:FEUS], ranges[:FEUS]))
    add_equation!(eqs, CRSU ~ WorldDynamics.interpolate(t, tables[:CRSU], ranges[:CRSU]))
    add_equation!(eqs, CO2EI ~ WorldDynamics.interpolate(t, tables[:CO2EI], ranges[:CO2EI]))
    add_equation!(eqs, CCCSt ~ WorldDynamics.interpolate(t, tables[:CCCSt], ranges[:CCCSt]))
    add_equation!(eqs, CO2ELULUC ~ WorldDynamics.interpolate(t, tables[:CO2ELULUC], ranges[:CO2ELULUC]))
    return ODESystem(eqs; name=name)
end

