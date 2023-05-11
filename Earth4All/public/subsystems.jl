include("../functions.jl")
@register ramp(x, slope, startx, endx)

@variables t
D = Differential(t)

function public(; name, params=_params, inits=_inits, tables=_tables, ranges=_ranges)
    @parameters OW2022 = params[:OW2022] [description = "Climate.Observed Warming in 2022 deg C"]
    @parameters CTA2022 = params[:CTA2022] [description = "Cost of TAs in 2022 GDollar/y"]
    @parameters DROTA1980 = params[:DROTA1980] [description = "Domestic ROTA in 1980 1/y"]
    @parameters EDROTA2022 = params[:EDROTA2022] [description = "Extra Domestic ROTA in 2022 1/y"]
    @parameters FUATA = params[:FUATA] [description = "Fraction Unprofitable Activity in TAs"]
    @parameters GDPTL = params[:GDPTL] [description = "GDPpp of Technology Leader kDollar/p/k"]
    @parameters IIEEROTA = params[:IIEEROTA] [description = "sIIEeoROTA<0: Inequality Index Effect on ROTA"]
    @parameters IPR1980 = params[:IPR1980] [description = "Infrastructure Purchases Ratio in 1980 y"]
    @parameters IPRVPSS = params[:IPRVPSS] [description = "sIPReoVPSS>0: Infrastructure Purchase Ratio effect on Value of Pubblic Services Supplied"]
    @parameters MIROTA2022 = params[:MIROTA2022] [description = "Maximum Imported ROTA from 2022 1/y"]
    @parameters OWETFP = params[:OWETFP] [description = "sOWeoTFP<0: Observed Warming Effect on Total Factor Productivity"]
    @parameters SC1980 = params[:SC1980] [description = "State Capacity in 1980 (fraction of GDP)"]
    @parameters SCROTA = params[:SCROTA] [description = "sSCeoROTA>0: State Capacity effect on Rate Of Technological Advance"]
    @parameters XETAC2022 = params[:XETAC2022] [description = "XExtra TA Cost in 2022 (share of GDP)"]
    @parameters XETAC2100 = params[:XETAC2100] [description = "XExtra TA Cost in 2100 (share of GDP)"]

    @variables CTFP(t) [description = "Change in TFP 1/y"]
    @variables DRTA(t) [description = "Domestic Rate of Technological Advance 1/y"]
    @variables ECTAF2022(t) [description = "Extra Cost of TAs From 2022 GDollar/y"]
    @variables ECTAGDP(t) [description = "Extra Cost of TAs as share of GDP"]
    @variables GSSGDP(t) [description = "Government Spending as Share of GDP"]
    @variables IPR(t) [description = "Infrastructure Purchases Ratio y"]
    @variables IROTA(t) [description = "Imported ROTA 1/y"]
    @variables ITFP(t) [description = "Indicated TFP"]
    @variables OWTFP(t) [description = "OWeoTFP"]
    @variables PLUA(t) [description = "Productivity Loss from Unprofitable Activity"]
    @variables PPP(t) [description = "Productivity of Public Purchases"]
    @variables PSEP(t) [description = "Public SErvices per Person kdollar/p/k"]
    @variables PSP(t) [description = "Public Spending per Person kDollar/p/k"]
    @variables RROTAI(t) [description = "Reduction in ROTA from Inequality 1/y"]
    @variables RTA(t) [description = "Rate of Technological Advance 1/y"]
    @variables RTFPUA(t) = inits[:RTFPUA] [description = "Reduction in TFP from Unprofitable Activity"]
    @variables SC(t) [description = "State Capacity (fraction of GDP)"]
    @variables TFPEE5TA(t) = inits[:TFPEE5TA] [description = "TFP Excluding Effect of 5TAs"]
    @variables TFPIE5TA(t) [description = "TFP Including Effect of 5TAs"]
    @variables VPSS(t) [description = "Value of Public Services Supplied GDollar/y"]
    @variables XECTAGDP(t) [description = "XExtra Cost of TAs as share of GDP"]

    @variables CPUS(t)
    @variables CTA(t)
    @variables CTPIS(t)
    @variables GDP(t)
    @variables GDPP(t)
    @variables GP(t)
    @variables GS(t)
    @variables INEQI(t)
    @variables IPT(t)
    @variables OW(t)
    @variables POP(t)

    eqs = []

    add_equation!(eqs, CTFP ~ RTA * TFPEE5TA)
    add_equation!(eqs, DRTA ~ (DROTA1980 + IfElse.ifelse(t > 2022, EDROTA2022, 0) * (1 + SCROTA * (SC / SC1980) - 1)))
    add_equation!(eqs, ECTAF2022 ~ max(0, CTA - CTA2022))
    add_equation!(eqs, ECTAGDP ~ ECTAF2022 / GDP)
    add_equation!(eqs, GSSGDP ~ GS / GDP)
    add_equation!(eqs, IPR ~ CPUS / GP)
    add_equation!(eqs, IROTA ~ IfElse.ifelse(t > 2022, max(0, MIROTA2022 * (1 - 1 * (GDPP / GDPTL - 1))), 0))
    add_equation!(eqs, ITFP ~ TFPEE5TA * OWTFP)
    add_equation!(eqs, OWTFP ~ IfElse.ifelse(t > 2022, 1 + OWETFP * (OW / OW2022 - 1), 1))
    add_equation!(eqs, PLUA ~ ECTAGDP * FUATA)
    add_equation!(eqs, PPP ~ max(0, 1 + IPRVPSS * log(IPR / IPR1980)))
    add_equation!(eqs, PSEP ~ VPSS / POP)
    add_equation!(eqs, PSP ~ GS / POP)
    add_equation!(eqs, D(TFPEE5TA) ~ CTFP)
    add_equation!(eqs, RROTAI ~ min(1, 1 + IIEEROTA * (INEQI / 1 - 1)))
    add_equation!(eqs, RTA ~ DRTA * RROTAI + IROTA)
    smooth!(eqs, RTFPUA, PLUA, IPT + CTPIS)
    add_equation!(eqs, SC ~ VPSS / GDP)
    add_equation!(eqs, TFPIE5TA ~ TFPEE5TA * (1 - RTFPUA))
    add_equation!(eqs, VPSS ~ GP * PPP)
    add_equation!(eqs, XECTAGDP ~ XETAC2022 + ramp(t, (XETAC2100 - XETAC2022) / 78, 2022, 2022 + 78))

    return ODESystem(eqs; name=name)
end

function public_support(; name, params=_params, inits=_inits, tables=_tables, ranges=_ranges)
    @variables CPUS(t) [description = "Output.Capacity PUS Geu"]
    @variables CTA(t) [description = "Other performance indicators.Cost of TAs Gdollar/y"]
    @variables CTPIS(t) [description = "Output.Construction time PIS y"]
    # @variables GDP(t) [description = "Inventory.GDP Gdollar/y"]
    # @variables GDPP(t) [description = "Population.GDP per person kDollar/p/k"]
    # @variables GP(t) [description = "Demand.Government purchases Gdollar/y"]
    # @variables GS(t) [description = "Demand.Government spending Gdollar/y"]
    # @variables INEQI(t) [description = "Demand.Inequality index"]
    @variables IPT(t) [description = "Output.Investment planning time y"]
    # @variables OW(t) [description = "Climate.Observed warming deg C"]
    # @variables OW2022(t) [description = "Climate.Observed warming in 2022 deg C"]
    # @variables POP(t) [description = "Population.Population Mp"]

    eqs = []

    add_equation!(eqs, CPUS ~ WorldDynamics.interpolate(t, tables[:CPUS], ranges[:CPUS]))
    add_equation!(eqs, CTA ~ WorldDynamics.interpolate(t, tables[:CTA], ranges[:CTA]))
    add_equation!(eqs, CTPIS ~ WorldDynamics.interpolate(t, tables[:CTPIS], ranges[:CTPIS]))
    #add_equation!(eqs, GDP ~ WorldDynamics.interpolate(t, tables[:GDP], ranges[:GDP]))
    #add_equation!(eqs, GDPP ~ WorldDynamics.interpolate(t, tables[:GDPP], ranges[:GDPP]))
    # add_equation!(eqs, GP ~ WorldDynamics.interpolate(t, tables[:GP], ranges[:GP]))
    # add_equation!(eqs, GS ~ WorldDynamics.interpolate(t, tables[:GS], ranges[:GS]))
    # add_equation!(eqs, INEQI ~ WorldDynamics.interpolate(t, tables[:INEQI], ranges[:INEQI]))
    add_equation!(eqs, IPT ~ WorldDynamics.interpolate(t, tables[:IPT], ranges[:IPT]))
    # add_equation!(eqs, OW ~ WorldDynamics.interpolate(t, tables[:OW], ranges[:OW]))
    # add_equation!(eqs, OW2022 ~ WorldDynamics.interpolate(t, tables[:OW2022], ranges[:OW2022]))
    # add_equation!(eqs, POP ~ WorldDynamics.interpolate(t, tables[:POP], ranges[:POP]))

    return ODESystem(eqs; name=name)
end
