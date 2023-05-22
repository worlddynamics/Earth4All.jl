include("../tables.jl")
include("../functions.jl")
@register ramp(x, slope, startx, endx)

@variables t
D = Differential(t)

function output(; name, params=_params, inits=_inits, tables=_tables, ranges=_ranges)
    # @parameters CAPPIS1980 = params[:CAPPIS1980] [description = "CAP PIS in 1980 Gcu"]
    @parameters CAPPUS1980 = params[:CAPPUS1980] [description = "CAP PUS in 1980 Gcu"]
    # @parameters CBCEFRA = params[:CBCEFRA] [description = "sCBCeoFRA<0: Corporate Borrowing Cost Effect on FRA"]
    @parameters CC1980 = params[:CC1980] [description = "Cost of Capacity in 1980 dollar/cu"]
    # @parameters CTPIS = params[:CTPIS] [description = "Construction Time PIS y"]
    @parameters CTPUS = params[:CTPUS] [description = "Construction Time PUS y"]
    # @parameters CUCPIS1980 = (params[:CAPPIS1980] / params[:LCPIS1980]) * params[:CTPIS] * params[:EMCUC] [description = "CUC PIS in 1980 Gcu"]
    # @parameters ED1980 = params[:ED1980] [description = "Excess Demand in 1980"]
    # @parameters EDEFRA = params[:EDEFRA] [description = "sEDeoFRA>0: Excess Demand Effect on FRA"]
    # @parameters EDELCM = params[:EDELCM] [description = "sEDeoLOC>0: Excess Demand Effect on Life of Capacity"]
    @parameters EMCUC = params[:EMCUC] [description = "Extra Mult on CUC, to avoid initial transient in investment share of GDP"]
    # @parameters FCI = params[:FCI] [description = "Foreign Capital Inflow Gdollar/y"]
    # @parameters FRA1980 = params[:FRA1980] [description = "FRA in 1980"]
    # @parameters FRACAM = params[:FRACAM] [description = "FRACA Min"]
    # @parameters GDPP1980 = params[:GDPP1980] [description = "GDP per Person in 1980"]
    # @parameters GDPPEFRACA = params[:GDPPEFRACA] [description = "sGDPppeoFRACA<0: GDP per Person Effect on FRACA"]
    # @parameters IPT = params[:IPT] [description = "Investment Planning Time y"]
    # @parameters JOBS1980 = params[:JOBS1980] [description = "JOBS in 1980 M-ftj"]
    # @parameters KAPPA = params[:KAPPA] [description = "Kappa"]
    # @parameters LAMBDA = params[:LAMBDA] [description = "Lambda"]
    # @parameters LAUS1980 = params[:LAUS1980] [description = "Labour Use in 1980 Gph/y"]
    # @parameters LCPIS1980 = params[:LCPIS1980] [description = "Life of Capacity PIS in 1980 y"]
    @parameters OW2022 = params[:OW2022] [description = "OBserved WArming in 2022 deg C"]
    # @parameters OG1980 = params[:OG1980] [description = "Output Growth in 1980 1/y (to avoid transient)"]
    # @parameters OO1980 = params[:OO1980] [description = "Optimal output in 1980 Gu/y"]
    @parameters OWECCM = params[:OWECCM] [description = "sOWeoCOC>0: Observed Warming Effect on Cost of Capacity Multiplier"]
    @parameters OWELCM = params[:OWELCM] [description = "sOWeoLOC<0: Observed Warming Effect on Life of Capacity Multiplier"]
    # @parameters PRUN = params[:CU1980] * (1 + params[:MA1980]) [description = "Price per Unit dollar/u"]
    # @parameters TOED = params[:TOED] [description = "Time to observe excess demand y"]
    # @parameters USPIS2022 = params[:USPIS2022] [description = "Unconventional Stimulus in PIS from 2022 (share of GDP)"]
    @parameters USPUS2022 = params[:USPUS2022] [description = "Unconventional Stimulus in PUS from 2022 (share of GDP)"]
    # @parameters WSOEFRA = params[:WSOEFRA] [description = "sWSOeoFRA<0: Worker Share of Output Effect on FRA"]

    # @variables AVCA(t) [description = "AVailable CApital Gdollar/y"]
    # @variables CBCEFCA(t) [description = "CBC Effect on Flow to Capacity Addion (1)"]
    # @variables CAP(t) [description = "CAPacity Gcu"]
    # @variables CAPIS(t) [description = "Capacity Addition PIS Gcu/y"]
    @variables CAPUS(t) [description = "Capacity Addition PUS Gcu/y"]
    # @variables CDPIS(t) [description = "Capacity Discard PIS Gcu/y"]
    @variables CDPUS(t) [description = "Capacity Discard PUS Gcu/y"]
    # @variables CIPIS(t) [description = "Capacity Initiation PIS Gcu/y"]
    @variables CIPUS(t) [description = "Capacity Initiation PUS Gcu/y"]
    @variables COCA(t) [description = "COst of CApacity dollar/cu"]
    # @variables CPIS(t) = params[:CAPPIS1980] [description = "Capacity PIS Gcu"]
    @variables CPUS(t) = params[:CAPPUS1980] [description = "Capacity PUS Gcu"]
    # @variables CRR(t) [description = "Capacity Renewal Rate 1/y"]
    # @variables CUCPIS(t) = (params[:CAPPIS1980] / params[:LCPIS1980]) * params[:CTPIS] * params[:EMCUC] [description = "Capacity Under Construction PIS Gcu"]
    @variables CUCPUS(t) = inits[:CUCPUS] [description = "Capacity Under Construction PUS Gcu"]
    @variables CUCPUS1980(t) [description = "CUC PUS in 1980 Gcu"]
    # @variables ECR(t) [description = "Effect of Capacity Renewal 1/y"]
    # @variables EDE(t) [description = "Excess DEmand (1)"]
    # @variables EDEFCA(t) [description = "ED Effect on Flow to Capacity Addition (1)"]
    # @variables EDELC(t) [description = "Excess Demand Effect on Life of Capacity (1)"]
    # @variables ETFP(t) = inits[:ETFP] [description = "Embedded TFP (1)"]
    # @variables FACNC(t) = inits[:FACNC] [description = "Fraction of Available Capital to New Capacity (1)"]
    # @variables FRACAMGDPPL(t) [description = "FRACA Mult from GDPpP - Line (1)"]
    # @variables FRACAMGDPPT(t) [description = "FRACA Mult from GDPpP - Table (1)"]
    # @variables INCPIS(t) [description = "Investment in New Capacity PIS Gdollar/y"]
    # @variables ISGDP(t) [description = "Investment Share of GDP (1)"]
    # @variables LCPIS(t) [description = "Life of Capacity PIS y"]
    @variables LCPUS(t) [description = "Life of Capacity PUS y"]
    @variables LCPUS1980(t) [description = "Life of Capacity PUS in 1980 y"]
    # @variables OBSGIPIS(t) [description = "Off-Balance Sheet Govmnt Inv in PIS (share of GDP)"]
    @variables OBSGIPUS(t) [description = "Off-Balance-Sheet Govmnt Inv in PUS (share of GDP)"]
    # @variables OGR(t) = params[:OG1980] [description = "Output Growth Rate 1/y"]
    # @variables OLY(t) = (params[:CAPPIS1980] / params[:PCORPIS] + params[:CAPPUS1980] / params[:PCORPUS]) / (1 + params[:OG1980]) [description = "Output Last Year Gdollar/y"]
    # @variables OOV(t) [description = "Optimal Ouput - Value Gdollar/y"]
    # @variables ORO(t) [description = "Optimal Real Output Gu/y"]
    @variables OWECC(t) [description = "OWeoCOC (1)"]
    @variables OWELC(t) [description = "OWeoLOC (1)"]
    # @variables PEDE(t) = 1 [description = "Perceived Excess DEmand (1)"]
    # @variables WSOEFCA(t) [description = "WSO Effect on Flow to Capacity Addition (1)"]

    @variables CBC(t)
    @variables CBC1980(t)
    @variables GDP(t)
    @variables GDPP(t)
    @variables GIPC(t)
    @variables ITFP(t)
    @variables LAUS(t)
    @variables OW(t)
    @variables TS(t)
    @variables TPP(t)
    @variables WASH(t)

    eqs = []

    # add_equation!(eqs, AVCA ~ TS + FCI)
    # add_equation!(eqs, CAP ~ CPIS + CPUS)
    # add_equation!(eqs, CAPIS ~ CUCPIS / CTPIS)
    add_equation!(eqs, CAPUS ~ CUCPUS / CTPUS)
    # add_equation!(eqs, CBCEFCA ~ 1 + CBCEFRA * (CBC / CBC1980 - 1))
    # add_equation!(eqs, CIPIS ~ max((INCPIS + OBSGIPIS * GDP) / COCA, 0))
    add_equation!(eqs, CIPUS ~ max((GIPC + OBSGIPUS * GDP) / COCA, 0))
    # add_equation!(eqs, CDPIS ~ CPIS / LCPIS)
    add_equation!(eqs, CDPUS ~ CPUS / LCPUS)
    add_equation!(eqs, COCA ~ CC1980 * OWECC)
    # add_equation!(eqs, D(CPIS) ~ CAPIS - CDPIS)
    add_equation!(eqs, D(CPUS) ~ CAPUS - CDPUS)
    # add_equation!(eqs, CRR ~ CAPIS / CPIS)
    # add_equation!(eqs, D(CUCPIS) ~ CIPIS - CAPIS)
    add_equation!(eqs, D(CUCPUS) ~ CIPUS - CAPUS)
    add_equation!(eqs, CUCPUS1980 ~ (CAPPUS1980 / LCPUS1980) * CTPUS * EMCUC)
    # add_equation!(eqs, ECR ~ (ITFP - ETFP) * CRR)
    # add_equation!(eqs, EDE ~ TPP / OOV)
    # add_equation!(eqs, EDEFCA ~ 1 + EDEFRA * (PEDE / ED1980 - 1))
    # add_equation!(eqs, EDELC ~ 1 + EDELCM * (PEDE / ED1980 - 1))
    # add_equation!(eqs, D(ETFP) ~ ECR)
    # smooth!(eqs, FACNC, FRA1980 * FRACAMGDPPL * (WSOEFCA + CBCEFCA + EDEFCA) / 3, IPT)
    # add_equation!(eqs, FRACAMGDPPL ~ max(FRACAM, 1 + GDPPEFRACA * (GDPP / GDPP1980 - 1)))
    # add_equation!(eqs, FRACAMGDPPT ~ withlookup(GDPP / GDPP1980, [(0.0, 1.0), (1.0, 1.0), (2.0, 0.85), (2.1, 0.84), (4.0, 0.65), (8.0, 0.55), (16.0, 0.5)]))
    # add_equation!(eqs, INCPIS ~ AVCA * FACNC)
    # add_equation!(eqs, ISGDP ~ (INCPIS + GIPC) / GDP)
    # add_equation!(eqs, LCPIS ~ (LCPIS1980 * OWELC) / EDELC)
    add_equation!(eqs, LCPUS ~ LCPUS1980)
    add_equation!(eqs, LCPUS1980 ~ 15 * OWELC)
    # add_equation!(eqs, OBSGIPIS ~ IfElse.ifelse(t > 2022, USPIS2022, 0))
    add_equation!(eqs, OBSGIPUS ~ IfElse.ifelse(t > 2022, 0.01 + USPUS2022, 0.01))
    # smooth!(eqs, OGR, (ORO - OLY) / OLY, 1)
    # smooth!(eqs, OLY, ORO, 1)
    # add_equation!(eqs, OOV ~ ORO * PRUN)
    # add_equation!(eqs, ORO ~ OO1980 * ((CPIS + CPUS) / (CAPPIS1980 + CAPPUS1980))^KAPPA * (LAUS / LAUS1980)^LAMBDA * (ETFP))
    add_equation!(eqs, OWECC ~ IfElse.ifelse(t > 2022, 1 + OWECCM * (OW / OW2022 - 1), 1))
    add_equation!(eqs, OWELC ~ IfElse.ifelse(t > 2022, 1 + OWELCM * (OW / OW2022 - 1), 1))
    # smooth!(eqs, PEDE, EDE, TOED)
    # add_equation!(eqs, WSOEFCA ~ 1 + WSOEFRA * (WASH / inits[:WSO] - 1))

    return ODESystem(eqs; name=name)
end

function output_full_support(; name, params=_params, inits=_inits, tables=_tables, ranges=_ranges)
    @variables CBC(t) [description = "Finance.Corporate Borrowing Cost 1/y"]
    @variables CBC1980(t) [description = "Finance.Corporate Borrowing Cost in 1980 1/y"]
    @variables GDP(t) [description = "Inventory.GDP GDollar/y"]
    @variables GDPP(t) [description = "Population.GDP per Person kdollar/p/y"]
    @variables GIPC(t) [description = "Demand.Govmnt Investment in Public Capacity Gdollar/y"]
    @variables ITFP(t) [description = "Public.Indicated TFP"]
    @variables LAUS(t) [description = "Labour and market.LAbour USe Gph/y"]
    @variables OW(t) [description = "Climate.Observed warming deg C"]
    @variables TS(t) [description = "Demand.TOtal SAvings Gdollar/y"]
    @variables TPP(t) [description = "Demand.Total Purchasing Power Gdollar/y"]
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
    add_equation!(eqs, TS ~ WorldDynamics.interpolate(t, tables[:TS], ranges[:TS]))
    add_equation!(eqs, TPP ~ WorldDynamics.interpolate(t, tables[:TPP], ranges[:TPP]))
    add_equation!(eqs, WASH ~ WorldDynamics.interpolate(t, tables[:WASH], ranges[:WASH]))

    return ODESystem(eqs; name=name)
end

function output_partial_support(; name, params=_params, inits=_inits, tables=_tables, ranges=_ranges)
    @variables CBC(t) [description = "Finance.Corporate Borrowing Cost 1/y"]
    @variables CBC1980(t) [description = "Finance.Corporate Borrowing Cost in 1980 1/y"]
    # @variables GDP(t) [description = "Inventory.GDP GDollar/y"]
    @variables GDPP(t) [description = "Population.GDP per Person kdollar/p/y"]
    # @variables GIPC(t) [description = "Demand.Govmnt Investment in Public Capacity Gdollar/y"]
    # @variables ITFP(t) [description = "Public.Indicated TFP (1)"]
    @variables LAUS(t) [description = "Labour and market.LAbour USe Gph/y"]
    @variables OW(t) [description = "Climate.Observed warming deg C"]
    # @variables TS(t) [description = "Demand.TOtal SAvings Gdollar/y"]
    # @variables TPP(t) [description = "Demand.Total Purchasing Power Gdollar/y"]
    @variables WASH(t) [description = "Labour and market.WAge SHare"]

    eqs = []

    add_equation!(eqs, CBC ~ WorldDynamics.interpolate(t, tables[:CBC], ranges[:CBC]))
    add_equation!(eqs, CBC1980 ~ WorldDynamics.interpolate(t, tables[:CBC1980], ranges[:CBC1980]))
    # add_equation!(eqs, GDP ~ WorldDynamics.interpolate(t, tables[:GDP], ranges[:GDP]))
    add_equation!(eqs, GDPP ~ WorldDynamics.interpolate(t, tables[:GDPP], ranges[:GDPP]))
    # add_equation!(eqs, GIPC ~ WorldDynamics.interpolate(t, tables[:GIPC], ranges[:GIPC]))
    # add_equation!(eqs, ITFP ~ WorldDynamics.interpolate(t, tables[:ITFP], ranges[:ITFP]))
    add_equation!(eqs, LAUS ~ WorldDynamics.interpolate(t, tables[:LAUS], ranges[:LAUS]))
    add_equation!(eqs, OW ~ WorldDynamics.interpolate(t, tables[:OW], ranges[:OW]))
    # add_equation!(eqs, TS ~ WorldDynamics.interpolate(t, tables[:TS], ranges[:TS]))
    # add_equation!(eqs, TPP ~ WorldDynamics.interpolate(t, tables[:TPP], ranges[:TPP]))
    add_equation!(eqs, WASH ~ WorldDynamics.interpolate(t, tables[:WASH], ranges[:WASH]))

    return ODESystem(eqs; name=name)
end
