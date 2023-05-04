include("../functions.jl")
@register ramp(x, slope, startx, endx)

@variables t
D = Differential(t)

function output(; name, params=_params, inits=_inits, tables=_tables, ranges=_ranges)
    @parameters CBCEFRA = params[:CBCEFRA] [description = "sCBCeoFRA<0: Corporate Borrowing Cost Effect on FRA"]
    @parameters CU1980 = params[:CU1980] [description = "Cost per Unit in 1980 dollar/u"]
    @parameters FCI = params[:FCI] [description = "Foreign Capital Inflow Gdollar/y"]
    @parameters FRA1980 = params[:FRA1980] [description = "FRA in 1980"]
    @parameters FRACAM = params[:FRACAM] [description = "FRACA Min"]
    @parameters GDPP1980 = params[:GDPPEFRACA] [description = "GDP per Person in 1980"]
    @parameters GDPPEFRACA = params[:GDPPEFRACA] [description = "sGDPppeoFRACA<0: GDP per Person Effect on FRACA"]
    @parameters IPT = params[:IPT] [description = "Investment Planning Time y"]
    @parameters MA1980 = params[:MA1980] [description = "MArgin in 1980"]
    @parameters USPIS2022 = params[:USPIS2022] [description = "Unconventional Stimulus in PIS from 2022 (share of GDP)"]
    @parameters WSOEFRA = params[:WSOEFRA] [description = "sWSOeoFRA<0: Worker Share of Output Effect on FRA"]

    @variables AVCA(t) [description = "AVailable CApital Gdollar/y"]
    @variables CBCEFCA(t) [description = "CBC Effect on Flow to Capacity Addion"]
    @variables FACNC(t) = inits[:FACNC] [description = "Fraction of Available Capital to New Capacity"]
    @variables FRACAMGDPPL(t) [description = "FRACA Mult from GDPpP - Line"]
    @variables FRACAMGDPPT(t) [description = "FRACA Mult from GDPpP - Table"]
    @variables INCPIS(t) [description = "Investment in New Capacity PIS G$/y"]
    @variables OBSGIPIS(t) [description = "Off-Balance Sheet Govmnt Inv in PIS (share of GDP)"]
    @variables PRUN(t) [description = "PRice per UNit $/u"]
    @variables WSOEFCA(t) [description = "WSO Effect on Flow to Capacity Addition"]

    @variables CBC(t)
    @variables CBC1980(t)
    @variables GDP(t)
    @variables GDPP(t)
    @variables GIPC(t)
    @variables ITFP(t)
    @variables LAUS(t)
    @variables OW(t)
    @variables TOSA(t)
    @variables TPP(t)
    @variables WASH(t)

    eqs = []

    add_equation!(eqs, AVCA ~ TOSA + FCI)
    add_equation!(eqs, CBCEFCA ~ 1 + CBCEFRA * (CBC / CBC1980 - 1))
    smooth!(eqs, FACNC, FRA1980 * FRACAMGDPPL * (WSOEFCA + CBCEFCA + EDEFCA) / 3, IPT)
    add_equation!(eqs, FRACAMGDPPL ~ max(FRACAM, 1 + GDPPEFRACA * (GDPP / GDPP1980 - 1)))
    add_equation!(eqs, FRACAMGDPPT ~ interpolate1(GDPP / GDPP1980, [(0.0, 1.0), (1.0, 1.0), (2.0, 0.85), (2.1, 0.84), (4.0, 0.65), (8.0, 0.55), (16.0, 0.5)]))
    add_equation!(eqs, INCPIS ~ AVCA * FACNC)
    add_equation!(eqs, OBSGIPIS ~ IfElse.ifelse(t > 2022, USPIS2022, 0))
    add_equation!(eqs, PRUN ~ CU1980 * (1 + MA1980))
    add_equation!(eqs, WSOEFCA ~ 1 + WSOEFRA * (WASH / inits[:WSO] - 1))

    return ODESystem(eqs; name=name)
end

function output_support(; name, params=_params, inits=_inits, tables=_tables, ranges=_ranges)
    @variables CBC(t) [description = "Corporate Borrowing Cost 1/y"]
    @variables CBC1980(t) [description = "Corporate Borrowing Cost in 1980 1/y"]
    @variables GDP(t) [description = "Inventory.GDP GDollar/y"]
    @variables GDPP(t) [description = "Population.GDP per Person kdollar/p/y"]
    @variables GIPC(t) [description = "Demand.Govmnt Investment in Public Capacity Gdollar/y"]
    @variables ITFP(t) [description = "Public.Indicated TFP"]
    @variables LAUS(t) [description = "Labour and market.LAbour USe Gph/y"]
    @variables OW(t) [description = "Climate.Observed warming deg C"]
    @variables TOSA(t) [description = "Demand.TOtal SAvings Gdollar/y"]
    @variables TPP(t) [description = "Demand.Total Purchasing Power G$/y"]
    @variables WASH(t) [description = "Labour and market.WAge SHare"]

    eqs = []

    add_equation!(eqs, CBC ~ WorldDynamics.interpolate(t, tables[:CBC], ranges[:CBC]))
    add_equation!(eqs, CBC1980 ~ WorldDynamics.interpolate(t, tables[:CBC1980], ranges[:CBC1980]))
    add_equation!(eqs, GDP ~ WorldDynamics.interpolate(t, tables[:GDP], ranges[:GDP]))
    add_equation!(eqs, GDPP ~ WorldDynamics.interpolate(t, tables[:GDPP], ranges[:GDPP]))
    add_equation!(eqs, GIPC ~ WorldDynamics.interpolate(t, tables[:GIPC], ranges[:GIPC]))
    add_equation!(eqs, ITFP ~ WorldDynamics.interpolate(t, tables[:ITFP], ranges[:ITFP]))
    add_equation!(eqs, LAUS ~ WorldDynamics.interpolate(t, tables[:LAUS], ranges[:LAUS]))
    add_equation!(eqs, OW ~ WorldDynamics.interpolate(t, tables[:OW], ranges[:OW]))
    add_equation!(eqs, TOSA ~ WorldDynamics.interpolate(t, tables[:TOSA], ranges[:TOSA]))
    add_equation!(eqs, TPP ~ WorldDynamics.interpolate(t, tables[:TPP], ranges[:TPP]))
    add_equation!(eqs, WASH ~ WorldDynamics.interpolate(t, tables[:WASH], ranges[:WASH]))

    return ODESystem(eqs; name=name)
end
