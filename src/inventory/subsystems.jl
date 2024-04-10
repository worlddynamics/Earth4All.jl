include("../functions.jl")
@register_symbolic ramp(x, slope, startx, endx)
@register_symbolic pulse(x, start, width)

@variables t
D = Differential(t)

function inventory(; name, params=_params, inits=_inits, tables=_tables, ranges=_ranges)
    @parameters DAT = params[:DAT] [description = "Demand Adjustment Time y"]
    @parameters DDI1980 = params[:DDI1980] [description = "DDI in 1980 y"]
    @parameters DIC = params[:DIC] [description = "Desired Inventory Coverage y"]
    @parameters DRI = params[:DRI] [description = "Desired Relative Inventory"]
    @parameters ICPT = params[:ICPT] [description = "Inventory Coverage Perception Time y"]
    @parameters MRIWI = params[:MRIWI] [description = "Minimum Relative Inventory Without Inflation"]
    @parameters OO = params[:OO] [description = "Optimal Output in 1980 Gu/y"]
    @parameters PH = params[:PH] [description = "Pulse Height"]
    @parameters PPU = params[:PPU] [description = "Price Per Unit /u"]
    @parameters SAT = params[:SAT] [description = "Sales Averaging Time y"]
    @parameters INVEODDI = params[:INVEODDI] [description = "sINVeoDDI < 0: INVentory Effect On Delivery Delay Index"]
    @parameters INVEOIN = params[:INVEOIN] [description = "sINVeoIN < 0: INVentory Effect On INflation"]
    @parameters INVEOSWI = params[:INVEOSWI] [description = "sINVeoSWI < 0: INVentory Effect On Shifts Worked Index"]
    @parameters SRI = params[:SRI] [description = "Sufficient Relative Inventory"]
    @parameters SWI1980 = params[:SWI1980] [description = "SWI in 1980"]
    @parameters TAS = params[:TAS] [description = "Time to Adjust Shifts y"]

    @variables DELDI(t) = inits[:DELDI] [description = "DELivery Delay - Index (1)"]
    @variables EPP(t) = inits[:EPP] [description = "Effective Purchasing Power Gdollar/y"]
    @variables INV(t) = inits[:INV] [description = "INVentory Gu"]
    @variables PRIN(t) = inits[:PRIN] [description = "PRice INdex (1980=1)"]
    @variables PRI(t) = inits[:PRI] [description = "Perceived Relative Inventory (1)"]
    @variables RS(t) = inits[:RS] [description = "Recent Sales Gu/y"]
    @variables SSWI(t) = inits[:SSWI] [description = "ShiftS Worked - Index (1)"]

    @variables CDDI(t) [description = "Change in DDI 1/y"]
    @variables CPI(t) [description = "Change in Price Index 1/y"]
    @variables DEL(t) [description = "DELiveries Gu/y"]
    @variables DEPU(t) [description = "DEmand PUlse 2020-25 (1)"]
    @variables DSWI(t) [description = "Desired Shifts Worked - Index (1)"]
    @variables GDP(t) [description = "GDP Gdollar/y"]
    @variables IC(t) [description = "Inventory Coverage y"]
    @variables IR(t) [description = "Inflation Rate 1/y"]
    @variables NI(t) [description = "National Income Gdollar/y"]
    @variables OUTP(t) [description = "OUTPut Gu/y"]
    @variables PNIS(t) [description = "Pink Noise In Sales (1)"]
    @variables ROCDDI(t) [description = "ROC in DDI 1/y"]
    @variables SA(t) [description = "SAles Gdollar/y"]

    @variables ORO(t)
    @variables TPP(t)

    eqs = []

    add_equation!(eqs, CDDI ~ ROCDDI * DELDI)
    add_equation!(eqs, CPI ~ PRIN * IR)
    add_equation!(eqs, DEL ~ ((EPP / PPU) / (DELDI / DDI1980)) * IfElse.ifelse(t > 1984, PNIS, 1))
    add_equation!(eqs, D(DELDI) ~ CDDI)
    add_equation!(eqs, DEPU ~ 0 + PH * pulse(t, 2020, 5))
    add_equation!(eqs, DSWI ~ 1 + INVEOSWI * (PRI / DRI - 1))
    smooth!(eqs, EPP, TPP, DAT)
    add_equation!(eqs, GDP ~ OUTP * PPU)
    add_equation!(eqs, IC ~ INV / RS)
    add_equation!(eqs, D(INV) ~ OUTP - DEL)
    add_equation!(eqs, IR ~ INVEOIN * (PRI / MRIWI - 1))
    add_equation!(eqs, NI ~ SA)
    add_equation!(eqs, OUTP ~ ORO * SSWI / SWI1980)
    add_equation!(eqs, D(PRIN) ~ CPI)
    add_equation!(eqs, PNIS ~ 1)
    smooth!(eqs, PRI, (IC / DIC), ICPT)
    add_equation!(eqs, ROCDDI ~ 0 + INVEODDI * (PRI / SRI - 1))
    smooth!(eqs, RS, DEL, SAT)
    add_equation!(eqs, SA ~ DEL * PPU)
    smooth!(eqs, SSWI, DSWI, TAS)

    return ODESystem(eqs, t; name=name)
end

function inventory_full_support(; name, params=_params, inits=_inits, tables=_tables, ranges=_ranges)
    @variables ORO(t) [description = "Output.Optimal Real Output Gu/y"]
    @variables TPP(t) [description = "Demand.Total Purchasing Power G/y"]

    eqs = []

    add_equation!(eqs, ORO ~ WorldDynamics.interpolate(t, tables[:ORO], ranges[:ORO]))
    add_equation!(eqs, TPP ~ WorldDynamics.interpolate(t, tables[:TPP], ranges[:TPP]))

    return ODESystem(eqs, t; name=name)
end

function inventory_partial_support(; name, params=_params, inits=_inits, tables=_tables, ranges=_ranges)
    @variables ORO(t) [description = "Output.Optimal Real Output Gu/y"]
    @variables TPP(t) [description = "Demand.Total Purchasing Power G/y"]

    eqs = []

    add_equation!(eqs, ORO ~ WorldDynamics.interpolate(t, tables[:ORO], ranges[:ORO]))
    add_equation!(eqs, TPP ~ WorldDynamics.interpolate(t, tables[:TPP], ranges[:TPP]))

    return ODESystem(eqs, t; name=name)
end


